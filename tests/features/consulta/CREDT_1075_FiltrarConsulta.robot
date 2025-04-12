*** Settings ***
Documentation       CREDT-1075 - (POST) /api/v1/gateway/query/{queryName}/filter

Resource            ../../../src/config/package.robot


*** Test Cases ***
Cenário: CREDT-1085 (API) Filtrar consultas com sucesso por Nome completo na conta da Neurotech
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/post_consulta_filter_schema
    E validar o filtro de consultas pelo campo na resposta    ${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}

Cenário: CREDT-1086 (API) Filtrar consultas com sucesso por Nome completo na conta do desenvolvedor
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/post_consulta_filter_schema
    E validar o filtro de consultas pelo campo na resposta    ${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}

Cenário: CREDT-1087 (API) Filtrar consultas com sucesso por Nome completo na conta do cliente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/post_consulta_filter_schema
    E validar o filtro de consultas pelo campo na resposta    ${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}

Cenário: CREDT-1088 (API) Filtrar consultas com sucesso por Nome parcial
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.PARCIAL}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E Json contendo lista de resultados    consultas/post_consulta_filter_schema
    E validar o filtro de consultas pelo campo na resposta    ${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.PARCIAL}

Cenário: CREDT-1089 (API) Filtrar consultas com sucesso por Nome inexistente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.INEXISTENTE}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar uma lista de consultas vazia

Cenário: CREDT-1090 (API) Filtrar consultas com sucesso por Nome vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.VAZIO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar uma lista de consultas vazia

Cenário: CREDT-1091 (API) Filtrar consultas com sucesso por Nome inválido
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.INVALIDO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar uma lista de consultas vazia

Cenário: CREDT-1092 (API) Tentar filtrar consulta sem passar o campo obrigatório Nome
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${EMPTY}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.METHOD_NOT_ALLOWED}
    E a api deve retornar o Json contendo o parametro statusCode    value=METHOD_NOT_ALLOWED
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Requisição do método 'POST' está incompleta. Preencha os campos obrigatórios.

Cenário: CREDT-1093 (API) Tentar filtrar consulta com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-1094 (API) Tentar filtrar consulta com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-1095 (API) Tentar filtrar consulta com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-1096 (API) Tentar filtrar consulta com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar sem body o método post para filtrar consultas
    ...    ${ENDPOINT_CONSULTA_FILTER.PATH}/${ENDPOINT_CONSULTA_FILTER.QUERY_NAME.COMPLETO}/filter
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

