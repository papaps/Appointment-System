*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Invalid Edit Schedule Regular
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Click To Edit Schedule
    Empty Schedule Regular
    Backward Schedule Regular
    Short Schedule Regular

Invalid Edit Schedule Custom
    Empty Schedule Custom
    Backward Schedule Custom
    Duplicate Schedule Custom
    Overlap Schedule Custom
    Short Schedule Custom

*** Keywords ***
Delete Regular Input
    Set Selenium Speed  0.3
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Set Selenium Speed  0.5

Delete Custom Input
    Set Selenium Speed  0.3
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-start-add
    Press Keys  None    DELETE
    Double Click Element   edit-start-add
    Press Keys  None    DELETE
    Double Click Element   edit-start-add
    Press Keys  None    DELETE
    Double Click Element   edit-start-add
    Press Keys  None    DELETE
    Double Click Element   edit-end-add
    Press Keys  None    DELETE
    Double Click Element   edit-end-add
    Press Keys  None    DELETE
    Double Click Element   edit-end-add
    Press Keys  None    DELETE
    Set Selenium Speed  0.5

Set To Regular
    Click Element   edit-custom

Click To Edit Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    Click Element   Monday-edit

Empty Schedule Regular
    ${regular}=  Run Keyword and Return Status   Page Should Not Contain Element     edit-start-add
    Run Keyword If  ${regular} is ${FALSE}   Set To Regular
    Delete Regular Input
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Please input a valid time

Backward Schedule Regular
#    ${regular}=  Run Keyword and Return Status   Page Should Not Contain Element     edit-start-add
#    Run Keyword If  ${regular} is ${FALSE}   Set To Regular
#    Delete Regular Input
    Input Text  edit-start  9:00
    Input Text  edit-end    8:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Invalid time interval

Short Schedule Regular
    Delete Regular Input
    Input Text  edit-start  8:00
    Input Text  edit-end    8:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Time interval is too short

Empty Schedule Custom
    Click Element   edit-custom
    Delete Custom Input
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Please input a valid time

Backward Schedule Custom
    Delete Custom Input
    Input Text  edit-start  9:00
    Input Text  edit-end    8:00
    Input Text  edit-start-add  10:00
    Input Text  edit-end-add   12:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Invalid time interval

Duplicate Schedule Custom
    Delete Custom Input
    Input Text  edit-start  8:00
    Input Text  edit-end    9:00
    Input Text  edit-start-add  8:00
    Input Text  edit-end-add   9:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Invalid time interval

Overlap Schedule Custom
    Delete Custom Input
    Input Text  edit-start  8:00
    Input Text  edit-end    9:00
    Input Text  edit-start-add  8:30
    Input Text  edit-end-add   10:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Invalid time interval

Short Schedule Custom
    Delete Custom Input
    Input Text  edit-start  8:00
    Input Text  edit-end    9:00
    Input Text  edit-start-add  9:00
    Input Text  edit-end-add   10:00
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule
    Page Should Contain    Time interval is too short