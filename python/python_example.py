from flask import Flask, request
import MySQLdb

app = Flask(__name__)

@app.route('/')
def index():
    # 建立資料庫連線
    conn = MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="courseselection")
    
    table = """
    <form method="post" action="/action" >
        文字輸出欄位：<input name="student_id">
        <input type="submit" value="送出">
    </form>
    """

    # 創建游標
    cursor = conn.cursor()
    
    # 查詢所有課程表
    query = "SELECT course.course_id, course.course_name, course.department, course.grade, course.credits, course.capacity, count(course_enroll.course_id), course.requirement_course  FROM course left join course_enroll on course.course_id = course_enroll.course_id group by course.course_id;"
    cursor.execute(query)
    courses = cursor.fetchall()

    # 生成HTML表格來顯示課程表
    table += "<table border='1'><tr><th>課程 ID</th><th>課程名稱</th><th>科系</th><th>年級</th><th>學分</th><th>人數上限</th><th>人數</th><th>是否為必修</th><th></th></tr>"
    for course in courses:
        table += "<tr>"
        for data in course:
            table += "<td>{}</td>".format(data)
        
        # 在每個課程資料列後面添加一個按鈕
        table += "<td><form action='/enroll' method='post'><input type='hidden' name='course_id' value='{}'><input type='submit' value='選課'></form></td>".format(course[0])
        
        table += "</tr>"

    table += "</table>"

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()
    
    return table

@app.route('/action', methods=['POST'])

def action():
    # 取得輸入的學號
    student_id_value = request.form.get("student_id")
    # 建立資料庫連線
    conn = MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="courseselection")
    
    table = ''''''
    
    # 欲查詢的 query 指令
    query = "SELECT * FROM student where student_id = '%s';" % student_id_value
    # 執行查詢
    cursor = conn.cursor()
    cursor.execute(query)
    student_data = cursor.fetchall()
    table+='<tr>'
    for des in student_data:
        table+="<td>{}</td>".format(des)
    table+='</tr>'
    # 如果學生存在，則繼續查詢課表
    if student_data:
        query = """
        SELECT course_schedule.weekday, course_schedule.period, course.course_name 
        FROM course_schedule 
        INNER JOIN course ON course_schedule.course_id = course.course_id 
        WHERE course_schedule.course_id IN (SELECT course_id FROM course_enroll WHERE student_id = '%s');
        """ % student_id_value
        cursor.execute(query)
        
        timetable = [["" for _ in range(8)] for _ in range(10)]
        table += " <table border='1'><tr><th>星期</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th><th>日</th></tr>"

        # 將查詢結果填入課程時間二維陣列
        for row in cursor.fetchall():
            weekday = row[0]  # 星期
            period = row[1]   # 節次
            course_name = row[2]  # 課程名稱
            timetable[period - 1][weekday] = course_name
        
        # 根據課程時間二維陣列生成表格
        for i in range(10):
            table += "<tr>"
            table += "<td>{}</td>".format(i + 1)  # 節次
            for j in range(7):
                table += "<td>{}</td>".format(timetable[i][j])  # 課程名稱
            table += "</tr>"
    else:
        table += "<p>查無此學號</p>"

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()

    return table


@app.route('/enroll', methods=['POST'])
def enroll():
    # 取得請求中的學號和課程ID
    student_id = request.form.get("student_id")
    course_id = request.form.get("course_id")

    # 建立資料庫連線
    conn = MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="courseselection")

    # 創建游標
    cursor = conn.cursor()

    # 檢查學生學分是否大於30
    query_credit = "SELECT SUM(credits) FROM course_enroll ce JOIN course c ON ce.course_id = c.course_id WHERE student_id = %s;"
    cursor.execute(query_credit, (student_id,))
    total_credits = cursor.fetchone()[0]

    if total_credits is None:
        total_credits = 0

    query_course_credit = "SELECT credits FROM course WHERE course_id = %s;"
    cursor.execute(query_course_credit, (course_id,))
    course_credits = cursor.fetchone()[0]

    if total_credits + course_credits > 30:
        cursor.close()
        conn.close()
        return "Fail: Exceeds maximum credits limit (30 credits)."

    # 檢查課程與學生是否同科系
    query_department = "SELECT department FROM student WHERE student_id = %s;"
    cursor.execute(query_department, (student_id,))
    student_department_result = cursor.fetchone()
    if student_department_result is None:
        cursor.close()
        conn.close()
        return "Fail: Student not found."

    student_department = student_department_result[0]

    query_course_department = "SELECT department FROM course WHERE course_id = %s;"
    cursor.execute(query_course_department, (course_id,))
    course_department = cursor.fetchone()[0]

    if student_department != course_department:
        cursor.close()
        conn.close()
        return "Fail: The student and course belong to different departments."

    # 加選
    query_enroll = "INSERT INTO course_enroll (student_id, course_id) VALUES (%s, %s);"
    cursor.execute(query_enroll, (student_id, course_id))
    conn.commit()

    cursor.close()
    conn.close()

    return "Success: Course enrolled successfully."
    