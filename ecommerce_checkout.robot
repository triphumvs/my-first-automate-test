*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://the-internet.herokuapp.com/login
${BROWSER}      chrome
${USERNAME}     tomsmith
${PASSWORD}     SuperSecretPassword!

*** Test Cases ***
Verify Successful Login
    [Documentation]    ทดสอบเข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง (Positive Test)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.4 seconds    # ช่วยให้หุ่นยนต์ทำงานนุ่มนวลขึ้น เบราว์เซอร์ตามทันแน่ๆ

    # 1. กรอกข้อมูลล็อกอิน
    Wait Until Element Is Visible    id=username    timeout=10s
    Input Text      id=username    ${USERNAME}
    Input Text      id=password    ${PASSWORD}
    Click Button    css=button[type="submit"]

    # 2. ตรวจสอบว่าระบบพาเข้าหน้าถัดไปสำเร็จ
    Wait Until Page Contains    Welcome to the Secure Area.    timeout=10s
    
    # 3. ตรวจสอบแถบสีเขียวแจ้งเตือนว่าล็อกอินสำเร็จ
    Element Should Contain    id=flash    You logged into a secure area!
    
    [Teardown]    Close Browser

Verify Login Failed With Invalid Credentials
    [Documentation]    ทดสอบเข้าสู่ระบบด้วยรหัสผ่านที่ผิด (Negative Test)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.4 seconds

    # 1. กรอกชื่อถูก แต่กรอกรหัสผ่านผิด
    Wait Until Element Is Visible    id=username    timeout=10s
    Input Text      id=username    ${USERNAME}
    Input Text      id=password    wrongpassword123
    Click Button    css=button[type="submit"]

    # 2. ตรวจสอบแถบสีแดงแจ้งเตือนว่ารหัสผ่านผิด
    Wait Until Element Is Visible    id=flash    timeout=10s
    Element Should Contain           id=flash    Your password is invalid!
    
    [Teardown]    Close Browser