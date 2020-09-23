*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${PROCEDURE}    Braces
${INVALID_PROC}     123

*** Test Cases ***
Invalid Create Duplicate Procedure
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Add Appointment Selection
    Add New Procedure
    Duplicate Procedure

Invalid Create Procedure Name
    [Template]  Invalid Procedure Name
    [Tags]              [PROCEDURE]
    Empty Procedure     ${EMPTY}
    Invalid Procedure   ${INVALID_PROC}

*** Keywords ***
Add Appointment Selection
#Day Speed
#   Set Selenium Speed  0.01
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    add

Add New Procedure
    Click Element    add-procedure-button

Invalid Procedure Name
    [Arguments]   ${tag}    ${procedure}
    Input Text  procedure-name  ${procedure}
    Click Element   create-procedure-button
    Page Should Contain   Please input a valid procedure name
    Page Should Contain   Please input a valid procedure name

Duplicate Procedure
    Set Selenium Speed  0.01
    Input Text  procedure-name  ${PROCEDURE}
    Click Element   create-procedure-button
    Page Should Contain   Procedure already exists
