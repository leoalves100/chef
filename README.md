# [Chef](https://docs.chef.io/)

## Componentes

- [Chef Infra Server](https://docs.chef.io/server/)
- [Chef Infra Client](https://docs.chef.io/chef_client_overview/) 
- [Chef Workstation](https://docs.chef.io/workstation/)
- [Chef Automate](https://docs.chef.io/automate/)

## Extras

- Repositório de cookbooks, tools e plugins: [supermarket](https://supermarket.chef.io/)

## Infrastrutura

| Instance          | Memory | CPU |
|-------------------|--------|-----|
| chef-infra-server | 4GB    | 2   |
| node              | 1GB    | 2   |

## Executando o projeto

```bash
vagrant up
```

## Executando cookbooks nos nodes

```bash
# Executa apenas uma vez
chef-client -o 'recipe[<name-cookbook>::<recipe>]'

# Executa e salva na runlist[]
chef-client -r 'recipe[<name-cookbook>::<recipe>]'

# Arquivo JSON contendo todos os recipes
chef-client -j first-boot.json
```

**Obs¹:** Caso não seja passado nenhum `recipe`, ele executa o `default.rb`

## Topics

- [Chef Infra Resources](https://docs.chef.io/resource/)
- [Data Bags](./chef-repo/cookbooks/lamp-stack/data_bags/README.md)
