*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Google And Search
    Open Browser    https://www.google.com    chrome
    Input Text      name=q    Automate Test for QA
    Press Keys      name=q    ENTER
    Sleep           3s
    Close Browser