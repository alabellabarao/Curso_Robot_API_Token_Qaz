*** Settings ***
Library   RequestsLibrary
Library   Collections
*** Variables ***

${BASE_URL}       https://restful-booker.herokuapp.com

*** Test Cases ***

Cadastrando Uma Reserva
    ${bookingdates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    ${data}=    Create Dictionary    firstname=herbertao    lastname=qazando    totalprice=222    depositpaid=True    bookingdates=${bookingdates}    additionalneeds=Breakfast
    Log    ${data}

         # Enviando a solicitação POST

    ${response}=    POST    ${BASE_URL}/booking    json=${data}
    Log    ${response.text}
    Log    ${response.status_code}
    Log    ${response.reason}

    Should Be True    ${response.ok}
    Should Be Equal As Numbers    ${response.status_code}    200

        # Validando os valores retornados
    ${booking}=  Set Variable  ${response.json()}
    Log Dictionary  ${booking}  # Exibe o conteúdo do dicionário para identificar as chaves disponíveis

        # Validação dos campos:
    ${booking_info}=  Get From Dictionary  ${booking}    booking
    Should Be Equal As Strings   ${booking_info['firstname']}  herbertao
    Should Be Equal As Strings   ${booking_info['lastname']}  qazando
    Should Be Equal As Strings   ${booking_info['totalprice']}  222
    Should Be Equal As Strings   ${booking_info['additionalneeds']}  Breakfast