*** Settings ***
Documentation    Suite description
Library     DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Variables ***
${LAST LOGIN}

*** Test Cases ***
Last Login Check
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Get Last Login
    Logout Page
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Last Login Should Be Correct

*** Keywords ***
Get Last Login
    ${CurrentDate}=    Get Current Date
    ${LAST LOGIN}=   Convert Date    ${CurrentDate}    result_format=%b %d, %Y %I:%M:%S

Last Login Should Be Correct
    Page Should Contain     ${LAST LOGIN}
