*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${INVALID_NAME}   `123
${PASSWORD}     1234567890
${SHORT_PASS}      1
${LONG_PASS}    123456789012345678901234567890123
${INVALID_PASS}     1234567890-

*** Test Cases ***
Invalid Reset Password
    Forgot Password
    Empty Credentials
    Invalid Username
    Passwords Do Not Match
    Invalid Password Format
    Password Too Short
    Password Too Long
    Valid Username Invalid Admin Password

*** Keywords ***
Forgot Password
    Set Selenium Speed  0.5
    Click Element   forgot

Empty Credentials
    Input Text  reset-username  ${EMPTY}
    Input Text  reset-password  ${EMPTY}
    Input Text  reset-confirm-password  ${EMPTY}
    Click Element   reset-button
    Page Should Contain   Please input a valid password
    Page Should Contain   Please input a valid username

Invalid Username
    Input Text  reset-username  ${INVALID_NAME}
    Input Text  reset-password  ${VALID PASSWORD}
    Input Text  reset-confirm-password  ${VALID PASSWORD}
    Click Element   reset-button
    Page Should Contain   Username does not exist

Passwords Do Not Match
    Input Text  reset-username  ${VALID SECRETARY}
    Input Text  reset-password  ${VALID PASSWORD}
    Input Text  reset-confirm-password  ${SHORT_PASS}
    Click Element   reset-button
    Page Should Contain   Passwords do not match

Invalid Password Format
    Input Text  reset-username  ${VALID SECRETARY}
    Input Text  reset-password  ${INVALID_PASS}
    Input Text  reset-confirm-password  ${INVALID_PASS}
    Click Element   reset-button
    Page Should Contain   Incorrect password format

Password Too Short
    Input Text  reset-username  ${VALID SECRETARY}
    Input Text  reset-password  ${SHORT_PASS}
    Input Text  reset-confirm-password  ${SHORT_PASS}
    Click Element   reset-button
    Page Should Contain   Password is too short

Password Too Long
    Input Text  reset-username  ${VALID SECRETARY}
    Input Text  reset-password  ${LONG_PASS}
    Input Text  reset-confirm-password  ${LONG_PASS}
    Click Element   reset-button
    Page Should Contain   Password is too long

Valid Username Invalid Admin Password
    Set Selenium Speed  0.3
    Input Text  reset-username  ${VALID SECRETARY}
    Input Text  reset-password  ${VALID PASSWORD}
    Input Text  reset-confirm-password  ${VALID PASSWORD}
    Click Element   reset-button
    Input Text  admin-input     ${INVALID_PASS}
    Click Element   reset-button-admin
    Page Should Contain   Incorrect admin password