*** Settings ***
Documentation       CREDT-878 - (GET) /api/v1/shared/{nameCredential}

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-985 (API) Listar credencial compartilhada com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter o nome de uma credencial compartilhada da consulta
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar a credencial compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E json contendo uma das listas de resultados
    E a api deve retornar o Json contendo o parametro StopShared    value=false

Cenário: CREDT-986 (API) Listar credencial que ainda não tenha sido compartilhada
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar a credencial que não tenha sido compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.NAO_COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credencial_compartilhamento_nulo_schema
    E a api deve retornar o Json contendo o parametro Id    value=${None}
    E a api deve retornar o Json contendo o parametro QtdSubmissions    value=${None}
    E a api deve retornar o Json contendo o parametro StopShared    value=${None}
    E a api deve retornar o Json contendo o parametro CredentialId    value=${None}
    E a api deve retornar o Json contendo o parametro DateFinal    value=${None}

Cenário: CREDT-987 (API) Listar credencial com o nome em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar a credencial que não tenha sido compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${EMPTY}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro title    value=Not Found
    E a api deve retornar o Json contendo o parametro status    value=${DADOS_COMUNS.STATUS_CODE.NOTFOUND}

Cenário: CREDT-989 (API) Tentar compartilhar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para listar a credencial compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-990 (API) Tentar compartilhar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para listar a credencial compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-991 (API) Tentar compartilhar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método get para listar a credencial compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-992 (API) Tentar compartilhar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para listar a credencial compartilhada
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    nameCredential=${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.COMPARTILHADA}/${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

