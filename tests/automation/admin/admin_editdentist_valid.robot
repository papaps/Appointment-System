*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${FIRST_NAME}   Lily
${LAST_NAME}    Van Der Woodsen
${PASSWORD}     1234567890

*** Test Cases ***
Valid Edit Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Dentist
    Input Edit Dentist Details

Edited Dentist Changes Should Be Visible
    Edited Dentist Should Exist in Table
    Logout Page
    Login New Dentist
    Dentist Should Be Available in Creating Appointments

*** Keywords ***
Edit Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    Daisy-Buchanan-edit

Input Edit Dentist Details
    Input Text  edit-firstname-dentist   ${FIRST_NAME}
    Input Text  edit-lastname-dentist    ${LAST_NAME}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${PASSWORD}
    Click Element    edit-dentist-button
    Set Selenium Speed  0.3
    Click Element   add-schedule-button
    Element Text Should Be   class:success   Dentist detail successfully edited

Edited Dentist Should Exist in Table
    Set Selenium Speed  0
    Table Should Contain    table   ${FIRST_NAME} ${LASTNAME}

Edited Dentist Should Be Available in Creating Appointments
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Contain    Dr. Lily Van Der Woodsen