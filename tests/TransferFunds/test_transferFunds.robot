*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/LoginPage.robot
Resource  ../../resources/pages/TransferFundsPage.robot
Resource  ../../variables/TransferFunds_variable.robot

Suite Setup    Load Environment
Test Setup     Open Application
Test Teardown  Close Application

*** Test Cases ***
Transfer Funds Between Accounts
        [Documentation]  Transfer funds between accounts
        [Tags]    ui    smoke    regression    transfer    positive    FR-01
        Login the user    ${username}    ${password}
        Transfer Funds    100    0  1
        Wait Until Element Is Visible    ${TRANSFER_FUNDS_SUCCESS_MESSAGE}


Transfer Funds Validation
        [Documentation]  Validate transfer funds functionality
        [Tags]    ui    regression    transfer    positive    FR-01
        Login the user    ${username}    ${password}
        Transfer Funds    100    0  1
        Wait Until Element Is Visible    ${TRANSFER_FUNDS_SUCCESS_MESSAGE}
        Page Should Contain Element    ${TRANSFER_FUNDS_SUCCESS_MESSAGE}

Verify Transfer Funds Amount and Accounts
        [Documentation]  Verify transfer funds amount and accounts
        [Tags]    ui    regression    transfer    positive    FR-01
        Login the user    ${username}    ${password}
        Open Transfer Funds Page
        Enter Transfer Amount    100
        Select From Account    0
        ${from_account}=    Get Selected List Label    ${TRANSFER_FUNDS_FROM_ACCOUNT_DROPDOWN}
        select To Account    1
        ${to_acount}=    Get Selected List Label    ${TRANSFER_FUNDS_TO_ACCOUNT_DROPDOWN}
        Click Transfer Button
        Wait Until Element Is Visible    ${TRANSFER_FUNDS_SUCCESS_MESSAGE}
        ${amount}=    Get Text    ${TRANSFER_FUNDS_SUCCESS_AMOUNT}
        Should Contain    ${amount}    100
        ${from_account_sucess}=    Get Text    ${TRANSFER_FUNDS_SUCCESS_FROM_ACCOUNT}
        Log To Console    ${from_account_sucess}
        Should Be Equal As Strings    ${from_account_sucess}    ${from_account}
        ${to_account_sucess}=    Get Text    ${TRANSFER_FUNDS_SUCCESS_TO_ACCOUNT}
        Log To Console    ${to_account_sucess}
        Should Be Equal As Strings    ${to_account_sucess}    ${to_acount}


Transfer Funds Without Amount
        [Documentation]  Validate transfer funds without amount
        [Tags]    ui    regression    transfer    negative    FR-01
        Login the user    ${username}    ${password}
        Open Transfer Funds Page
        Select From Account    0
        select To Account    1
        Click Transfer Button
        Wait Until Element Is Visible    ${ERROR_MESSAGE}
        Page Should Contain Element    ${ERROR_MESSAGE}

