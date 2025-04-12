*** Settings ***
Documentation       CREDT-175 - (POST) /api/v1/gateway/query

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-172 (API) Adicionar consulta com sucesso
    [Tags]    regression    sanity
    [Setup]    Obter o queryId de uma consulta do portfólio
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E Json contendo lista de resultados    consultas/post_consulta_schema

Cenário: CREDT-176 (API) Tentar adicionar consulta com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-177 (API) Tentar adicionar consulta com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-178 (API) Tentar adicionar consulta com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-179 (API) Tentar adicionar consulta com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-180 (API) Tentar adicionar uma consulta já adicionada anteriormente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.REPETIDO}
    ...    ${EMPTY}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.REPETIDO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CONFLICT}
    E a api deve retornar o Json contendo o parametro statusCode    value=CONFLICT
    E a api deve retornar o Json contendo o parametro message
    ...    value=Já existe uma consulta cadastrada para essa conta

Cenário: CREDT-181 (API) Tentar adicionar uma consulta passando um nome de consulta que não existe no Gateway
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.INEXISTENTE}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-182 (API) Tentar adicionar uma consulta, passando o nome da consulta em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.EM_BRANCO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-183 (API) Tentar adicionar uma consulta, sem passar a consulta no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.VAZIO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Corpo da requisição ausente. O body da requisição é obrigatório para o cadastro da consulta.

Cenário: CREDT-930 (API) Adicionar uma consulta rascunho com sucesso
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E Json contendo lista de resultados    consultas/post_consulta_schema

Cenário: CREDT-932 (API) Validar que uma consulta rascunho criada aparece no portfólio do cliente destino
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para obter consultas do portfólio
    ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir o conteúdo no retorno json    texto=${BODY_CONSULTA.SUCESSO_RASCUNHO.id}

Cenário: CREDT-933 (API) Validar que uma consulta rascunho criada para a conta X não pode ser adicionada na conta errada Y
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_5_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-934 (API) Tentar adicionar uma consulta rascunho já adicionada anteriormente
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta para desenvolvimento
    Quando adicionar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CONFLICT}
    E a api deve retornar o Json contendo o parametro statusCode    value=CONFLICT
    E a api deve retornar o Json contendo o parametro message
    ...    value=Já existe uma consulta cadastrada para essa conta
     
Cenário: CREDT-936 (API) Validar que as consultas no portfólio do cliente estão em ordem alfabética case insensitive
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para obter consultas do portfólio
    ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir o conteúdo em ordem alfabética no retorno json

Cenário: CREDT-937 (API) Validar que as consultas no portfólio da Neurotech estão em ordem alfabética case insensitive
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método get para obter consultas do portfólio
    ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir o conteúdo em ordem alfabética no retorno json