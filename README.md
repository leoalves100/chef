# Chef

## Componentes

- [Chef Infra Server](https://docs.chef.io/server/)
- [Chef Infra Client](https://docs.chef.io/chef_client_overview/) 
- [Chef Workstation](https://docs.chef.io/workstation/)


## Extras

- Repositório de cookbooks, tools e plugins: [supermarket](https://supermarket.chef.io/)


## Habilitar login por senha

1. Editar o arquivo `/etc/ssh/sshd_config`
   
```bash
PasswordAuthentication yes
```

2. Reiniciar o serviço

```bash
sudo systemctl restart sshd
```