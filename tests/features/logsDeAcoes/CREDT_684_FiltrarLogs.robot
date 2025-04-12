*** Settings ***
Documentation       CREDT-684 - (POST) /api/v1/credentials/logs

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-705 (API) Filtrar logs de ação com sucesso por Consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.CONSULTA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.CONSULTA}

Cenário: CREDT-708 (API) Filtrar logs de ação com sucesso por Credencial
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.CREDENCIAL}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.CREDENCIAL}

Cenário: CREDT-709 (API) Filtrar logs de ação com sucesso por Usuário
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.USUARIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.USUARIO}

Cenário: CREDT-710 (API) Filtrar logs de ação com sucesso por Ação de Edição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_EDICAO}

Cenário: CREDT-713 (API) Filtrar logs de ação com sucesso por um intervalo de datas
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.INTERVALO_DATAS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.INTERVALO_DATAS}

Cenário: CREDT-714 (API) Filtrar logs de ação com sucesso por Consulta, Credencial, Usuário, Ação e Intervalo de datas, simultaneamente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.TODOS_OS_FILTROS}

Cenário: CREDT-715 (API) Filtrar logs de ação com sucesso sem selecionar nenhum filtro
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.NENHUM_FILTRO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema

Cenário: CREDT-716 (API) Filtrar logs de ação com sucesso por um filtro que não corresponde a nenhum log registrado na conta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.LOG_INEXISTENTE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve exibir um array vazio no retorno de Logs

Cenário: CREDT-717 (API) Tentar filtrar logs de ação por Ação inválida
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_INVALIDA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=Tipo de ação para o log está inválido

Cenário: CREDT-718 (API) Tentar filtrar logs de ação passando uma data inicial mas não uma data final
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.APENAS_DATA_INICIAL}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A data de inicio ou a de fim não podem ser vazias quando uma das duas é informada

Cenário: CREDT-720 (API) Tentar filtrar logs de ação passando uma data final mas não uma data inicial
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.APENAS_DATA_FINAL}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A data de inicio ou a de fim não podem ser vazias quando uma das duas é informada

Cenário: CREDT-721 (API) Tentar filtrar logs de ação, passando uma data inicial posterior à data final
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.DATA_INICIAL_MAIOR}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BAD_GATEWAY}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_GATEWAY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A data de início não pode ser maior que a data final

Cenário: CREDT-722 (API) Tentar filtrar logs de ação com Token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-723 (API) Tentar filtrar logs de ação com Token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-724 (API) Tentar filtrar logs de ação com Token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-725 (API) Tentar filtrar logs de ação com Token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-728 (API) Filtrar logs de ação com sucesso por Ação de Promoção
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_PROMOCAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_PROMOCAO}

Cenário: CREDT-729 (API) Filtrar logs de ação com sucesso por Ação de Criação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_CRIACAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_CRIACAO}

Cenário: CREDT-730 (API) Filtrar logs de ação com sucesso por Ação de Edição de Entradas e Valores
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_EDICAO_DE_ENTRADA_E_VALORES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_EDICAO_DE_ENTRADA_E_VALORES}

Cenário: CREDT-731 (API) Filtrar logs de ação com sucesso por Ação de Exclusão
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_EXCLUSAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_EXCLUSAO}

Cenário: CREDT-732 (API) Filtrar logs de ação com sucesso por Ação de Edição de Valores
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.ACAO_EDICAO_DE_VALORES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.ACAO_EDICAO_DE_VALORES}

Cenário: CREDT-1074 (API) Filtrar logs de ação com sucesso por um intervalo de data no mesmo dia
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar logs de ações
    ...    ${ENDPOINT_LOGS_FILTER.PATH}
    ...    ${BODY_LOGS_FILTER.SUCESSO}
    ...    ${BODY_LOGS_FILTER.INTERVALO_DATA_MESMO_DIA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    logs_de_acoes/post_logs_filter_schema
    E validar o filtro de logs de ações pelo campo na resposta    ${BODY_LOGS_FILTER.INTERVALO_DATA_MESMO_DIA}