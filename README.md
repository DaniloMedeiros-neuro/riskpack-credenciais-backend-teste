# RISKPACK CREDENCIAIS TESTES BACKEND

Repositório dos testes de Backend do Riskpack Credenciais, também conhecido como Credentials.
Foi desenvolvido com RobotFramework em Python, utilizando a biblioteca RequestsLibrary para comunicação com serviços.

## ARQUITETURA

- Deve ser utilizado o Design Pattern Page Object, que consiste em criar camadas de abstração, dividindo seus elementos e suas ações centralizado em cada página web. Tornando o projeto mais organizado e de fácil manutenção.

### DOWNLOADS

- Instalar Python 3 (verificar versão estável):

  > Python 3 + [`download`](https://www.python.org/downloads/)

- Verificar que deu certo a instalacao
  - python --version
  - robot --version

> ```bash
> python 3.9+
> pip 21.2.4
> ```


### PARA CRIAR O AMBIENTE VIRTUAL
- no CMD
```
  python -m venv .venv
```

### PARA HABILITAR O AMBIENTE VIRTUAL

- no CMD

```cmd
.venv\Scripts\activate.bat
```

- no PowerShell

```cmd
.venv\Scripts\Activate.ps1
```

- no Bash

```sh
..venv\Scripts\activate
```

### BAIXANDO AS DEPENDÊNCIAS DO PROJETO

- Execute no terminal:
  > ```cmd
  > cd path_to_repository_paste
  > pip install -r requirements.txt
  > ```
  
  
## EXECUTANDO DOS TESTES

Seguem exemplos de como executar os testes via terminal (sem utilizar extensão):

- Rodar uma classe de testes excluindo os casos de teste com tag `regression`:

```sh
robot --exclude regression tests/features/oauth/login.robot
```

- Rodar uma suite completa (oauth) excluindo os casos de teste com tag `regression`:

```sh
robot --exclude regression tests/features/oauth
```

- Rodar todos os testes excluindo os casos de teste com tag `regression`:

```sh
robot --exclude regression tests/features
```

- Rodar apenas os testes que contenham a tag `regression`:

```sh
robot --include regression tests/features
```

## EXECUTANDO DOS TESTES UTILIZANDO EXTENSÃO

- Clicar no 'play' ou em 'Run' para executar a suite ou caso de teste desejado;

## EVIDÊNCIAS DA EXECUÇÃO

- No terminal, através do arquivo Log ou Report.



Created by [Thamires Ramos](https://github.com/ramosth)
