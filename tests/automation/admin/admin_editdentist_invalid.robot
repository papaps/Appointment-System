*** Settings ***
Documentation    Suite description

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${FIRST_NAME}   Truman
${LAST_NAME}    Burbank
${USERNAME}     truman
${SHORT_NAME}  t
${INVALID_NAME}   `123
${PASSWORD}     1234567890
${SHORT_PASS}      1
${LONG_PASS}    123456789012345678901234567890123
${INVALID_PASS}     1234567890-

*** Test Cases ***
Invalid Edit Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Dentist
    Invalid Edit Dentist Details Empty
    Invalid Name
    First Name Too Short
    Last Name Too Short
    Invalid Matching Passwords
    Invalid Password Format
    Password Too Short
    Password Too Long

*** Keywords ***
Edit Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-edit

Invalid Edit Dentist Details Empty
    Set Selenium Speed  0.01
    Input Text  edit-firstname-dentist   ${EMPTY}
    Input Text  edit-lastname-dentist    ${EMPTY}
    Input Text  edit-password-dentist    ${EMPTY}
    Input Text  edit-confirm-password-dentist    ${EMPTY}
    Click Element    edit-dentist-button
    Page Should Contain   Please input a valid name
    Page Should Contain   Please input a valid password

Invalid Name
    Input Text  edit-firstname-dentist   ${INVALID_NAME}
    Input Text  edit-lastname-dentist    ${INVALID_NAME}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${PASSWORD}
    Click Element    edit-dentist-button
    Page Should Contain   Invalid name format
    Page Should Contain   Invalid name format

First Name Too Short
    Input Text  edit-firstname-dentist   ${SHORT_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${PASSWORD}
    Click Element    edit-dentist-button
    Page Should Contain   First Name is too short

Last Name Too Short
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${SHORT_NAME}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${PASSWORD}
    Click Element    edit-dentist-button
    Page Should Contain   Last Name is too short

Invalid Matching Passwords
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${INVALID_PASS}
    Click Element    edit-dentist-button
    Page Should Contain     Passwords do not match

Invalid Password Format
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${INVALID_PASS}
    Input Text  edit-confirm-password-dentist    ${INVALID_PASS}
    Click Element    edit-dentist-button
    Page Should Contain     Incorrect password format

Password Too Short
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${SHORT_PASS}
    Input Text  edit-confirm-password-dentist    ${SHORT_PASS}
    Click Element    edit-dentist-button
    Page Should Contain     Password is too short

Password Too Long
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${LONG_PASS}
    Input Text  edit-confirm-password-dentist    ${LONG_PASS}
    Click Element    edit-dentist-button
    Page Should Contain     Password is too long