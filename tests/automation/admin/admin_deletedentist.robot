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
Remove Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Delete Dentist

Dentist Should Not Exist
    Dentist Should Not Exist in Table
    Logout Page
    Deleted Dentist Cannot Login
    Dentist Should Not Exist in Creating Appointments
    Dentist Should Not Appear in Availability Page
    Dentist Should Not Appear in Doctor Dropdown

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
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
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

Dentist Should Not Appear in Availability Page
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Page Should Not Contain    Dr. Jack Skellington

Dentist Should Not Appear in Doctor Dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Page Should Not Contain    Dr. Skellington