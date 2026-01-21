*** Variables ***
${Lst_ORIGEN}             xpath=/html/body/div[3]/form/select[1] 
${Lst_DESTINO}            xpath=/html/body/div[3]/form/select[2]
${Btn_BUSCAR}             xpath=/html/body/div[3]/form/div/input
${Btn_SELECCIONARVUELO}   xpath=/html/body/div[2]/table/tbody/tr[2]/td[1]/input
${Txt_NOMBRE}             xpath=//*[@id="inputName"]
${Txt_DIRECCION}          xpath=//*[@id="address"]
${Txt_CIUDAD}             xpath=//*[@id="city"]
${Txt_PROVINCIA}          xpath=//*[@id="state"]
${Txt_CODIGOPOSTAL}       xpath=//*[@id="zipCode"]
${Lst_TIPOTARJETA}        xpath=//*[@id="cardType"]
${Txt_NUMEROTARJETA}      xpath=//*[@id="creditCardNumber"]
${Txt_MESVENCIMIENTO}     xpath=//*[@id="creditCardMonth"]
${Txt_ANIOVENCIMIENTO}    xpath=//*[@id="creditCardYear"]
${Txt_NOMBREENTARJETA}    xpath=//*[@id="nameOnCard"]
${Btn_COMPRARVUELO}       xpath=/html/body/div[2]/form/div[11]/div/input
${Txt_ID}                 xpath=//td[text()='Id']/following-sibling::td