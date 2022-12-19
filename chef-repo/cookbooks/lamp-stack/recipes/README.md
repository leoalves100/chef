# [Recipes](https://docs.chef.io/recipes/)

## Introdução

Uma receita é o elemento de configuração mais fundamental dentro do organização. Uma receita:

- É criado usando Ruby, que é uma linguagem de programação projetada para ler e se comportar de maneira previsível
- É principalmente uma coleção de recursos, definidos usando padrões (nomes de recursos, pares atributo-valor e ações); código auxiliar é adicionado em torno disso usando Ruby, quando necessário
- Deve definir tudo o que é necessário para configurar parte de um sistema
- Deve ser armazenado em um livro de receitas(cookbook)
- Pode ser incluído em outra receita
- Pode usar os resultados de uma consulta de pesquisa e ler o conteúdo de um data bag (incluindo um data bag criptografado)
- Pode ter uma dependência de uma (ou mais) receitas
- Deve ser adicionado a uma lista de execução antes de poder ser usado pelo Chef Infra Cliente
- É sempre executado na mesma ordem listada em uma lista de execução