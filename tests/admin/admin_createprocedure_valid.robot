*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${PROCEDURE}    Veneers

*** Test Cases ***
Valid Create New Procedure
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Add Appointment Selection
    Add New Procedure
    Input New Procedure Detail

New Procedure Should Exist
    Procedure Should Exist in Table
    Logout Page
    Procedure Should Be Available in Creating Appointments

*** Keywords ***
Add Appointment Selection
#Day Speed
#   Set Selenium Speed  0.01
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    add

Add New Procedure
    Click Element    add-procedure-button

Input New Procedure Detail
    Input Text  procedure-name  ${PROCEDURE}
    Click Element   create-procedure-button
    Element Text Should Be   class:success   New procedure successfully added

Procedure Should Exist in Table
    Click Element   procedureButton
    Table Should Contain    table   ${PROCEDURE}

Procedure Should Be Available in Creating Appointments
    Input Username  secretary
    Input Password  1234567890
    Submit Credentials
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Contain    ${PROCEDURE}
