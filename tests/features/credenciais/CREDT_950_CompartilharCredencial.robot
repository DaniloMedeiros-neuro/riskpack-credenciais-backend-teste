*** Settings ***
Documentation       CREDT-950 - (POST) /api/v1/shared

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-995 (API) Compartilhar credencial ativa em consulta rascunho com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da nova consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_NOVO_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso
    E validar que a credencial compartilhada está sendo listada na credencial da consulta na conta do desenvolvedor

Cenário: CREDT-996 (API) Compartilhar credencial ativa em consulta definitiva com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-997 (API) Interromper compartilhamento da credencial ativa em consulta rascunho com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_RASCUNHO}
    Quando executar o método post para interromper o compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-998 (API) Interromper compartilhamento da credencial ativa em consulta definitiva com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Quando executar o método post para interromper o compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-999 (API) Tentar compartilhar credencial com status inativo em consulta rascunho
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status inativo da consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial precisa está com o status ativo para poder compartilhar

Cenário: CREDT-1000 (API) Tentar compartilhar credencial com status inativo em consulta definitiva
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status inativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial precisa está com o status ativo para poder compartilhar

Cenário: CREDT-1001 (API) Tentar compartilhar credencial com body incorreto
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=Corpo da requisição ausente. O body da requisição é obrigatório para o poder compartilhar a credencial

Cenário: CREDT-1002 (API) Tentar compartilhar credencial com credentialId vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_VAZIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial não pode ser nula

Cenário: CREDT-1003 (API) Tentar compartilhar credencial com credentialId nulo
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_NULO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial não pode ser nula

Cenário: CREDT-1004 (API) Tentar compartilhar credencial com credentialId inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_INEXISTENTE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=Não foi encontrada uma credencial para o Id informado

Cenário: CREDT-1005 (API) Compartilhar credencial com dateFinal vazio
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_VAZIO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-970 (API) Tentar compartilhar a credencial com uma data final inválida
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_INVÁLIDA}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A data final está inválida

Cenário: CREDT-971 (API) Tentar compartilhar a credencial com uma data final anterior à data atual
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_PASSADA}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A data final precisa ser maior que a data de hoje

Cenário: CREDT-972 (API) Tentar compartilhar credencial por uma data final inexistente
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_INEXISTENTE}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A data final está inválida

Cenário: CREDT-1008 (API) Compartilhar credencial com dateFinal em formato dd_mm_aaaa
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_FORMATO_DD_MM_AAAA_TRACO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-1009 (API) Compartilhar credencial com dateFinal em formato dd/mm/aaaa
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_FORMATO_DD_MM_AAAA}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-1010 (API) Compartilhar credencial com dateFinal em formato aaaa_mm_dd
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_FORMATO_AAAA_MM_DD_TRACO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-1011 (API) Compartilhar credencial com dateFinal em formato aaaa/mm/dd
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_FORMATO_AAAA_MM_DD}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-1012 (API) Compartilhar credencial com qtdSubmissions vazio
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QTD_SUBMISSIONS_VAZIO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial compartilhada com sucesso

Cenário: CREDT-1013 (API) Tentar compartilhar credencial com qtdSubmissions maior que 2 dígitos
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QTD_SUBMISSIONS_MAIOR_2_DIGITOS}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A quantidade de submissão não pode ter mais de 2 dígitos

Cenário: CREDT-1014 (API) Tentar compartilhar credencial com qtdSubmissions for diferente do tipo inteiro
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QTD_SUBMISSIONS_LETRAS}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A Requisição está com um formato inválido.

Cenário: CREDT-1015 (API) Tentar compartilhar credencial com qtdSubmissions inteiro menor que zero
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QTD_SUBMISSIONS_NEGATIVO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O valor da quantidade de submissões não pode ser negativo

Cenário: CREDT-1016 (API) Tentar interromper compartilhamento da credencial com status inativo em consulta rascunho
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status inativo da consulta rascunho para interromper o compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_RASCUNHO_INTERROMPER}
    Quando executar o método post para interromper o compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_RASCUNHO_INTERROMPER}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial precisa está com o status ativo para poder compartilhar

Cenário: CREDT-1017 (API) Tentar interromper compartilhamento da credencial com status inativo em consulta definitiva
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status inativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A credencial precisa está com o status ativo para poder compartilhar

Cenário: CREDT-1019 (API) Tentar compartilhar credencial com stopShared diferente de booleano
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED_NAO_BOOLEANO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A informação para saber deve parar de compartilhar está no formato inválido

Cenário: CREDT-1020 (API) Tentar compartilhar credencial com stopShared vazio
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED_VAZIO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A informação para saber deve parar de compartilhar está no formato inválido

Cenário: CREDT-1021 (API) Tentar compartilhar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-1022 (API) Tentar compartilhar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-1023 (API) Tentar compartilhar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-1024 (API) Tentar compartilhar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL.SUCESSO_COMPARTILHAMENTO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-953 (API) Tentar compartilhar credencial com os campos dateFinal e qtdSubmissions vazios
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.DATE_FINAL_E_QTD_SUBMISSIONS_VAZIOS}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A data ou a quantidade de submissões não podem ser nulas

Cenário: CREDT-1037 (API) Tentar interromper compartilhamento da credencial com status ativa que ainda não foi compartilhada em consulta rascunho
    [Tags]    regression    sanity
    [Setup]    Obter uma credencial da consulta com status ativo da consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para compartilhar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH_COMPARTILHAMENTO}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.STOP_SHARED}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_RASCUNHO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O status de parar de compartilhar está habilitado para uma credencial que não foi compartilhada
