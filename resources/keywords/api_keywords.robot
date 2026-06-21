*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          common_keywords.robot

*** Keywords ***

Get Customer_id
    [Documentation]    Retrieve customer_id from the API
    Create Session    api_session    ${API_URL}  verify=False
    ${header}=       Create Dictionary  Accept=application/json
    ${response1}=    GET On Session   api_session    /login/${username}/${password}  headers=${header}
    ${body1}=        Set Variable    ${response1.json()}
    ${customer_id}=    Get From Dictionary    ${body1}    id
    Log To Console    Customer ID: ${customer_id}
    RETURN    ${customer_id}

Get All Accounts
    [Documentation]    Retrieve account_id from the API using customer_id
    [Arguments]    ${customer_id}
    Create Session    api_session    ${API_URL}  verify=False
    ${header}=       Create Dictionary  Accept=application/json
    ${response2}=    GET On Session   api_session  /customers/${customer_id}/accounts  headers=${header}
    RETURN    ${response2}

Get Account by Account_id
    [Documentation]    Retrieve account details from the API using account_id
    [Arguments]    ${account_id}
    Create Session    api_session    ${API_URL}  verify=False
    ${header}=       Create Dictionary  Accept=application/json
    ${response3}=    GET On Session   api_session  /accounts/${account_id}  headers=${header}  expected_status=anything
    RETURN    ${response3}

Create Account
    [Documentation]    Create a new account for a customer using the API
    [Arguments]    ${customer_id}  ${account_type}  ${account_id}
    Create Session    api_session    ${API_URL}  verify=False
    ${header}=       Create Dictionary  Accept=application/json
    ${query}=      Create Dictionary
    ...  customerId=${customer_id}
    ...  newAccountType=${account_type}
    ...  fromAccountId=${account_id}
    ${response}=     POST On Session   api_session  /createAccount  headers=${header}  params=${query}
    RETURN    ${response}

Transfer Funds
    [Arguments]    ${from_account_id}    ${to_account_id}    ${amount}
    Create Session    api_session    ${API_URL}    verify=False
    ${header}=    Create Dictionary    Accept=application/json
    ${query}=    Create Dictionary
    ...    fromAccountId=${from_account_id}
    ...    toAccountId=${to_account_id}
    ...    amount=${amount}
    ${response4}=    POST On Session    api_session    /transfer    params=${query}    headers=${header}    expected_status=anything
    RETURN    ${response4}
Get balance of account
    [Documentation]    Retrieve the balance of an account using the API
    [Arguments]  ${account_id}
    ${response}=    Get Account by Account_id    ${account_id}
    ${body}=  Set Variable    ${response.json()}
    ${balance}=    Get From Dictionary    ${body}    balance
    Log To Console    Account Balance: ${balance}
    RETURN    ${balance}

