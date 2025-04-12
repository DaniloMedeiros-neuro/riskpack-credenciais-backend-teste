*** Settings ***
Documentation       CREDT-198 - (POST) /api/v1/credentials

Resource            ../../../src/config/package.robot

Test Setup          Setup para o cadastro de novas credenciais


*** Test Cases ***
Cenário: CREDT-225 (API) Cadastrar credencial com sucesso
    [Tags]    regression    sanity
    [Setup]    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

Cenário: CREDT-231 (API) Tentar cadastrar credencial com token inválido
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.INVALIDO}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-232 (API) Tentar cadastrar credencial com token expirado
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.EXPIRADO}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Token expired

Cenário: CREDT-233 (API) Tentar cadastrar credencial com token vazio
    [Tags]    regression    sanity
    Dado que possua um token    ${DADOS_COMUNS.TOKEN.VAZIO}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.FORBIDDEN}
    E a api deve retornar o Json contendo o parametro statusCode    value=FORBIDDEN
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-234 (API) Tentar cadastrar credencial com token sem autorização
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_BASIC_SEM_PERMISSAO_CREDENCIAIS}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNAUTHORIZED}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNAUTHORIZED
    E a api deve retornar o Json contendo o parametro message
    ...    value=Access denied: you don't have access to this resource

Cenário: CREDT-238 (API) Tentar cadastrar credenciais idênticas exceto pelos inputs
    [Tags]    regression    sanity
    [Setup]    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CONFLICT}
    E a api deve retornar o Json contendo o parametro statusCode    value=CONFLICT
    E a api deve retornar o Json contendo o parametro message    value=A credencial já existe nesta conta

Cenário: CREDT-239 (API) Cadastrar credenciais idênticas exceto pela consulta
    [Tags]    regression    sanity
    [Setup]    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Quando executar o método post para cadastrar credenciais com uma consulta diferente
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.CONSULTA_DIFERENTE}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=As entradas da credencial não correspondem ao esperado da consulta

# CASO DE TESTE CANCELADO
# Cenário: CREDT-241 (API) Cadastrar credenciais idênticas exceto pela descrição
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${EMPTY}
#    Quando executar o método post para cadastrar credenciais com uma descrição diferente
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.DESCRICAO_DIFERENTE}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
#    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
#    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

# CASO DE TESTE CANCELADO
# Cenário: CREDT-242 (API) Cadastrar credenciais idênticas exceto pelo ambiente
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${EMPTY}
#    Quando executar o método post para cadastrar credenciais com um ambiente diferente
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.AMBIENTE_DIFERENTE}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
#    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
#    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

Cenário: CREDT-245 (API) Tentar cadastrar credencial em uma consulta inexistente no Gateway
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com uma consulta inexistente no Gateway
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.CONSULTA_INEXISTENTE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-246 (API) Tentar cadastrar credencial com uma consulta não adicionada à conta utilizada
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com uma consulta não adicionada à conta utilizada
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.CONSULTA_NAO_CADASTRADA_NA_CONTA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-247 (API) Tentar cadastrar credencial com o campo consulta vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo consulta vazio
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.CONSULTA_VAZIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-248 (API) Tentar cadastrar credencial sem o campo consulta no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais sem o campo consulta no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_CONSULTA}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.NOTFOUND}
    E a api deve retornar o Json contendo o parametro statusCode    value=NOT_FOUND
    E a api deve retornar o Json contendo o parametro message
    ...    value=A Consulta não foi encontrada para poder associar a conta

Cenário: CREDT-249 (API) Tentar cadastrar credencial com o campo descrição vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo descrição vazio
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_VAZIA}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode ser vazia
    ...    novo_campo=true

Cenário: CREDT-250 (API) Tentar cadastrar credencial com o campo descrição só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo descrição só com espaços em branco
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_ESPACOS_EM_BRANCO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode ser vazia
    ...    novo_campo=true

Cenário: CREDT-251 (API) Tentar cadastrar credencial sem o campo descrição no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais sem o campo descrição no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_DESCRICAO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode ser vazia
    ...    novo_campo=true

# CASO DE TESTE CANCELADO
# Cenário: CREDT-252 (API) Tentar cadastrar credencial com o campo ambiente inválido
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais com o campo ambiente inválido
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.AMBIENTE_INEXISTENTE}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message
#    ...    value=Ambiente inválido associado à credencial: ${BODY_CREDENCIAL.AMBIENTE_INEXISTENTE.campo1.valor}

# CASO DE TESTE CANCELADO
# Cenário: CREDT-253 (API) Tentar cadastrar credencial com o campo ambiente com letras minúsculas
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais com o campo ambiente com letras minúsculas
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.AMBIENTE_MINUSCULO}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message
#    ...    value=Ambiente inválido associado à credencial: ${BODY_CREDENCIAL.AMBIENTE_MINUSCULO.campo1.valor}

# CASO DE TESTE CANCELADO
# Cenário: CREDT-254 (API) Tentar cadastrar credencial com o campo ambiente vazio
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais com o campo ambiente vazio
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.AMBIENTE_VAZIO}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message
#    ...    value=Ambiente inválido associado à credencial: null

# CASO DE TESTE CANCELADO
# Cenário: CREDT-255 (API) Tentar cadastrar credencial sem o campo ambiente no body da requisição
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais sem o campo ambiente no body da requisição
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_AMBIENTE}
#    ...    ${EMPTY}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message
#    ...    value=Ambiente inválido associado à credencial: null

Cenário: CREDT-256 (API) Tentar cadastrar credencial sem inputs no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais sem inputs no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_ENTRADAS}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A credencial não possui entradas

Cenário: CREDT-257 (API) Tentar cadastrar credencial com inputs vazios no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com inputs vazios no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.ENTRADA_VAZIA}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A credencial não possui entradas

Cenário: CREDT-258 (API) Tentar cadastrar credencial com inputs com nome vazio no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com inputs com nome vazio no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_ENTRADAS_NAME}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=O nome da entrada da credencial não pode ser vazio

Cenário: CREDT-259 (API) Tentar cadastrar credencial com inputs com nome preenchido só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com inputs com nome preenchido só com espaços em branco
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.ENTRADA_NOME_ESPACO_EM_BRANCO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=O nome da entrada da credencial não pode ser vazio

Cenário: CREDT-260 (API) Tentar cadastrar credencial com inputs com valor vazio no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com inputs com valor vazio no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SEM_O_CAMPO_ENTRADAS_VALOR}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A credencial não pode conter entradas com valores vazios

Cenário: CREDT-261 (API) Tentar cadastrar credencial com inputs com valor preenchido só com espaços em branco
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com inputs com valor preenchido só com espaços em branco
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.ENTRADA_VALOR_ESPACO_EM_BRANCO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.UNPROCESSABLE_ENTITY}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message
    ...    value=A credencial não pode conter entradas com valores vazios

# CASO DE TESTE CANCELADO
# Cenário: CREDT-420 (API) Tentar cadastrar credencial com uma descrição inválida (contendo caracteres especiais)
#    [Tags]    regression    sanity
#    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
#    Quando executar o método post para cadastrar credenciais com uma descrição inválida com caracteres especiais
#    ...    ${ENDPOINT_CREDENCIAL.PATH}
#    ...    ${BODY_CREDENCIAL.SUCESSO}
#    ...    ${BODY_CREDENCIAL.DESCRICAO_CARACTERES_ESPECIAL_EDICAO}
#    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
#    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
#    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
#    E a api deve retornar o Json contendo o parametro errors
#    ...    value=A descrição da credencial não pode conter caracteres especiais
#    ...    novo_campo=true

Cenário: CREDT-421 (API) Tentar cadastrar credencial com uma descrição contendo mais de 50 caracteres alfanuméricos
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com uma descrição contendo mais de 50 caracteres alfanuméricos
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.DESCRICAO_COM_MAIS_DE_50_EDICAO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=A descrição da credencial não pode conter mais de 50 caracteres
    ...    novo_campo=true

Cenário: CREDT-481 (API) Cadastrar credencial com um nome válido contendo underline
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com um nome válido contendo underline
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COM_UNDERLINE}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

Cenário: CREDT-482 (API) Tentar cadastrar credencial com o campo nome contendo hífen
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo hífen
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COM_HIFEN}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-483 (API) Tentar cadastrar credencial com o campo nome contendo caracteres especiais, incluindo acentos e cedilha
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo caracteres especiais, incluindo acentos e cedilha
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COM_CARACTERE_ESPECIAL}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-484 (API) Tentar cadastrar credencial com o campo nome contendo letras minúsculas
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo letras minúsculas
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_MINUSCULO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-485 (API) Tentar cadastrar credencial com o campo nome contendo espaços
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo espaços
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_ESPACOS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-486 (API) Tentar cadastrar credencial com o campo nome começando com números
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome começando com números
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COMECANDO_COM_NUMEROS}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-487 (API) Tentar cadastrar credencial com o campo nome contendo menos de 5 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo menos de 5 caracteres
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COM_MENOS_DE_5_CARACTERES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial deve possuir entre 5 e 50 caracteres
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-488 (API) Tentar cadastrar credencial com o campo nome contendo mais de 50 caracteres
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome contendo mais de 50 caracteres
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_COM_MAIS_DE_50_CARACTERES}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial deve possuir entre 5 e 50 caracteres
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-489 (API) Tentar cadastrar credencial com o campo nome vazio
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com o campo nome vazio
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_VAZIO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve validar o retorno quando o campo nome é vazio

Cenário: CREDT-490 (API) Tentar cadastrar credencial sem o campo nome no body da requisição
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais sem o campo nome no body da requisição
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${BODY_CREDENCIAL.NOME_CREDENCIAL_NULL}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=UNPROCESSABLE_ENTITY
    E a api deve retornar o Json contendo o parametro message    value=Erro de validação
    E a api deve retornar o Json contendo o parametro errors
    ...    value=O nome da credencial não pode ser vazio
    ...    novo_campo=true
    ...    nome_campo=name

Cenário: CREDT-491 (API) Tentar cadastrar credencial com o campo nome idêntico ao de outra credencial, na mesma consulta e conta
    [Tags]    regression    sanity
    [Setup]    E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Quando executar o método post para cadastrar credenciais com o campo nome idêntico ao de outra credencial, na mesma consulta e conta
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CONFLICT}
    E a api deve retornar o Json contendo o parametro statusCode    value=CONFLICT
    E a api deve retornar o Json contendo o parametro message    value=A credencial já existe nesta conta

Cenário: CREDT-1064 (API) Cadastrar credencial com sucesso em consulta rascunho na conta do desenvolvedor
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

Cenário: CREDT-1065 (API) Cadastrar credencial com sucesso em consulta rascunho na conta do cliente
    [Tags]    regression    sanity
    [Setup]    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta para desenvolvimento
    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.CREATED}
    E a api deve retornar o Json contendo o parametro statusCode    value=CREATED
    E a api deve retornar o Json contendo o parametro message    value=Credencial cadastrada com sucesso

Cenário: CREDT-1101 (API) Tentar cadastrar credencial com inputs que não pertencem a consulta original
    [Tags]    regression    sanity
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para cadastrar credenciais com com inputs que não pertencem a consulta original
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.ENTRADA_EXTRA}
    ...    ${EMPTY}
    Então a api retorna StatusCode    ${DADOS_COMUNS.STATUS_CODE.BADREQUEST}
    E a api deve retornar o Json contendo o parametro statusCode    value=BAD_REQUEST
    E a api deve retornar o Json contendo o parametro message
    ...    value=As entradas da credencial não correspondem ao esperado da consulta