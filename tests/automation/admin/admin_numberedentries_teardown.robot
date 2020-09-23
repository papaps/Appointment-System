*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Login
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Delete 30 Dentists
    [Template]  Delete Dentist
    [Tags]          ELEMENT NAME
    Doctor 1        Doctor-AA-delete
    Doctor 27       Doctor-AAA-delete
    Doctor 2        Doctor-BB-delete
    Doctor 28       Doctor-BBB-delete
    Doctor 3        Doctor-CC-delete
    Doctor 29       Doctor-CCC-delete
    Doctor 4        Doctor-DD-delete
    Doctor 30       Doctor-DDD-delete
    Doctor 5        Doctor-EE-delete
    Doctor 6        Doctor-FF-delete
    Doctor 7        Doctor-GG-delete
    Doctor 8        Doctor-HH-delete
    Doctor 9        Doctor-II-delete
    Doctor 10       Doctor-JJ-delete
    Doctor 11       Doctor-KK-delete
    Doctor 12       Doctor-LL-delete
    Doctor 13       Doctor-MM-delete
    Doctor 14       Doctor-NN-delete
    Doctor 15       Doctor-OO-delete
    Doctor 16       Doctor-PP-delete
    Doctor 17       Doctor-QQ-delete
    Doctor 18       Doctor-RR-delete
    Doctor 19       Doctor-SS-delete
    Doctor 20       Doctor-TT-delete
    Doctor 21       Doctor-UU-delete
    Doctor 22       Doctor-VV-delete
    Doctor 23       Doctor-WW-delete
    Doctor 24       Doctor-XX-delete
    Doctor 25       Doctor-YY-delete
    Doctor 26       Doctor-ZZ-delete

Go To Procedures
    View Procedure Table

Delete 30 Procedures
    [Template]  Delete Procedure
    [Tags]         ELEMENT NAME
    Procedure 1    A-delete
    Procedure 27   AA-delete
    Procedure 2    B-delete
    Procedure 28   BB-delete
    Procedure 3    C-delete
    Procedure 29   CC-delete
    Procedure 4    D-delete
    Procedure 30   DD-delete
    Procedure 5    E-delete
    Procedure 6    F-delete
    Procedure 7    G-delete
    Procedure 8    H-delete
    Procedure 9    I-delete
    Procedure 10   J-delete
    Procedure 11   K-delete
    Procedure 12   L-delete
    Procedure 13   M-delete
    Procedure 14   N-delete
    Procedure 15   O-delete
    Procedure 16   P-delete
    Procedure 17   Q-delete
    Procedure 18   R-delete
    Procedure 19   S-delete
    Procedure 20   T-delete
    Procedure 21   U-delete
    Procedure 22   V-delete
    Procedure 23   W-delete
    Procedure 24   X-delete
    Procedure 25   Y-delete
    Procedure 26   Z-delete

*** Keywords ***
View Procedure Table
    Sleep   1
    Click Element   procedureButton

Delete Dentist
    [Arguments]  ${tag}    ${element}
    Sleep   1
    Click Element   ${element}
    Sleep   1
    Click Element   delete-user-button

Delete Procedure
    [Arguments]  ${tag}    ${element}
    Sleep   1
    Click Element   ${element}
    Sleep   1
    Click Element   delete-procedure-button