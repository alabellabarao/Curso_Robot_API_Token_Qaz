*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com

*** Test Cases ***
Gerando um Token
    ${data}=  Create Dictionary  username=admin      password=password123

    ${response}     POST    ${BASE_URL}/auth    json=${data}
    Should Be True      ${response.ok}
    Should Be Equal As Numbers      ${response.status_code}     200
    
    ${data_response}=    Set Variable        ${response.json()}
    Log Dictionary  ${data_response}

    ${token}=   Get From Dictionary   ${data_response}      token
    Log  Seu token é: ${token}