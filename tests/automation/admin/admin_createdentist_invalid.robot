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
${DUPLICATE_NAME}   buchanan
${INVALID_NAME}   `123
${PASSWORD}     1234567890
${SHORT_PASS}      1
${LONG_PASS}    123456789012345678901234567890123
${INVALID_PASS}     1234567890-

*** Test Cases ***
Invalid Create New Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Add Appointment Selection
    Add New Dentist
    Invalid New Dentist Details Empty
    Invalid Name
    First Name Too Short
    Last Name Too Short
    Duplicate Name
    Invalid Username
    Invalid Matching Passwords
    Invalid Password Format
    Password Too Short
    Password Too Long

*** Keywords ***
Add Appointment Selection
#Day Speed
#   Set Selenium Speed  0.01
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    add

Add New Dentist
    Click Element    add-dentist-button

Invalid New Dentist Details Empty
    Set Selenium Speed  0.01
    Input Text  add-firstname-dentist   ${EMPTY}
    Input Text  add-lastname-dentist    ${EMPTY}
    Input Text  add-username-dentist    ${EMPTY}
    Input Text  add-password-dentist    ${EMPTY}
    Input Text  confirm-password-dentist    ${EMPTY}
    Click Element    create-dentist-button
    Page Should Contain   Please input a valid name
    Page Should Contain   Please input a valid password
    Page Should Contain   Please input a valid username

Invalid Name
    Input Text  add-firstname-dentist   ${INVALID_NAME}
    Input Text  add-lastname-dentist    ${INVALID_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Page Should Contain   Invalid name format
    Page Should Contain   Invalid name format

First Name Too Short
    Input Text  add-firstname-dentist   ${SHORT_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Page Should Contain   First Name is too short

Last Name Too Short
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${SHORT_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Page Should Contain   Last Name is too short

Duplicate Name
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${DUPLICATE_NAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Page Should Contain   Username already taken
    Page Should Contain   Username already taken

Invalid Username
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${INVALID_NAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Page Should Contain   Incorrect username format
    Page Should Contain   Username should be at least 6 alphanumeric characters

Invalid Matching Passwords
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${INVALID_PASS}
    Click Element    create-dentist-button
    Page Should Contain     Passwords do not match

Invalid Password Format
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${INVALID_PASS}
    Input Text  confirm-password-dentist    ${INVALID_PASS}
    Click Element    create-dentist-button
    Page Should Contain     Incorrect password format

Password Too Short
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${SHORT_PASS}
    Input Text  confirm-password-dentist    ${SHORT_PASS}
    Click Element    create-dentist-button
    Page Should Contain     Password is too short

Password Too Long
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${LONG_PASS}
    Input Text  confirm-password-dentist    ${LONG_PASS}
    Click Element    create-dentist-button
    Page Should Contain     Password is too long