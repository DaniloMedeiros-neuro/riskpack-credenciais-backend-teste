*** Settings ***
Documentation       CREDT-244 - (PUT) /api/v1/credentials/{credtId}

Resource            ../../../src/config/package.robot

Test Setup          Obter o credtId em uma credencial da consulta ABRTELECOM


*** Test Cases ***
Cenário: CREDT-325 (API) Editar credencial com Status Inativo
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_INATIVO}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Credencial atualizada com sucesso

Cenário: CREDT-327 (API) Editar credencial com Status Ativo
    [Tags]    regression    sanity
    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.STATUS_ATIVO}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Credencial atualizada com sucesso

## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais alterar o Ambiente durante a edição.
# Cenário: CREDT-328 (API) Editar credencial passando o Ambiente HML
#    [Tags]    regression    sanity
#    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.AMBIENTE_HML}
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
#    Quando executar o método put para editar credencial
#    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
#    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
#    ...    ${EMPTY}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
#    E a api deve retornar o Json contendo o parametro statusCode    value=OK
#    E a api deve retornar o Json contendo o parametro message    value=Credencial atualizada com sucesso

## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais alterar o Ambiente durante a edição.
# Cenário: CREDT-329 (API) Editar credencial passando o Ambiente PRD
#    [Tags]    regression    sanity
#    [Setup]    Obter da consulta o credtId e setar o valor na variável global    ${BODY_CREDENCIAL_FILTER.AMBIENTE_PRD}
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
#    Quando executar o método put para editar credencial
#    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
#    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
#    ...    ${EMPTY}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
#    E a api deve retornar o Json contendo o parametro statusCode    value=OK
#    E a api deve retornar o Json contendo o parametro message    value=Credencial atualizada com sucesso

## TESTE CANCELADO: Este caso de teste não se aplica mais pois ficou decidido que não poderá mais alterar o Ambiente durante a edição.
# Cenário: CREDT-330 (API) Tentar editar credencial passsando um Ambiente inválido
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método put para editar credencial
#    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
#    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
#    ...    ${BODY_CREDENCIAL.AMBIENTE_MINUSCULO_EDICAO}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message
#    ...    value=Ambiente inválido associado à credencial: ${BODY_CREDENCIAL.AMBIENTE_MINUSCULO_EDICAO.campo1.valor}

Cenário: CREDT-331 (API) Tentar editar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-332 (API) Tentar editar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-333 (API) Tentar editar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-334 (API) Tentar editar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-339 (API) Tentar editar credencial passando um id de credencial inexistente no endpoint
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.INVALIDO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não foi encontrada uma credencial para o Id informado

Cenário: CREDT-340 (API) Tentar editar credencial sem passar o id da credencial no endpoint
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.VAZIO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=Não pode converter o tipo do parâmetro: credtId

Cenário: CREDT-346 (API) Tentar editar credencial passando uma Descrição vazia
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_VAZIA_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode ser vazia
    ...    novo_campo=true

Cenário: CREDT-347 (API) Tentar editar credencial passando uma descrição preenchida só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_ESPACOS_EM_BRANCO_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode ser vazia
    ...    novo_campo=true

Cenário: CREDT-350 (API) Tentar editar credencial passando uma Descrição com caracteres especiais
    [Tags]    regression    sanity
    [Setup]    Obter o credtId em uma credencial da consulta ABRTELECOM
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_CARACTERES_ESPECIAL_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.SUCESSO}
    E a api deve retornar o Json contendo o parametro statusCode    value=OK
    E a api deve retornar o Json contendo o parametro message    value=Credencial atualizada com sucesso

Cenário: CREDT-351 (API) Tentar editar credencial passando uma Descrição com mais de 50 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.SUCESSO_EDICAO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_COM_MAIS_DE_50_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode conter mais de 50 caracteres
    ...    novo_campo=true

Cenário: CREDT-352 (API) Tentar editar credencial passando uma entrada com o nome vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.ENTRADA_NOME_VAZIO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=As entradas da credencial não correspondem ao esperado da consulta

Cenário: CREDT-353 (API) Tentar editar credencial passando uma entrada com o nome preenchido só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.ENTRADA_NOME_ESPACO_EM_BRANCO_EDICAO}
    ...    ${EMPTY}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=As entradas da credencial não correspondem ao esperado da consulta

Cenário: CREDT-355 (API) Tentar editar credencial passando uma entrada com o valor preenchido só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.ENTRADA_VALOR_ESPACO_EM_BRANCO_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A credencial não pode conter entradas com valores vazios

Cenário: CREDT-1102 (API) Tentar editar credencial com inputs que não pertencem a consulta original
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método put para editar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}
    ...    ${BODY_CREDENCIAL.ENTRADA_EXTRA_EDICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=As entradas da credencial não correspondem ao esperado da consulta