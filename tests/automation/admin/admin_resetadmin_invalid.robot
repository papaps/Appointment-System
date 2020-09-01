*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${CUR_PASS}   1234567890
${NEW_PASS}   0123456789
${SHORT_PASS}      1
${LONG_PASS}    123456789012345678901234567890123
${INVALID_PASS}     1234567890-

*** Test Cases ***
Invalid Reset Admin Password Inputs
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Admin
    Invalid Current Password Empty
    Invalid Current Password
    Invalid Matching Passwords
    Invalid New Password Format
    Invalid New Password Too Short
    Invalid New Password Too Long

*** Keywords ***
Reset Admin
    Sleep   0.5
    Click Element   resetAdmin

Invalid Current Password Empty
    Input Text    current-password        ${EMPTY}
    Input Text    new-password            ${NEW_PASS}
    Input Text    confirm-new-password    ${NEW_PASS}
    Click Element   save-password
    Page Should Contain     Please input your current password

Invalid Current Password
    Input Text    current-password        ${NEW_PASS}
    Input Text    new-password            ${NEW_PASS}
    Input Text    confirm-new-password    ${NEW_PASS}
    Click Element   save-password
    Page Should Contain     Incorrect current password

Invalid Matching Passwords
    Input Text    current-password        ${CUR_PASS}
    Input Text    new-password            ${NEW_PASS}
    Input Text    confirm-new-password    ${CUR_PASS}
    Click Element   save-password
    Page Should Contain     Passwords do not match

Invalid New Password Format
    Input Text    current-password        ${CUR_PASS}
    Input Text    new-password            ${INVALID_PASS}
    Input Text    confirm-new-password    ${INVALID_PASS}
    Click Element   save-password
    Page Should Contain     Incorrect password format

Invalid New Password Too Short
    Input Text    current-password        ${CUR_PASS}
    Input Text    new-password            ${SHORT_PASS}
    Input Text    confirm-new-password    ${SHORT_PASS}
    Click Element   save-password
    Page Should Contain     Password is too short

Invalid New Password Too Long
    Input Text    current-password        ${CUR_PASS}
    Input Text    new-password            ${LONG_PASS}
    Input Text    confirm-new-password    ${LONG_PASS}
    Click Element   save-password
    Page Should Contain     Password is too long