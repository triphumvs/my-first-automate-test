*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in

*** Test Cases ***
Verify Get User API Successfully
    [Documentation]    ทดสอบยิง API เพื่อดึงข้อมูล User ID หมายเลข 2 (Positive Test)
    
    # 1. สร้างการเชื่อมต่อ (Session) ไปยัง Server หลังบ้าน
    Create Session    reqres    ${BASE_URL}
    
    # 2. ส่งคำสั่ง GET (ขอข้อมูล) ไปที่พิกัด /api/users/2
    ${response}=      GET On Session    reqres    /api/users/2
    
    # 3. [Assertion] ตรวจสอบ Status Code (200 แปลว่าระบบทำงานสำเร็จและส่งข้อมูลกลับมา)
    Status Should Be    200    ${response}
    
    # 4. แปลงข้อมูลดิบจาก API ให้กลายเป็นโครงสร้าง JSON เพื่อให้อ่านง่าย
    ${json_data}=       Set Variable    ${response.json()}
    
    # 5. ดึงข้อมูลด้านในออกมาเช็ค (เช่น เช็คว่าฟิลด์ email ตรงกับที่ระบบบันทึกไว้ไหม)
    ${email}=           Get From Dictionary    ${json_data['data']}    email
    Should Be Equal As Strings    ${email}    janet.weaver@reqres.in