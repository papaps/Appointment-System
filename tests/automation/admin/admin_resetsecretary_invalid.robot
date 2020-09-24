*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

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
    Reset Secretary
    Invalid Current Password Empty
    Invalid Current Password
    Invalid Matching Passwords
    Invalid New Password Format
    Invalid New Password Too Short
    Invalid New Password Too Long

*** Keywords ***
Reset Secretary
    Set Selenium Speed  0.05
    Click Element   resetSecretary

Invalid Current Password Empty
    Input Text    sec-current-password        ${EMPTY}
    Input Text    sec-new-password            ${NEW_PASS}
    Input Text    sec-confirm-new-password    ${NEW_PASS}
    Click Element   sec-save-password
    Page Should Contain     Please input your current password

Invalid Current Password
    Input Text    sec-current-password        ${NEW_PASS}
    Input Text    sec-new-password            ${NEW_PASS}
    Input Text    sec-confirm-new-password    ${NEW_PASS}
    Click Element   sec-save-password
    Page Should Contain     Incorrect current password

Invalid Matching Passwords
    Input Text    sec-current-password        ${CUR_PASS}
    Input Text    sec-new-password            ${NEW_PASS}
    Input Text    sec-confirm-new-password    ${CUR_PASS}
    Click Element   sec-save-password
    Page Should Contain     Passwords do not match

Invalid New Password Format
    Input Text    sec-current-password        ${CUR_PASS}
    Input Text    sec-new-password            ${INVALID_PASS}
    Input Text    sec-confirm-new-password    ${INVALID_PASS}
    Click Element   sec-save-password
    Page Should Contain     Incorrect password format

Invalid New Password Too Short
    Input Text    sec-current-password        ${CUR_PASS}
    Input Text    sec-new-password            ${SHORT_PASS}
    Input Text    sec-confirm-new-password    ${SHORT_PASS}
    Click Element   sec-save-password
    Page Should Contain     Password is too short

Invalid New Password Too Long
    Input Text    sec-current-password        ${CUR_PASS}
    Input Text    sec-new-password            ${LONG_PASS}
    Input Text    sec-confirm-new-password    ${LONG_PASS}
    Click Element   sec-save-password
    Page Should Contain     Password is too long