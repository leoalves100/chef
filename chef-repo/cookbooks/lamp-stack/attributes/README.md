# [Attributes](https://docs.chef.io/attributes/)

## Introdução

Um atributo é um detalhe específico sobre um nó. Os atributos são usados ​​pelo Chef Infra Client para entender:

- O estado atual do nó
- Qual era o estado do nó no final da execução anterior do Chef Infra Client
- Qual deve ser o estado do nó no final da execução atual do Chef Infra Client

## Definições

Os atributos são definidos por:

- O nó salvo no Chef Infra Server
- Atributos passados ​​usando JSON na linha de comando Cookbooks (em arquivos de attribute e/ou recipes)
- Arquivos de política

Durante cada execução do Chef Infra Client, ele cria a lista de atributos usando:

- Atributos passados ​​usando JSON na linha de comando
- Dados sobre o nó coletados por Ohai .
- O objeto de nó que foi salvo no Chef Infra Server no final da execução anterior do Chef Infra Client.
- O objeto de nó reconstruído da execução atual do Chef Infra Client, após ser atualizado para alterações nos livros de receitas (arquivos de atributos e/ou receitas) e/ou Policyfiles e atualizado para quaisquer alterações no estado do próprio nó.

Depois que o objeto do nó é reconstruído, todos os atributos são comparados e, em seguida, o nó é atualizado com base na precedência do atributo. No final de cada execução do Chef Infra Client, o objeto do nó que define o estado atual do nó é carregado no Chef Infra Server para que possa ser indexado para pesquisa.