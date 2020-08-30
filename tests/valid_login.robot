*** Settings ***
Documentation     A test suite containing tests related to valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource    login_resource.robot

*** Test Cases ***
Valid Admin Login
    Open Browser To Login Page Slow
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Admin Page Should Be Open
    Logout Page
    [Teardown]    Close Browser

Valid Secretary Login
    Open Browser To Login Page Slow
    Input Username    secretary
    Input Password    1234567890
    Submit Credentials
    Secretary Page Should Be Open
    Logout Page
    [Teardown]    Close Browser

Valid Dentist Login
    Open Browser To Login Page Slow
    Input Username    buchanan
    Input Password    1234567890
    Submit Credentials
    Dentist Page Should Be Open
    Logout Page
    [Teardown]    Close Browser