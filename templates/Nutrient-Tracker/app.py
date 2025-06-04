# from flask import Flask, render_template, g, request
# from datetime import datetime
# import sqlite3

# app = Flask(__name__)

# def connect_db():
#     sql = sqlite3.connect(r'database.db')
#     sql.row_factory = sqlite3.Row
#     return sql


# def get_db():
#     if not hasattr(g, 'sqlite_db'):
#         g.sqlite_db = connect_db()
#     return g.sqlite_db

# @app.teardown_appcontext
# def close_db(error):
#     if hasattr(g, 'sqlite_db'):
#         g.sqlite_db.close()



# @app.route('/', methods = ["POST", "GET"])
# def home():
#     db = get_db()
#     if request.method == "POST":
#         if 'date-btn' in request.form:
#             date = request.form['date']
#             dt = datetime.strptime(date, '%Y-%m-%d')
#             database_date = datetime.strftime(dt, '%Y%m%d')
#             print(database_date)
#             db.execute('insert into log_date (entry_date) values(?)', [database_date])
#             db.commit()

#         elif 'food-btn' in request.form:
#             name = (request.form['food-name'])
#             fat = int(request.form['fat'])
#             carbs = int(request.form['carbs'])
#             protein = int(request.form['protein'])
#             calories = protein * 4 + carbs * 4 + fat * 9
#             db.execute(
#                 """ 
#                 insert into food (name, fat, protein, carbs, calories) 
#                 values (?, ?, ?, ?, ?)
#                 """,
#                 [name, fat, protein, carbs, calories]
#             )
#             db.commit()

#             cur = db.execute('select name, protein, carbs, fat, calories from food')
#             results = cur.fetchall()
#             return render_template('foods.html', results = results)

    
#     cur = db.execute(
#         """ 
#         select log_date.entry_date, 
#         sum(food.protein) as protein, sum(food.carbs) as carbs, sum(food.fat) as fat, sum(food.calories) as calories 
#         from log_date 
#         left join food_date on food_date.log_date_id = log_date.id
#         left join food on food.id = food_date.food_id
#         group by log_date.id order by log_date.entry_date desc
#         """
#     )
#     results = cur.fetchall()
#     print(results)
#     date_results_all = []

#     for i in results:
#         single_date = {}
#         single_date['entry_date'] = i['entry_date']
#         single_date['protein'] = i['protein']
#         single_date['carbs'] = i['carbs']
#         single_date['fat'] = i['fat']
#         single_date['calories'] = i['calories']

#         d = datetime.strptime(str(i['entry_date']), '%Y%m%d')
#         single_date['readable_date'] = datetime.strftime(d, "%B %d, %Y")
#         date_results_all.append(single_date)            

#     return render_template('home.html', results = date_results_all)


# @app.route('/food-details')
# def foodDetails():
#     db = get_db()
#     cur = db.execute('select name, protein, carbs, fat, calories from food')
#     results = cur.fetchall()
#     return render_template('foods.html', results = results)


# @app.route('/view/<date>', methods = ["GET", "POST"])
# def view(date):

#     db = get_db()
#     cur = db.execute("select id, entry_date from log_date where entry_date = ?", [date])
#     date_result = cur.fetchone()
#     if request.method == "POST":
#         db.execute('insert into food_date (food_id, log_date_id) values (?, ?)', [request.form['food-selected'], date_result['id']])
#         db.commit()

#     d = datetime.strptime(str(date_result['entry_date']), '%Y%m%d')
#     readable_date = datetime.strftime(d, '%B %d, %Y')

#     food_cur = db.execute('select id, name from food')
#     food_results = food_cur.fetchall()

#     log_cur = db.execute(
#         """ 
#         select food.name, food.protein, food.carbs, food.fat, food.calories from log_date
#         join food_date on food_date.log_date_id = log_date.id
#         join food on food.id = food_date.food_id
#         where log_date.entry_date = ?
#         """,
#         [date]
#     )
#     log_results = log_cur.fetchall()


#     totals = {}
#     totals['protein'] = 0
#     totals['carbs'] = 0
#     totals['fat'] = 0
#     totals['calories'] = 0

#     for food in log_results:
#         totals['protein'] += food['protein']
#         totals['carbs'] += food['carbs']
#         totals['fat'] += food['fat']
#         totals['calories'] += food['calories']

#     return render_template('view.html', entry_date=date_result['entry_date'], readable_date = readable_date, \
#                            food_results=food_results, log_results=log_results, totals = totals)
    

# if __name__ == "__main__":
#     app.run(debug=True)

from flask import Flask, jsonify, render_template, request, redirect, url_for, session, flash
from datetime import datetime
from flask_mysqldb import MySQL
from functools import wraps

app = Flask(__name__, static_url_path="/static")
app.secret_key = "client id"

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'kamal'
app.config['MYSQL_DB'] = 'food_delivery_system'
mysql = MySQL(app)

@app.route('/tracker', methods=["POST", "GET"])
def home1():
    cur = mysql.connection.cursor()

    if request.method == "POST":
        if 'date-btn' in request.form:
            date = request.form['date']
            dt = datetime.strptime(date, '%Y-%m-%d')
            database_date = datetime.strftime(dt, '%Y%m%d')
            cur.execute('INSERT INTO log_date (entry_date) VALUES (%s)', [database_date])
            mysql.connection.commit()

        elif 'food-btn' in request.form:
            name = request.form['food-name']
            fat = int(request.form['fat'])
            carbs = int(request.form['carbs'])
            protein = int(request.form['protein'])
            calories = protein * 4 + carbs * 4 + fat * 9

            cur.execute(
                """
                INSERT INTO food (name, fat, protein, carbs, calories)
                VALUES (%s, %s, %s, %s, %s)
                """,
                (name, fat, protein, carbs, calories)
            )
            mysql.connection.commit()

            cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
            results = cur.fetchall()

            return render_template('foods.html', results=results)

    cur.execute(
        """
        SELECT log_date.entry_date,
               SUM(food.protein) AS protein,
               SUM(food.carbs) AS carbs,
               SUM(food.fat) AS fat,
               SUM(food.calories) AS calories
        FROM log_date
        LEFT JOIN food_date ON food_date.log_date_id = log_date.id
        LEFT JOIN food ON food.id = food_date.food_id
        GROUP BY log_date.id
        ORDER BY log_date.entry_date DESC
        """
    )
    results = cur.fetchall()
    date_results_all = []

    for i in results:
        single_date = {
            'entry_date': i[0],
            'protein': i[1],
            'carbs': i[2],
            'fat': i[3],
            'calories': i[4],
            'readable_date': datetime.strptime(str(i[0]), '%Y-%m-%d').strftime('%B %d, %Y')
        }
        date_results_all.append(single_date)

    return render_template('home1.html', results=date_results_all)

@app.route('/food-details')
def foodDetails():
    cur = mysql.connection.cursor()
    cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
    # results = cur.fetchall()

    rows = cur.fetchall()

    results = [
        {'name': r[0], 'protein': r[1], 'carbs': r[2], 'fat': r[3], 'calories': r[4]}
        for r in rows
    ]
    return render_template('foods.html', results=results)

@app.route('/view/<date>', methods=["GET", "POST"])
def view(date):
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, entry_date FROM log_date WHERE entry_date = %s", [date])
    date_result = cur.fetchone()

    if request.method == "POST":
        cur.execute('INSERT INTO food_date (food_id, log_date_id) VALUES (%s, %s)', [request.form['food-selected'], date_result[0]])
        mysql.connection.commit()
            # 'readable_date': datetime.strptime(str(i[0]), '%Y-%m-%d').strftime('%B %d, %Y')

    readable_date = datetime.strptime(str(date_result[1]), '%Y-%m-%d').strftime('%B %d, %Y')

    cur.execute('SELECT id, name FROM food')
    food_result = cur.fetchall()
    food_results = [{'id': row[0], 'name': row[1]} for row in food_result]
    cur.execute(
        """
        SELECT food.name, food.protein, food.carbs, food.fat, food.calories
        FROM log_date
        JOIN food_date ON food_date.log_date_id = log_date.id
        JOIN food ON food.id = food_date.food_id
        WHERE log_date.entry_date = %s
        """,
        [date]
    )
    log_results = cur.fetchall()

    totals = {'protein': 0, 'carbs': 0, 'fat': 0, 'calories': 0}
    for food in log_results:
        totals['protein'] += food[1]
        totals['carbs'] += food[2]
        totals['fat'] += food[3]
        totals['calories'] += food[4]
    # print("entry_date:", entry_date)
    # print("readable_date:", readable_date)
    # print("food_results:", food_results)
    # print("log_results:", log_results)
    # print("totals:", totals)


    return render_template('view.html', entry_date=date_result[1], readable_date=readable_date,
                           food_results=food_results, log_results=log_results, totals=totals)

if __name__ == '__main__':
    app.run(debug=True)