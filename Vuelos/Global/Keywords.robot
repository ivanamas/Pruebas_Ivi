*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem
Library      Collections
Library      String
Library      DateTime


*** Keywords ***
Leer Datos CSV
    [Arguments]                         ${csv_path}
    ${contenido}=    Get File           ${csv_path}
    ${contenido}=    Replace String     ${contenido}    \ufeff    ${EMPTY}
    ${lineas}=       Split String       ${contenido}    \n
    ${cabecera}=     Get From List      ${lineas}    0
    ${valores}=      Get From List      ${lineas}    1
    ${keys}=         Split String       ${cabecera}    ;
    ${values}=       Split String       ${valores}    ;
    ${datos}=        Create Dictionary
    FOR    ${i}      IN RANGE    0      ${keys.__len__()}
    ${key}=          Strip String       ${keys}[${i}]
    ${value}=        Strip String       ${values}[${i}]
    Set To Dictionary    ${datos}       ${key}=${value}
    END
    RETURN    ${datos}

Capture With Timestamp
    [ARGUMENTS]    ${BASENAME}
    ${TIMESTAMP} =    Get Current Date    result_format=%Y-%m-%d_%H-%M-%S
    Capture Page Screenshot    ${BASENAME}_${TIMESTAMP}.png