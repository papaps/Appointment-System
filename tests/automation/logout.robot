*** Settings ***
Documentation     A test suite containing tests related to logout.
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    login_resource.robot

*** Test Cases ***
Admin Logout
    Set Selenium Speed  0.05
    Input Username    ${VALID_ADMIN}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Logout Page
    Login Page Should Be Open

Secretary Logout
    Input Username    ${VALID_SECRETARY}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Logout Page
    Login Page Should Be Open

Dentist Logout
    Input Username    ${VALID_DENTIST}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Sleep   0.05
    Logout Page
    Login Page Should Be Open