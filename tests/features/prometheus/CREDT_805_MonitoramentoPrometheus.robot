*** Settings ***
Documentation       CREDT-805 - (GET) /actuator/{}

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-806 (API) Listar endpoints de métricas, monitoramento e healthcheck
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    prometheus/get_actuator_schema

Cenário: CREDT-807 (API) Listar status da aplicação
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus 
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_HEALTH}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    prometheus/get_actuator_health_schema

Cenário: CREDT-808 (API) Listar informações sobre a aplicação
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_INFO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    prometheus/get_actuator_info_schema

Cenário: CREDT-809 (API) Listar as métricas da aplicação em formato requerido pelo Prometheus
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_PROMETHEUS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}

Cenário: CREDT-810 (API) Listar a lista de nomes de métricas
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_METRICS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    prometheus/get_actuator_metrics_schema

Cenário: CREDT-811 (API) Listar a informação sobre uma métrica específica
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_METRICS}/${ENDPOINT_PROMETHEUS_LIST.PARAMETER.NAME_METRICS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    prometheus/get_actuator_metrics_especifica_schema

Cenário: CREDT-812 (API) Listar a informação sobre uma métrica inexistente
    [Tags]    regression    sanity    novo
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_METRICS}/${ENDPOINT_PROMETHEUS_LIST.PARAMETER.NAME_METRICS_INVALID}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api não deve exibir nenhum retorno

Cenário: CREDT-819 (API) Validar alerta de colisão de Credenciais ao listar métricas
    [Tags]    regression    sanity    novo
    [Setup]    Obter uma credencial da consulta para colisão
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_ADMIN_CONTA_654}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_COLISAO.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Sleep    90s
    Quando executar o método do Prometheus
    ...    ${ENDPOINT_PROMETHEUS_LIST.PATH_PROMETHEUS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir o conteúdo no retorno    texto=credential_conflict_total{Consulta="${BODY_CREDENCIAL.SUCESSO_COLISAO.QueryName}",Conta="654",Credencial="${BODY_CREDENCIAL.NOME_ALEATORIO_COLISAO.campo1.valor}"}
    E a api deve exibir o conteúdo no retorno    texto=credential_conflict_topdeskId_total{Chamado_aberto_para_a_colisao="REQ