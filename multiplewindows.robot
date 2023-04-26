*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}    https://the-internet.herokuapp.com/windows
${browser}    gc
${locator_hyperlink_ClickHere}  css = #content > div > a

*** Keywords ***
OPEN WEB BROWSER
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

*** Test Cases ***
Multiple Windows
    # Set Selenium Speed    1s
    OPEN WEB BROWSER
    Wait Until Element Is Visible    ${locator_hyperlink_ClickHere} 
    Click Element    ${locator_hyperlink_ClickHere}   
    Switch Window    NEW
    Page Should Contain   New Window  
    @{title}    Get Window Titles
    Should Be Equal    ${title}[0]    The Internet
    Should Be Equal    ${title}[1]    New Window
    Close Browser
