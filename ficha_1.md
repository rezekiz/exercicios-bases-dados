# Ficha 1

### Enunciado

Todas as empresas da área da saúde, de uma maneira ou de outra, têm de guardar a informação relativa aos
contactos pessoais dos profissionais que nela trabalham, **incluindo morada, telefone, telemóvel e e-mail, entre
outros**. 

A forma como é mantida essa informação depende muito das nossas pretensões de utilização ou das necessidades associadas.

Os “livros” de contactos podem apresentar estruturas e formatos muito diversos. Os seus utilizadores costumam personalizá-los frequentemente e neles guardam informação muito díspar e variada. 

Veja-se, a título de
exemplo, a Figura 1.

Figura 1: Exemplo de um livro de contactos.

Com base no caso apresentado, pretende-se que:

##Questões

1. Identifique e caracterize potenciais entidades envolvidas num livro de contactos idealizado por si, bem
como os vários atributos que as constituem.


**Resposta:**
|entidade|atributos|
|-|-|
|profissional|id, nome , telefone , email , morada , especialidade, cargo|
|telefones|id, numero|
|morada|id, rua , localidade , codigo postal|
|especialidade|id, nome (e.g. pneumologia)|
|cargo|id, nome (e.g. gestor)|

2. Identifique e caracterize os diversos relacionamentos que possam existir entre as entidades estabelecidas
na alínea anterior.

**Resposta:**
|entidade|relacionamento|
|-|-|
|profissional| id_telefone(s) (1:n), id_morada (1:1), id_especialidade(s) (1:n), id_cargo(s) (1:1)|
|telefones|id_profissional (n:1)|
|morada|id_profissional (1:1)|
|especialidade|id, nome (e.g. pneumologia) (n:1)|
|cargo|id, nome (e.g. gestor) (1:1)|

