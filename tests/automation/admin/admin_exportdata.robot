*** Settings ***
Documentation    Suite description
Library  OperatingSystem
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Export Appointment Data
    Input Username    ${VALID ADMIN}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Export Data

Check For Data File
    Data Should Exist   Appointment.csv
    Delete Data     Appointment.csv

*** Keywords ***
Export Data
#Day Speed
#    Set Selenium Speed  ${DELAY}
#Night Speed
    Set Selenium Speed  0.5
    Click Element      downloadFile

Data Should Exist
    [Arguments]         ${file}
    File Should Exist   C:\\Users\\user\\Downloads\\${file}

Delete Data
    [Arguments]     ${file}
    Remove File     C:\\Users\\user\\Downloads\\${file}