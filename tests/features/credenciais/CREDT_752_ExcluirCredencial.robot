*** Settings ***
Documentation       CREDT-752 - (DELETE) /api/v1/credentials/{credtId}

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-762 (API) Excluir com sucesso credencial que está inativa há 8 dias ou mais
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta para exclusão que está inativa há 8 dias ou mais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message
    ...    value=Credencial excluída com sucesso

Cenário: CREDT-763 (API) Excluir com sucesso credencial inativa criada há menos de 24 horas e que nunca foi ativada
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta para exclusão criada a menos de 24 horas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message
    ...    value=Credencial excluída com sucesso

Cenário: CREDT-765 (API) Tentar excluir credencial inativa criada há menos de 24 horas, mas que foi ativada e inativada
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta para exclusão criada a menos de 24 horas, para ativar e inativar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Quando executar o método put para inativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.INATIVAR}
    ...    ${EMPTY}
    ...    data=True
    Quando executar o método delete para excluir a credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Credencial não pode ser excluída antes de 8 dias da data de inativação

Cenário: CREDT-766 (API) Tentar excluir credencial ativa
    [Tags]    regression    sanity
    [Setup]    Obter o credtId de uma credencial da consulta para exclusão com status ativo
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Credencial não pode ser excluída antes de 8 dias da data de inativação

Cenário: CREDT-768 (API) Tentar excluir credencial com Token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método delete para excluir a credencial com token inválido
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-769 (API) Tentar excluir credencial com Token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método delete para excluir a credencial com token expirado
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-770 (API) Tentar excluir credencial com Token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método delete para excluir a credencial com token vazio
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-771 (API) Tentar excluir credencial com Token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a credencial com token sem autorização
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-773 (API) Tentar excluir credencial inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.INVALIDO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não foi encontrada uma credencial para o Id informado
