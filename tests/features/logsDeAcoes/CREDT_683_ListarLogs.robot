*** Settings ***
Documentation       CREDT-683 - (GET) /api/v1/credentials/logs

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-687 (API) Listar logs de ação com sucesso
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/get_logs_list_schema

Cenário: CREDT-688 (API) Tentar listar logs de ação com parâmetro page inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE_INVALID}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: page

Cenário: CREDT-689 (API) Tentar listar logs de ação com parâmetro size inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE_INVALID}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: size

Cenário: CREDT-690 (API) Listar logs de ação mesmo com os parâmetros page e size vazios
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE_EMPTY}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE_EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/get_logs_list_schema

Cenário: CREDT-691 (API) Tentar listar logs de ação passando um valor do 'page' maior que o número de páginas com registros da lista
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE_MAIOR}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro Logs    value=[]

Cenário: CREDT-692 (API) Tentar listar logs de ação sem passar nenhum parâmetro
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/get_logs_list_schema

Cenário: CREDT-693 (API) Tentar listar logs de ação com Token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-694 (API) Tentar listar logs de ação com Token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-695 (API) Tentar listar logs de ação com Token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-696 (API) Tentar listar logs de ação com Token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar os logs das ações
    ...    ${ENDPOINT_LOGS_LIST.PATH}
    ...    page=${ENDPOINT_LOGS_LIST.PARAMETER.PAGE}
    ...    size=${ENDPOINT_LOGS_LIST.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource
