*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${PROCEDURE}    Dental Checkup

*** Test Cases ***
Valid Edit Procedure
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Procedure
    [Tags]                          PROCEDURE
    Input Edit Procedure Detail     ${PROCEDURE}

Edited Procedure Should Be Visible
    Procedure Should Exist in Table
    Logout Page
    Procedure Should Be Available in Creating Appointments
    Logout Page

Revert Procedure
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Edit Procedure
    [Tags]                          PROCEDURE
    Input Edit Procedure Detail     Checkup

*** Keywords ***
Edit Procedure
    Set Selenium Speed      0.5
    Sleep   1
    Click Element   procedureButton
    ${name}=    Run Keyword and Return Status   Page Should Not Contain      ${PROCEDURE}
    Run Keyword If  ${name}==True   Click Element   Checkup-edit
    ...     ELSE   Click Element    ${PROCEDURE}-edit

Input Edit Procedure Detail
    [Arguments]  ${procedure}
    Input Text  edit-procedure-name     ${procedure}
    Click Element   edit-procedure-button
    Set Selenium Speed  0.3
    Element Text Should Be   class:success   Procedure successfully edited

Procedure Should Exist in Table
    Table Should Contain    table   ${PROCEDURE}

Procedure Should Be Available in Creating Appointments
    Set Selenium Speed      0.5
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Click Element   add-button
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Contain    ${PROCEDURE}
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard