*** Settings ***
Documentation       CREDT-292 - (GET) /api/v1/gateway/query/{queryId}/credentials

Resource            ../../../src/config/package.robot

Test Setup          Obter as consultas da conta com credenciais cadastradas


*** Test Cases ***
Cenário: CREDT-273 (API) Listar credenciais com sucesso sem definir ordenação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema

Cenário: CREDT-274 (API) Listar credenciais com sucesso ordenando por Descrição em ordem crescente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    E validar a ordenação pelo campo na resposta
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}

Cenário: CREDT-275 (API) Listar credenciais com sucesso ordenando por Descrição em ordem decrescente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    E validar a ordenação pelo campo na resposta
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}

## TESTE CANCELADO: Este caso de teste não se aplica mais pois o campo Ambiente deixou de existir.
# Cenário: CREDT-276 (API) Listar credenciais com sucesso ordenando por Ambiente em ordem crescente
    # [Tags]    regression    sanity
    # Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    # Quando executar o método get para listar as credenciais por consulta
    # ...    ${ENDPOINT_CONSULTAS.PATH}
    # ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    # ...    origem=credentials
    # ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[1]}
    # ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    # Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    # E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    # E validar a ordenação pelo campo na resposta
    # ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[1]}
    # ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}

## TESTE CANCELADO: Este caso de teste não se aplica mais pois o campo Ambiente deixou de existir.
# Cenário: CREDT-277 (API) Listar credenciais com sucesso ordenando por Ambiente em ordem decrescente
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método get para listar as credenciais por consulta
#    ...    ${ENDPOINT_CONSULTAS.PATH}
#    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
#    ...    origem=credentials
#    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[1]}
#    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
#    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
#    E validar a ordenação pelo campo na resposta
#    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[1]}
#    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}

Cenário: CREDT-278 (API) Listar credenciais com sucesso ordenando por Status em ordem crescente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    E validar a ordenação pelo campo na resposta
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}

Cenário: CREDT-279 (API) Listar credenciais com sucesso ordenando por Status em ordem decrescente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    E validar a ordenação pelo campo na resposta
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[1]}

Cenário: CREDT-280 (API) Tentar listar credenciais com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar as credenciais por consulta com token inválido
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-281 (API) Tentar listar credenciais com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para listar as credenciais por consulta com token expirado
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-282 (API) Tentar listar credenciais com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método get para listar as credenciais por consulta com token vazio
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-283 (API) Tentar listar credenciais com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta com token sem autorização
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-284 (API) Tentar listar credenciais passando uma consulta que não foi adicionada à conta utilizada
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.INEXISTENTE}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-286 (API) Tentar listar credenciais passando o nome da consulta só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_VAZIO}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-288 (API) Listar credenciais com direção e campo de ordenação vazios
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[3]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[2]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema
    E validar a ordenação pelo campo na resposta
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}

Cenário: CREDT-289 (API) Tentar listar credenciais com direção e campo de ordenação preenchidos somente com espaço em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[4]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[3]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_consultas_credenciais_schema

Cenário: CREDT-290 (API) Tentar listar credenciais passando um valor inválido para o campo de ordenação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[5]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[0]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: sortField

Cenário: CREDT-291 (API) Tentar listar credenciais passando um valor inválido para a direção de ordenação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}
    ...    origem=credentials
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[0]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[4]}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: sortDirection
