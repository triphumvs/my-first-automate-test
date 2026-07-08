*** Settings ***
# เปลี่ยนจาก SeleniumLibrary มาใช้ Browser แทน
Library    Browser

*** Variables ***
${URL}          https://the-internet.herokuapp.com/login
${USERNAME}     tomsmith
${PASSWORD}     SuperSecretPassword!

*** Test Cases ***
Verify Login With Playwright
    [Documentation]    ระบบล็อกอินที่เขียนด้วย Playwright (ไม่ต้องใส่คำสั่ง Wait เลย!)
    
    # 1. เปิดเบราว์เซอร์แบบเปิดหน้าจอให้เราเห็น (headless=False)
    New Browser    browser=chromium    headless=False
    New Page       ${URL}
    
    # 2. พิมพ์ข้อมูลล็อกอิน (Playwright ใช้คำสั่ง Fill แทน Input Text)
    # และสังเกตว่าเราไม่ต้องใส่ Wait Until... นำหน้าเลย มันจัดการให้เอง!
    Fill Text      id=username    ${USERNAME}
    Fill Text      id=password    ${PASSWORD}
    Click          css=button[type="submit"]
    
    # 3. ตรวจสอบข้อความแจ้งเตือนความสำเร็จ
    Get Text       id=flash    contains    You logged into a secure area!
    
    [Teardown]    Close Browser