*** Settings ***
Documentation     A test suite containing tests related to logout.
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    login_resource.robot

*** Test Cases ***
Admin Logout
    Set Selenium Speed  0.1
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Logout Page
    Login Page Should Be Open

Secretary Logout
    Input Username    ${VALID SECRETARY}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Logout Page
    Login Page Should Be Open

Dentist Logout
    Input Username    ${VALID DENTIST}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Sleep   0.05
    Logout Page
    Login Page Should Be Open