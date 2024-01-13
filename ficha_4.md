# Ficha 4

### Questões

Assim, com base na resolução da Ficha PL03, pretende-se que:

1. Utilizando o MySQL Workbench, faça a geração do respetivo esquema físico para a base de dados em questão.

![Diagrama ER](ficha4_eer_diag.png)

2. Desenvolva as operações necessárias para fazer o povoamento das tabelas da base de dados

Em primeiro lugar é necessário criar a tabela partindo do esquema lógico. No MySQL Workbench podemos recorrer à função "Forward Engineer". Anexo abaixo o script .sql utilizado, gerado automaticamente pela funcionalidade acima mencionada.

Posteriormente podemos inserir os dados usando o comando `INSERT`. Um exemplo abaixo de criação de algumas entradas:


```SQL

INSERT INTO aluno (nome, nif, nomc_enc_edu, nome_pai)
VALUES (
    'João Silva',
    '999999999',
    'Miguel Silva',
    'Miguel Silva',
)

INSERT INTO UC (designacao, ECTs)
VALUES (
    'Introdução a Bases de Dados',
    30
)

INSERT INTO curso (designacao, ano_letivo)
VALUES (
    'Mestrado em Bioinformática',
    1
)
```

