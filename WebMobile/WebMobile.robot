*** Settings ***
Library   SeleniumLibrary
Library   AppiumLibrary

*** Keywords ***
Obtener Titulos Web Y Mobile
    # WEB
    SeleniumLibrary.Open Browser    https://urbanaplayfm.com    chrome
    SeleniumLibrary.Mouse Over                       xpath=//*[@id="menu-main-menu"]/li[3]/a
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//*[@id="menu-main-menu"]/li[3]/ul/li[3]/a   10s
    SeleniumLibrary.Click Element                    xpath=//*[@id="menu-main-menu"]/li[3]/ul/li[3]/a
    SeleniumLibrary.Scroll Element Into View         xpath=(//h2[contains(@class, 'entry-title')] | //h2)[1]
    SeleniumLibrary.Click Element                    xpath=//html/body/div[1]/div[5]/div/div/section/div/div[1]/article[1]/div[2]/div/div/h2/a
    ${TITULO_WEB}=    SeleniumLibrary.Get Text       xpath=//html/body/div[1]/div[5]/div/div/div[1]/div/h1
    SeleniumLibrary.Capture Page Screenshot   TITULO_WEB.png
    Log    <img src="Capturas/TITULO_WEB.png" width="600px">    html=yes
    SeleniumLibrary.Close Browser

    # MOBILE
    AppiumLibrary.Open Application    http://127.0.0.1:4723   platformName=Android    deviceName=emulator-5554    appPackage=com.android.chrome    appActivity=com.google.android.apps.chrome.Main   automationName=UiAutomator2
    Run Keyword And Ignore Error    AppiumLibrary.Wait Until Element Is Visible    id=com.android.chrome:id/signin_fre_dismiss_button    5s
    Run Keyword And Ignore Error    AppiumLibrary.Click Element    id=com.android.chrome:id/signin_fre_dismiss_button
    Run Keyword And Ignore Error    AppiumLibrary.Wait Until Element Is Visible    id=com.android.chrome:id/ack_button   5s
    Run Keyword And Ignore Error    AppiumLibrary.Click Element    id=com.android.chrome:id/ack_button
    AppiumLibrary.Go To Url   https://urbanaplayfm.com
    Sleep    5s
    AppiumLibrary.Click Element    xpath=(//android.view.View[@content-desc="Goyo Degano: «Estamos manijas de volver a entrar al estudio con Bandalos Chinos»"])[2]
    Sleep    5s
    ${TITULO_MOBILE}=    AppiumLibrary.Get Text    xpath=//android.view.View[@text="Goyo Degano: «Estamos manijas de volver a entrar al estudio con Bandalos Chinos»"]
    Log To Console    Titulo Mobile: ${TITULO_MOBILE}
    AppiumLibrary.Capture Page Screenshot   TITULO_MOBILE.png
    Log    <img src="Capturas/TITULO_MOBILE.png" width="600px">    html=yes
    AppiumLibrary.Close Application

    RETURN  ${TITULO_WEB}    ${TITULO_MOBILE}


*** Test Cases ***
Comparar Titulos
    ${TITULO_WEB}    ${TITULO_MOBILE}=    Obtener Titulos Web Y Mobile
    Should Be Equal    ${TITULO_WEB}    ${TITULO_MOBILE}
    Log To Console    ¡Los títulos son iguales!