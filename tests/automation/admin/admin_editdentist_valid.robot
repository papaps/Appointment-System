*** Settings ***
Documentation    Suite description
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
    [Tags]                      FIRSTNAME       LASTNAME
    Input Edit Dentist Details  ${FIRST_NAME}   ${LAST_NAME}

Edited Dentist Should Be Visible
    Edited Dentist Should Exist in Table
    Logout Page
    Edited Dentist Should Be Available in Creating Appointments
    Dentist Should Appear in Availability Page
    Dentist Should Appear in Doctor Dropdown
    Logout Page

Revert Dentist Changes
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Dentist
    [Tags]                      FIRSTNAME   LASTNAME
    Input Edit Dentist Details  Daisy       Buchanan

*** Keywords ***
Edit Dentist
    Set Selenium Speed  0.5
    ${name}=    Run Keyword and Return Status   Page Should Not Contain      ${LAST_NAME}
    Run Keyword If  ${name}==True   Click Element   Daisy-Buchanan-edit
    ...     ELSE   Click Element   Lily-Van Der Woodsen-edit

Input Edit Dentist Details
    [Arguments]  ${firstname}   ${lastname}
    Input Text  edit-firstname-dentist   ${firstname}
    Input Text  edit-lastname-dentist    ${lastname}
    Input Text  edit-password-dentist    ${PASSWORD}
    Input Text  edit-confirm-password-dentist    ${PASSWORD}
    Click Element    edit-dentist-button
    Element Text Should Be   class:success   Dentist detail successfully edited

Edited Dentist Should Exist in Table
    Set Selenium Speed  0.5
    Sleep   1
    Table Should Contain    table   ${FIRST_NAME} ${LASTNAME}

Edited Dentist Should Be Available in Creating Appointments
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Sleep   1
    Click Element   add-button
    Sleep   1
    Set Selenium Speed  0.5
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Sleep   1
    Page Should Contain    Dr. Lily Van Der Woodsen
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

Dentist Should Appear in Availability Page
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Sleep   1
    Page Should Contain    Dr. Lily Van Der Woodsen

Dentist Should Appear in Doctor Dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Page Should Contain    Dr. Van Der Woodsen