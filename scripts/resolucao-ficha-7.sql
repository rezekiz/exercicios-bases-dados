/*
Exercício 1

Resolva utilizando funções de agregação as alíneas k, l, n e o da questão 2 da 6.a ficha prática laboratorial
*/

/* Qual é o nome e a idade dos médicos de Clínica Geral que não consultaram em janeiro de 2016? */
SELECT nome, idade(data_nascimento) AS idade FROM medico
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
JOIN consulta ON consulta.id_medico = medico.id_medico
WHERE especialidade.designacao = 'Clínica Geral' AND (month(consulta.data_hora) IS NULL OR (month(consulta.data_hora) != 1 AND year(consulta.data_hora) != 2016))
GROUP BY medico.nome, idade

/* Qual é o nome e a idade dos pacientes que já foram consultados por todos os médicos?*/

SELECT paciente.nome, idade(paciente.data_nascimento) AS idade FROM paciente
JOIN consulta ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico
GROUP BY paciente.nome, idade
HAVING count(*) = (SELECT COUNT(*) FROM medico)


/*(m) Qual é o nome das especialidades que tiveram consultas no mês de janeiro e março de 2016?*/

SELECT especialidade.designacao as especialidade_jan_e_mar_16
FROM especialidade
JOIN medico ON especialidade.id_especialidade = medico.especialidade
JOIN consulta ON consulta.id_medico = medico.id_medico
WHERE year(consulta.data_hora) = 2016 AND (month(consulta.data_hora) = 1 OR month(consulta.data_hora) = 3)
GROUP BY especialidade.designacao

/*(n) Qual é o nome dos médicos que nunca consultaram pacientes residentes em Braga?*/

SELECT medico.nome FROM medico
JOIN consulta ON consulta.id_medico = medico.id_medico
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN codigo_postal ON codigo_postal.codigo_postal = paciente.codigo_postal
WHERE codigo_postal.localidade != 'Braga'
GROUP BY medico.nome

/*(o) Qual é o nome e a idade dos pacientes que só foram consultados a Clínica Geral?*/

SELECT paciente.nome, idade(paciente.data_nascimento) AS idade FROM paciente
JOIN consulta ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
WHERE especialidade.designacao = 'Clínica Geral'
GROUP BY paciente.nome, idade

/*
Exercício 2
Utilizando SQL, desenvolva os comandos necessários para responder às seguintes questões:
*/

/* Alinea A
Apresente a média das idades dos médicos com mais de 15 anos de serviço.
*/
SELECT AVG(idade(data_nascimento)) FROM medico
WHERE anservico(data_inicio_servico) > 15;

/* Alinea B 
Apresente a média dos anos de serviço dos médicos para cada uma das especialidades. Devem ser
#apresentadas todas as especialidades, incluindo as que não tenham médicos associados.
*/

SELECT especialidade.designacao AS especialidade, avg(anservico(data_inicio_servico)) AS media_anos_servico FROM medico
JOIN especialidade ON especialidade.id_especialidade = medico.especialidade
GROUP BY especialidade.designacao

/* Alinea C 
Apresente o número de consultas que estão registadas por cada um dos médicos. Devem ser apresen-
tados todos os médicos, incluindo os que nunca tenham dado consultas. 
*/

SELECT medico.nome, COUNT(*) AS numero_consultas
FROM consulta
JOIN medico ON consulta.id_medico = medico.id_medico
GROUP BY medico.nome


/* Alinea D
Apresente a média das idades dos pacientes por cada uma das localidades. Devem ser apresentadas
todas as localidades, incluindo as que não tenham pacientes associados.
*/

SELECT codigo_postal.localidade, avg(idade(paciente.data_nascimento)) AS med_idade 
FROM codigo_postal
JOIN paciente ON codigo_postal.codigo_postal = paciente.codigo_postal
GROUP BY codigo_postal.localidade

/* Alinea E
Apresente para cada médico o valor total faturado em 2016. Devem ser apresentados todos os
médicos, incluindo os que nunca tenham dado consultas.
*/

SELECT medico.nome AS medico, sum(consulta.preco) AS faturado FROM medico
JOIN consulta ON consulta.id_medico = medico.id_medico
GROUP BY medico

/* Alinea F
Apresente o número de médicos para cada uma das especialidades. Devem ser apresentadas todas as
especialidades, incluindo as que não tenham médicos associados.
*/

SELECT especialidade.designacao AS especialidade, count(*) AS num_medicos FROM especialidade
JOIN medico ON especialidade.id_especialidade = medico.especialidade
GROUP BY especialidade

/* Alinea G
Para cada uma das especialidades com menos de dois médicos, apresente o valor máximo e o valor
mínimo faturado para o conjunto das consultas, bem como o seu valor médio.
*/

SELECT 
especialidade.designacao AS especialidade,
 max(consulta.preco) AS max_faturado,
 min(consulta.preco) AS min_faturado,
 avg(consulta.preco) AS fat_media
FROM consulta
JOIN medico ON consulta.id_medico = medico.id_medico
JOIN especialidade  ON especialidade.id_especialidade = medico.especialidade
GROUP BY especialidade HAVING count(DISTINCT medico.id_medico) < 2
	


/*Alinea H
Apresente o nome do(s) médico(s) cujo valor médio faturado em 2016 por consulta seja superior
à média por consulta desse mesmo ano, bem como o valor médio associado a cada um desses(s)
médico(s).
*/

SELECT medico.nome AS medico, avg(consulta.preco) AS fat_media
FROM consulta
JOIN medico ON consulta.id_medico = medico.id_medico
WHERE year(consulta.data_hora) = 2016 
GROUP BY medico.nome
HAVING fat_media > (SELECT avg(consulta.preco) FROM consulta WHERE year(consulta.data_hora) = 2016)

/* Alinea I
Apresente o nome da(s) especialidade(s) que mais faturou (faturaram) em 2016, bem como o valor
total associado a cada uma dessa(s) especialidade(s).
*/

SELECT especialidade.designacao AS especialidade, sum(consulta.preco) AS faturado
FROM consulta
JOIN medico ON consulta.id_medico = medico.id_medico
JOIN especialidade  ON especialidade.id_especialidade = medico.especialidade
WHERE year(consulta.data_hora) = 2016
GROUP BY especialidade 
ORDER BY faturado DESC
LIMIT 1;

/* Alinea J
Apresente o nome dos três médicos que mais deram consultas em 2016, bem como o número de
consultas associado a cada um desses médicos.
*/

SELECT medico.nome AS medico, count(*) AS num_consultas
FROM consulta
JOIN medico ON consulta.id_medico = medico.id_medico
WHERE year(consulta.data_hora) = 2016
GROUP BY medico
ORDER BY num_consultas DESC
LIMIT 3;