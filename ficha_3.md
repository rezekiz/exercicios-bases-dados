# Ficha 3

A inscrição e o registo das classificações nas unidades curriculares (UCs) que os alunos vão fazendo ao longo
dos anos, há muito que representam um problema relevante para os serviços académicos. Os seus responsáveis,
depois de várias reuniões de trabalho, decidiram finalmente avançar para a implementação de um novo sistema
para a gestão dos processos referidos.
Nesse sentido, promoveram várias reuniões com os serviços de informação para discutirem o plano de tra-
balho para os futuros serviços de bases de dados, bem como a estrutura da futura base de dados em si. No
final, foi apresentado um documento com os requisitos que acharam mais importantes e que gostariam de ver
refletidos na futura base de dados. Os pontos essenciais desse documento são os seguintes:

* Na altura da sua inscrição num dado curso, um aluno tem que indicar:
    * o seu nome, 
    * o seu número de contribuinte,
    * o seu número de cartão de cidadão,
    * a sua morada,
    * um ou mais números de contacto telefónico,
    * os nomes dos seus pais e
    * do seu encarregado de educação,
    * a sua data de nascimento e
    * o curso que vai frequentar.
    * cada aluno tem um identificador único

* Os cursos estarão catalogados no sistema de acordo com
* o seu identicador único, 
* a sua designação, 
* o seu ciclo de estudos (1.o, 2.oou 3.o), 
* o grau que confere e
* o número de alunos inscritos. 

Além disso, incluem também a **identificação do seu diretor** que é, obrigatoriamente, um dos **docentes da instituição**.

* No entanto, um aluno pode obviamente **estar inscrito em vários cursos**. Quando inscrito num curso, e
para garantir a sua realização, um aluno tem que realizar todas as **unidades curriculares** que pertencem
ao curso. O registo de dados do aluno associado ao curso irá conter o **número de unidades curriculares**
realizadas, o correspondente **valor em ECTs**, bem como **a sua média atual**. As **datas de início** e de **fim**
associadas ao(s) curso(s) que o aluno frequenta devem, igualmente, serem registadas.

* *Um aluno não se pode inscrever de uma só vez em todas as unidades curriculares de um dado curso, isto é,
ele tem de respeitar a regulamentação vigente sobre a frequência e a realização de unidades curriculares.
Por outro lado, a sua **data de inscrição em cada unidade curricular tem de estar registada no sistema**.

* *No final de cada semestre, os docentes das várias unidades curriculares comunicam as notas finais que os
alunos obtiveram, sendo estas posteriormente lançadas no sistema, unidade curricular a unidade curricular,
aluno a aluno. A cada classificação (nota final) está sempre associada a **data de realização** da unidade
curricular pelo aluno.

* *Como já foi referido anteriormente, as **unidades curriculares** estão integradas num dado curso. Uma
unidade curricular apenas pode pertencer a **um único curso**, estando caracterizada pelo:
    * seu identificador único e 
    * a sua designação. 
       
* Também é definida pela sua 
    * escolaridade, bem como 
    * o ano letivo e 
    * o semestre de lecionação.

* Na futura base de dados deverá, igualmente, figurar a informação relativa ao responsável das unidades
curriculares (um docente), assim como o tipo e o número de horas semanais que cada docente associado a
unidade curriculare leciona. Os docentes das unidades curriculares pertencem a um único departamento
dentro da instuição e são classificados através da sua categoria dentro da mesma, bem como são caracte-
rizados pelo seu identificador único e o seu nome. Os departamentos são unicamente caracterizados pelo
seu identidicador único e a sua designação.


Assim, com base no caso apresentado, pretende-se que:

1. Desenvolva um esquema conceptual para a base de dados requerida, de acordo com os requisitos apresen-
tados.

![Diagrama ER](ficha3_chen_diag.png)


2. Utilizando o MySQL Workbench, converta o esquema conceptual produzido na alínea anterior para o seu
correspondente esquema lógico

![Diagrama ER](ficha3_eer_diag.png)