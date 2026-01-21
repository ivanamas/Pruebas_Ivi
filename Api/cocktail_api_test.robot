*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem

*** Variables ***
${BASE_URL}          https://www.thecocktaildb.com/api/json/v1/1
${INGREDIENTE}       Non_Alcoholic
${REPORTE_HTML}      results/reporte_tragos.html

*** Test Cases ***
Buscar Tragos Sin Alcohol
    Create Session     cocktail    ${BASE_URL}
    ${response}=    GET On Session   cocktail    url=/filter.php?a=${INGREDIENTE}
    Should Be Equal As Strings   ${response.status_code}    200
    ${drinks}=    Get From Dictionary    ${response.json()}    drinks
    ${cantidad}  Get Length        ${drinks}
    Log   Se encontraron ${cantidad} drinks ${INGREDIENTE}

    # Generar reporte HTML
    Remove File    ${REPORTE_HTML}
    Create File    ${REPORTE_HTML}    <html><body><h1>Tragos ${INGREDIENTE}</h1>
    FOR    ${drink}    IN    @{drinks}
        ${nombre}=    Get From Dictionary    ${drink}    strDrink
        ${imagen}=    Get From Dictionary    ${drink}    strDrinkThumb
        Append To File    ${REPORTE_HTML}    <p>${nombre}<br><img src="${imagen}" width="150"></p>
    END
    Append To File    ${REPORTE_HTML}    </body></html>