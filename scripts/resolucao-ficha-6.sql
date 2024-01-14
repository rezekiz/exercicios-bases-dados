/* Exercício 2 

Foi criada uma função `anservico` para facilitar o cálculo dos anos de serviço.
*/

DELIMITER //
CREATE FUNCTION `anservico`(dta date) RETURNS INT(3)
BEGIN
	RETURN TIMESTAMPDIFF(YEAR, dta, CURDATE());
END; //

DELIMITER

/* Alinea A
Qual é o nome dos médicos com mais de 10 anos de serviço?
*/

SELECT * FROM medico WHERE anservico(data_inicio_servico) > 10

/* Alinea B
Qual é o nome de todos os médicos e a respetiva especialidade que cada um exerce?
*/

SELECT medico.nome, especialidade.designacao 
FROM medico
JOIN especialidade ON medico.especialidade = especialidade.id_especialidade

/* Alinea C
Qual é o nome e a morada dos pacientes residentes na localidade de Braga? 
*/


SELECT nome, morada
FROM paciente
JOIN codigo_postal ON paciente.codigo_postal = codigo_postal.codigo_postal
WHERE codigo_postal.localidade = 'Braga'

/* Alinea D 
Qual é o nome dos médicos da especialidade de Oftalmologia?
*/

SELECT medico.nome, especialidade.designacao 
FROM medico
JOIN especialidade ON medico.especialidade = especialidade.id_especialidade
WHERE especialidade.designacao = 'Oftalmologia'

/* Alinea E
Qual é o nome e a idade dos médicos com mais de 40 anos de idade da especialidade de Clínica Geral?
*/

SELECT nome, idade(data_nascimento) 
FROM medico
JOIN especialidade ON medico.especialidade = especialidade.id_especialidade
WHERE especialidade.designacao = 'Clínica Geral'

/* Alinea F
Qual é o nome dos médicos da especialidade de Oftalmologia que consultaram pacientes da localidade de Braga?
*/

SELECT DISTINCT medico.nome AS nome_medico, paciente.nome AS nome_paciente, especialidade.designacao as especialidade
FROM medico
JOIN especialidade ON medico.especialidade = especialidade.id_especialidade
JOIN consulta ON medico.id_medico = consulta.id_medico
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN codigo_postal ON paciente.codigo_postal = codigo_postal.codigo_postal
WHERE especialidade.designacao = 'Oftalmologia' AND codigo_postal.localidade = 'Braga';

/* Alinea G
Qual é o nome e os anos de serviço dos médicos com mais de 50 anos de idade que deram consultas a partir das 12h a pacientes com menos de 20 anos de idade?
*/

SELECT medico.nome AS nome_medico, anservico(medico.data_inicio_servico) AS anos_servico, idade(medico.data_nascimento) AS idade_medico, paciente.nome AS nome_paciente, idade(paciente.data_nascimento) AS idade_paciente
FROM medico
JOIN consulta ON consulta.id_medico = medico.id_medico
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
WHERE idade(medico.data_nascimento) > 50 AND idade(paciente.data_nascimento) < 20

/* Alinea H
Qual é o nome e a idade dos pacientes com mais de 10 anos de idade que nunca foram consultados na especialidade de Oftalmologia?
*/

SELECT paciente.nome AS paciente, idade(paciente.data_nascimento) AS idade, especialidade.designacao AS especialidade_consultada
FROM medico
JOIN consulta ON consulta.id_medico = medico.id_medico
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
WHERE especialidade.designacao != 'Oftalmologia' AND idade(paciente.data_nascimento) > 10

/* Alinea I
 Qual é o nome das especialidades que tiveram consultas no mês de janeiro de 2016? */

SELECT DISTINCT especialidade.designacao as especialidade_jan_16
FROM especialidade
JOIN medico ON especialidade.id_especialidade = medico.especialidade
JOIN consulta ON consulta.id_medico = medico.id_medico
WHERE year(consulta.data_hora) = 2016 AND month(consulta.data_hora) = 1

/* Alinea J
 Qual é o nome dos médicos com mais de 30 anos de idade ou menos de 5 anos de serviço?
 */

SELECT nome FROM medico
WHERE idade(data_nascimento) > 30 AND anservico(data_inicio_servico) >5

/* Alinea K
 Qual é o nome e a idade dos médicos de Clínica Geral que não consultaram em janeiro de 2016?
 */


SELECT nome, idade(data_nascimento) AS idade FROM medico
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
JOIN consulta ON consulta.id_medico = medico.id_medico
WHERE especialidade.designacao = 'Clínica Geral' AND (month(consulta.data_hora) IS NULL OR (month(consulta.data_hora) != 1 AND year(consulta.data_hora) != 2016))

/* Alinea L
 Qual é o nome e a idade dos pacientes que já foram consultados por todos os médicos? */

SELECT paciente.nome, idade(paciente.data_nascimento) AS idade FROM paciente
JOIN consulta ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico
GROUP BY paciente.nome, idade
HAVING count(*) = (SELECT COUNT(*) FROM medico)

/* Alinea M
 Qual é o nome das especialidades que tiveram consultas no mês de janeiro e março de 2016?
 */

SELECT especialidade.designacao as especialidade_jan_e_mar_16
FROM especialidade
JOIN medico ON especialidade.id_especialidade = medico.especialidade
JOIN consulta ON consulta.id_medico = medico.id_medico
WHERE year(consulta.data_hora) = 2016 AND (month(consulta.data_hora) = 1 OR month(consulta.data_hora) = 3)

/* Alinea N
Qual é o nome dos médicos que nunca consultaram pacientes residentes em Braga?
*/

SELECT medico.nome FROM medico
JOIN consulta ON consulta.id_medico = medico.id_medico
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN codigo_postal ON codigo_postal.codigo_postal = paciente.codigo_postal
WHERE codigo_postal.localidade != 'Braga'

/* Alinea O
 Qual é o nome e a idade dos pacientes que só foram consultados a Clínica Geral? */

SELECT paciente.nome, idade(paciente.data_nascimento) AS idade FROM paciente
JOIN consulta ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
WHERE especialidade.designacao = 'Clínica Geral'
