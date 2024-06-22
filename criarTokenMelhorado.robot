*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com

*** Keywords ***
Acessar os dados obrigatórios
    ${data}=  Create Dictionary  username=admin      password=password123
    Set Test Variable   ${data}

Enviando a solicitaçao POST
    ${response}     POST    ${BASE_URL}/auth    json=${data}
    Should Be True      ${response.ok}
    Should Be Equal As Numbers      ${response.status_code}     200
    Set Test Variable   ${response}
    
Validando os valores retornados e formatando para json
    
    ${data_response}=    Set Variable        ${response.json()}
    Log Dictionary  ${data_response}
    Set Test Variable   ${data_response}

Capturando o token gerado
    ${token}=   Get From Dictionary   ${data_response}      token
    Log  Seu token é: ${token}


*** Test Cases ***
Cenario 1 - Capturar o Token
    Acessar os dados obrigatórios
    Enviando a solicitaçao POST
    Validando os valores retornados e formatando para json
    Capturando o token gerado