*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/AccountOverview_variable.robot

*** Keywords ***
Open Account Overview Page
    [Documentation]  Opens the account overview page
    Wait Until Element Is Visible    ${ACCOUNT_OVERVIEW_NAVIGATION_BUTTON}
    Click Element    ${ACCOUNT_OVERVIEW_NAVIGATION_BUTTON}

Get Balance By Account
    [Arguments]    ${account}
    ${balance}=    Get Text    xpath=//a[text()='${account}']/../following-sibling::td[1]
    [Return]    ${balance}