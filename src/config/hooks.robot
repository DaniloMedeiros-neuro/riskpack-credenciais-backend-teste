*** Settings ***
Resource    package.robot


*** Keywords ***
Conectando na API
    [Arguments]    ${auth}=${EMPTY}    ${url}=${DADOS_COMUNS.URL}
    Set Suite Variable    ${base_url}    ${url}
    Create Session    create_session    url=${base_url}    headers=${headers}    auth=${auth}    disable_warnings=true

Atualizar arquivo YAML ${local}
    [Arguments]    ${nome_arquivo}    ${dado}
    ${caminho_arquivo}    Join Path    ${EXECDIR}    src    auto    datatest    ${nome_arquivo}.yaml
    ${file}    Get File    ${caminho_arquivo}
    ${loaded}    Safe Load    ${file}

    IF    '${local}' == 'de Consultas'
        ${loaded}[BODY_CONSULTA][SUCESSO][id]    Set Variable    ${dado}
        ${loaded}[ENDPOINT_CONSULTAS][QUERYID][SUCESSO]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Consultas com credenciais'
        ${loaded}[ENDPOINT_CONSULTAS][QUERYID][CREDENCIAL][PARAMETER][QUERYID]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Consultas com credenciais obtendo o id da consulta'
        ${loaded}[ENDPOINT_CONSULTAS][QUERYID][CREDENCIAL][PARAMETER][QUERYID_COM_CREDENCIAIS]    Set Variable
        ...    ${dado}
    ELSE IF    '${local}' == 'de Consultas sem credenciais'
        ${loaded}[ENDPOINT_CONSULTAS][QUERYID][CREDENCIAL][PARAMETER][QUERYID_SEM_CREDENCIAIS]    Set Variable
        ...    ${dado}
    ELSE IF    '${local}' == 'de Consultas para desenvolvimento'
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO][descriptionGateway]    Set Variable    ${dado.descriptionGateway}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO][accountClient]    Set Variable    ${dado.accountClient}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO][nameGateway]    Set Variable    ${dado.nameGateway}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO][inputs][0]    Set Variable    ${dado.entrada_1}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO][inputs][1]    Set Variable    ${dado.entrada_2}
        ${loaded}[BODY_CONSULTA][SUCESSO_RASCUNHO][id]    Set Variable    ${dado.nameGateway}
        ${loaded}[BODY_CONSULTA][SUCESSO_RASCUNHO_2][id]    Set Variable    ${dado.nameGateway}2
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO_RASCUNHO][descriptionGateway]    Set Variable    ${dado.descriptionGateway}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO_RASCUNHO][nameGateway]    Set Variable    ${dado.nameGateway}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO_RASCUNHO_2][nameGateway]    Set Variable    ${dado.nameGateway}2
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO_RASCUNHO][inputs][0]     Set Variable    ${dado.entrada_1}
        ${loaded}[BODY_CONSULTA_DESENVOLVIMENTO][SUCESSO_RASCUNHO][inputs][1]     Set Variable    ${dado.entrada_2}
    ELSE IF    '${local}' == 'de Credencial com dados para compartilhar'
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Description]    Set Variable    ${dado.descriptionGateway}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][QueryName]    Set Variable    ${dado.nameGateway}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Name]    Set Variable    TESTE_AUTOMACAO_BACK_COMPARTILHAR_${dado.accountClient}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Inputs][0][Name]     Set Variable    ${dado.entrada_1}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Inputs][1][Name]     Set Variable    ${dado.entrada_2}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Inputs][0][Value]     Set Variable    123
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR][Inputs][1][Value]     Set Variable    456
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Description]    Set Variable    ${dado.descriptionGateway}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][QueryName]    Set Variable    ${dado.nameGateway}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Name]    Set Variable    TESTE_AUTOMACAO_BACK_COMPARTILHAR_${dado.accountClient}${dado.accountClient}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Inputs][0][Name]     Set Variable    ${dado.entrada_1}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Inputs][1][Name]     Set Variable    ${dado.entrada_2}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Inputs][0][Value]     Set Variable    123
        ${loaded}[BODY_CREDENCIAL][SUCESSO_CRIAR_COMPARTILHAR_1][Inputs][1][Value]     Set Variable    456
        ${loaded}[BODY_CREDENCIAL_COMPARTILHAR][QUERYNAME_SUCESSO][campo1][valor]     Set Variable     ${dado.nameGateway}
        ${loaded}[BODY_CREDENCIAL_COMPARTILHAR][QUERYNAME_SUCESSO_2][campo1][valor]     Set Variable     ${dado.nameGateway}2
    ELSE IF    '${local}' == 'de Credencial com dados para filtrar'
        ${loaded}[BODY_CREDENCIAL_FILTER][SUCESSO_COMPARTILHAR][Filter][Name]    Set Variable    TESTE_AUTOMACAO_BACK_COMPARTILHAR_${dado.accountClient}
        ${loaded}[BODY_CREDENCIAL_FILTER][SUCESSO_COMPARTILHAR][QueryName]    Set Variable    ${dado.nameGateway}
    ELSE IF    '${local}' == 'de Credenciais'
        ${loaded}[BODY_CREDENCIAL][SUCESSO][Description]    Set Variable    ${dado.description}
        ${loaded}[BODY_CREDENCIAL][SUCESSO][Name]    Set Variable    ${dado.nome_credencial}
        ${loaded}[BODY_CREDENCIAL][SUCESSO][QueryName]    Set Variable    ${dado.consulta1}
        ${loaded}[BODY_CREDENCIAL][SUCESSO][Inputs][0][Value]    Set Variable    ${dado.ddd}
        ${loaded}[BODY_CREDENCIAL][SUCESSO][Inputs][1][Value]    Set Variable    ${dado.telefone}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_EDICAO][Description]    Set Variable    ${dado.description}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_EDICAO][Inputs][0][Value]    Set Variable    ${dado.ddd}
        ${loaded}[BODY_CREDENCIAL][SUCESSO_EDICAO][Inputs][1][Value]    Set Variable    ${dado.telefone}
        ${loaded}[BODY_CREDENCIAL][CONSULTA_DIFERENTE][campo1][valor]    Set Variable    ${dado.consulta2}
        ${loaded}[BODY_CREDENCIAL][DESCRICAO_DIFERENTE][campo1][valor]    Set Variable
        ...    DESCRICAO DE TESTE AUTOMACAO CREDENCIAIS ${dado.numero_aleatorio}
        ${loaded}[BODY_CREDENCIAL][NOME_CREDENCIAL_COM_UNDERLINE][campo1][valor]    Set Variable
        ...    NOME_CREDENCIAL_COM_UNDERLINE_${dado.numero_aleatorio}
    ELSE IF    '${local}' == 'de Credenciais da Consulta'
        ${loaded}[ENDPOINT_CREDENCIAL][CREDTID][SUCESSO]    Set Variable    ${dado}
        ${nome}    FakerLibrary.Name
        ${loaded}[BODY_CREDENCIAL][ENTRADA_VALOR_VAZIO_E_NOVA_ENTRADA_EDICAO][Inputs][2][Name]    Set Variable
        ...    ${nome}
        ${loaded}[BODY_CREDENCIAL][ENTRADA_VALOR_VAZIO_E_NOVA_ENTRADA_EDICAO][Inputs][2][Value]    Set Variable
        ...    ${nome}
    ELSE IF    '${local}' == 'de Credencial para exclusão em uma Consulta'
        ${loaded}[ENDPOINT_CREDENCIAL][CREDTID_EXCLUSAO][SUCESSO]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Credencial para exclusão em uma Consulta, após ativar e inativar'
        ${loaded}[BODY_CREDENCIAL][NOME_ALEATORIO][campo1][valor]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Credencial para colisão'
        ${loaded}[BODY_CREDENCIAL][NOME_ALEATORIO_COLISAO][campo1][valor]    Set Variable    ${dado}
        ${cep}    FakerLibrary.Postcode
        ${loaded}[BODY_CREDENCIAL][SUCESSO_COLISAO][Inputs][0][Value]    Set Variable    ${cep}
    ELSE IF    '${local}' == 'de Credencial para colisão em uma Consulta'
        ${loaded}[ENDPOINT_CREDENCIAL][CREDTID_COLISAO][SUCESSO]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Credencial para compartilhar'
        ${loaded}[BODY_CREDENCIAL][SUCESSO_COMPARTILHAMENTO][credentialId]    Set Variable    ${dado}
    ELSE IF    '${local}' == 'de Credencial sendo compartilhada'
        ${loaded}[ENDPOINT_CREDENCIAL][NAME_CREDENTIAL][COMPARTILHADA]    Set Variable    ${dado}
    END

    ${output}    Dump    ${loaded}    allow_unicode=True

    Remove File    ${caminho_arquivo}
    Wait Until Removed    ${caminho_arquivo}
    Create File    ${caminho_arquivo}    ${output}    encoding=UTF-8
    Wait Until Created    ${caminho_arquivo}

E gerar novos dados de credenciais aleatórios
    [Arguments]    ${lista_consultas}

    Log List    ${lista_consultas}
    ${descriptions}    FakerLibrary.Text    max_nb_chars=50
    ${description}    FakerLibrary.Sentence    nb_words=4    variable_nb_words=False
    ${descriptionBig}    Generate Random String    length=100
    ${nome_credencial}    Generate Random String    3-29    [UPPER]_[NUMBERS]
    ${nome}    FakerLibrary.Name
    ${senha}    FakerLibrary.Password
    ${email}    FakerLibrary.Email
    ${estado}    FakerLibrary.State
    ${cidade}    FakerLibrary.City
    ${cep}    FakerLibrary.Postcode
    ${telefone}    FakerLibrary.Phone Number
    ${ddd}    FakerLibrary.Random Int    min=10    max=99
    ${consulta1}    Get From List    ${lista_consultas}    0
    ${consulta2}    Get From List    ${lista_consultas}    1
    ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]

    ${description}    Remove String    ${description}    .
    Log Many    ${description}

    &{dicionario}    Create Dictionary
    ...    description=${description}
    ...    descriptions=${descriptions}
    ...    descriptionBig=${descriptionBig}
    ...    nome_credencial=TESTE_AUTOMACAO_BACK_${nome_credencial}
    ...    nome=${nome}
    ...    senha=${senha}
    ...    email=${email}
    ...    estado=${estado}
    ...    cidade=${cidade}
    ...    cep=${cep}
    ...    ddd=${ddd}
    ...    telefone=${telefone}
    ...    consulta1=${consulta1}
    ...    consulta2=${consulta2}
    ...    numero_aleatorio=${numero_aleatorio}

    Log Many    &{dicionario}
    RETURN    &{dicionario}

E gerar novos dados de consultas aleatórios
    ${descriptions}    FakerLibrary.Text    max_nb_chars=50
    ${description}    FakerLibrary.Sentence    nb_words=4    variable_nb_words=False
    ${descriptionBig}    Generate Random String    length=100
    ${nome_consulta}    Generate Random String    3-20    [UPPER]_[NUMBERS]
    ${nome}    FakerLibrary.Name
    ${numero_aleatorio}    Random Int    max=99999
    ${numero_aleatorio_1}    Generate Random String    length=6    chars=[NUMBERS]
    ${numero_aleatorio_2}    Generate Random String    length=6    chars=[NUMBERS]

    ${descriptions}    Remove String    ${descriptions}    .
    Log Many    ${descriptions}

    &{dicionario}    Create Dictionary
    ...    descriptionGateway=${descriptions}
    ...    descriptionBig=${descriptionBig}
    ...    nameGateway=TESTE_AUTOMACAO_BACK_CONSULTA_${nome_consulta}
    ...    accountClient=${numero_aleatorio}
    ...    entrada_1=TESTE_ENTRADA_${numero_aleatorio_1}
    ...    entrada_2=TESTE_ENTRADA_${numero_aleatorio_2}

    Log Many    &{dicionario}
    RETURN    &{dicionario}

# Selecionar ambiente aleatório
#    ${valorAleariorio}    Random Element    ['HML', 'PRD']
#    RETURN    ${valorAleariorio}

Gerar dados novos de credenciais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${total_consultas}    Get Length    ${consultas}
    Log To Console    total_consultas: ${total_consultas}

    ${lista_consultas}    Create List

    ## Adição de 2 novas consultas, caso tenha 0 ou 1 consulta cadastrada na conta
    IF    ${total_consultas} < ${2}
        ${consulta_id}    Quando executar o método para obter consultas do portfólio
        ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
        Quando adicionar uma consulta
        Append To List    ${lista_consultas}    ${consulta_id}

        ${consulta_id}    Quando executar o método para obter consultas do portfólio
        ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
        Quando adicionar uma consulta
        Append To List    ${lista_consultas}    ${consulta_id}
    ELSE
        Append To List    ${lista_consultas}    ${BODY_CONSULTA.REPETIDO.id}
        Append To List    ${lista_consultas}    ${consultas[1]['queryName']}
    END

    ${dados}    E gerar novos dados de credenciais aleatórios    ${lista_consultas}
    Log Many    ${dados}
    Atualizar arquivo YAML de Credenciais    credenciais/credenciais    ${dados}

    &{dict1}    Create Dictionary
    ...    Name=ddd
    ...    Value=${dados.ddd}
    &{dict2}    Create Dictionary
    ...    Name=telefone
    ...    Value=${dados.telefone}

    @{Inputs}    Create List    ${dict1}    ${dict2}

    &{dicionario}    Create Dictionary
    ...    Description=${dados.description}
    ...    Name=${dados.nome_credencial}
    ...    Inputs=${Inputs}
    ...    QueryName=${BODY_CONSULTA.REPETIDO.id}

    Log Many    ${dicionario}

    RETURN    ${dicionario}

Gerar dados novos de consultas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}

    ${dados}    E gerar novos dados de consultas aleatórios
    Log Many    ${dados}
    Atualizar arquivo YAML de Consultas para desenvolvimento    consultas/consultas    ${dados}
    Atualizar arquivo YAML de Credencial com dados para compartilhar    credenciais/credenciais    ${dados}
    Atualizar arquivo YAML de Credencial com dados para filtrar    credenciais/filtro    ${dados}

    @{inputs}    Create List    ${dados.entrada_1}    ${dados.entrada_2}

    &{dicionario}    Create Dictionary
    ...    accountClient=${dados.accountClient}
    ...    descriptionGateway=${dados.descriptionGateway}
    ...    nameGateway=${dados.nameGateway}
    ...    inputs=${inputs}

    Log Many    ${dicionario}

    RETURN    &{dicionario}

Obter o credtId de uma credencial da consulta
    [Arguments]    ${nome_consulta}=${None}

    IF    $nome_consulta != $None
        ${nome_consulta}    Set Variable    ${nome_consulta}
    ELSE
        ${nome_consulta}    Obter as consultas da conta com credenciais cadastradas
    END

    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${nome_consulta}
    ...    origem=credentials

    ${credenciais_da_consulta}    Set Variable    ${response}[CredentialsList]
    Log List    ${credenciais_da_consulta}

    ${total_credenciais_da_consulta}    Get Length    ${credenciais_da_consulta}
    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_credenciais_da_consulta})
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${numero_aleatorio}][Id]
    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credenciais da Consulta    credenciais/credenciais    ${credencial_id}
    RETURN    ${credencial_id}

Obter da consulta o credtId de uma credencial com o campo ${tipo_campo}
    [Arguments]    ${filtro}

    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO}
    ...    ${filtro}
    ...    Filter

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    Log List    ${credenciais_da_consulta}

    ${total_credenciais_da_consulta}    Get Length    ${credenciais_da_consulta}
    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_credenciais_da_consulta})
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${numero_aleatorio}][Id]
    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credenciais da Consulta    credenciais/credenciais    ${credencial_id}
    RETURN    ${credencial_id}

Obter as consultas da conta
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Log Many    resposta: ${response}
    ${consultas}    Set Variable    ${response['GatewayQueries']}
    Log List    ${consultas}
    ${total_consultas}    Get Length    ${consultas}
    Log To Console    total_consultas: ${total_consultas}

    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_consultas})
    ${consulta_id}    Set Variable    ${response['GatewayQueries'][${numero_aleatorio}]['queryName']}
    Log To Console    consulta_id: ${consulta_id}
    Atualizar arquivo YAML de Consultas    consultas/consultas    ${consulta_id}
    RETURN    ${consulta_id}

Obter as consultas da conta com credenciais cadastradas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Log Many    resposta: ${response}
    ${consultas}    Set Variable    ${response['GatewayQueries']}
    Log List    ${consultas}
    ${lista_teste}    Create List

    FOR    ${element}    IN    @{consultas}
        IF    ${element}[credentialCount] > ${0}
            Log    ${element}
            Append To List    ${lista_teste}    ${element}
        END
    END

    Log List    ${lista_teste}
    ${total_consultas_credenciais}    Get Length    ${lista_teste}
    Log To Console    total_consultas_credenciais: ${total_consultas_credenciais}

    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_consultas_credenciais})
    ${consulta_id}    Set Variable    ${lista_teste}[${numero_aleatorio}][queryName]
    Log To Console    consulta_id: ${consulta_id}
    Atualizar arquivo YAML de Consultas com credenciais    consultas/consultas    ${consulta_id}
    RETURN    ${consulta_id}

Obter o id de uma consulta da conta com credenciais cadastradas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Log Many    resposta: ${response}
    ${consultas}    Set Variable    ${response['GatewayQueries']}
    Log List    ${consultas}
    ${lista_teste}    Create List

    FOR    ${element}    IN    @{consultas}
        IF    ${element}[credentialCount] > ${0}
            Log    ${element}
            Append To List    ${lista_teste}    ${element}
        END
    END

    Log List    ${lista_teste}
    ${total_consultas_credenciais}    Get Length    ${lista_teste}
    Log To Console    total_consultas_credenciais: ${total_consultas_credenciais}

    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_consultas_credenciais})
    ${consulta_id}    Set Variable    ${lista_teste}[${numero_aleatorio}][longId]
    Log To Console    consulta_id: ${consulta_id}
    Atualizar arquivo YAML de Consultas com credenciais obtendo o id da consulta
    ...    consultas/consultas
    ...    ${consulta_id}
    RETURN    ${consulta_id}

Obter as consultas da conta sem credenciais cadastradas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Log Many    resposta: ${response}
    ${consultas}    Set Variable    ${response['GatewayQueries']}
    Log List    ${consultas}
    ${lista_teste}    Create List

    FOR    ${element}    IN    @{consultas}
        IF    ${element}[credentialCount] == ${0}
            Log    ${element}
            Append To List    ${lista_teste}    ${element}
        END
    END

    Log List    ${lista_teste}
    ${total_consultas_sem_credenciais}    Get Length    ${lista_teste}
    Log To Console    total_consultas_sem_credenciais: ${total_consultas_sem_credenciais}

    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_consultas_sem_credenciais})
    ${consulta_id}    Set Variable    ${lista_teste}[${numero_aleatorio}][longId]
    Log To Console    consulta_id: ${consulta_id}
    Atualizar arquivo YAML de Consultas sem credenciais    consultas/consultas    ${consulta_id}
    RETURN    ${consulta_id}

E validar a ordenação pelo campo na resposta
    [Arguments]    ${sortField}    ${sortDirection}

    ${lista_teste}    Create List
    ${campo}    Evaluate    '${sortField}'.title()

    FOR    ${element}    IN    @{response.json()}[CredentialsList]
        ${texto}    Evaluate    '${element}[${campo}]'.lower()
        Append To List    ${lista_teste}    ${texto}
    END

    Log List    ${lista_teste}

    IF    '${sortDirection}' == 'ASC'
        ${lista_ordenada}    Evaluate    sorted(${lista_teste}, key=lambda x: x.lower())
    ELSE IF    '${sortDirection}' == 'DESC'
        ${lista_ordenada}    Evaluate    sorted(${lista_teste}, key=lambda x: x.lower(), reverse=True)
    END

    Lists Should Be Equal    ${lista_teste}    ${lista_ordenada}

E validar o filtro pelo campo na resposta
    [Arguments]    ${campo}

    ${tamanho}    Get Length    ${campo}

    FOR    ${element}    IN    @{response.json()}[CredentialsList]
        Log Many    ${element}
        IF    '${filtro}' == '${None}'
            FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
                Should Contain    ${element}[Description]    ${campo.Filter.Description}
                Should Contain    ${element}[Name]    ${campo.Filter.Name}
                Should Contain    ${element}[Status]    ${campo.Filter.Status}
            END
        ELSE
            FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
                Log Many    ${campo.campo${counter}.valor}

                IF    "${campo.campo${counter}.valor}" != ""
                    IF    "${campo.campo${counter}.nome}" == "User"
                        Log Many    ${campo.campo${counter}.valor}
                        ${usuario_criacao}    Get From Dictionary    ${element}    CreateUserName
                        ${usuario_atualizacao}    Get From Dictionary    ${element}    UpdateUserName
                        ${lista_usuarios}    Create List    ${usuario_criacao}    ${usuario_atualizacao}

                        ${verifica_usuario_criacao}    Run Keyword And Return Status
                        ...    Should Contain
                        ...    ${usuario_criacao}
                        ...    ${campo.campo${counter}.valor}
                        ...    ignore_case=True
                        ...    strip_spaces=True
                        ...    collapse_spaces=True
                        ${verifica_usuario_atualizacao}    Run Keyword And Return Status
                        ...    Should Contain
                        ...    ${usuario_atualizacao}
                        ...    ${campo.campo${counter}.valor}
                        ...    ignore_case=True
                        ...    strip_spaces=True
                        ...    collapse_spaces=True
                        IF    ${verifica_usuario_criacao} == ${True} or ${verifica_usuario_atualizacao} == ${True}
                            CONTINUE
                        ELSE
                            Fail    Foi encontrado no resultado data diferente da informado no filtro.
                        END
                    ELSE
                        Should Contain    ${element}[${campo.campo${counter}.nome}]    ${campo.campo${counter}.valor}
                    END
                END
            END
        END
    END

E validar o filtro de consultas pelo campo na resposta
    [Arguments]    ${campo}

    FOR    ${element}    IN    @{response.json()}[GatewayQueries]
        Log Many    ${element}
        Should Contain    ${element}[queryName]    ${campo}
    END

E validar o filtro de logs de ações pelo campo na resposta
    [Arguments]    ${campo}
    ${tamanho}    Get Length    ${campo}
    ${filtro_acao}    Create List

    FOR    ${element}    IN    @{response.json()}[Logs]
        Log Many    &{element}

        FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
            ${verifica_valor_vazio}    Run Keyword And Return Status
            ...    Should Be Empty
            ...    ${campo.campo${counter}.valor}
            IF    ${verifica_valor_vazio} != ${True}
                IF    "${campo.campo${counter}.nome}" == "Type"
                    Log List    ${campo.campo${counter}.valor}
                    ${type}    Get From Dictionary    ${element}    ${campo.campo${counter}.nome}

                    List Should Contain Value
                    ...    ${campo.campo${counter}.valor}
                    ...    ${type}
                    ...    ignore_case=True
                ELSE IF    "${campo.campo${counter}.nome}" == "DateEnd"
                    ${verifica_data_inicial_vazia}    Run Keyword And Return Status
                    ...    Should Be Empty
                    ...    ${campo.campo${2}.valor}
                    IF    ${verifica_data_inicial_vazia} != ${True}
                        ${data_final}    Set Variable    ${campo.campo${counter}.valor}
                        ${data_inicial}    Set Variable    ${campo.campo${2}.valor}
                        ${data_teste}    Get From Dictionary    ${element}    Date
                        ${data_teste_formatada}    Convert Date    ${data_teste}    result_format=%Y-%m-%d

                        IF    '${data_teste_formatada}' >= '${data_inicial}' and '${data_teste_formatada}' <= '${data_final}'
                            CONTINUE
                        ELSE
                            Fail    Foi encontrada uma data fora do intervalo especificado no filtro.
                        END
                    END
                ELSE IF    "${campo.campo${counter}.nome}" == "DateStart"
                    ${verifica_data_final_vazia}    Run Keyword And Return Status
                    ...    Should Be Empty
                    ...    ${campo.campo${1}.valor}
                    IF    ${verifica_data_final_vazia} != ${True}
                        ${data_final}    Set Variable    ${campo.campo${1}.valor}
                        ${data_inicial}    Set Variable    ${campo.campo${counter}.valor}
                        ${data_teste}    Get From Dictionary    ${element}    Date
                        ${data_teste_formatada}    Convert Date    ${data_teste}    result_format=%Y-%m-%d

                        IF    '${data_teste_formatada}' >= '${data_inicial}' and '${data_teste_formatada}' <= '${data_final}'
                            CONTINUE
                        ELSE
                            Fail    Foi encontrada uma data fora do intervalo especificado no filtro.
                        END
                    END
                ELSE
                    Log Many    ${element}[${campo.campo${counter}.nome}]
                    Log Many    ${campo.campo${counter}.valor}
                    Should Contain    ${element}[${campo.campo${counter}.nome}]    ${campo.campo${counter}.valor}
                END
            END
        END
    END

Obter da consulta o credtId e setar o valor na variável global
    [Arguments]    ${status}=${None}

    IF    $status != $None
        ${result}    ${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}    Run Keyword And Ignore Error
        ...    Obter da consulta o credtId de uma credencial com o campo Status Inativo
        ...    ${status}
    ELSE
        ${result}    ${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}    Run Keyword And Ignore Error
        ...    Obter o credtId de uma credencial da consulta
    END

Obter consulta sem credenciais
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando adicionar uma consulta
    Quando executar o método para obter consultas do portfólio
    ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}

    ${result}
    ...    ${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_SEM_CREDENCIAIS}
    ...    Run Keyword And Ignore Error
    ...    Obter as consultas da conta sem credenciais cadastradas

Obter consulta com credenciais
    ${result}    ${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID}    Run Keyword And Ignore Error
    ...    Obter o id de uma consulta da conta com credenciais cadastradas

E obtenha novos dados aleatórios para uma credencial para setar o valor na variável global
    ${result}    ${BODY_CREDENCIAL.SUCESSO}    Run Keyword And Ignore Error
    ...    Gerar dados novos de credenciais

Obter o credtId de uma credencial da consulta para exclusão ${detalhe_para_exclusao}
    IF    '${detalhe_para_exclusao}' == 'com status ativo' or '${detalhe_para_exclusao}' == 'que está inativa há 8 dias ou mais'
        ${nome_consulta}    Set Variable    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.CONSULTA_COM_CREDENCIAL_ATIVA}
    ELSE
        ${nome_consulta}    Set Variable    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.CONSULTA}
    END

    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[2]}
    ...    queryId=${nome_consulta}
    ...    origem=credentials

    ${credenciais_da_consulta}    Set Variable    ${response}[CredentialsList]
    Log List    ${credenciais_da_consulta}

    ${total_credenciais_da_consulta}    Get Length    ${credenciais_da_consulta}

    IF    '${detalhe_para_exclusao}' == 'com status ativo'
        FOR    ${element}    IN    @{credenciais_da_consulta}
            IF    '${element}[Status]' == 'ACTIVE'
                ${credencial_id}    Set Variable    ${element}[Id]
            END
        END
    ELSE IF    '${detalhe_para_exclusao}' == 'criada a menos de 24 horas'
        Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
        Quando executar o método post para cadastrar credenciais
        ...    ${ENDPOINT_CREDENCIAL.PATH}
        ...    ${BODY_CREDENCIAL.SUCESSO_EXCLUSAO}
        ...    ${EMPTY}
        Sleep    1s
        Quando executar o método post para filtrar credenciais
        ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
        ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_EXCLUSAO}
        ...    ${EMPTY}
        ...    Filter
        ...    queryName=${BODY_CREDENCIAL_FILTER.SUCESSO_EXCLUSAO.QueryName}

        ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
        ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]
    ELSE IF    '${detalhe_para_exclusao}' == 'criada a menos de 24 horas, para ativar e inativar'
        Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
        ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]
        Atualizar arquivo YAML de Credencial para exclusão em uma Consulta, após ativar e inativar    credenciais/credenciais    TESTE_AUTOMACAO_BACK_EXCLUSAO_${numero_aleatorio}

        Quando executar o método post para cadastrar credenciais
        ...    ${ENDPOINT_CREDENCIAL.PATH}
        ...    ${BODY_CREDENCIAL.SUCESSO_EXCLUSAO}
        ...    ${BODY_CREDENCIAL.NOME_ALEATORIO}
        Sleep    1s
        Quando executar o método post para filtrar credenciais
        ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
        ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_EXCLUSAO}
        ...    ${BODY_CREDENCIAL.NOME_ALEATORIO}
        ...    Filter
        ...    queryName=${BODY_CREDENCIAL_FILTER.SUCESSO_EXCLUSAO.QueryName}

        ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
        ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]
    ELSE IF    '${detalhe_para_exclusao}' == 'que está inativa há 8 dias ou mais'
        ${data_atual}    Get Current Date
        ${data_atual_menos_7_dias}    Subtract Time From Date    ${data_atual}    7 days
        ${data_atual_menos_7_dias}    Convert Date    ${data_atual_menos_7_dias}    result_format=datetime

        FOR    ${element}    IN    @{credenciais_da_consulta}
            IF    '${element}[Status]' == 'INACTIVE'
                ${data_atualizacao}    Set Variable    ${element}[Updated]
                ${data_atualizacao}    Convert Date    ${data_atualizacao}    result_format=datetime
                IF    '${data_atualizacao}' <= '${data_atual_menos_7_dias}'
                    Log    ${element}
                    ${credencial_id}    Set Variable    ${element}[Id]

                    Should Be True    ${element}[CanDelete] == ${True}

                    IF    '${element}[InativateDate]' != 'None'
                        ${data_inativacao}    Set Variable    ${element}[InativateDate]
                        ${data_inativacao}    Convert Date    ${data_inativacao}    result_format=datetime
                        Should Be True    '${data_inativacao}' <= '${data_atual_menos_7_dias}'
                    END
                    BREAK
                END
            END
        END
    END

    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para exclusão em uma Consulta    credenciais/credenciais    ${credencial_id}
    RETURN    ${credencial_id}

Obter uma credencial da consulta para exclusão criada a menos de 24 horas
    ${result}    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial da consulta para exclusão criada a menos de 24 horas

Obter uma credencial da consulta para exclusão criada a menos de 24 horas, para ativar e inativar
    ${result}    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial da consulta para exclusão criada a menos de 24 horas, para ativar e inativar

Obter uma credencial da consulta para exclusão que está inativa há 8 dias ou mais
    ${result}    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.SUCESSO}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial da consulta para exclusão que está inativa há 8 dias ou mais

Obter o credtId de uma credencial da consulta para colisão
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]
    Atualizar arquivo YAML de Credencial para colisão    credenciais/credenciais    TESTE_AUTOMACAO_BACK_COLISAO_${numero_aleatorio}

    ## Criar uma nova credencial com os mesmos dados na primeira conta - 1
    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO_COLISAO}
    ...    ${BODY_CREDENCIAL.NOME_ALEATORIO_COLISAO}
    Sleep    1s
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_COLISAO}
    ...    ${BODY_CREDENCIAL.NOME_ALEATORIO_COLISAO}
    ...    Filter
    ...    queryName=${BODY_CREDENCIAL_FILTER.SUCESSO_COLISAO.QueryName}

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]
    Log To Console    credencial_id: ${credencial_id}

    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${credencial_id}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True

    ## Criar uma nova credencial com os mesmos dados na segunda conta - 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_ADMIN_CONTA_654}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}

    Quando executar o método post para cadastrar credenciais
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO_COLISAO}
    ...    ${BODY_CREDENCIAL.NOME_ALEATORIO_COLISAO}
    Sleep    1s
    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_COLISAO}
    ...    ${BODY_CREDENCIAL.NOME_ALEATORIO_COLISAO}
    ...    Filter
    ...    queryName=${BODY_CREDENCIAL_FILTER.SUCESSO_COLISAO.QueryName}

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]
    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para colisão em uma Consulta    credenciais/credenciais    ${credencial_id}
    RETURN    ${credencial_id}

Obter uma credencial da consulta para colisão
    ${result}    ${ENDPOINT_CREDENCIAL.CREDTID_COLISAO.SUCESSO}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial da consulta para colisão

Setup para o cadastro de novas credenciais
    Obter as consultas da conta
    Gerar dados novos de credenciais

Setup para o cadastro de novas consultas
    ${result}    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}    Run Keyword And Ignore Error
    ...    Gerar dados novos de consultas

Obter o credtId de uma credencial ativa da nova consulta para compartilhar
    ${nome_consulta}    Quando criar uma consulta rascunho para a conta 654
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}

    Quando adicionar uma consulta para desenvolvimento

    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
    ...    ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO}
 
    Sleep    1s

    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR}
    ...    ${EMPTY}
    ...    Filter
    ...    queryName=${nome_consulta}

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]

    Sleep    1s

    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${credencial_id}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True

    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para compartilhar    credenciais/credenciais    ${credencial_id}

    RETURN    ${credencial_id}

Obter o credtId de uma credencial ativa da consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Sleep    1s

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${encontrado}    Set Variable    False
    
    FOR    ${element}    IN    @{consultas}
        Log Many    ${element}

        IF    'TESTE_AUTOMACAO_BACK_CONSULTA' in '${element}[queryName]'
            ${encontrado}    Set Variable    True
        END
        IF    ${encontrado} == True and ${element}[credentialCount] >= 1
            ${nome_consulta}    Set Variable    ${element}[queryName]
            ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO.campo1.valor}    Set Variable    ${nome_consulta}
            ${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.QueryName}    Set Variable    ${nome_consulta}
            BREAK
        END
    END

    ${response_entradas}    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${nome_consulta}

    ${dict_entradas}=    Create List
    FOR    ${entrada}    IN    @{response_entradas}
        ${dict}=    Create Dictionary    Name=${entrada["Name"]}    Value=${entrada["Description"]}
        Append To List    ${dict_entradas}    ${dict}
    END

    Log To Console    ${dict_entradas}

    ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]

    &{dicionario}    Create Dictionary
    ...    Description=${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR.Description}
    ...    Name=TESTE_AUTOMACAO_BACK_${numero_aleatorio}
    ...    Inputs=${dict_entradas}
    ...    QueryName=${nome_consulta}
    
    Log Many    ${dicionario}

    &{filter}    Create Dictionary
    ...    Description=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.Description}
    ...    Name=TESTE_AUTOMACAO_BACK_${numero_aleatorio}
    ...    Status=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.Status}
    ...    User=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.User}

    &{dicionario_filtro}    Create Dictionary
    ...    Filter=${filter}
    ...    QueryName=${nome_consulta}
    
    Log Many    ${dicionario_filtro}

    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${dicionario}
    ...    ${EMPTY}
 
    Sleep    1s

    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${dicionario_filtro}
    ...    ${EMPTY}
    ...    Filter
    ...    queryName=${nome_consulta}

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]

    Quando executar o método put para ativar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}/${credencial_id}/status
    ...    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    ...    ${EMPTY}
    ...    data=True

    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para compartilhar    credenciais/credenciais    ${credencial_id}

    RETURN    ${credencial_id}

Obter o credtId de uma credencial inativa da consulta rascunho para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    Sleep    1s

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${encontrado}    Set Variable    False
    
    FOR    ${element}    IN    @{consultas}
        Log Many    ${element}

        IF    'TESTE_AUTOMACAO_BACK_CONSULTA' in '${element}[queryName]'
            ${encontrado}    Set Variable    True
        END
        IF    ${encontrado} == True and ${element}[credentialCount] >= 1
            ${nome_consulta}    Set Variable    ${element}[queryName]
            ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO.campo1.valor}    Set Variable    ${nome_consulta}
            ${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.QueryName}    Set Variable    ${nome_consulta}
            BREAK
        END
    END

    ${response_entradas}    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${nome_consulta}

    ${dict_entradas}=    Create List
    FOR    ${entrada}    IN    @{response_entradas}
        ${dict}=    Create Dictionary    Name=${entrada["Name"]}    Value=${entrada["Description"]}
        Append To List    ${dict_entradas}    ${dict}
    END

    Log To Console    ${dict_entradas}
    ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]

    &{dicionario}    Create Dictionary
    ...    Description=${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR.Description}
    ...    Name=TESTE_AUTOMACAO_BACK_${numero_aleatorio}
    ...    Inputs=${dict_entradas}
    ...    QueryName=${nome_consulta}
    
    Log Many    ${dicionario}

    &{filter}    Create Dictionary
    ...    Description=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.Description}
    ...    Name=TESTE_AUTOMACAO_BACK_${numero_aleatorio}
    ...    Status=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.Status}
    ...    User=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.Filter.User}

    &{dicionario_filtro}    Create Dictionary
    ...    Filter=${filter}
    ...    QueryName=${nome_consulta}
    
    Log Many    ${dicionario_filtro}

    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${dicionario}
    ...    ${EMPTY}
 
    Sleep    1s

    Quando executar o método post para filtrar credenciais
    ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
    ...    ${dicionario_filtro}
    ...    ${EMPTY}
    ...    Filter
    ...    queryName=${nome_consulta}

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]

    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para compartilhar    credenciais/credenciais    ${credencial_id}

    RETURN    ${credencial_id}

Obter o credtId de uma credencial com status ${status} da consulta ${tipo_consulta} para compartilhar
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    IF    '${tipo_consulta}' == 'rascunho'
        ${response}    Quando executar o método get para listar as consultas
        ...    ${ENDPOINT_CONSULTAS.PATH}
        ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
        ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    
        ${consultas}    Set Variable    ${response['GatewayQueries']}
        ${encontrado}    Set Variable    False
        
        FOR    ${element}    IN    @{consultas}
            Log Many    ${element}

            IF    'TESTE_AUTOMACAO_BACK_CONSULTA' in '${element}[queryName]'
                ${encontrado}    Set Variable    True
            END
            IF    ${encontrado} == True and ${element}[credentialCount] >= 1
                ${nome_consulta}    Set Variable    ${element}[queryName]
                BREAK
            END
        END

    ELSE IF    '${tipo_consulta}' == 'definitiva'
        ${nome_consulta}    Set Variable    ${ENDPOINT_CREDENCIAL.CREDTID_EXCLUSAO.CONSULTA_COM_CREDENCIAL_ATIVA}
    END

    Log    ${nome_consulta}

    ${response}    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}
    ...    sortField=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.FIELD[2]}
    ...    sortDirection=${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.DIRECTION[2]}
    ...    queryId=${nome_consulta}
    ...    origem=credentials

    ${credenciais_da_consulta}    Set Variable    ${response}[CredentialsList]
    Log List    ${credenciais_da_consulta}

    ${total_credenciais_da_consulta}    Get Length    ${credenciais_da_consulta}
    
    IF    '${status}' == 'ativo'
        FOR    ${element}    IN    @{credenciais_da_consulta}
            IF    '${element}[Status]' == 'ACTIVE'
                ${credencial_id}    Set Variable    ${element}[Id]
                BREAK
            END
        END
    ELSE IF    '${status}' == 'inativo'
        FOR    ${element}    IN    @{credenciais_da_consulta}
            IF    '${element}[Status]' == 'INACTIVE'
                ${credencial_id}    Set Variable    ${element}[Id]
                BREAK
            END
        END
    ELSE IF    '${status}' == 'inativo' and '${tipo_consulta}' == 'rascunho'
        Quando executar o método post para cadastrar credencial
        ...    ${ENDPOINT_CREDENCIAL.PATH}
        ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
        ...    ${EMPTY}
 
        Sleep    1s

        Quando executar o método post para filtrar credenciais
        ...    ${ENDPOINT_CREDENCIAL_FILTER.PATH}
        ...    ${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR}
        ...    ${EMPTY}
        ...    Filter
        ...    queryName=${BODY_CREDENCIAL_FILTER.SUCESSO_COMPARTILHAR.QueryName}
    
        ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
        ${credencial_id}    Set Variable    ${credenciais_da_consulta}[${0}][Id]
    END

    Log To Console    credencial_id: ${credencial_id}

    Atualizar arquivo YAML de Credencial para compartilhar    credenciais/credenciais    ${credencial_id}
    RETURN    ${credencial_id}

Obter uma credencial da consulta com status ativo da nova consulta rascunho para compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_NOVO_RASCUNHO.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial ativa da nova consulta para compartilhar

Obter uma credencial da consulta com status ativo da consulta rascunho para compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_RASCUNHO.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial ativa da consulta rascunho para compartilhar

Obter uma credencial da consulta com status inativo da consulta rascunho para compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_RASCUNHO.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial inativa da consulta rascunho para compartilhar

Obter uma credencial da consulta com status ativo da consulta definitiva para compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_ATIVO_DEFINITIVO.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial com status ativo da consulta definitiva para compartilhar

Obter uma credencial da consulta com status inativo da consulta definitiva para compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_DEFINITIVO.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial com status inativo da consulta definitiva para compartilhar

Obter uma credencial da consulta com status inativo da consulta rascunho para interromper o compartilhar
    ${result}    ${BODY_CREDENCIAL_COMPARTILHAR.CREDENTIAL_ID_SUCESSO_INATIVO_RASCUNHO_INTERROMPER.campo1.valor}    Run Keyword And Ignore Error
    ...    Obter o credtId de uma credencial com status inativo da consulta rascunho para compartilhar

E validar que a credencial compartilhada está sendo listada na credencial da consulta na conta do desenvolvedor
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_999_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}

    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO.campo1.valor}
    ...    origem=credentials

    ${credenciais_da_consulta}    Set Variable    ${response.json()}[CredentialsList]
    ${name}    Set Variable    ${credenciais_da_consulta}[${0}][Name]
    ${description}    Set Variable    ${credenciais_da_consulta}[${0}][Description]
    ${status}    Set Variable    ${credenciais_da_consulta}[${0}][Status]
    ${accountclient}    Set Variable    ${credenciais_da_consulta}[${0}][AccountClient]
    ${accountclient}    Convert To Integer    ${accountclient}

    Should Be Equal    ${name}    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR.Name}
    Should Be Equal    ${description}    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR.Description}
    Should Be Equal    ${status}    ${BODY_CREDENCIAL.SUCESSO_STATUS.ATIVAR}
    Should Be Equal    ${accountclient}    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO_RASCUNHO.accountClient}

Obter o nome de uma credencial compartilhada da consulta
    ${nome_consulta_com_credenciais_compartilhada}    Set Variable    ${ENDPOINT_CONSULTAS.QUERYID.COMPARTILHADA}

    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as credenciais por consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${nome_consulta_com_credenciais_compartilhada}
    ...    origem=credentials

    ${credenciais_da_consulta}    Set Variable    ${response}[CredentialsList]
    Log List    ${credenciais_da_consulta}

    ${lista_credenciais_compartilhadas}    Create List

    FOR    ${element}    IN    @{credenciais_da_consulta}
        Log    ${element}
        IF    '${element}[Shared]' == 'TRUE'
            Append To List    ${lista_credenciais_compartilhadas}    ${element}
        END
    END

    Log List    ${lista_credenciais_compartilhadas}
    ${total_credenciais_da_consulta}    Get Length    ${lista_credenciais_compartilhadas}

    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_credenciais_da_consulta})
    ${credencial_comppartilhada_name}    Set Variable    ${lista_credenciais_compartilhadas}[${numero_aleatorio}][Name]
    Atualizar arquivo YAML de Credencial sendo compartilhada    credenciais/credenciais    ${credencial_comppartilhada_name}
    RETURN    ${credencial_comppartilhada_name}
    
E json contendo uma das listas de resultados
    ${status}    ${mensagem}    Run Keyword And Ignore Error    E Json contendo lista de resultados    credenciais/get_credencial_compartilhamento_schema
    Run Keyword If    '${status}' == 'FAIL'    E Json contendo lista de resultados    credenciais/get_credencial_compartilhamento_schema_qtd_null

Obter consulta rascunho sem credenciais na conta do ${tipo_usuario}
    ${nome_consulta}    Quando criar uma consulta rascunho para a conta 654
    IF    '${tipo_usuario}' == 'cliente'
        Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
        Quando adicionar uma consulta para desenvolvimento
    END

    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${total_consultas}    Get Length    ${consultas}

    FOR    ${element}    IN    @{consultas}
        Log Many    ${element}
        IF    '${element}[queryName]' == '${nome_consulta}'
            Log    ${element}
            ${queryId}    Set Variable    ${element}[id]
            BREAK
        END
    END

    RETURN    ${queryId}

Obter consulta rascunho com credenciais na conta do ${tipo_usuario}
    ${nome_consulta}    Quando criar uma consulta rascunho para a conta 654
    Set Test Variable    ${nome_consulta}
    IF    '${tipo_usuario}' == 'desenvolvedor'
        Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
        Quando executar o método post para cadastrar credencial
        ...    ${ENDPOINT_CREDENCIAL.PATH}
        ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
        ...    ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO}
     
        Sleep    1s
    ELSE IF    '${tipo_usuario}' == 'cliente'
        Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
        Quando adicionar uma consulta para desenvolvimento

        Quando executar o método post para cadastrar credencial
        ...    ${ENDPOINT_CREDENCIAL.PATH}
        ...    ${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR}
        ...    ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO}
     
        Sleep    1s
    END

    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${total_consultas}    Get Length    ${consultas}

    FOR    ${element}    IN    @{consultas}
        Log Many    ${element}
        IF    '${element}[queryName]' == '${nome_consulta}'
            Log    ${element}
            ${queryId}    Set Variable    ${element}[id]
            BREAK
        END
    END

    RETURN    ${queryId}

Dado que obtenha consulta rascunho sem credencial na conta do ${tipo_usuario}
    ${result}    ${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}    Run Keyword And Ignore Error
        ...    Obter consulta rascunho sem credenciais na conta do ${tipo_usuario}

Dado que obtenha consulta rascunho com credencial na conta do ${tipo_usuario}
    ${result}    ${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}    Run Keyword And Ignore Error
        ...    Obter consulta rascunho com credenciais na conta do ${tipo_usuario}

Obter o queryId da consulta do cliente na conta do desenvolvedor
    Setup para o cadastro de novas consultas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO_RASCUNHO_2}
    ...    ${EMPTY}
    
    ${nome_consulta}    Set Variable    ${BODY_CONSULTA.SUCESSO_RASCUNHO_2.id}

    Set Test Variable    ${nome_consulta}
    
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_654_NAO_NEUROTECH}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO_RASCUNHO_2}
    ...    ${EMPTY}

    ${response_entradas}    Quando executar o método get para listar as entradas de uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    queryId=${nome_consulta}

    ${dict_entradas}=    Create List
    FOR    ${entrada}    IN    @{response_entradas}
        ${dict}=    Create Dictionary    Name=${entrada["Name"]}    Value=${entrada["Description"]}
        Append To List    ${dict_entradas}    ${dict}
    END

    Log To Console    ${dict_entradas}

    ${numero_aleatorio}    Generate Random String    length=6    chars=[NUMBERS]

    &{dicionario}    Create Dictionary
    ...    Description=${BODY_CREDENCIAL.SUCESSO_CRIAR_COMPARTILHAR.Description}
    ...    Name=TESTE_AUTOMACAO_BACK_${numero_aleatorio}
    ...    Inputs=${dict_entradas}
    ...    QueryName=${nome_consulta}
    
    Log Many    ${dicionario}

    Quando executar o método post para cadastrar credencial
    ...    ${ENDPOINT_CREDENCIAL.PATH}
    ...    ${dicionario}
    ...    ${EMPTY}
    
    Sleep    1s
    # Dado que obtenha consulta rascunho com credencial na conta do cliente
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    ${response}    Quando executar o método get para listar as consultas
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    page=${ENDPOINT_CONSULTAS.PARAMETER.PAGE}
    ...    size=${ENDPOINT_CONSULTAS.PARAMETER.SIZE}

    ${consultas}    Set Variable    ${response['GatewayQueries']}
    ${total_consultas}    Get Length    ${consultas}

    FOR    ${element}    IN    @{consultas}
        Log Many    ${element}
        IF    '${element}[queryName]' == '${nome_consulta}'
            Log    ${element}
            ${queryId}    Set Variable    ${element}[id]
            Set Test Variable    ${dados_consulta_desenv_baseada_consulta_cliente}    ${element}
            BREAK
        END
    END

    RETURN    ${queryId}

Dado que obtenha o queryId da consulta do cliente na conta do desenvolvedor
    ${result}    ${ENDPOINT_CONSULTAS.QUERYID.CREDENCIAL.PARAMETER.QUERYID_CONSULTA_RASCUNHO}    Run Keyword And Ignore Error
        ...    Obter o queryId da consulta do cliente na conta do desenvolvedor

E validar que a credencial foi criada exclusivamente na conta do cliente e não na conta do desenvolvedor
    ${valor}    Get From Dictionary    ${dados_consulta_desenv_baseada_consulta_cliente}    credentialCount
    Should Be Equal As Numbers    ${valor}    0

E validar a paginação dos resultados
    [Arguments]    ${size}
    ${total_elementos_retorno}    Set Variable    ${json_retorno}[TotalElements]
    ${restante_paginacao}    Evaluate    ${total_elementos_retorno} - ${size}
    ${credenciais}    Set Variable    ${json_retorno}[CredentialsList]
    ${total_credenciais}    Get Length    ${credenciais}
    Should Be True    ${restante_paginacao} > 0    msg=O restante da paginação deve ser maior que 0
    Should Be True    ${total_credenciais} == ${size}    msg=O restante da paginação não pode exceder o tamanho da página (${size})

Obter o credtId em uma credencial da consulta ABRTELECOM
    ${result}    ${ENDPOINT_CREDENCIAL.CREDTID.SUCESSO}    Run Keyword And Ignore Error
        ...    Obter o credtId de uma credencial da consulta    ${ENDPOINT_CREDENCIAL.NAME_CREDENTIAL.NAO_COMPARTILHADA}

Obter o queryId de uma consulta do portfólio
    ${consulta}    Quando executar o método para obter consultas do portfólio
    ...    ${ENDPOINT_CONSULTAS.PATH_PORTFOLIO}
    
    ${result}    ${BODY_CONSULTA.SUCESSO}    Run Keyword And Ignore Error
    ...    Create Dictionary
    ...    id=${consulta}
        