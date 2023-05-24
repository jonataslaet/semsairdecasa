# Sem sair de casa

Esse repositório contém uma aplicação onde se pode criar, ler, editar e deletar coordenadas de cidades. 


## 🚀 Introdução

As instruções a seguir vão te ajudar a ter uma cópia deste projeto em execução na sua máquina local.


### 📋 Pré-requisitos

Além de já ter feito o clone deste repositório, é muito importante ter o docker instalado, que pode ser conseguido [neste tutorial](https://felixgilioli.medium.com/como-rodar-um-banco-de-dados-postgres-com-docker-6aecf67995e1). Também é necessário já ter o flutter instalado, que pode ser conseguido [neste link da documentação oficial](https://docs.flutter.dev/get-started).


### 🔧 Executando este projeto em ambiente de desenvolvimento

Este é um passo a passo que vai te levar a ter o ambiente rodando em sua máquina local

01. Para subir o banco de dados, vá pela linha de comando até a pasta do projeto e digite o seguinte comando:

```
docker-compose -p semsairdecasa -f docker/docker-compose.yml up -d
```

02. Plugue um dispositivo android ao seu computador, ou abra um simulador de dispositivo

03. Pela linha de comando, vá até a pasta "mobile-flutter", que fica dentro da pasta do projeto, e digite:

```
flutter run
```

04. Em seguida, selecione o dispositivo em que deseja executar a aplicação.


## 🛠️ Tecnologias 

As seguintes tecnologias foram utilizadas neste projeto

* [Flutter](https://spring.io/) - Mobile development framework
* [Dart](https://dart.dev/) - Mobile programming language 
* [MySQL](https://www.mysql.com/) - Relational DataBase Management System


## ✒️ Desenvolvedores

Aqui estão os desenvolvedores que de alguma forma contribuíram para este projeto:

* **Jonatas Laet** - *Documentação e Desenvolvimento* - [jonataslaet](https://github.com/jonataslaet)
* **Franciney Andrews** - ** - [Franciney-Andrews](https://github.com/Franciney-Andrews)

Você pode ver a lista de colaboradores [aqui](https://github.com/jonataslaet/semsairdecasa/graphs/contributors).


---
Developed by: 
[Jonatas Laet](https://github.com/jonataslaet)😊