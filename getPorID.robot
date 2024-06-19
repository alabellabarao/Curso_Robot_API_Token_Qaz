*** Settings ***
    # Declarar a biblioteca
Library   RequestsLibrary
Library   Collections


*** Variables ***
${expected_price}  111

*** Test Cases ***
    ${response}=  GET   https://restful-booker.herokuapp.com/booking/443

      
        # Verificando as reservas
    ${primeiroNome}=    Get From Dictionary   ${response.json()}  firstname
    Should Be Equal As Strings  ${primeiroNome}     John

    ${ultimoNome}=    Get From Dictionary   ${response.json()}  lastname
    Should Be Equal As Strings  ${ultimoNome}     Smith
       
        # Criar variável  ${totalprice}
        # Get From Dictionary: É uma palavra-chave do Robot Framework usada para acessar 
            # um valor específico dentro de um dicionário.
        # ${response.json()}: Refere-se ao corpo da resposta JSON da chamada GET que foi 
            # armazenada na variável ${response}.
        # totalprice: É a chave no dicionário JSON da qual estamos extraindo o valor. 
            # Neste caso, estamos acessando o valor associado à chave totalprice.
    ${totalpriceNova}=    Get From Dictionary   ${response.json()}  totalprice

        # Cria a variável ${totalprice_str}, converte a variável ${totalprice} para string
            # e a variável ${totalprice_str} armazena esse valor como string.
    ${totalprice_str}=  Convert To String  ${totalpriceNova}
      # Cria a variável ${expected_price_str}, converte a variável ${expected_price} para string
            # e a variável ${expected_price_str} armazena esse valor como string.
    ${expected_price_str}=  Convert To String  ${expected_price}

        # Verifica se os dois valores são iguais
    Should Be Equal     ${totalprice_str}   ${expected_price_str}

 
         # Verificando se o depositpaid
    ${depositpaid}=     Get From Dictionary     ${response.json()}  depositpaid
    Should Be True  ${depositpaid} 

     
    ${adicaoNecessaria}=    Get From Dictionary   ${response.json()}  additionalneeds
    Should Be Equal As Strings  ${adicaoNecessaria}     Breakfast
