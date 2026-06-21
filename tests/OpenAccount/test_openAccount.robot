*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/pages/openAccountPage.robot
Resource  ../../variables/OpenAccount_variable.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/LoginPage.robot

Suite Setup    Load Environment
Test Setup     Open Application
Test Teardown  Close Application

*** Test Cases ***

Create Saving Account
        [Documentation]  Open a Saving account
        [Tags]    ui    smoke    regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        Open New Account    SAVINGS
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}


Create Checking Account
        [Documentation]  Open a Checking account
        [Tags]    ui   smoke  regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        Open New Account    CHECKING
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}


Verify Account Creation Success Message
        [Documentation]  Verify account creation success message is displayed
        [Tags]    ui    regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        Open New Account    SAVINGS
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
        Page Should Contain Element    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}

Verify Account ID
        [Documentation]  Verify account ID is displayed after account creation
        [Tags]    ui    regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        Open New Account    SAVINGS
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_ACCOUNT_ID}
        ${account_id}=    Get Text    ${OPEN_ACCOUNT_ACCOUNT_ID}
        Should Not Be Empty    ${account_id}
        Log To Console    ${account_id}