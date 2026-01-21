*** Settings ***
Resource     Global/Locators.robot
Resource     Global/Keywords.robot


*** Test Cases ***
Leer datos del CSV y usarlos
    ${datos}=     Leer Datos CSV    Vuelos/Datos/Reservavuelo.csv
    Open Browser     http://blazedemo.com    chrome
	Set Screenshot Directory     ${CURDIR}/Capturas
    Maximize Browser Window
    Select From List By Label    name:fromPort    ${datos}[Origen]
    Select From List By Label    name:toPort      ${datos}[Destino]
	Capture With Timestamp      Pasaje_csv
    Click Element       ${BTn_BUSCAR}
    # Seleccionar el vuelo
    Click Element       ${BTn_SELECCIONARVUELO}
    # Completar formulario de reserva
    Wait Until Element Is Visible    id=inputName    10s
    Input Text    id=inputName     ${datos}[Name]
    Input Text    id=address       ${datos}[Address]
    Input Text    id=city          ${datos}[City]
    Input Text    id=state         ${datos}[State]
    Input Text    id=zipCode       ${datos}[ZIPCODE]
    Select From List By Value    id=cardType     ${datos}[CARDTYPE]
    Input Text    id=creditCardNumber    ${datos}[CREDITCARDNUMBER]
    Input Text    id=creditCardMonth    ${datos}[CREDITCARDMONTH]
    Input Text    id=creditCardYear    ${datos}[CREDITCARDYEAR]
    Input Text    id=nameOnCard    ${datos}[NAMEONCARD]
	Capture With Timestamp       Datos pasajero y tarjeta_csv
    Click Element       ${Btn_COMPRARVUELO}
	Capture With Timestamp       Compra pasaje_csv
    # Verificar reserva exitosa
    Page Should Contain    Thank you for your purchase today!
    Close Browser