*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../../resources/keywords/common_keywords.robot
Resource          ../../resources/keywords/api_keywords.robot
Resource          ../../resources/pages/accountOverviewPage.robot

Suite Setup    Load Environment

*** Test Cases ***

TC-022 Get accounts list
    [Documentation]    Test retrieval of all accounts associated with a customer
    ${customer_id}=    Get Customer_id
    ${response}=     Get All Accounts    ${customer_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${accounts}=  Set Variable    ${response.json()}
    Log To Console    Accounts: ${accounts}

TC-023 checking a non-existent account id
    [Documentation]    Test retrieval of accounts using a non-existent customer_id
    ${response}=     Get Account by Account_id    0000
    Should Be Equal As Integers    ${response.status_code}    400

TC-024 Transfer funds between accounts
    [Documentation]    Test transferring funds between two accounts
    ${customer_id}=    Get Customer_id
    ${account_response}=    Get All Accounts    ${customer_id}
    ${accounts}=  Set Variable    ${account_response.json()}
    ${from_account_id}=    Get From Dictionary    ${accounts}[0]    id
    Create Account    ${customer_id}    1    ${from_account_id}
    ${account_response}=    Get All Accounts    ${customer_id}
    ${accounts}=  Set Variable    ${account_response.json()}
    ${to_account_id}=    Get From Dictionary    ${accounts}[1]    id
    ${response}=     Transfer Funds    ${from_account_id}    ${to_account_id}    100
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    Transfer Result: ${response.text}

TC-025 Validate balance after transfer
    [Documentation]    Test validating account balances after a fund transfer
    ${customer_id}=    Get Customer_id
    ${account_response}=    Get All Accounts    ${customer_id}
    ${accounts}=  Set Variable    ${account_response.json()}
    ${from_account_id}=    Get From Dictionary    ${accounts}[0]    id
    Create Account    ${customer_id}    1    ${from_account_id}
    ${account_response}=    Get All Accounts    ${customer_id}
    ${accounts}=  Set Variable    ${account_response.json()}
    ${to_account_id}=    Get From Dictionary    ${accounts}[1]    id
    ${initial_fromAccount_balance}=  Get balance of account    ${from_account_id}
    ${initial_toAccount_balance}=  Get balance of account    ${to_account_id}
    ${amount}=  Set Variable  100
    ${response}=     Transfer Funds    ${from_account_id}    ${to_account_id}    ${amount}
    Should Be Equal As Integers    ${response.status_code}    200
    ${final_fromAccount_balance}=  Evaluate  ${initial_fromAccount_balance}-${amount}
    ${final_toAccount_balance}=  Evaluate  ${initial_toAccount_balance}+${amount}
    ${actual_fromAccount_balance}=  Get balance of account    ${from_account_id}
    ${actual_toAccount_balance}=  Get balance of account    ${to_account_id}
    Should Be Equal As Numbers    ${final_fromAccount_balance}    ${actual_fromAccount_balance}
    Should Be Equal As Numbers    ${final_toAccount_balance}    ${actual_toAccount_balance}




