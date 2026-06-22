*** Settings ***
Library         SeleniumLibrary
Resource        ../../resources/pages/RegisterPage.robot
Resource        ../../variables/Register_variable.robot
Resource        ../../resources/keywords/common_keywords.robot
Resource        ../../resources/pages/LoginPage.robot

Suite Setup     Load Environment
Test Setup      Open Application
Test Teardown   Close Application

*** Test Cases ***
TC-001 Register new user
        [Documentation]  Registeing  a new user
        [Tags]    ui    smoke    regression    registration    positive    FR-01
        open Register Page
        ${CUSTOMER}=    Get Valid Customer Data
        Fill the fields    ${CUSTOMER}
        Click Register Button
        Wait Until Element Is Visible    ${REGISTER_SUCCESS_MESSAGE}
        Page Should Contain Element    ${REGISTER_SUCCESS_MESSAGE}

TC-002 Register with existing username
        [Documentation]  Registeing  a new user with existing username
        [Tags]    ui    regression    registration    negative    FR-09
        open Register Page
        ${CUSTOMER}=    Get Valid Customer Data
        Fill the fields    ${CUSTOMER}
        Click Register Button
        Wait Until Element Is Visible    ${USERNAME_ALREADY_EXISTS_ERROR}
        Page Should Contain Element   ${USERNAME_ALREADY_EXISTS_ERROR}

TC-003 Login with Valid Credentials
        [Documentation]  Login with valid credentials
        [Tags]    ui    smoke    regression    login    positive    FR-01
        
        Fill the Login Fields    ${username}     ${password}
        click login button
        Wait Until Element Is Visible    ${LOGIN SUCCESS_MESSAGE}
        Page Should Contain Element    ${LOGIN SUCCESS_MESSAGE}

TC-004 Login with Invalid Credentials
        [Documentation]  Login with invalid credentials
        [Tags]    ui    regression    login    negative    FR-09

        Fill the Login Fields    invalid_user     invalid_password
        click login button
        Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}
        Page Should Contain Element    ${LOGIN_ERROR_MESSAGE}

TC-019 Register with invalid mobile number
        [Documentation]  registering with invalid mobile number
        open Register Page
        ${customer}=  Create Dictionary
    ...    first_name=John
    ...    last_name=Doe
    ...    address=4521 Oak Ave
    ...    city=Springfield
    ...    state=CA
    ...    zip_code=90001
    ...    phone=abcdefgh
    ...    ssn=123-45-6789
    ...    username=${username}
    ...    password=${password}

    Fill the fields    ${customer}
    Click Register Button
    Page Should Not Contain    ${REGISTER_SUCCESS_MESSAGE}
