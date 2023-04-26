*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}    https://the-internet.herokuapp.com/upload
${browser}    gc
${locator_btn_ChooseFile}  id = file-upload  
${locator_btn_Upload}    id = file-submit
${file}    /Users/kittipat/Desktop/test.pdf


*** Keywords ***
OPEN WEB BROWSER
    Open Browser    ${url}    ${browser}
    Maximize Browser Window


*** Test Cases ***
File Upload
    # Set Selenium Speed    1
    OPEN WEB BROWSER
    Wait Until Element Is Visible    ${locator_btnChooseFile}
    Choose File    ${locator_btn_ChooseFile}    ${file} 
    Click Element    ${locator_btn_Upload}
    Wait Until Page Contains    File Uploaded!
    Close Browser

File Upload Fail
    # Set Selenium Speed    1
    OPEN WEB BROWSER
    Wait Until Element Is Visible    ${locator_btn_Upload}
    Click Element    ${locator_btn_Upload}
    Wait Until Page Contains    Internal Server Error
    Close Browser
