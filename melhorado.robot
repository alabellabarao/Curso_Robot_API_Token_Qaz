*** Settings ***
Library   RequestsLibrary

*** Keywords ***
Step 1: Fazer a request GET
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
    Log  ${response.text}
     # Esse set test variable faz com que a variável fique dispobível para outros cenários
    Set Test Variable   ${response}

Step 2: Verificar se GET foi feito com sucesso
    Should Be True  ${response.ok}
    
Step 3: Verificar o statuS_code é igual a 200
    Should Be Equal As strings  ${response.status_code}  200

*** Test Cases ***
Cenario 1: Validando get melhorado
    Step 1: Fazer a request GET
    Step 2: Verificar se GET foi feito com sucesso
    Step 3: Verificar o statuS_code é igual a 200