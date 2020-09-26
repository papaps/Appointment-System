*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${FIRST_NAME}   Jack
${LAST_NAME}    Skellington
${USERNAME}     skellington
${PASSWORD}     1234567890

*** Test Cases ***
Valid Create New Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Add Appointment Selection
    Add New Dentist
    Input New Dentist Details

New Dentist Should Exist
    Dentist Should Exist in Table
    Logout Page
    Login New Dentist
    Dentist Should Be Available in Creating Appointments
    Dentist Should Appear in Availability Page
    Dentist Should Appear in Doctor Dropdown

*** Keywords ***
Add Appointment Selection
#Day Speed
#   Set Selenium Speed  0.01
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    add

Add New Dentist
    Click Element    add-dentist-button

Input New Dentist Details
    Input Text  add-firstname-dentist   ${FIRST_NAME}
    Input Text  add-lastname-dentist    ${LAST_NAME}
    Input Text  add-username-dentist    ${USERNAME}
    Input Text  add-password-dentist    ${PASSWORD}
    Input Text  confirm-password-dentist    ${PASSWORD}
    Click Element    create-dentist-button
    Set Selenium Speed  0.3
    Click Element   add-schedule-button
    Element Text Should Be   class:success   New dentist successfully added
#    Wait Until Element Contains     class:success    Dentist schedule successfully added
    Page Should Contain     Dentist schedule successfully added
    Click Element   close-schedule-modal
#Single Press ESC works in manual testing, but requires 4 presses in automation
#    Press Keys    None    ESC
#    Press Keys    None    ESC
#    Press Keys    None    ESC
#    Press Keys    None    ESC

Dentist Should Exist in Table
    Set Selenium Speed  0
    Table Should Contain    table   ${FIRST_NAME} ${LASTNAME}

Login New Dentist
#Day Speed
#   Set Selenium Speed 0.02
    Set Selenium Speed  0.5
    Input Username  ${USERNAME}
    Input Password  ${PASSWORD}
    Submit Credentials
    Logout Page

Dentist Should Be Available in Creating Appointments
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Contain    Dr. Jack Skellington
    Click Element   cancel-appointment
    Click Element   discard

Dentist Should Appear in Availability Page
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Page Should Contain    Dr. Jack Skellington

Dentist Should Appear in Doctor Dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Page Should Contain    Dr. Skellington