*** Settings ***
Documentation       CREDT-216 - (GET) /api/v1/gateway/query

Resource            ../../../src/config/package.robot

Test Setup          Obter as consultas da conta


*** Test Cases ***
Cenário: CREDT-217 (API) Listar entradas de uma consulta com sucesso
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_entradas_schema

Cenário: CREDT-218 (API) Tentar listar entradas de uma consulta com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-219 (API) Tentar listar entradas de uma consulta com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-220 (API) Tentar listar entradas de uma consulta com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-221 (API) Tentar listar entradas de uma consulta com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-222 (API) Tentar listar entradas de uma consulta passando um valor inválido no 'queryId'
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.INVALIDO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-223 (API) Tentar listar entradas de uma consulta inexistente no Gateway
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.INEXISTENTE}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message    value=A Consulta não foi encontrada para poder associar a conta
