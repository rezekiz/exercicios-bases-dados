/* Alinea A
Crie um procedimento denominado “Atualiza_Preco_Referencia_Especialidade” que atualize o preço de referência de cada especialidade 
com o valor médio  cobrado nas consultas da especialidade num dado ano, acrescido de uma determinada percentagem. 
O ano e a percentagem são passados como parâmetros no procedimento. No entanto, caso uma determinada especialidade não tenha
consultas associadas nesse mesmo ano, o valor médio cobrado nas consultas da especialidade no ano em questão é substituído pelo valor 
atual do preço de referência da especialidade na operação supramencionada. */



/* Alinea B
Remova da base de dados todos os médicos que nunca consultaram. Para implementar esta operação
deverá criar uma função denominada “temConsultas(id_med)”. 
*/

/* Criação da função temConsultas */

DELIMITER //
CREATE FUNCTION `temConsultas`(id_med INT) RETURNS BOOLEAN
BEGIN
	IF (SELECT count(*) FROM consulta WHERE id_medico = id_med) > 0 THEN
		RETURN TRUE;
	ELSE 
		RETURN FALSE;
	END IF;
END; //

DELIMITER

/* 
Remoção de todos os médicos que nunca consultaram com recurso à função
*/

SET SQL_SAFE_UPDATES = 0;

DELETE FROM medico
WHERE temConsultas(medico.id_medico) = 0;

SET SQL_SAFE_UPDATES = 1


/*Alinea C
Remova da base de dados todos os códigos postais que não tenham ligação às tabelas MEDICO e
PACIENTE. Para implementar esta operação deverá criar uma função denominada “utilizadoCodi-
goPostal(cp)”. 
*/


/* Criação da Função */
DELIMITER //

CREATE FUNCTION utilizadoCodigoPostal(cp VARCHAR(8))
RETURNS BOOLEAN
BEGIN
    DECLARE existeMedico BOOLEAN;
    DECLARE existePaciente BOOLEAN;
    
    SELECT EXISTS(SELECT * FROM medico WHERE codigo_postal = cp) INTO existeMedico;
    
    SELECT EXISTS(SELECT * FROM paciente WHERE codigo_postal = cp) INTO existePaciente;
    
    RETURN (existeMedico OR existePaciente);
END //

DELIMITER ;

DELETE FROM codigo_postal
WHERE utilizadoCodigoPostal(codigo_postal.codigo_postal) = 0

/* Alinea D 

Adicione um atributo denominado “total_faturado” na tabela MEDICO para acumular os valores faturados por cada um dos médicos nas suas consultas. 
Numa primeira etapa, pretende-se que este atributo seja carregado recorrendo aos dados já existentes na base de dados. 
Seguidamente, efetue igualmente as operações necessárias para que o referido atributo se mantenha sempre atualizado.
*/

/* Adicionar o novo atributo */

ALTER TABLE medico
ADD total_faturado DECIMAL(8,2) DEFAULT 0;

/* Povoamos os valores com base nos valores existentes */

UPDATE medico
SET total_faturado = (
	SELECT sum(preco) FROM consulta WHERE id_medico = medico.id_medico
);

/* Programar um trigger para manter o preço atualizado sempre que haja uma nova consulta */

DELIMITER //

CREATE TRIGGER atualizar_total_faturado
AFTER INSERT ON CONSULTA
FOR EACH ROW
BEGIN
	UPDATE medico
    SET total_faturado = (SELECT sum(preco) FROM consulta WHERE id_medico = medico.id_medico)
        WHERE id_medico = NEW.id_medico;
END //

DELIMITER ;


/* Alinea E

Crie uma tabela denominada “PACIENTE_ACUMULADO_MENSAL”, com os seguintes atributos:
“id_paciente”, “ano”, “mes” e “total_faturado”. 
Numa primeira etapa, pretende-se que esta tabela seja carregada recorrendo aos dados já existentes na base de dados. 
Seguidamente, implemente também as operações necessárias para que a tabela se mantenha sempre atualizada.
*/

/* Criação da tabela */

CREATE TABLE paciente_acumulado_mensal (
	id_paciente INT,
    ano INT(4),
    mes INT(2),
    total_faturado DECIMAL(8,2),
    PRIMARY KEY (id_paciente, ano, mes),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
    );

INSERT INTO paciente_acumulado_mensal (id_paciente, ano, mes, total_faturado)
SELECT id_paciente, YEAR(data_hora) AS ano, MONTH(data_hora) AS mes, SUM(preco) AS total_faturado
FROM CONSULTA
GROUP BY id_paciente, ano, mes;

/* Programação de um trigger para manter a tabela atualizada */ 

DELIMITER //

CREATE TRIGGER atualizar_paciente_acumulado_mensal
AFTER INSERT ON CONSULTA
FOR EACH ROW
BEGIN
    -- Atualiza a tabela PACIENTE_ACUMULADO_MENSAL após alterações na tabela CONSULTA
    INSERT INTO PACIENTE_ACUMULADO_MENSAL (id_paciente, ano, mes, total_faturado)
    VALUES (
		NEW.id_paciente, 
        YEAR(NEW.data_hora), 
        MONTH(NEW.data_hora), 
		(SELECT sum(preco) FROM CONSULTA WHERE id_paciente = NEW.id_paciente AND YEAR(data_hora) = YEAR(NEW.data_hora) AND MONTH(data_horaa) = MONTH(NEW.data_hora)
    ))
    ON DUPLICATE KEY UPDATE
    total_faturado = (
        SELECT sum(preco)
        FROM CONSULTA
        WHERE id_paciente = NEW.id_paciente AND YEAR(data_hora) = YEAR(NEW.data_hora) AND MONTH(data_hora) = MONTH(NEW.data_hora)
    );
END //

DELIMITER ;

