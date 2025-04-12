*** Settings ***
Documentation       Arquivo de Mapeamento de arquivos e bibliotecas

### Bibliotecas ####
Library             OperatingSystem
Library             Collections
Library             DateTime
Library             RequestsLibrary
Library             FakerLibrary    locale=pt_BR
Library             String
Library             BuiltIn
Library             yaml
Library             JSONLibrary
Library             base64

### Data ###
Variables           ../auto/auth/auth.yaml
Variables           ../utils/common.yaml
Variables           ../auto/datatest/consultas/consultas.yaml
Variables           ../auto/datatest/consultas/filtro.yaml
Variables           ../auto/datatest/credenciais/filtro.yaml
Variables           ../auto/datatest/credenciais/credenciais.yaml
Variables           ../auto/datatest/logs_de_acoes/filtro.yaml
Variables           ../auto/datatest/logs_de_acoes/logs.yaml
Variables           ../auto/datatest/prometheus/monitoramento.yaml

### Config-Framework ###
Resource            hooks.robot

### Utils ###
Resource            ../utils/common.robot

