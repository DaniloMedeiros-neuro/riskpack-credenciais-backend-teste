*** Settings ***
Documentation       CREDT-272 - (GET) /api/v1/credential/{id}

Resource            ../../../src/config/package.robot

Test Setup          Obter o credtId de uma credencial da consulta


*** Test Cases ***
Cenário: CREDT-263 (API) Detalhar credencial com sucesso
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para detalhar credencial de uma consulta
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_consulta_schema

Cenário: CREDT-264 (API) Tentar detalhar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método get para detalhar credencial de uma consulta com token inválido
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-265 (API) Tentar detalhar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método get para detalhar credencial de uma consulta com token expirado
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-266 (API) Tentar detalhar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método get para detalhar credencial de uma consulta com token vazio
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-267 (API) Tentar detalhar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para detalhar credencial de uma consulta com token sem autorização
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-268 (API) Tentar detalhar credencial passando 'credtId' inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para detalhar credencial de uma consulta passando 'credtId' inválido
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    credtId=${ENDPOINT_CREDENCIAL.CREDTID.INVALIDO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não foi encontrada uma credencial para o Id informado
