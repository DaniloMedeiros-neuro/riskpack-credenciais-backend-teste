*** Settings ***
Documentation       CREDT-753 - (DELETE) /api/v1/gateway/query/{queryId}

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-754 (API) Excluir consulta com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter consulta sem credenciais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=NO_CONTENT
    E a api deve retornar o Json contendo o parametro message
    ...    value=A consulta foi excluída com sucesso

Cenário: CREDT-756 (API) Tentar excluir consulta com credenciais cadastradas
    [Tags]    regression    sanity
    [Setup]    Obter consulta com credenciais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_COM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Essa consulta tem credenciais associadas e não pode ser excluída

Cenário: CREDT-757 (API) Tentar excluir consulta inexistente
    [Tags]    regression    sanity
    [Setup]    Obter consulta com credenciais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CREDENCIAL_INEXISTENTE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-758 (API) Tentar excluir consulta com Token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método delete para excluir a consulta com token inválido
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-759 (API) Tentar excluir consulta com Token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método delete para excluir a consulta com token expirado
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-760 (API) Tentar excluir consulta com Token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método delete para excluir a consulta com token vazio
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-761 (API) Tentar excluir consulta com Token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta com token sem autorização
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-1066 (API) Excluir consulta rascunho com sucesso na conta do desenvolvedor
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho sem credencial na conta do desenvolvedor
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=NO_CONTENT
    E a api deve retornar o Json contendo o parametro message
    ...    value=A consulta foi excluída com sucesso
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api não deve exibir o conteúdo no retorno json    texto=${BODY_CONSULTA.SUCESSO_RASCUNHO.id}

Cenário: CREDT-1067 (API) Tentar excluir consulta rascunho da conta do desenvolvedor com token de usuário de outra conta
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho sem credencial na conta do desenvolvedor
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-1068 (API) Tentar excluir consulta rascunho com credenciais cadastradas na conta do desenvolvedor
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho com credencial na conta do desenvolvedor
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Essa consulta tem credenciais associadas e não pode ser excluída

Cenário: CREDT-1069 (API) Excluir consulta rascunho com sucesso na conta do cliente
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho sem credencial na conta do cliente
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=NO_CONTENT
    E a api deve retornar o Json contendo o parametro message
    ...    value=A consulta foi excluída com sucesso
    Quando executar o método get para listar as consultas do desenvolvimento
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api não deve exibir o conteúdo no retorno json    texto=${BODY_CONSULTA.SUCESSO_RASCUNHO.id}

Cenário: CREDT-1070 (API) Tentar excluir consulta rascunho da conta do cliente com token de usuário de outra conta
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho sem credencial na conta do cliente
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-1071 (API) Tentar excluir consulta rascunho com credenciais cadastradas na conta do cliente
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha consulta rascunho com credencial na conta do cliente
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Essa consulta tem credenciais associadas e não pode ser excluída

Cenário: CREDT-1072 (API) Tentar excluir consulta rascunho na conta do desenvolvedor após criar credencial na conta do cliente
    [Tags]    regression    sanity
    [Setup]    Dado que obtenha o queryId da consulta do cliente na conta do desenvolvedor
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método delete para excluir a consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}/${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.ERRORINTERNAL}
    E a api deve retornar o Json contendo o parametro statusCode    value=INTERNAL_SERVER_ERROR
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não é possível excluir a consulta, pois essa está com credenciais associadas na conta do cliente
    E validar que a credencial foi criada exclusivamente na conta do cliente e não na conta do desenvolvedor