*** Settings ***
Library           SeleniumLibrary
Library             String
*** Variables ***
${BROWSER}        Chrome
${URL}            https://the-internet.herokuapp.com/login
${USERNAME}       tomsmith
${PASSWORD}       SuperSecretPassword!

*** Test Cases ***
Login Test
    Open Browser    ${URL}    ${BROWSER}
    Input Text      xpath://html/body/div[2]/div/div/form/div[1]/div/input   ${USERNAME}
    Input Password  xpath://html/body/div[2]/div/div/form/div[2]/div/input    ${PASSWORD}
    Click Button    xpath://html/body/div[2]/div/div/form/button
    ${flash_message_xpath_login}=    Set Variable    //div[@id='flash-messages']//div[@class='flash success' and contains(text(), 'You logged into a secure area')]
    ${Textlogin}=   Get Text   ${flash_message_xpath_login}    
    ${Textlogin}    Replace String    ${Textlogin}    \n     ${EMPTY}  
    ${Textlogin}    Replace String    ${Textlogin}    ×      ${EMPTY} 
    set global Variable   ${Textlogin}
    Page should contain       ${Textlogin} 
    Click Element    //i[contains(@class, 'icon-signout')]/ancestor::a[contains(@class, 'button') and contains(@class, 'radius') and contains(@class, 'secondary')]
    ${flash_message_xpath_logout}=    Set Variable    //div[@id='flash-messages']//div[@class='flash success' and contains(text(), 'You logged out of the secure area!')]
    ${Textlogout}=   Get Text   ${flash_message_xpath_logout}   
    ${Textlogout}    Replace String    ${Textlogout}    \n     ${EMPTY}  
    ${Textlogout}    Replace String    ${Textlogout}    ×      ${EMPTY}  
    set global Variable   ${Textlogout}
    Page should contain       ${Textlogout} 
Validate_login
    ${validatelogin}=       Set Variable     ${Textlogin}    
    ${expected_text_login}=    Set Variable    You logged into a secure area!                                                      
    Should Be Equal    ${validatelogin}    ${expected_text_login}
Validate_logout
    ${validatelogout}=       Set Variable     ${Textlogout} 
    ${expected_text_logout}=    Set Variable    You logged out of the secure area!
    Should Be Equal    ${validatelogout}    ${expected_text_logout}

