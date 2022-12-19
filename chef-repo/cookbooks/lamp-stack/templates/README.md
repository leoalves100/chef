# [Templates](https://docs.chef.io/templates/)

## Introdução

Um template de cookbook é um modelo `Embedded Ruby (ERB)` que é usado para gerar dinamicamente arquivos de texto estáticos. Os templates podem conter expressões e instruções Ruby e são uma ótima maneira de gerenciar arquivos de configuração. 

Use o recurso de modelo para adicionar modelos de cookbook a recipes; coloque o arquivo de modelo Embedded Ruby (ERB) correspondente no diretório de um cookbook. `cookbook/<name>/templates`

## Gerando arquivo

O diretório não existe por padrão em um cookbook. Gere o diretório e um arquivo de modelo a partir do diretório com o comando:

```bash
chef generate template PATH_TO_COOKBOOK TEMPLATE_NAME
```

Por exemplo, este comando gera um template(httpd) no livro de receitas(custom_web)

```bash
chef generate template cookbooks/custom_web httpd
```

## [Requisitos](https://docs.chef.io/templates/#requirements)

Para usar um modelo, duas coisas devem acontecer:

1. Um recurso de modelo deve ser adicionado a uma receita(recipe)
2. Um modelo de Embedded Ruby (ERB) deve ser adicionado a um livro de receitas(cookbook)