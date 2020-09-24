*** Settings ***
Documentation    Suite description
Library  DateTime
Library  String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
Secretary View
    Login Secretary
    Set Selenium Speed  0.5
    Sleep   1

View Appointment Setup
    [Template]  Add Appointment
    [Tags]              FIRST_NAME      TIME
    Add Appointment     Aperson         8:00 AM
    Add Appointment     Bperson         8:30 AM
    Add Appointment     Cperson         9:00 AM
    Add Appointment     Dperson         9:30 AM
    Add Appointment     Eperson         10:00 AM
    Add Appointment     Fperson         10:30 AM
    Add Appointment     Gperson         11:00 AM
    Add Appointment     Hperson         11:30 AM

Exit Secretary View
    Logout Page

View Appointment Should Work
    Login Dentist
    Sleep   1
    Click Next Button
    Click Weekdate
    View Weekdate Schedule
    Logout Page

View Appointment Teardown
    Login Secretary
    Set Selenium Speed  0.5
    Click Dropdown
    Click Next Button
    Click Weekdate
    Delete Appointment  8:00 AM-0
    Delete Appointment  8:30 AM-0
    Delete Appointment  9:00 AM-0
    Delete Appointment  9:30 AM-0
    Delete Appointment  10:00 AM-0
    Delete Appointment  10:30 AM-0
    Delete Appointment  11:00 AM-0
    Delete Appointment  11:30 AM-0
    Logout Page


*** Keywords ***
Login Secretary
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Get Date
    ${date}=    Get Current Date
    ${letters}=     Convert Date    ${date}     result_format=%A

    ${mon}=     Add Time To Date    ${date}  11 days
    ${tue}=     Add Time To Date    ${date}  10 days
    ${wed}=     Add Time To Date    ${date}  9 days
    ${thu}=     Add Time To Date    ${date}  8 days
    ${fri}=     Add Time To Date    ${date}  7 days
    ${sat}=     Add Time To Date    ${date}  6 days
    ${sun}=     Add Time To Date    ${date}  5 days

    ${date}=     Set Variable If  '${letters}'=='Monday'  ${mon}
    ...  '${letters}'=='Tuesday'  ${tue}
    ...  '${letters}'=='Wednesday'  ${wed}
    ...  '${letters}'=='Thursday'  ${thu}
    ...  '${letters}'=='Friday'  ${fri}
    ...  '${letters}'=='Saturday'  ${sat}
    ...  '${letters}'=='Sunday'  ${sun}

    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%B ${day}, %Y
    [Return]        ${date}

Click Add Appointment Button
    Click Element   add-button

Click Proceed Add Appointment Button
    Click Element   date-done

Click Proceed Edit Appointment Button
    Click Element   date-done-edit

Click Next Button
    Click Element   next-button

Click Weekdate
    Click Element   Friday

Click Dropdown
    Click Element   view-chooser

Click Appointment
    [Arguments]  ${button}
    Click Element   ${button}

Click Delete Appointment
    Click Element   edit-delete-button

Click Continue Delete Appointment
    Click Element   edit-continue-button

Delete Date Field
    Double Click Element    add-dateInput
    Press Keys  None    DELETE
    Double Click Element    add-dateInput
    Press Keys  None    DELETE
    Double Click Element    add-dateInput
    Press Keys  None    DELETE
    Double Click Element    add-dateInput
    Press Keys  None    DELETE
    Double Click Element    add-dateInput
    Press Keys  None    DELETE
    Double Click Element    add-dateInput
    Press Keys  None    DELETE

Delete Time Field
    Double Click Element    add-timeInput
    Press Keys  None    DELETE
    Double Click Element    add-timeInput
    Press Keys  None    DELETE
    Double Click Element    add-timeInput
    Press Keys  None    DELETE
    Double Click Element   add-timeInput
    Press Keys  None    DELETE
    Double Click Element    add-timeInput
    Press Keys  None    DELETE

Input Date Field
    [Arguments]  ${date}
    Input Text  add-dateInput   ${date}

Input Time Field
    [Arguments]  ${time}
    Input Text  add-timeInput   ${time}

Input First Name
    [Arguments]  ${name}
    Input Text  add-firstName   ${name}

Input Last Name
    [Arguments]  ${name}
    Input Text  add-lastName   ${name}

Input Contact Number
    [Arguments]  ${number}
    Input Text  add-contact   ${number}

Add Appointment
    [Arguments]  ${tag}  ${first}  ${time}
    Click Add Appointment Button
    ${date}=    Get Date
    Delete Date Field
    Input Date Field    ${date}
    Delete Time Field
    Input Time Field    ${time}
    Click Proceed Add Appointment Button
    Input First Name  ${first}
    Input Last Name  Lastname
    Input Contact Number  09777777777
    Press Keys  None    TAB
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER
    Press Keys  None    TAB
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER

View Weekdate Schedule
    Page Should Contain  Aperson
    Page Should Contain  Bperson
    Page Should Contain  Cperson
    Page Should Contain  Dperson
    Page Should Contain  Eperson
    Page Should Contain  Fperson
    Page Should Contain  Gperson
    Page Should Contain  Hperson

Delete Appointment
    [Arguments]  ${button}
    Click Appointment   ${button}
    Click Proceed Edit Appointment Button
    Click Delete Appointment
    Click Continue Delete Appointment




