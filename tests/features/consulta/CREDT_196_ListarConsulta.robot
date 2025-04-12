*** Settings ***
Documentation       CREDT-196 - (GET) /api/v1/gateway/query

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-197 (API) Listar consultas com sucesso
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-199 (API) Listar consultas com parâmetro page inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_INVALID}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: page

Cenário: CREDT-200 (API) Listar consultas com parâmetro size inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE_INVALID}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: size

Cenário: CREDT-201 (API) Listar consultas mesmo com os parâmetros page e size vazios
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_EMPTY}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE_EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-202 (API) Tentar listar consultas com Token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar as consultas com token inválido
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-203 (API) Tentar listar consultas com Token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método get para listar as consultas com token vazio
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-204 (API) Tentar listar consultas com Token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para listar as consultas com token expirado
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-205 (API) Tentar listar consultas com Token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas com token sem autorização
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-206 (API) Tentar listar consultas passando um valor do page maior que o número de páginas com registros da lista
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas passando um valor do page maior que o número de páginas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_MAIOR}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro GatewayQueries    value=[]

Cenário: CREDT-207 (API) Tentar listar consultas sem passar nenhum parâmetro
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-912 (API) Listar consultas do desenvolvimento com sucesso
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-913 (API) Listar consultas do desenvolvimento com parâmetro page inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_INVALID}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: page

Cenário: CREDT-914 (API) Listar consultas do desenvolvimento com parâmetro size inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE_INVALID}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: size

Cenário: CREDT-915 (API) Listar consultas do desenvolvimento mesmo com os parâmetros page e size vazios
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_EMPTY}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE_EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-920 (API) Tentar listar consultas do desenvolvimento passando um valor do page maior que o número de páginas com registros da lista
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento passando um valor do page maior que o número de páginas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE_MAIOR}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro GatewayQueries    value=[]

Cenário: CREDT-921 (API) Tentar listar consultas do desenvolvimento sem passar nenhum parâmetro
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/get_consultas_schema

Cenário: CREDT-935 (API) Listar consultas rascunhos adicionadas com sucesso
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta para desenvolvimento
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir o conteúdo no retorno json    texto=${BODY_CONSULTA.SUCESSO_RASCUNHO.id}