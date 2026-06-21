*** Settings ***
Library  SeleniumLibrary
Library  ../config/env_loader.py

*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    Load Env    ${ENV}
    ${url}=  Get Env    baseurl
    ${api_url}=  Get Env    api_baseurl
    ${username}=  Get Env    username
    ${password}=  Get Env    password
    Set Global Variable    ${BASE_URL}  ${url}
    Set Global Variable    ${API_URL}  ${api_url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

Open Application
    [Documentation]  Opens the application
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito

    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
Close Application
    [Documentation]  Closing the application
    Close All Browsers