*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/Login_variable.robot
Resource  ../keywords/common_keywords.robot

*** Keywords ***
Fill the Login Fields
    [Arguments]   ${uname}    ${pwd}
    Input Text    ${LOGIN_USERNAME}    ${uname}
    Input Text    ${LOGIN_PASSWORD}    ${pwd}

CLick login button
    Click Element    ${LOGIN_BUTTON}

Login the user
    [Arguments]   ${uname}    ${pwd}
    Fill the Login Fields    ${uname}    ${pwd}
    CLick login button