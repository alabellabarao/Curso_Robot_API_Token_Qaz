*** Settings ***
    // Declarar a biblioteca
Library   RequestsLibrary

*** Test Cases ***
Consultando as reservas cadastradas com status 200
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
        # Ver o que retornou referente a linha de cima, Imprimir como se fosse um texto
    Log  ${response.text}
    Log    Status Code: ${response.status_code}
        # Validar se é verdadeiro. Se o response retornou = OK
    Run Keyword If    '${response.status_code}' == '400'    Log To Console    O status_code retornou 200
    Should Be True  ${response.ok}
        # Validar se a string status_code é igual a 200
    Should Be Equal As strings  ${response.status_code}  200

Consultando as reservas cadastradas com status 400
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
    Log  ${response.text}
    Log    Status Code: ${response.status_code}
    Run Keyword If    '${response.status_code}' == '400'    Log To Console    O status_code retornou 400.
    Run Keyword If    '${response.status_code}' != '400'    Log To Console    O status_code não retornou 400.
    Should Be Equal As Strings    ${response.status_code}    400