*** Settings ***
Library   RequestsLibrary
Library   Collections
Library   BuiltIn
*** Variables ***

${BASE_URL}       https://restful-booker.herokuapp.com

*** Keywords ***

Cadastrando Uma Reserva

        # Criando dados para o ${bookingdates} , onde tem os valores checkin e checkout
    ${bookingdates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01

        # Create Dictionary: Esta é uma palavra-chave do Robot Framework usada para criar
        # um dicionário. Dicionários são estruturas de dados que armazenam pares 
        # chave-valor.
        # Cria o valor para cada campo
    ${data}=    Create Dictionary    firstname=herbertao    lastname=qazando    totalprice=222    depositpaid=True    bookingdates=${bookingdates}    additionalneeds=Breakfast
   
        # Esse set test variable faz com que a variável fique disponível para outros cenários
    Set Test Variable   ${data}

        # É uma palavra-chave do Robot Framework utilizada para registrar informações no console de saída durante a execução dos teste
    Log    ${data}

    # Enviando a solicitação POST

Enviando o POST com sucesso
        # Recupera o valor da variável ${data}
    ${data}=    Get Variable Value    ${data}

        # Envia uma requisição HTTP POST para a URL ${BASE_URL}/booking com um payload JSON igual a ${data}. O resultado da requisição é armazenado em ${response}.
    ${response}=    POST    ${BASE_URL}/booking    json=${data}

        # Escreve o conteúdo da variável ${response}
    Log    ${response.text}

        # Retorna o status_code (200, 400)
    Log    ${response.status_code}
    
        # Retorna o reason (OK, Not Found)
    Log    ${response.reason}

        # Verifica se a resposta foi bem-sucedida (${response.ok}). Se a condição não for verdadeira, o teste falha.
    Should Be True    ${response.ok}

        # Verifica se o código de status da resposta (${response.status_code}) é igual a 200. Se não for, o teste falha.
    Should Be Equal As Numbers    ${response.status_code}    200

        # Avalia a expressão Python json.loads('${response.text}') para carregar o texto da resposta JSON em um dicionário Python e armazena o resultado em ${response_body}.
    ${response_body}=    Evaluate    json.loads('''${response.text}''')    json

        # Define a variável ${response_body} com o valor obtido da linha anterior.
    Set Test Variable    ${response_body}

Validação dos campos
        # Get Variable Value é usada para recuperar o valor de uma variável. 
        # Recuper o valor da variável ${response_body} e armazenando-o de volta em ${response_body}
    ${response_body}=    Get Variable Value    ${response_body}

        # o Robot Framework vai formatar e registrar o conteúdo no log na forma do Json
    Log Dictionary    ${response_body}


     # Validação dos campos:

      # Get From Dictionary usa a chave booking para acessar o valor associado a essa chave no dicionário ${response_body}.  
    ${booking_info}=  Get From Dictionary  ${response_body}    booking
    Should Be Equal As Strings   ${booking_info['firstname']}  herbertao
    Should Be Equal As Strings   ${booking_info['lastname']}  qazando
    Should Be Equal As Strings   ${booking_info['totalprice']}  222
    Should Be Equal As Strings   ${booking_info['additionalneeds']}  Breakfast

*** Test Cases ***
Cenario 1: Validação 200 do POST
    Cadastrando Uma Reserva
    Enviando o POST com sucesso
    Validação dos campos