*** Settings ***
Documentation       CREDT-877 - (POST) /api/v1/draft

Resource            ../../../src/config/package.robot

Test Setup          Setup para o cadastro de novas consultas

*** Test Cases ***
Cenário: CREDT-879 (API) Cadastrar nova consulta com todos os campos obrigatórios
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-880 (API) Cadastrar nova consulta com Descrição contendo caracteres especiais, acentuação e números
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.DESCRICAO_CARACTERES_ESPECIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-881 (API) Cadastrar nova consulta com Descrição contendo espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.DESCRICAO_ESPACO_EM_BRANCO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-882 (API) Cadastrar nova consulta com Código do cliente contendo até 5 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_ATE_5}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-883 (API) Cadastrar nova consulta com Entradas da consulta com mais de 50 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.ENTRADA_DA_CONSULTA_MAIOR_50_CARACTERES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-884 (API) Cadastrar nova consulta com Entradas da consulta contendo caracteres especiais e acentuação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.ENTRADA_DA_CONSULTA_CARACTERES_ESPECIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=A consulta foi criada com sucesso

Cenário: CREDT-885 (API) Tentar criar consulta sem preencher o campo Nome da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_VAZIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome da consulta é obrigatório

Cenário: CREDT-886 (API) Tentar criar consulta sem preencher o campo Descrição da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.DESCRICAO_VAZIA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A descrição da consulta é obrigatória

Cenário: CREDT-887 (API) Tentar criar consulta sem preencher o campo Código do Cliente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_VAZIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A conta do cliente é obrigatória

Cenário: CREDT-888 (API) Tentar criar consulta sem preencher o campo Entrada da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.ENTRADAS_VAZIAS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=As entradas da consulta são obrigatórias

Cenário: CREDT-889 (API) Tentar criar consulta sem o campo Nome da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SEM_O_CAMPO_NOME}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome da consulta é obrigatório
    
Cenário: CREDT-890 (API) Tentar criar consulta sem o campo Descrição da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SEM_O_CAMPO_DESCRICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A descrição da consulta é obrigatória

Cenário: CREDT-891 (API) Tentar criar consulta sem o campo Código do Cliente
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SEM_O_CAMPO_CODIGO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A conta do cliente é obrigatória

Cenário: CREDT-892 (API) Tentar criar consulta sem o campo Entrada da consulta
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SEM_O_CAMPO_ENTRADA}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=As entradas da consulta são obrigatórias

Cenário: CREDT-893 (API) Tentar criar consulta com o campo Nome da consulta com letra minúscula
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_MINUSCULO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome da consulta pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula

Cenário: CREDT-894 (API) Tentar criar consulta com o campo Nome da consulta com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_ESPACO_EM_BRANCO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome da consulta não pode conter espaços em branco

Cenário: CREDT-895 (API) Tentar criar consulta com o campo Nome da consulta com caracteres especiais e acentuação
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_CARACTERES_ESPECIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome da consulta pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula

Cenário: CREDT-896 (API) Tentar criar consulta com o campo Nome da consulta já existente no gateway
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_JA_EXISTENTE_GATEWAY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A consulta já existe no gateway

Cenário: CREDT-897 (API) Tentar criar consulta com o campo Nome contendo mais de 50 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_MAIOR_50_CARACTERES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome e/ou a descrição da consulta não pode conter mais de 50 caracteres
    
Cenário: CREDT-898 (API) Tentar criar consulta com o campo Descrição contendo mais de 50 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.DESCRICAO_MAIOR_50_CARACTERES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O nome e/ou a descrição da consulta não pode conter mais de 50 caracteres

Cenário: CREDT-899 (API) Tentar criar consulta com o campo Código do cliente contendo letras
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_LETRAS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A conta do cliente só pode ser números

Cenário: CREDT-900 (API) Tentar criar consulta com o campo Código do cliente igual a zero
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_ZERO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O valor não pode ser negativo ou 0 e também não pode ser mais que 5 dígitos

Cenário: CREDT-901 (API) Tentar criar consulta com o campo Código do cliente contendo número negativo
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_NEGATIVO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O valor não pode ser negativo ou 0 e também não pode ser mais que 5 dígitos

Cenário: CREDT-902 (API) Tentar criar consulta com o campo Código do cliente contendo caracteres especiais
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_CARACTERES_ESPECIAIS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A conta do cliente só pode ser números

Cenário: CREDT-903 (API) Tentar criar consulta com o campo Código do cliente contendo mais de 5 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_MAIOR_QUE_5}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=O valor não pode ser negativo ou 0 e também não pode ser mais que 5 dígitos

Cenário: CREDT-904 (API) Tentar criar consulta com o campo Entradas da consulta contendo mais de 10 itens
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.ENTRADA_DA_CONSULTA_MAIOR_10_ITENS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A quantidade de entradas da consulta não pode ser maior que 10

Cenário: CREDT-905 (API) Tentar criar consulta com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando criar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-906 (API) Tentar criar consulta com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando criar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-907 (API) Tentar criar consulta com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando criar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-909 (API) Tentar criar consulta com token válido porém usuário da conta 1 e @neurotech
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_1_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando criar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=A conta do desenvolvedor não é válida para essa ação

Cenário: CREDT-910 (API) Tentar criar consulta com token válido porém usuário da conta 999 e NÃO @neurotech
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_999_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando criar uma consulta para desenvolvimento
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=A conta do desenvolvedor não é válida para essa ação

Cenário: CREDT-911 (API) Tentar criar consulta sem passar o body na requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA.VAZIO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Corpo da requisição ausente. O body da requisição é obrigatório para o cadastro da consulta.

Cenário: CREDT-916 (API) Tentar criar consulta com o campo Nome da consulta já existente no desenvolvimento
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.NOME_JA_EXISTENTE_DESENVOLVIMENTO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CONFLICT}
    E a api deve retornar o Json contendo o parametro statusCode    value=CONFLICT
    E a api deve retornar o Json contendo o parametro message    value=Já existe uma consulta com esse nome cadastrada

Cenário: CREDT-931 (API) Tentar criar nova consulta com o código do cliente da conta 1
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.CODIGO_DO_CLIENTE_CONTA_1}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message    value=A conta do cliente não poder ser 1
