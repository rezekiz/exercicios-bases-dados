# Ficha 2:

### Enunciado

Uma empresa de colheitas de análises clínicas pretende desenvolver uma pequena base de dados para registar
os equipamentos que os seus funcionários utilizam nas diversas tarefas de colheita e de armazenamento que
realizam.

A empresa possui **várias viaturas** devidamente equipadas que se deslocam aos diferentes locais onde devem
ser realizadas as colheitas. Os membros da direção da empresa acreditam que, dessa maneira, conseguirão fazer
uma melhor gestão dos equipamentos da empresa, bem como reduzir os seus custos de manutenção.

Após uma reunião de trabalho com os membros da direção, com os chefes das equipas de colheita e, ob-
viamente, com todos os funcionários integrados em equipas de colheita, o arquiteto da futura base de dados
elaborou uma pequena lista de requisitos para a sua construção. 

Nessa lista figurava o seguinte: na definição
de cada serviço de colheita é necessário caracterizar a **colheita que será realizada (número, designação, data de início, data de fim, nome do cliente e local de realização)**, indicar quais os **funcionários (número, nome e categoria)** que nela vão participar, bem como o **equipamento que vai ser utilizado no trabalho** e o número de horas de utilização previsto para cada equipamento nesse trabalho.

 Além disso, será igualmente necessário registar o
funcionário que é o responsável da equipa de colheita na realização de cada um dos diferentes serviços de colheita.
Com base no caso apresentado, pretende-se que:

### Questões

1. Identifique e caracterize potenciais entidades envolvidas no estudo de caso apresentado, bem como os
vários atributos que as constituem.

**Resposta**

|entidade|atributos|
|-|-|
|colheita|id, designação, funcionário, data início, data fim, cliente, local, equipamento, horas de utilização|
|cliente| id, nome|
|local|id, rua, localidade, codigo postal|
|funcionário| id, nome, categoria|
|categoria| id, designação|
|equipamento|id, designação|


2. Identifique e caracterize os diversos relacionamentos que possam existir entre as entidades estabelecidas
na alínea anterior.

**Resposta**
|entidade|relacionamento|
|-|-|
|colheita|id_funcionário (n:n), id_cliente (n:1), id_local (1:1), equipamento (1:1)|
|cliente| id_colheita (1:n)|
|local|id_colheita (1:1)|
|funcionário|id_colheita (n:n), id_categoria(1:1)|
|categoria|id_funcionário (1:1)|
|equipamento|id_colheita (n:1)|

3. Desenhe um diagrama entidade relacionamento (ER) na notação Chen capaz de acolher os diversos objetos
de dados identificados e caracterizados nas alíneas anteriores.

![Diagrama ER](ficha2_chen_diagram.png)

