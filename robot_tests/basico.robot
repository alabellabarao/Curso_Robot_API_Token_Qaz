*** Settings ***
Library   RequestsLibrary

*** Test Cases ***
Consultando as reservas cadastradas com status 200
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
    Log  ${response.text}
    Should Be True  ${response.ok}
    Should Be Equal As strings  ${response.status_code}  200

Consultando as reservas cadastradas com status 400
    ${response}=  GET   https://restful-booker.herokuapp.com/booking
    Log  ${response.text}
    Should Be True  ${response.ok}
    Should Be Equal As strings  ${response.status_code}  400