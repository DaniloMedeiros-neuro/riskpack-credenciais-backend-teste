*** Settings ***
Documentation       CREDT-365 - (PUT) /api/v1/credentials/{credtId}/status

Resource            ../../../src/config/package.robot

Test Setup          Obter da consulta o credtId e setar o valor na variável global


*** Test Cases ***
Cenário: CREDT-364 (API) Ativar credencial com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_INATIVO}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Status da credencial alterada com sucesso

Cenário: CREDT-366 (API) Inativar credencial com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_ATIVO}

    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para inativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.INATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Status da credencial alterada com sucesso

Cenário: CREDT-367 (API) Ativar credencial com status ativo
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_ATIVO}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Status da credencial alterada com sucesso

Cenário: CREDT-368 (API) Inativar credencial com status inativo
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_INATIVO}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para inativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Status da credencial alterada com sucesso

Cenário: CREDT-369 (API) Tentar ativar/inativar credencial passando um Status inválido no body
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.INVALIDO}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Status inválido associado à credencial

Cenário: CREDT-370 (API) Tentar ativar/inativar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-371 (API) Tentar ativar/inativar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-372 (API) Tentar ativar/inativar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-373 (API) Tentar ativar/inativar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-375 (API) Tentar ativar/inativar credencial passando um id de credencial inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.INVALIDO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não foi encontrada uma credencial para o Id informado

Cenário: CREDT-376 (API) Tentar ativar/inativar credencial passando um id de credencial vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.VAZIO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O objeto está inválido para a busca
