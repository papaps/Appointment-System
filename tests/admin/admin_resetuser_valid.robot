*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${CUR_ADMIN_PASS}   1234567890
${NEW_ADMIN_PASS}   0123456789
${CUR_SEC_PASS}   1234567890
${NEW_SEC_PASS}   0123456789

*** Test Cases ***
Reset Admin Password
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Admin
    Logout Page
    Input Username    admin
    Input Password    0123456789
    Submit Credentials
    Revert Admin
    Logout Page

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
Reset Admin
    Set Selenium Speed  0.05
    Click Element   resetAdmin
    Input Text    current-password        ${CUR_ADMIN_PASS}
    Input Text    new-password            ${NEW_ADMIN_PASS}
    Input Text    confirm-new-password    ${NEW_ADMIN_PASS}
    Click Element   save-password

Reset Secretary
    Click ELement   resetSecretary
    Input Text    sec-current-password        ${CUR_SEC_PASS}
    Input Text    sec-new-password            ${NEW_SEC_PASS}
    Input Text    sec-confirm-new-password    ${NEW_SEC_PASS}
    Click Element   sec-save-password

Revert Admin
    Click Element   resetAdmin
    Input Text    current-password        ${NEW_ADMIN_PASS}
    Input Text    new-password            ${CUR_ADMIN_PASS}
    Input Text    confirm-new-password    ${CUR_ADMIN_PASS}
    Click Element   save-password

Revert Secretary
    Click ELement   resetSecretary
    Input Text    sec-current-password        ${NEW_SEC_PASS}
    Input Text    sec-new-password            ${CUR_SEC_PASS}
    Input Text    sec-confirm-new-password    ${CUR_SEC_PASS}
    Click Element   sec-save-password