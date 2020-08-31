*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${FIRST_NAME}   Jack
${LAST_NAME}    Skellington
${USERNAME}     skellington
${PASSWORD}     1234567890

*** Test Cases ***
Remove Dentist
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Delete Dentist

Dentist Should Not Exist
    Dentist Should Not Exist in Table
    Logout Page
    Deleted Dentist Cannot Login
    Dentist Should Not Exist in Creating Appointments

*** Keywords ***
Delete Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Jack-Skellington-delete
    Click Element   delete-user-button
    Set Selenium Speed  0.01
    Element Text Should Be   class:success   User successfully deleted

Dentist Should Not Exist in Table
    Element Should Not Contain  table   ${FIRST_NAME} ${LASTNAME}   None    False

Deleted Dentist Cannot Login
    Set Selenium Speed  0.01
    Input Username  ${USERNAME}
    Input Password  ${PASSWORD}
    Submit Credentials
    Page Should Contain   Invalid username

Dentist Should Not Exist in Creating Appointments
    Input Username  secretary
    Input Password  1234567890
    Submit Credentials
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Jack Skellington