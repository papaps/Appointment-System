*** Settings ***
Documentation     A test suite containing tests related to valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource    login_resource.robot

*** Test Cases ***
Valid Admin Login
    Open Browser To Login Page
    Input Username    admin
    Input Password    @dmin
    Submit Credentials
    Admin Page Should Be Open
    [Teardown]    Close Browser

Valid Secretary Login
    Open Browser To Login Page
    Input Username    secretary
    Input Password    secret@ry
    Submit Credentials
    Secretary Page Should Be Open
    [Teardown]    Close Browser

Valid Dentist Login
    Open Browser To Login Page
    Input Username    buchanan
    Input Password    1234567890
    Submit Credentials
    Dentist Page Should Be Open
    [Teardown]    Close Browser