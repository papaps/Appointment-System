*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${NEW PASSWORD}     0123456789

*** Test Cases ***
Forgot Password Secretary
    Forgot Password
    [Tags]                          USERNAME                PASSWORD
    Input Reset Password Details    ${VALID SECRETARY}      ${NEW PASSWORD}
    Input Admin Confirmation

Secretary Password Should Be Reset
    Success Reset
    Input Username  ${VALID SECRETARY}
    Input Password  ${NEW PASSWORD}
    Submit Credentials
    Logout Page

Forgot Password Dentist
    Forgot Password
    [Tags]                          USERNAME                PASSWORD
    Input Reset Password Details    ${VALID DENTIST}        ${NEW PASSWORD}
    Input Admin Confirmation

Dentist Password Should Be Reset
    Success Reset
    Input Username  ${VALID DENTIST}
    Input Password  ${NEW PASSWORD}
    Submit Credentials
    Logout Page

Revert Secretary Password
    Forgot Password
    [Tags]                          USERNAME                PASSWORD
    Input Reset Password Details    ${VALID SECRETARY}      ${VALID PASSWORD}
    Input Admin Confirmation

Revert Dentist Password
    Forgot Password
    [Tags]                          USERNAME                PASSWORD
    Input Reset Password Details    ${VALID DENTIST}        ${VALID PASSWORD}
    Input Admin Confirmation

*** Keywords ***
Forgot Password
    Set Selenium Speed  0.5
    Click Element   forgot

Input Reset Password Details
    [Arguments]     ${username}     ${password}
    Input Text  reset-username  ${username}
    Input Text  reset-password  ${password}
    Input Text  reset-confirm-password  ${password}
    Click Element   reset-button

Input Admin Confirmation
    Input Text  admin-input     ${VALID PASSWORD}
    Click Element   reset-button-admin

Success Reset
    Element Text Should Be  class:success   Password successfully reset