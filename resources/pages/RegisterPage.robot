*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/Register_variable.robot
Resource  ../keywords/common_keywords.robot

*** Keywords ***
Open Register Page
    [Documentation]  Opens the register page
    Click Element    ${REGISTER_NAVIGATION_BUTTON}
Fill the fields
    [Documentation]  Fills the fields in the register page
    [Arguments]   ${customer}
    Input Text    ${FIRST_NAME}             ${customer}[first_name]
    Input Text    ${LAST_NAME}              ${customer}[last_name]
    Input Text    ${ADDRESS}                ${customer}[address]
    Input Text    ${CITY}                   ${customer}[city]
    Input Text    ${STATE}                  ${customer}[state]
    Input Text    ${ZIP_CODE}               ${customer}[zip_code]
    Input Text    ${PHONE}                  ${customer}[phone]
    Input Text    ${SSN}                    ${customer}[ssn]
    Input Text    ${REGISTER_USERNAME}      ${customer}[username]
    Input Text    ${REGISTER_PASSWORD}      ${customer}[password]
    Input Text    ${CONFIRM_PASSWORD}       ${customer}[password]
Click Register Button
    [Documentation]  Clicks the register button
    Click Element    ${REGISTER_BUTTON}


Get Valid Customer Data
    [Documentation]    Returns a dictionary of valid registration data.
    ${customer}=    Create Dictionary
    ...    first_name=John
    ...    last_name=Doe
    ...    address=4521 Oak Ave
    ...    city=Springfield
    ...    state=CA
    ...    zip_code=90001
    ...    phone=5551234567
    ...    ssn=123-45-6789
    ...    username=${username}
    ...    password=${password}
    RETURN    ${customer}
