*** Settings ***
Library   RequestsLibrary

*** Keywords ***
Step 1: Fazer a request GET
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
    Log  ${response.text}
    Set Test Variable   ${response}


        Should Be Equal As strings  ${response.status_code}  200
    
Step 3: Verificar o status é igual a 200
    Should Be Equal As strings  ${response.status_code}  200