*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${url}    https://the-internet.herokuapp.com/tables
${browser}    gc

${locator_header_lastname_ex1}    css = #table1 > thead > tr > th:nth-child(1)
${locator_header_firstname_ex1}    css = #table1 > thead > tr > th:nth-child(2)
${locator_header_email_ex1}    css = #table1 > thead > tr > th:nth-child(3)
${locator_header_due_ex1}    css = #table1 > thead > tr > th:nth-child(4)
${locator_header_website_ex1}    css = #table1 > thead > tr > th:nth-child(5)

${locator_column_lastname_ex1}    xpath = //*[@id="table1"]/tbody/tr/td[1]
${locator_column_firstname_ex1}    xpath = //*[@id="table1"]/tbody/tr/td[2]
${locator_column_email_ex1}    xpath = //*[@id="table1"]/tbody/tr/td[3]
${locator_column_due_ex1}    xpath = //*[@id="table1"]/tbody/tr/td[4]
${locator_column_website_ex1}    xpath = //*[@id="table1"]/tbody/tr/td[5]

${locator_header_due_ex2}    class = dues

${locator_column_lastname_ex2}    class = last-name
${locator_column_firstname_ex2}    class = first-name
${locator_column_email_ex2}    class = first-name
${locator_column_due_ex2}    xpath=//*[@id="table2"]/tbody/tr/td[4]
${locator_column_website_ex2}    class = web-site



*** Keywords ***
OPEN WEB BROWSER
    Open Browser    ${url}    ${browser}
    Maximize Browser Window


SORTING DATA EX1
    [Arguments]    ${locator_header}    ${locator_column}
    Click Element    ${locator_header}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            Append To List    ${value}    ${text}
        END
    ${sort_value}    Copy List    ${value}
    Sort List    ${sort_value}
    Should Be Equal    ${sort_value}    ${value}
    Log To Console    ${value}
    Log To Console    ${sort_value}

    Click Element    ${locator_header}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            Append To List    ${value}    ${text}
        END
    Reverse List    ${sort_value}
    Should Be Equal    ${sort_value}    ${value}
    Log To Console    ${value}
    Log To Console    ${sort_value}


SORTING DATA EX2
    [Arguments]    ${locator_column}
    Click Element    ${locator_column}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            Append To List    ${value}    ${text}
        END
    Remove From List    ${value}    0
    ${sort_value}    Copy List    ${value}
    Sort List    ${sort_value}
    Should Be Equal    ${value}    ${sort_value}
    Log To Console    ${value}
    Log To Console    ${sort_value}

    Click Element    ${locator_column}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            Append To List    ${value}    ${text}
        END
    Remove From List    ${value}    0
    Reverse List    ${sort_value}
    Should Be Equal    ${value}    ${sort_value}
    Log To Console    ${value}
    Log To Console    ${sort_value}


SORTING NUMBER
    [Arguments]    ${locator_header}    ${locator_column}
    Click Element    ${locator_header}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            ${new_text}=    Remove String    ${text}    $
            ${number}    Convert To Number    ${new_text}
            Append To List    ${value}    ${number}
        END
    ${sort_value}    Copy List    ${value}
    Sort List    ${sort_value}
    Should Be Equal    ${value}    ${sort_value}
    Log To Console    ${value}
    Log To Console    ${sort_value}

    Click Element    ${locator_header}
    ${webelements}=    Get WebElements    ${locator_column}
    ${value}=    Create List
        FOR    ${element}    IN    @{webelements}
            ${text}=    Get Text    ${element}
            ${new_text}=    Remove String    ${text}    $
            ${number}    Convert To Number    ${new_text}
            Append To List    ${value}    ${number}
        END
    Reverse List    ${sort_value}
    Should Be Equal    ${value}    ${sort_value}
    Log To Console    ${value}
    Log To Console    ${sort_value}



*** Test Cases ***
Example 1
    # Set Selenium Speed    1s
    OPEN WEB BROWSER
    Wait Until Element Is Visible    id = table1
    SORTING DATA EX1    ${locator_header_lastname_ex1}     ${locator_column_lastname_ex1}
    SORTING DATA EX1    ${locator_header_firstname_ex1}    ${locator_column_firstname_ex1}
    SORTING DATA EX1    ${locator_header_email_ex1}        ${locator_column_email_ex1}
    SORTING NUMBER      ${locator_header_due_ex1}          ${locator_column_due_ex1}
    SORTING DATA EX1    ${locator_header_website_ex1}      ${locator_column_website_ex1}
    Close Browser

Example 2
    # Set Selenium Speed    1s
    OPEN WEB BROWSER
    Wait Until Element Is Visible    id = table2
    SORTING DATA EX2    ${locator_column_lastname_ex2}
    SORTING DATA EX2    ${locator_column_firstname_ex2}
    SORTING DATA EX2    ${locator_column_email_ex2}
    SORTING NUMBER      ${locator_header_due_ex2}          ${locator_column_due_ex2}   
    SORTING DATA EX2    ${locator_column_website_ex2}
    Close Browser

