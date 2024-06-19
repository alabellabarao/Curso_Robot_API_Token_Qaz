*** Settings ***
    # Declarar a biblioteca
Library   RequestsLibrary
Library   Collections
Library   BuiltIn

*** Keywords ***

 Consultando as reservas que foi cadastrada do zero
    ${response}=  GET   https://restful-booker.herokuapp.com/booking/756
    Log  ${response.text}
     # Esse set test variable faz com que a variável fique dispobível para outros cenários
    Set Global Variable   ${response}  ${response}

 Verificando o campo Nome    
    ${response}=  Get Variable Value    ${response}   
        # Verificando as reservas
    ${primeiroNome}=    Get From Dictionary   ${response.json()}  firstname
    Should Be Equal As Strings  ${primeiroNome}     Josh

 Verificando o campo último nome  
    ${response}=  Get Variable Value    ${response}     
    ${ultimoNome}=    Get From Dictionary   ${response.json()}  lastname
    Should Be Equal As Strings  ${ultimoNome}     Allen
       
 Verificando o campo totalprice  
    ${response}=  Get Variable Value    ${response}
    ${expected_price}=  Set Variable    111    # Define a variável expected_price com valor 111
    ${totalpriceNova}=  Get From Dictionary   ${response.json()}  totalprice
    ${totalprice_str}=  Convert To String  ${totalpriceNova}
    ${expected_price_str}=  Convert To String  ${expected_price}
    Should Be Equal  ${totalprice_str}  ${expected_price_str}

 Verificando o campo depositpaid  
    ${response}=  Get Variable Value    ${response}      
         # Verificando se o depositpaid
    ${depositpaid}=     Get From Dictionary     ${response.json()}  depositpaid
    Should Be True  ${depositpaid} 

 Verificando o campo additionalneeds    
    ${response}=  Get Variable Value    ${response}   
    ${adicaoNecessaria}=    Get From Dictionary   ${response.json()}  additionalneeds
    Should Be Equal As Strings  ${adicaoNecessaria}     super bowls

*** Test Cases ***
Cenario 1: Validando todos os campos
    Consultando as reservas que foi cadastrada do zero
    Verificando o campo Nome 
    Verificando o campo último nome
    Verificando o campo totalprice
    Verificando o campo depositpaid
    Verificando o campo additionalneeds