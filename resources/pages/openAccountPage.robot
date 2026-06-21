*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/pages/openAccountPage.robot
Resource  ../../variables/OpenAccount_variable.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/LoginPage.robot

*** Keywords ***
Open Account Page
    [Documentation]  Opens the open account page
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_NAVIGATION_BUTTON}
    Sleep    5s
    Click Element    ${OPEN_ACCOUNT_NAVIGATION_BUTTON}

Account Type
    [Documentation]  Selects the account type from the dropdown
    [Arguments]   ${account_type}
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_ACCOUNT_TYPE_DROPDOWN}
    Select From List By Label    ${OPEN_ACCOUNT_ACCOUNT_TYPE_DROPDOWN}    ${account_type}

Account to transfer funds from
    [Documentation]  Selects the account to transfer funds from
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_FROM_ACCOUNT_DROPDOWN}
    Wait Until Page Contains Element    ${OPEN_ACCOUNT_FROM_ACCOUNT_DROPDOWN}/option  10s
    Select From List By Index    ${OPEN_ACCOUNT_FROM_ACCOUNT_DROPDOWN}    0

Click Open New Account Button
    [Documentation]  Clicks the open new account button
    Wait Until Element Is Enabled    ${OPEN_NEW_ACCOUNT_BUTTON}
    Click Element    ${OPEN_NEW_ACCOUNT_BUTTON}

Open New Account
    [Documentation]  Opens a new account with the specified type and from account
    [Arguments]   ${account_type}
    Open Account Page
    Account Type    ${account_type}
    Account to transfer funds from
    Click Open New Account Button