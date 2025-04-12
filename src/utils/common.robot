*** Settings ***
Documentation       Keywords Comuns para uso em geral

Resource            ../config/package.robot


*** Keywords ***
Dado que possua um token
    [Arguments]    ${token}
    ${headers}=    Create Dictionary
    ...    Accept=application/json;charset=UTF-8
    ...    Content-Type=application/json
    Set Test Variable    ${chaves}    ${EMPTY}
    Set Test Variable    ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}    ${token}
    Set Test Variable    ${headers}

Dado que contenha as chaves API da conta
    [Arguments]    ${credenciais}    ${url}
    ${auth}    Create List    ${credenciais.CHAVES.CLIENTE_ID}    ${credenciais.CHAVES.CLIENTE_SECRET}
    ${headers}=    Create Dictionary
    ...    Accept=application/json;charset=UTF-8
    ...    Content-Type=application/json
    Set Test Variable    ${chaves}    ${auth}
    Set Test Variable    ${headers}
    Conectando na API    ${chaves}    ${url}

Dado que gere um token
    [Arguments]    ${credenciais}    ${url}=${DADOS_COMUNS.URL}
    Dado que contenha as chaves API da conta    ${credenciais}    ${url}
    ${response}    POST On Session
    ...    create_session
    ...    url=${ENDPOINT_LOGIN.PATH}
    ...    json=${credenciais.BODY_LOGIN}
    ...    headers=${headers}
    ...    expected_status=any
    Set Test Variable    ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}    ${response.json()['access_token']}

Então a api retorna StatusCode    # Valida o status code da api
    [Arguments]    ${status_code}
    Should Be Equal As Strings    ${response.status_code}    ${status_code}

E a api deve retornar o Json contendo o parametro ${parametro}    # Pode ser usado para validar um parametro em específico
    [Arguments]    ${value}    ${novo_campo}=${None}    ${nome_campo}=description
    Run Keyword And Return If
    ...    $novo_campo != $None
    ...    Should Contain
    ...    ${response.json()['${parametro}']['${nome_campo}']}
    ...    ${value}
    Should Be Equal As Strings    ${response.json()['${parametro}']}    ${value}

E a api deve validar o retorno quando o campo nome é vazio
    Should Contain Any
    ...    ${response.json()['errors']['name']}
    ...    O nome da credencial deve possuir entre 5 e 50 caracteres
    ...    O nome da credencial pode conter apenas caracteres alfanuméricos maiúsculos ou o caracter '_' e deve começar com uma letra maiúscula
    ...    O nome da credencial não pode ser vazio

E a api não deve exibir nenhum retorno    # Usado para validar nenhum    retorno no body de response
    Should Be Equal As Strings    ${response.text}    ${EMPTY}

E a api deve exibir o conteúdo no retorno
    [Arguments]    ${texto}
    Log    ${response.text}
    Should Be Equal As Strings   ${RESPONSE.headers["Content-Type"]}    text/plain;version=0.0.4;charset=utf-8
    Should Contain    ${response.text}    ${texto}

E a api deve exibir o conteúdo no retorno json
    [Arguments]    ${texto}
    Log    ${response.text}
    Should Contain    ${response.text}    ${texto}

E a api não deve exibir o conteúdo no retorno json
    [Arguments]    ${texto}
    Log    ${response.text}
    Should Not Contain    ${response.text}    ${texto}

E a api deve exibir o conteúdo em ordem alfabética no retorno json
    ${consultas}    Set Variable    ${response.json()['Sites']}
    
    @{names}           Create List
    FOR    ${item}    IN    @{consultas}
        ${site}       Get From Dictionary    ${item}    Site
        Append To List    ${names}    ${site}
    END
    Log Many           ${names}
    
    ${lista_ordenada}    Evaluate    sorted(${names}, key=lambda x: x.lower())
    Log Many           ${lista_ordenada}
    Should Be Equal    ${names}    ${lista_ordenada}

E a api deve exibir um array vazio no retorno    # Usado para validar nenhum    retorno no body de response
    Should Be Equal As Strings    ${response.json()}[CredentialsList]    []

E a api deve exibir um array vazio no retorno de Logs    # Usado para validar nenhum    retorno no body de response
    Should Be Equal As Strings    ${response.json()}[TotalElements]    ${EMPTY}
    Should Be Equal As Strings    ${response.json()}[Logs]    []

E contrato da API esta correto
    [Arguments]    ${response}    ${schema}
    Validate Json By Schema File    ${response}    src/auto/schema/${schema}.json    encoding=UTF-8

E Json contendo lista de resultados
    [Arguments]    ${schema}
    E contrato da API esta correto    ${response.json()}    ${schema}

E a api deve retornar uma lista de consultas vazia
    Should Be Equal As Strings  ${response.json()['GatewayQueries']}    []

Quando executar o método get ${nome_metodo}
    [Arguments]
    ...    ${endpoint}
    ...    ${page}=${None}
    ...    ${size}=${None}
    ...    ${queryId}=${None}
    ...    ${credtId}=${None}
    ...    ${origem}=inputs
    ...    ${sortField}=${None}
    ...    ${sortDirection}=${None}
    ...    ${nameCredential}=${None}

    Log To Console    page=${page}
    Log To Console    size=${size}
    Log To Console    queryId=${queryId}
    Log To Console    credtId=${credtId}
    Log To Console    nameCredential=${nameCredential}

    IF    '${page}' == 'EMPTY' or '${size}' == 'EMPTY'
        ${endpoint}    Set Variable    ${endpoint}?page=${EMPTY}&size=${EMPTY}
    ELSE IF    '${page}' == '${None}' or '${size}' == '${None}'
        ${endpoint}    Set Variable    ${endpoint}
        IF    '${queryId}' != '${None}'
            IF    '${origem}'
                IF    '${sortField}' == 'EMPTY' or '${sortDirection}' == 'EMPTY'
                    ${endpoint}    Set Variable
                    ...    ${endpoint}/${queryId}/${origem}?&sortField=${EMPTY}&sortDirection=${EMPTY}
                ELSE IF    '${sortField}' == '${None}' or '${sortDirection}' == '${None}'
                    ${endpoint}    Set Variable    ${endpoint}/${queryId}/${origem}?&sortField=${EMPTY}&sortDirection=${EMPTY}
                ELSE IF    '${queryId}' == 'EMPTY'
                    ${endpoint}    Set Variable
                    ...    ${endpoint}/${EMPTY}/${origem}?&sortField=${sortField}&sortDirection=${sortDirection}
                ELSE
                    ${endpoint}    Set Variable
                    ...    ${endpoint}/${queryId}/${origem}?&sortField=${sortField}&sortDirection=${sortDirection}
                END
            END
        ELSE IF    '${credtId}' != '${None}'
            ${endpoint}    Set Variable    ${endpoint}/${credtId}
        ELSE IF    '${nameCredential}' != '${None}'
            ${endpoint}    Set Variable    ${endpoint}/${nameCredential}
        END
    ELSE IF    '${page}' != '${None}' and '${size}' != '${None}' and '${queryId}' != '${None}'
        ${endpoint}    Set Variable    ${endpoint}
        IF    '${origem}'
            IF    '${sortField}' == 'EMPTY' or '${sortDirection}' == 'EMPTY'
                ${endpoint}    Set Variable
                ...    ${endpoint}/${queryId}/${origem}?page=${page}&size=${size}&sortField=${EMPTY}&sortDirection=${EMPTY}
            ELSE
                ${endpoint}    Set Variable
                ...    ${endpoint}/${queryId}/${origem}?page=${page}&size=${size}&sortField=${sortField}&sortDirection=${sortDirection}
            END
        END
    ELSE
        ${endpoint}    Set Variable    ${endpoint}?page=${page}&size=${size}
    END

    Conectando na API

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    ${response}    GET On Session
    ...    create_session
    ...    url=${endpoint}
    ...    headers=${header}
    ...    expected_status=any

    Log To Console    statusCode: ${response}
    Set Suite Variable    ${response}

    IF    '${response}' != '<Response [400]>'
        ${result}    ${value}    Run Keyword And Ignore Error    Set Test Variable    ${resposta}    ${response.json()}
        IF    '${result}' == 'PASS'    RETURN    ${response.json()}
    END

Quando executar o método post ${nome_metodo}
    [Arguments]    ${endpoint}    ${body}    ${parametro}    ${filtro}=${None}    ${queryName}=${BODY_CREDENCIAL_FILTER.SUCESSO.QueryName}

    ${tamanho}    Get Length    ${parametro}
    Set Suite Variable    ${filtro}

    IF    '${filtro}' == 'Filter'
        FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
            ${body}    Update Value To Json
            ...    ${body}[Filter]
            ...    ${parametro.campo${counter}.nome}
            ...    ${parametro.campo${counter}.valor}

            ${body}    Create Dictionary    QueryName=${queryName}    Filter=${body}
        END
    ELSE
        FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
            ${body}    Update Value To Json
            ...    ${body}
            ...    ${parametro.campo${counter}.nome}
            ...    ${parametro.campo${counter}.valor}
            Log    ${counter}
        END
    END

    Conectando na API

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    ${response}    POST On Session
    ...    create_session
    ...    url=${endpoint}
    ...    json=${body}
    ...    headers=${header}
    ...    expected_status=any

    Log Many    bodyPost: ${body}
    Set Suite Variable    ${response}
    Set Suite Variable    ${json_retorno}    ${response.json()}

Quando executar sem body o método post ${nome_metodo}
    [Arguments]    ${endpoint}

    Conectando na API

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    ${response}    POST On Session
    ...    create_session
    ...    url=${endpoint}
    ...    headers=${header}
    ...    expected_status=any

    Set Suite Variable    ${response}
    Set Suite Variable    ${json_retorno}    ${response.json()}

Quando executar o método put ${nome_metodo}
    [Arguments]    ${endpoint}    ${body}    ${parametro}    ${data}=${None}

    ${tamanho}    Get Length    ${parametro}

    FOR    ${counter}    IN RANGE    1    ${tamanho} + 1
        ${body}    Update Value To Json
        ...    ${body}
        ...    ${parametro.campo${counter}.nome}
        ...    ${parametro.campo${counter}.valor}
        Log    ${counter}
    END

    Conectando na API

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    IF    $data != $None
        ${response}    PUT On Session
        ...    create_session
        ...    url=${endpoint}
        ...    data=${body}
        ...    headers=${header}
        ...    expected_status=any
    ELSE
        ${response}    PUT On Session
        ...    create_session
        ...    url=${endpoint}
        ...    json=${body}
        ...    headers=${header}
        ...    expected_status=any
    END

    Log Many    bodyPost: ${body}
    Set Suite Variable    ${response}

Quando executar o método delete ${nome_metodo}
    [Arguments]    ${endpoint}

    Conectando na API 

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    ${response}    DELETE On Session
    ...    create_session
    ...    url=${endpoint}
    ...    headers=${header}
    ...    expected_status=any

    Set Suite Variable    ${response}

Quando executar o método para obter consultas do portfólio
    [Arguments]    ${endpoint}
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Conectando na API

    Set Test Variable
    ...    &{header}
    ...    Authorization=Bearer ${DADOS_COMUNS.TOKEN.ACCESS_TOKEN}

    ${response}    GET On Session
    ...    create_session
    ...    url=${endpoint}
    ...    headers=${header}
    ...    expected_status=any

    Log To Console    response: ${response}
    Set Suite Variable    ${response}

    ${consultas}    Set Variable    ${response.json()['Sites']}
    ${total_consultas}    Get Length    ${consultas}
    ${numero_aleatorio}    Evaluate    random.randrange(0, ${total_consultas})
    ${consulta_id}    Set Variable    ${response.json()['Sites'][${numero_aleatorio}]['Site']}
    Atualizar arquivo YAML de Consultas    consultas/consultas    ${consulta_id}
    RETURN    ${consulta_id}

Quando executar o método do Prometheus
    [Arguments]    ${endpoint}    ${auth}=${EMPTY}    ${url}=${DADOS_COMUNS.URL}
    
    ${headers}=    Create Dictionary
    ...    Accept=*/*

    Set Suite Variable    ${base_url}    ${url}
    Create Session    create_session    url=${base_url}    headers=${headers}    auth=${auth}    disable_warnings=true

    ${response}    GET On Session
    ...    create_session
    ...    url=${endpoint}
    ...    expected_status=any

    Log To Console    statusCode: ${response}
    Set Suite Variable    ${response}

    IF    '${response}' != '<Response [400]>'
        ${result}    ${value}    Run Keyword And Ignore Error    Set Test Variable    ${resposta}    ${response.json()}
        IF    '${result}' == 'PASS'    RETURN    ${response.json()}
    END

Quando adicionar uma consulta
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO}
    ...    ${EMPTY}

Quando adicionar uma consulta para desenvolvimento
    Quando executar o método post para adicionar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH}
    ...    ${BODY_CONSULTA.SUCESSO_RASCUNHO}
    ...    ${EMPTY}

Quando criar uma consulta para desenvolvimento
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO}
    ...    ${EMPTY}

Quando criar uma consulta rascunho para a conta 654
    Setup para o cadastro de novas consultas
    Dado que gere um token    ${ENDPOINT_LOGIN.LOGIN_SUPER_NEUROTECH_999}    url=${DADOS_COMUNS.URL_PORTAL_AUTH}
    Quando executar o método post para criar uma consulta
    ...    ${ENDPOINT_CONSULTAS.PATH_DESENVOLVIMENTO}
    ...    ${BODY_CONSULTA_DESENVOLVIMENTO.SUCESSO_RASCUNHO}
    ...    ${EMPTY}
    
    ${consulta_id}    Set Variable    ${BODY_CONSULTA.SUCESSO_RASCUNHO.id}
    # ${BODY_CREDENCIAL_COMPARTILHAR.QUERYNAME_SUCESSO.campo1.valor}    Set Variable    ${BODY_CONSULTA.SUCESSO_RASCUNHO.id}

   RETURN    ${consulta_id}