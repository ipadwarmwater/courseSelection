from flask import Flask, request, session ,redirect, url_for
import MySQLdb

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

def connect_to_database():
    return MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="courseselection")

@app.route('/logout', methods=['GET', 'POST'])
def logout():
    # 清除会话中的用户信息
    session.pop('student_id', None)
    session.pop('logged_in', None)

    return redirect('/')

@app.route('/home')
def home():
    results = """
    <p><a href="/search">檢索課程</a></p>
    <p><a href="/student_table_show">查詢課表</a></p>
    <p><a href="/student_table_deleteshow">退選課程</a></p>
    <form action="/logout" method="post">
        <input type="submit" value="Logout">
    </form>
    """
    return results

@app.route('/')
def index():
    if 'student_id' not in session:
        return '''<form method="post" action="/login">
            請輸入學號：<input name="student_id">
            <input type="submit" name="search_button" value="登入">
        </form>'''
    else:
        return redirect("/home")

@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('student_id')

    conn = connect_to_database()
    cursor = conn.cursor()
    
    query = "SELECT student_id FROM student;"
    cursor.execute(query)
    student_data = cursor.fetchall()
    for i in student_data:
        if i[0] == username:  # Access the first element of the tuple
            session['student_id'] = username
            cursor.close()
            conn.close()
            session['logged_in'] = True
            return redirect("/home")
    cursor.close()
    conn.close()
    return "登入失敗，非本校學生"

@app.route('/search', methods=['GET', 'POST'])
def search():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']

    # 建立資料庫連線
    conn = connect_to_database()
    
    table = """"""

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
        table += "<td><form action='/enroll' method='post'><input type='hidden' name='student_id' value='{}'><input type='hidden' name='course_id' value='{}'><input type='submit' value='選課'></form></td>".format(student_id, course[0])

        table += "</tr>"

    table += "</table>"

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()
    
    return table


@app.route('/enroll', methods=['POST'])
def enroll():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    # 取得請求中的學號和課程ID
    course_id = request.form.get("course_id")

    # 建立資料庫連線
    conn = connect_to_database()

    # 創建游標
    cursor = conn.cursor()

    result = '''<p><a href="/">回首頁</a></br><a href="/search">回選課</a></p>'''
    
    # 檢查學生是否已選這堂課
    query_select = "SELECT COUNT(*) FROM course_enroll WHERE course_id = %s AND student_id = %s"
    cursor.execute(query_select, (course_id, student_id))
    count = cursor.fetchone()[0]
    if count > 0:
        result += "錯誤：已選此課程"
        return result

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
        result+= "錯誤：超過學分上限(30學分)"
        return result

    # 檢查課程與學生是否同科系
    query_department = "SELECT department FROM student WHERE student_id = %s;"
    cursor.execute(query_department, (student_id,))
    student_department_result = cursor.fetchone()
    if student_department_result is None:
        cursor.close()
        conn.close()
        result+= "錯誤：查無此人"
        return result

    student_department = student_department_result[0]

    query_course_department = "SELECT department FROM course WHERE course_id = %s;"
    cursor.execute(query_course_department, (course_id,))
    course_department = cursor.fetchone()[0]

    if student_department != course_department:
        cursor.close()
        conn.close()
        result+=  "錯誤：學生和課程分屬不同系所"
        return result

    # 加選
    query_enroll = "INSERT INTO course_enroll (student_id, course_id) VALUES (%s,%s);"
    cursor.execute(query_enroll, (student_id, course_id))
    conn.commit()

    cursor.close()
    conn.close()

    result+=  "成功：課程加選成功"
    return result

@app.route('/student_table_show', methods=['POST', 'GET'])
def student_table_show():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    table = '''<p><a href="/">回首頁</a></p>'''
    
    # 建立資料庫連線
    conn = connect_to_database()
    
    # 欲查詢的 query 指令
    query = "SELECT * FROM student where student_id = %s;" % student_id
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
        WHERE course_schedule.course_id IN (SELECT course_id FROM course_enroll WHERE student_id = %s);
        """ % student_id
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


@app.route('/student_table_deleteshow', methods=['GET', 'POST'])
def student_table_deleteshow():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    table = '''<p><a href="/">回首頁</a></p>'''
    # 建立資料庫連線
    conn = connect_to_database()

    # 欲查詢的 query 指令
    query = "SELECT * FROM student where student_id = %s;" % student_id
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
        SELECT ce.course_id, course_schedule.weekday, course_schedule.period, course.course_name 
        FROM course_schedule 
        INNER JOIN course ON course_schedule.course_id = course.course_id 
        INNER JOIN course_enroll ce ON course_schedule.course_id = ce.course_id
        WHERE ce.student_id = %s;
        """ % student_id
        cursor.execute(query)

        timetable = [["" for _ in range(8)] for _ in range(10)]
        table += " <table border='1'><tr><th>星期</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th><th>日</th></tr>"

        # 將查詢結果填入課程時間二維陣列
        for row in cursor.fetchall():
            course_id = row[0]  # 課程ID
            weekday = row[1]  # 星期
            period = row[2]   # 節次
            course_name = row[3]  # 課程名稱
            timetable[period - 1][weekday] = (course_id, course_name)  # 存入課程ID和課程名稱的tuple

        # 根據課程時間二維陣列生成表格
        for i in range(10):
            table += "<tr>"
            table += "<td>{}</td>".format(i + 1)  # 節次
            for j in range(7):
                course_info = timetable[i][j]
                if course_info:
                    course_id, course_name = course_info
                    # 顯示課程名稱和退選按鈕
                    table += "<td>{}</br><form action='/withdraw' method='post'><input type='hidden' name='student_id' value='{}'><input type='hidden' name='course_id' value='{}'><input type='submit' value='退選'></form></td>".format(course_name, student_id, course_id)
                else:
                    table += "<td></td>"
            table += "</tr>"
    else:
        table += "<p>查無此學號</p>"

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()

    return table


@app.route('/withdraw', methods=['POST'])
def withdraw_course():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    # 取得請求中的學號和課程ID
    course_id = request.form.get("course_id")

    # 建立資料庫連線
    conn = connect_to_database()

    # 創建游標
    cursor = conn.cursor()

    result = '''<p><a href="/">回首頁</a></p>'''

    # 檢查退選後學分是否低於最低學分限制
    query_credit = "SELECT SUM(credits) FROM course_enroll ce JOIN course c ON ce.course_id = c.course_id WHERE student_id = %s;"
    cursor.execute(query_credit, (student_id,))
    total_credits = cursor.fetchone()[0]

    query_course_credit = "SELECT credits FROM course WHERE course_id = %s;"
    cursor.execute(query_course_credit, (course_id,))
    course_credits = cursor.fetchone()[0]

    if total_credits - course_credits < 9:
        cursor.close()
        conn.close()
        result += "不能低於9學分"
        return result

    # 如果該課程是必修課，則提出警告
    query_requirement = "SELECT requirement_course FROM course WHERE course_id = %s;"
    cursor.execute(query_requirement, (course_id,))
    requirement_course = cursor.fetchone()[0]

    if requirement_course == '1':
        result += "Warning: This course is a required course. Are you sure you want to withdraw?"

    # 從課程選課表中刪除該課程
    query_withdraw = "DELETE FROM course_enroll WHERE student_id =%sAND course_id = %s;"
    cursor.execute(query_withdraw, (student_id, course_id))
    conn.commit()

    cursor.close()
    conn.close()

    result += "Success: Course withdrawn successfully."
    return result

if __name__ == '__main__':
    app.run(debug=True)
