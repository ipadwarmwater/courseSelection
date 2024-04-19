from flask import Flask, request, session ,redirect, render_template
import MySQLdb

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

def connect_to_database():
    return MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="courseselection")

@app.route('/')
def index():
    if 'student_id' not in session:
        return render_template('loginPage.html')
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


@app.route('/logout', methods=['GET', 'POST'])
def logout():
    
    session.pop('student_id', None)
    session.pop('logged_in', None)

    return redirect('/')

@app.route('/home')
def home():
    return render_template('homePage.html')


@app.route('/browse', methods=['GET', 'POST'])
def search():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']

    # 建立資料庫連線
    conn = connect_to_database()
    
    # 創建游標
    cursor = conn.cursor()
    
    # 查詢所有課程表
    query = "SELECT course.course_id, course.course_name, course.department, course.grade, course.credits, course.capacity, count(course_enroll.course_id), course.requirement_course  FROM course left join course_enroll on course.course_id = course_enroll.course_id group by course.course_id;"
    cursor.execute(query)
    courses = cursor.fetchall()

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()
    
    return render_template('browsePage.html', student_id=student_id, courses=courses)

# 可選課表
@app.route('/elective_courses', methods=['GET', 'POST'])
def elective():
    if 'student_id' not in session:
        return redirect("/")
        
    student_id = session['student_id']

    # 建立資料庫連線
    conn = connect_to_database()
        
    # 創建游標
    cursor = conn.cursor()
        
    # 查詢所有課程表
    query = "SELECT course_id, course_name, department, grade, credits, capacity, requirement_course FROM course WHERE department = (SELECT department FROM student WHERE student_id = %s) OR department = 'General Eudcation';"
    cursor.execute(query, (student_id,))
    courses = cursor.fetchall()

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()
        
    return render_template('electiveCoursesPage.html', courses=courses, student_id=student_id)


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

    message = ""  # 初始化消息變數
    
    # 檢查是否衝堂
    query_student_schedule = """
        SELECT cs.weekday, cs.period 
        FROM course_schedule cs 
        INNER JOIN course_enroll ce ON cs.course_id = ce.course_id 
        WHERE ce.student_id = %s;
    """
    cursor.execute(query_student_schedule, (student_id,))
    student_schedule = cursor.fetchall()

    query_course_schedule = """
        SELECT weekday, period 
        FROM course_schedule 
        WHERE course_id = %s;
    """
    cursor.execute(query_course_schedule, (course_id,))
    course_schedule = cursor.fetchall()

    # 比較學生已選課程時間與欲選課程時間
    for student_time in student_schedule:
        for course_time in course_schedule:
            if student_time == course_time:
                cursor.close()
                conn.close()
                message = "錯誤：衝堂 " + str(student_time[0]+1)
                return render_template('EnrollPage.html', message=message)

    # 檢查學生是否已選這堂課
    query_select = "SELECT COUNT(*) FROM course_enroll WHERE course_id = %s AND student_id = %s"
    cursor.execute(query_select, (course_id, student_id))
    count = cursor.fetchone()[0]
    if count > 0:
        message = "錯誤：已選此課程"
        return render_template('enrollPage.html', message=message)

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
        message = "錯誤：超過學分上限(30學分)"
        return render_template('EnrollPage.html', message=message)

    # 檢查課程與學生是否同科系
    query_department = "SELECT department FROM student WHERE student_id = %s;"
    cursor.execute(query_department, (student_id,))
    student_department_result = cursor.fetchone()
    if student_department_result is None:
        cursor.close()
        conn.close()
        message = "錯誤：查無此人"
        return render_template('EnrollPage.html', message=message)

    student_department = student_department_result[0]

    query_course_department = "SELECT department FROM course WHERE course_id = %s;"
    cursor.execute(query_course_department, (course_id,))
    course_department = cursor.fetchone()[0]

    if student_department != course_department and course_department != 'General Eudcation':
        cursor.close()
        conn.close()
        message = "錯誤：學生和課程分屬不同系所"
        return render_template('EnrollPage.html', message=message)

    # 加選
    query_enroll = "INSERT INTO course_enroll (student_id, course_id) VALUES (%s,%s);"
    cursor.execute(query_enroll, (student_id, course_id))
    conn.commit()

    #計算學分數

    query_s_credit = "UPDATE student INNER JOIN (SELECT student.student_id, SUM(course.credits) AS total_credits FROM student INNER JOIN course_enroll ON student.student_id = course_enroll.student_id INNER JOIN course ON course_enroll.course_id = course.course_id GROUP BY student.student_id ) AS new_credits ON student.student_id = new_credits.student_id SET student.credit = new_credits.total_credits;"
    cursor.execute(query_s_credit)
    conn.commit()

    cursor.close()
    conn.close()

    message = "成功：課程加選成功"
    return render_template('EnrollPage.html', message=message)

@app.route('/student_table_show', methods=['POST', 'GET'])
def student_table_show():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    # 建立資料庫連線
    conn = connect_to_database()
    
    # 欲查詢的 query 指令
    query = "SELECT * FROM student WHERE student_id = %s;"
    # 執行查詢
    cursor = conn.cursor()
    cursor.execute(query, (student_id,))
    student_data = cursor.fetchall()

    timetable = [["" for _ in range(8)] for _ in range(10)]

    # 如果學生存在，則繼續查詢課表
    if student_data:
        query = """
        SELECT course_schedule.weekday, course_schedule.period, course.course_name 
        FROM course_schedule 
        INNER JOIN course ON course_schedule.course_id = course.course_id 
        WHERE course_schedule.course_id IN (SELECT course_id FROM course_enroll WHERE student_id = %s);
        """ 
        cursor.execute(query, (student_id,))
        
        # 將查詢結果填入課程時間二維陣列
        for row in cursor.fetchall():
            weekday = row[0]  # 星期
            period = row[1]   # 節次
            course_name = row[2]  # 課程名稱
            timetable[period - 1][weekday] = course_name

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()

    return render_template('studentTimeTablePage.html', student_data=student_data, timetable=timetable)


@app.route('/student_table_deleteshow', methods=['GET', 'POST'])
def student_table_deleteshow():
    if 'student_id' not in session:
        return redirect("/")
    
    student_id = session['student_id']
    
    # 建立資料庫連線
    conn = connect_to_database()
    
    # 欲查詢的 query 指令
    query = "SELECT * FROM student WHERE student_id = %s;"
    # 執行查詢
    cursor = conn.cursor()
    cursor.execute(query, (student_id,))
    student_data = cursor.fetchall()

    timetable = [["" for _ in range(8)] for _ in range(10)]

    # 如果學生存在，則繼續查詢課表
    if student_data:
        query = """
        SELECT ce.course_id, course_schedule.weekday, course_schedule.period, course.course_name 
        FROM course_schedule 
        INNER JOIN course ON course_schedule.course_id = course.course_id 
        INNER JOIN course_enroll ce ON course_schedule.course_id = ce.course_id
        WHERE ce.student_id = %s;
        """ 
        cursor.execute(query, (student_id,))
        
        # 將查詢結果填入課程時間二維陣列
        for row in cursor.fetchall():
            course_id = row[0]  # 課程ID
            weekday = row[1]  # 星期
            period = row[2]   # 節次
            course_name = row[3]  # 課程名稱
            timetable[period - 1][weekday] = (course_id, course_name)  # 存入課程ID和課程名稱的tuple

    # 關閉游標和資料庫連線
    cursor.close()
    conn.close()

    return render_template('studentTableDeleteshow.html', student_data=student_data, timetable=timetable)


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

    result = ''

    # 檢查退選後學分是否低於最低學分限制
    query_credit = "SELECT SUM(credits) FROM course_enroll ce JOIN course c ON ce.course_id = c.course_id WHERE student_id = %s;"
    cursor.execute(query_credit, (student_id,))
    total_credits = cursor.fetchone()[0]

    query_course_credit = "SELECT credits FROM course WHERE course_id = %s;"
    cursor.execute(query_course_credit, (course_id,))
    course_credits_result = cursor.fetchone()

    if course_credits_result is not None:
        course_credits = course_credits_result[0]

        if total_credits - course_credits < 9:
            cursor.close()
            conn.close()
            result += "不能低於9學分"
            return render_template('withdrawPage.html', result=result)
    
        # 取得學生的年級
        query_student_grade = "SELECT grade FROM student WHERE student_id = %s;"
        cursor.execute(query_student_grade, (student_id,))
        student_grade = cursor.fetchone()[0]

        # 如果該課程是必修課，則提出警告
        query_requirement = "SELECT requirement_course, grade FROM course WHERE course_id = %s;"
        cursor.execute(query_requirement, (course_id,))
        requirement_course, course_grade = cursor.fetchone()

        if requirement_course == 1 and student_grade == course_grade:
            result += "這門課是必修，退選後果自負..."

        # 從課程選課表中刪除該課程
        query_withdraw = "DELETE FROM course_enroll WHERE student_id =%s AND course_id = %s;"
        cursor.execute(query_withdraw, (student_id, course_id))

        #計算學分數
        query_s_credit = "UPDATE student INNER JOIN (SELECT student.student_id, SUM(course.credits) AS total_credits FROM student INNER JOIN course_enroll ON student.student_id = course_enroll.student_id INNER JOIN course ON course_enroll.course_id = course.course_id GROUP BY student.student_id ) AS new_credits ON student.student_id = new_credits.student_id SET student.credit = new_credits.total_credits;"
        cursor.execute(query_s_credit)

        conn.commit()

        cursor.close()
        conn.close()

        result += "退選成功"
    else:
        result += "課程不存在"

    return render_template('WithdrawPage.html', result=result)



if __name__ == '__main__':
    app.run(debug=True)
