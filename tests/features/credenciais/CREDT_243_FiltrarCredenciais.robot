*** Settings ***
Documentation       CREDT-243 - (POST) /api/v1/credentials/search

Resource            ../../../src/config/package.robot


*** Test Cases ***
## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais filtrar por Ambiente.
# Cenário: CREDT-295 (API) Filtrar credenciais com sucesso por Ambiente HML
#     [Tags]    regression    sanity
#     Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#     Quando executar o método post para filtrar credenciais
#     ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
#     ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
#     ...    ${BODY_CREDENCIAL_FILTER.AMBIENTE_HML}
#     ...    Filter
#     Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
#     E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
#     E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.AMBIENTE_HML}

## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais filtrar por Ambiente.
# Cenário: CREDT-296 (API) Filtrar credenciais com sucesso por Ambiente PRD
#     [Tags]    regression    sanity
#     Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#     Quando executar o método post para filtrar credenciais
#     ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
#     ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
#     ...    ${BODY_CREDENCIAL_FILTER.AMBIENTE_PRD}
#     ...    Filter
#     Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
#     E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
#     E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.AMBIENTE_PRD}

## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais filtrar por Ambiente.
# Cenário: CREDT-297 (API) Tentar filtrar credenciais passando um Ambiente inválido
#     [Tags]    regression    sanity
#     Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#     Quando executar o método post para filtrar credenciais
#     ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
#     ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
#     ...    ${BODY_CREDENCIAL_FILTER.AMBIENTE_INVALIDO}
#     ...    Filter
#     Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#     E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#     E a api deve retornar o Json contendo o parametro message
#     ...    value=Ambiente inválido associado à credencial: ${BODY_CREDENCIAL_FILTER.AMBIENTE_INVALIDO.campo1.valor}

Cenário: CREDT-298 (API) Filtrar credenciais com sucesso por Status Ativo
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.STATUS_ATIVO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.STATUS_ATIVO}

Cenário: CREDT-299 (API) Filtrar credenciais com sucesso por Status Inativo
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.STATUS_INATIVO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.STATUS_INATIVO}

Cenário: CREDT-300 (API) Tentar filtrar credenciais passando um Status inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.STATUS_INVALIDO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=Status inválido associado à credencial

Cenário: CREDT-301 (API) Filtrar credenciais com sucesso por Descrição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.DESCRICAO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.DESCRICAO}

Cenário: CREDT-302 (API) Filtrar credenciais com sucesso por uma Descrição inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.DESCRICAO_INEXISTENTE}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir um array vazio no retorno

Cenário: CREDT-303 (API) Filtrar credenciais com sucesso por Descrição, Ambiente e Status
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.SUCESSO}

Cenário: CREDT-304 (API) Filtrar credenciais com sucesso sem selecionar nenhum filtro
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.FILTROS_VAZIO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema

Cenário: CREDT-307 (API) Tentar filtrar credenciais com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-308 (API) Tentar filtrar credenciais com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-309 (API) Tentar filtrar credenciais com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-310 (API) Tentar filtrar credenciais com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-311 (API) Tentar filtrar credenciais sem passar uma consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.CONSULTA_VAZIA}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-312 (API) Tentar filtrar credenciais passando uma consulta do Gateway que não foi adicionada à conta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.CONSULTA_INEXISTENTE}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-533 (API) Filtrar credenciais com sucesso por Nome
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.DESCRICAO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.DESCRICAO}

Cenário: CREDT-534 (API) Filtrar credenciais com sucesso por uma Nome inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.NOME_INEXISTENTE}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir um array vazio no retorno

Cenário: CREDT-535 (API) Filtrar credenciais com sucesso por Usuário
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.USUARIO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar o filtro pelo campo na resposta    ${BODY_CREDENCIAL_FILTER.USUARIO}

Cenário: CREDT-536 (API) Filtrar credenciais com sucesso por uma Usuário inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.USUARIO_INEXISTENTE}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir um array vazio no retorno

Cenário: CREDT-1097 (API) Validar a paginação dos resultados filtrados
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}?page=${ENDPOINT_CONSULTA_FILTER.PARAMETER.PAGE_SECOND}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${BODY_CREDENCIAL_FILTER.FILTROS_VAZIO}
    ...    Filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    credenciais/get_credenciais_filter_schema
    E validar a paginação dos resultados    ${ENDPOINT_CONSULTA_FILTER.PARAMETER.SIZE_20}