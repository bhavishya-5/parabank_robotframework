*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  Collections
Resource  ../../resources/pages/openAccountPage.robot
Resource  ../../variables/OpenAccount_variable.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/LoginPage.robot
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup    Load Environment
Test Setup     Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-026 Create Account via UI and verify via API
        [Documentation]  Create a new account through the UI and verify its existence via API
        [Tags]    ui    api    hybrid    regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        Open New Account    SAVINGS
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
        ${account_id}=    Get Text    ${OPEN_ACCOUNT_ACCOUNT_ID}
        Should Not Be Empty    ${account_id}
        Log To Console    Created Account ID: ${account_id}

        # Verify account existence via API
        ${customer_id}=    Get Customer_id
        ${response}=     Get All Accounts    ${customer_id}
        Should Be Equal As Integers    ${response.status_code}    200
        ${body_str}=    Convert To String    ${response.json()}
        Log To Console    ${body_str}
        Should Contain    ${body_str}    ${account_id}


TC-027 Create Account via ui and check its detail via API
        [Documentation]  Create a new account through the UI and verify its details via API
        [Tags]    ui    api    hybrid    regression    account    positive    FR-01
        Login the user    ${username}    ${password}
        ${account_type}=    Set Variable    CHECKING
        Open New Account    ${account_type}
        Wait Until Element Is Visible    ${OPEN_ACCOUNT_SUCCESS_MESSAGE}
        ${account_id}=    Get Text    ${OPEN_ACCOUNT_ACCOUNT_ID}
        Should Not Be Empty    ${account_id}
        Log To Console    Created Account ID: ${account_id}

        # Verify account details via API
        ${response}=     Get Account by Account_id    ${account_id}
        Should Be Equal As Integers    ${response.status_code}    200
        ${body_str}=    Convert To String    ${response.json()}
        Log To Console    ${body_str}
        Should Contain    ${body_str}    ${account_type}