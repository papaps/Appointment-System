*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${PROCEDURE}    Veneers

*** Test Cases ***
Remove Procedure
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Delete Procedure

Procedure Should Not Exist
    Procedure Should Not Exist in Table
    Logout Page
    Procedure Should Not Exist in Creating Appointments

*** Keywords ***
Delete Procedure
    Set Selenium Speed  0.5
    Click Element   procedureButton
    Sleep   1
    Click Element   Veneers-delete
    Click Element   delete-procedure-button
    Set Selenium Speed  0.01
    Element Text Should Be   class:success   Procedure successfully deleted

Procedure Should Not Exist in Table
    Element Should Not Contain    table   ${PROCEDURE}    None    False

Procedure Should Not Exist in Creating Appointments
    Input Username  secretary
    Input Password  1234567890
    Submit Credentials
    Sleep   1
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    ${PROCEDURE}