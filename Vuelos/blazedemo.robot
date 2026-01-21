*** Settings ***
Library      SeleniumLibrary
Library      DateTime
Resource     Global/Variables.robot
Resource     Global/Locators.robot


*** Keywords ***
Capture With Timestamp
    [ARGUMENTS]    ${BASENAME}
    ${TIMESTAMP} =    Get Current Date    result_format=%Y-%m-%d_%H-%M-%S
    Capture Page Screenshot    ${BASENAME}_${TIMESTAMP}.png


*** Test Cases ***
Blazedemo
  # Buscar pasajes
   Open Browser                 ${URL}   chrome
   Set Screenshot Directory     ${CURDIR}/Capturas
   Maximize Browser Window
   Select From List By Value    ${Lst_ORIGEN}             ${ORIGEN}
   Select From List By Value    ${Lst_DESTINO}            ${DESTINO}
   Capture With Timestamp       Pasaje
   Click Element                ${Btn_BUSCAR}

   # Carga de datos del pasajero y tarjeta
   Click Element                ${Btn_SELECCIONARVUELO}

   Input Text                   ${Txt_NOMBRE}             ${NAME}
   Input Text                   ${Txt_DIRECCION}          ${ADDRESS}
   Input Text                   ${Txt_CIUDAD}             ${CITY}
   Input Text                   ${Txt_PROVINCIA}          ${STATE}
   Input Text                   ${Txt_CODIGOPOSTAL}       ${ZIPCODE}
   Select From List By Value    ${Lst_TIPOTARJETA}        ${CARDTYPE}
   Input Text                   ${Txt_NUMEROTARJETA}      ${CREDITCARDNUMBER}
   Input Text                   ${Txt_MESVENCIMIENTO}     ${CREDITCARDMONTH}
   Input Text                   ${Txt_ANIOVENCIMIENTO}    ${CREDITCARDYEAR}
   Input Text                   ${Txt_NOMBREENTARJETA}    ${NAMEONCARD}
   Capture With Timestamp       Datos pasajero y tarjeta
   Click Element                ${Btn_COMPRARVUELO}
   Capture With Timestamp       Compra pasaje
   Page Should Contain    Thank you for your purchase today!
   Close Browser