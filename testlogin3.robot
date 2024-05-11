*** Settings ***
Library           SeleniumLibrary
Library             String
*** Variables ***
${BROWSER}        Chrome
${URL}            https://the-internet.herokuapp.com/login
${USERNAME}       tomhollan
${PASSWORD}       Password!

*** Test Cases ***
Login Test
    Open Browser    ${URL}    ${BROWSER}
    Input Text      xpath://html/body/div[2]/div/div/form/div[1]/div/input   ${USERNAME}
    Input Password  xpath://html/body/div[2]/div/div/form/div[2]/div/input    ${PASSWORD}
    Click Button    xpath://html/body/div[2]/div/div/form/button
    ${flash_message_xpath_invalid}=    Set Variable    //div[@id='flash-messages']//div[@class='flash error' and contains(text(), 'Your username is invalid!')]
    ${Textinvalid}=   Get Text   ${flash_message_xpath_invalid}   
    ${Textinvalid}    Replace String    ${Textinvalid}    \n     ${EMPTY}  
    ${Textinvalid}    Replace String    ${Textinvalid}    ×      ${EMPTY}  
    set global Variable   ${Textinvalid}
    Page should contain       ${Textinvalid} 
Validate_username
    ${validateusername}=       Set Variable     ${Textinvalid}    
    ${expected_text_invalid}=    Set Variable    Your username is invalid!                                                     
    Should Be Equal    ${validateusername}    ${expected_text_invalid}
