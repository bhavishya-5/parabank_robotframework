*** Settings ***
Library  SeleniumLibrary
Library    String
Resource  ../../resources/pages/openAccountPage.robot
Resource  ../../variables/OpenAccount_variable.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/LoginPage.robot
Resource  ../../resources/pages/accountOverviewPage.robot
Resource  ../../variables/AccountOverview_variable.robot

Suite Setup    Load Environment
Test Setup     Open Application
Test Teardown  Close Application

*** Test Cases ***
Verify New Account
    [Documentation]  Verify that a new account is created and displayed in the account overview
    [Tags]    ui    regression    account    positive    FR-01
    Login the user    ${username}    ${password}
    Open New Account    SAVINGS
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
    Page Should Contain Element    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
    ${account} =    Get Text    ${OPEN_ACCOUNT_ACCOUNT_ID}
    open Account Overview Page
    Wait Until Element Is Visible    ${ACCOUNT_OVERVIEW_TABLE}/tbody/tr  10s
    Page Should Contain    ${account}

Verify balance in new account
    [Documentation]  Verify that the balance of a new account is displayed as $100.00 in the account overview
    [Tags]    ui    regression    account    positive    FR-01
    Login the user    ${username}    ${password}
    Open New Account    CHECKING
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
    Page Should Contain Element    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
    ${account_id} =    Get Text    ${OPEN_ACCOUNT_ACCOUNT_ID}
    open Account Overview Page
    Wait Until Element Is Visible    ${ACCOUNT_OVERVIEW_TABLE}/tbody/tr  10s
    ${balance}=  Get Balance By Account    ${account_id}
    Should Be Equal As Strings   ${balance}   $100.00