*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${CUR_PASS}   1234567890
${NEW_PASS}   0123456789

*** Test Cases ***
Reset Secretary Password
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Secretary
    Logout Page
    Input Username    secretary
    Input Password    0123456789
    Submit Credentials
    Logout Page
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Revert Secretary
    Logout Page

*** Keywords ***
Reset Secretary
    Set Selenium Speed  0.1
    Click ELement   resetSecretary
    Input Text    sec-current-password        ${CUR_PASS}
    Input Text    sec-new-password            ${NEW_PASS}
    Input Text    sec-confirm-new-password    ${NEW_PASS}
    Click Element   sec-save-password

Revert Secretary
    Click ELement   resetSecretary
    Input Text    sec-current-password        ${NEW_PASS}
    Input Text    sec-new-password            ${CUR_PASS}
    Input Text    sec-confirm-new-password    ${CUR_PASS}
    Click Element   sec-save-password