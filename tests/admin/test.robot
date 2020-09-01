*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
New Dentist Should Exist
    Dentist Should Be Available in Creating Appointments

*** Keywords ***
Dentist Should Be Available in Creating Appointments
    Set Selenium Speed  0.5
    Input Username  secretary
    Input Password  1234567890
    Submit Credentials
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
#    Sleep   5
#    Select From List By Label   doctors   Dr. Jack Skellington
    Wait Until Element Contains     add-multiDoctor     Dr. Jack Skellington