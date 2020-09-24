*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Variables ***
${PROCEDURE}    Braces
${INVALID_PROC}     123

*** Test Cases ***
Invalid Create Duplicate Procedure
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Procedure
    Duplicate Procedure

Invalid Create Procedure Name
    [Template]  Invalid Procedure Name
    [Tags]              [PROCEDURE]
    Empty Procedure     ${EMPTY}
    Invalid Procedure   ${INVALID_PROC}

*** Keywords ***
Edit Procedure
    Set Selenium Speed      0.5
    Sleep   1
    Click Element   procedureButton
    Click Element   Checkup-edit

Invalid Procedure Name
    Set Selenium Speed  0.3
    [Arguments]   ${tag}    ${procedure}
    Input Text  edit-procedure-name  ${procedure}
    Click Element   edit-procedure-button
    Page Should Contain   Please input a valid procedure name
    Page Should Contain   Please input a valid procedure name

Duplicate Procedure
    Set Selenium Speed  0.01
    Input Text  edit-procedure-name  ${PROCEDURE}
    Click Element   edit-procedure-button
    Page Should Contain   Procedure already exists