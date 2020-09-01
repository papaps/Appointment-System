*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Inactive Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Set Dentist Inactive
    Logout Page

Inactive Dentist Should Not Be Accessible
    Dentist Should Not Be Able To Login
    Dentist Should Be Unavailable in Creating Appointments
    Dentist Should Not Appear in Availability Page
    Dentist Should Not Appear in Doctor Dropdown
    Logout Page

Active Dentist
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Set Dentist Active
    Logout Page

Active Dentist Should Be Accessible
    Dentist Should Be Able to Login
    Dentist Should Be Available in Creating Appointments
    Dentist Should Appear in Availability Page
    Dentist Should Appear in Doctor Dropdown

*** Keywords ***
Set Dentist Active
    Sleep   1
    Click Element       Daisy-Buchanan-active
    Element Text Should Be      Daisy-Buchanan-active   Active

Set Dentist Inactive
    Sleep   1
    Click Element       Daisy-Buchanan-active
    Element Text Should Be      Daisy-Buchanan-active   Inactive

Dentist Should Be Able to Login
    Input Username    ${VALID DENTIST}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Logout Page

Dentist Should Not Be Able To Login
    Input Username    ${VALID DENTIST}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Page Should Contain   Invalid username
#    Sleep   1
#    Logout Page

Dentist Should Be Available in Creating Appointments
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Set Selenium Speed     0.5
    Sleep   1
    Click Element   add-button
    Sleep   1
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Contain    Dr. Daisy Buchanan
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

Dentist Should Be Unavailable in Creating Appointments
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Set Selenium Speed     0.5
    Sleep   1
    Click Element   add-button
    Sleep   1
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

Dentist Should Appear in Availability Page
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Page Should Contain    Dr. Daisy Buchanan

Dentist Should Not Appear in Availability Page
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Page Should Not Contain    Dr. Daisy Buchanan

Dentist Should Appear in Doctor Dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Page Should Contain    Dr. Buchanan

Dentist Should Not Appear in Doctor Dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Page Should Not Contain    Dr. Buchanan