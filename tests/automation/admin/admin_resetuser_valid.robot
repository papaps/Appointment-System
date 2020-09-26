*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${CUR_ADMIN_PASS}   1234567890
${NEW_ADMIN_PASS}   0123456789
${CUR_SEC_PASS}   1234567890
${NEW_SEC_PASS}   0123456789

*** Test Cases ***
Valid Reset Admin Password
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Admin
    Admin Reset Success Message Should Appear
    Logout Page
    Input Username    admin
    Input Password    0123456789
    Submit Credentials
    Revert Admin
    Logout Page


Valid Reset Secretary Password
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Secretary
    Secretary Reset Success Message Should Appear
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
    Set Selenium Speed  0.2
    Click Element   resetAdmin
    Input Text    current-password        ${CUR_ADMIN_PASS}
    Input Text    new-password            ${NEW_ADMIN_PASS}
    Input Text    confirm-new-password    ${NEW_ADMIN_PASS}
    Click Element   save-password

Reset Secretary
    Click Element   resetSecretary
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
    Click Element   resetSecretary
    Input Text    sec-current-password        ${NEW_SEC_PASS}
    Input Text    sec-new-password            ${CUR_SEC_PASS}
    Input Text    sec-confirm-new-password    ${CUR_SEC_PASS}
    Click Element   sec-save-password

Admin Reset Success Message Should Appear
    Element Text Should Be   class:success   Password successfully reset

Secretary Reset Success Message Should Appear
    Element Text Should Be   class:success   Password successfully reset