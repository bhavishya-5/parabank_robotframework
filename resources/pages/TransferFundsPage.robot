*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/TransferFunds_variable.robot

*** Keywords ***
Open Transfer Funds Page
    [Documentation]  Opens the transfer funds page
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_NAVIGATION_BUTTON}
    Click Element    ${TRANSFER_FUNDS_NAVIGATION_BUTTON}

Enter Transfer Amount
    [Documentation]  Enters the transfer amount
    [Arguments]   ${amount}
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_AMOUNT_INPUT}
    Input Text    ${TRANSFER_FUNDS_AMOUNT_INPUT}    ${amount}

Select From Account
    [Documentation]  Selects the account to transfer funds from
    [Arguments]  ${from_account_index}
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_FROM_ACCOUNT_DROPDOWN}
    Wait Until Page Contains Element    ${TRANSFER_FUNDS_FROM_ACCOUNT_DROPDOWN}/option  10s
    Select From List By Index    ${TRANSFER_FUNDS_FROM_ACCOUNT_DROPDOWN}    ${from_account_index}

select To Account
    [Documentation]  Selects the account to transfer funds to
    [Arguments]  ${to_account_index}
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_TO_ACCOUNT_DROPDOWN}
    Wait Until Page Contains Element    ${TRANSFER_FUNDS_TO_ACCOUNT_DROPDOWN}/option  10s
    Select From List By Index    ${TRANSFER_FUNDS_TO_ACCOUNT_DROPDOWN}    ${to_account_index}

Click Transfer Button
    [Documentation]  Clicks the transfer button
    Wait Until Element Is Enabled    ${TRANSFER_FUNDS_BUTTON}
    Click Element    ${TRANSFER_FUNDS_BUTTON}

Transfer Funds
    [Documentation]  Transfers funds from one account to another
    [Arguments]   ${amount}    ${from_account_index}    ${to_account_index}
    Open Transfer Funds Page
    Enter Transfer Amount    ${amount}
    Select From Account    ${from_account_index}
    select To Account    ${to_account_index}
    Click Transfer Button

