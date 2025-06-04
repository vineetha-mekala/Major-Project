from flask import flash
from datetime import datetime, timedelta,date
import json
import time
import MySQLdb
from flask import Flask,jsonify,render_template,request,redirect,url_for,session
import flask
import random
from flask_mysqldb import MySQL
from functools import wraps
# import MySQLdb

app = Flask(__name__,static_url_path="/static")
app.secret_key = "client id"
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Vineetha@Vmtw123'
app.config['MYSQL_DB'] = 'food_delivery_system'
mysql = MySQL(app)


@app.route('/indexs')
def indexs():
    return render_template('index.html')

# Decorator function to check if user is logged in
def login_rest(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'restaurant_ID' not in session:
            # Redirect to login page if user is not logged in
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def login_cust(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'customer_id' not in session:
            # Redirect to login page if user is not logged in
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def login_agent(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'agent_ID' not in session:
            # Redirect to login page if user is not logged in
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

# login for all
@app.route('/login',methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'useremail' in request.form and 'password' in request.form and 'authority' in request.form:
        useremail = request.form['useremail']
        password = request.form['password']
        authority = request.form['authority']
        session['addr_ID'] = None
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        if (authority == "Customer"):
            if("'" in useremail):
                msg = "Single Quote (') is not allowed in username field."
                flask.flash(msg)
                return redirect(url_for('login'))
            cursor.execute("SELECT * FROM Customers WHERE contact_details->>'$.email' = %s AND password = %s", (useremail, password,))
            account = cursor.fetchone()
            if account:
                session['customerbool'] = True
                session['restbool'], session['agentbool'] = False, False
                session['customer_id'] = str(account['customer_id'])
                cursor.execute("select address_ID from customer_address where customer_id=%s", (session['customer_id'],))
                addr_ID = cursor.fetchall()
                session['addr_ID'] = addr_ID[0]
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('index'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        elif (authority == "Delivery Agent"):
            cursor.execute("SELECT * FROM delivery_agent WHERE email = %s AND password = %s", (useremail, password, ))
            account = cursor.fetchone()
            if account:
                session['agentbool'] = True
                session['cutomerbool'], session['restbool'] = False, False
                session['agent_ID'] = account['agent_id']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('index_deliveryagent'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        elif (authority == "Restaurant"):
            cursor.execute("SELECT * FROM Restaurant WHERE email = %s AND password = %s", (useremail, password, ))
            # cursor.execute(f"SELECT * FROM restaurant WHERE email='{useremail}' AND password='{password}'")
            account = cursor.fetchone()
            if account:
                session['restbool'] = True
                session['agentbool'], session['customerbool'] = False, False
                session['restaurant_ID'] = account['restaurant_id']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('restaurant_details'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        else:
            time.sleep(2)
            msg = 'Incorrect username / password !'
        flask.flash(msg)
    return render_template('login.html', msg = msg)

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    return render_template('signup.html')



@app.route('/signupcustomer',methods=['GET', 'POST'])
def signupcustomer():
    if request.method == 'POST':
        userdetails = request.form
        firstname = userdetails['firstname']
        middle_name = userdetails['middlename']
        lastname = userdetails['lastname']
        email = userdetails['email']
        DOB = userdetails['DOB']
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        building_name = userdetails['building_name']
        street_name = userdetails['street_name']
        city = userdetails['cityname']
        state = userdetails['statename']
        pin_code = userdetails['pincode']
        cur = mysql.connection.cursor()
        cur.execute("select max(customer_id) from customers")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.execute("SELECT * FROM Address WHERE building_name=%s and street=%s and city=%s and state=%s and pin_code=%s",(building_name,street_name,city,state,pin_code))
        address_ID = cur.fetchone()
        try:
            if address_ID is None:
                cur.execute("select max(address_id) from Address")
                address_ID = cur.fetchone()
                address_ID = str(int(address_ID[0]) + 1)
                cur.execute("INSERT INTO Address (address_id, building_name, street, pin_code, city, state) VALUES (%s,%s,%s,%s,%s,%s)",(address_ID,building_name,street_name,pin_code,city,state))
            else:
                address_ID = address_ID[0]
             # Calculate age from DOB
            dob = datetime.strptime(DOB, '%Y-%m-%d')
            age = (datetime.now() - dob).days // 365

            cur.execute("INSERT INTO customers(customer_id, first_name, middle_name, last_name, dob, age, contact_details, password) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(ID,firstname,middle_name,lastname,DOB,age,json.dumps({'email': email, 'phone': phone_number}),password))
            cur.execute("INSERT INTO Customer_Address (customer_id, address_id) VALUES (%s,%s)",(ID,address_ID))
            mysql.connection.commit()
        except:
            mysql.connection.rollback()
        finally:
            cur.close()
        mysql.connection.commit()
        flask.flash('Customer successfully registered')
        return redirect(url_for('login'))
    return render_template("/customers/signup_user.html")


@app.route('/signuprestaurants',methods=['GET', 'POST'])
def signuprestaurants():
    if request.method == 'POST':
        userdetails = request.form
        restaurant_name = userdetails['restaurant_name']
        cuisine_type = userdetails['cuisine_type']

        if cuisine_type == "null":
            msg = 'Please select a cuisine type'
            flask.flash(msg)
            return render_template('/restaurants/signup_restaurant.html', msg = msg)
        
        email = userdetails['email']
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        building_name = userdetails['building_name']
        street_name = userdetails['street_name']
        city = userdetails['cityname']
        state = userdetails['statename']
        pin_code = userdetails['pincode']
        account_number = userdetails['account_number']
        ifsc_code = userdetails['ifsc_code']
        bank_name = userdetails['bank_name']
        timings = userdetails['timing']
        cur = mysql.connection.cursor()
        cur.execute("select max(restaurant_id) from Restaurant")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.execute("SELECT * FROM Address WHERE building_name=%s and street=%s and city=%s and state=%s and pin_code=%s",(building_name,street_name,city,state,pin_code))
        address_ID = cur.fetchone()
        try:
            if address_ID is None:
                cur.execute("select max(address_id) from Address")
                address_ID = cur.fetchone()
                address_ID = str(int(address_ID[0]) + 1)
                cur.execute("INSERT INTO Address (address_id, building_name, street, pin_code, city, state) VALUES (%s,%s,%s,%s,%s,%s)",(address_ID,building_name,street_name,pin_code,city,state))
            else:
                address_ID = address_ID[0]
            cur.execute("INSERT INTO Restaurant (password, restaurant_id, restaurant_name, cuisine_type, email, phone, timings, rating, balance_earned, account_no, IFSC_code, bank_name) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(password, ID, restaurant_name, cuisine_type, email, phone_number,timings, 0, 0, account_number, ifsc_code, bank_name))
            cur.execute("INSERT INTO Restaurant_Address (restaurant_id, address_id) VALUES (%s,%s)",(ID,address_ID))
            mysql.connection.commit()
        except:
            mysql.connection.rollback()
        finally:
            cur.close()
        mysql.connection.commit()
        flask.flash('Restaurant successfully registered')
        return redirect(url_for('login'))
    return render_template("/restaurants/signup_restaurant.html")

# as a delivery person
@app.route('/signupdelivery',methods=['GET', 'POST'])
def signupdelivery():
    if request.method == 'POST':
        userdetails = request.form
        firstname = userdetails['firstname']
        middle_name = userdetails['middlename']
        lastname = userdetails['lastname']
        email = userdetails['email']
        DOB = userdetails['DOB']
        vehicle_number = userdetails['vehicle_number']  
        l_id = userdetails['license_id']
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        location = userdetails['location']
        cur = mysql.connection.cursor()
        cur.execute("select max(agent_id) from Delivery_Agent")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.execute("""
            INSERT INTO Delivery_Agent (agent_id, vehicle_number, agent_name, phone_num, email, location, password, dob, availability, license_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (ID, vehicle_number, firstname + " " + middle_name + " " + lastname, phone_number, email, location, password, DOB, 1, l_id))
        mysql.connection.commit()
        flask.flash('Delivery Agent successfully registered')
        return redirect(url_for('login'))
    return render_template("/delivery/signup_deli.html")
    
    
@app.route('/signout')
def signout():
    session.pop('customer_id', None)
    session.pop('restaurant_ID', None)
    session.pop('agent_ID', None)
    session.pop('addr_ID', None)
    session.pop('customerbool', None)
    session.pop('restbool', None)
    session.pop('agentbool', None)
    return redirect(url_for('home'))

@app.route('/')
def home():
    session.pop('customer_id', None)
    session.pop('restaurant_ID', None)
    session.pop('agent_ID', None)
    session.pop('addr_ID', None)
    session.pop('customerbool', None)
    session.pop('restbool', None)
    session.pop('agentbool', None)
    return render_template('home.html')

@app.route('/dashboard')
@login_cust
def index():
    cur = mysql.connection.cursor()

    # Execute first query to fetch data from the 'users' table
    cur.execute('SELECT * FROM customers')
    users_data = cur.fetchall()
    user_columns = [col[0] for col in cur.description]
    users = [dict(zip(user_columns, row)) for row in users_data]

    # Execute second query to fetch data from the 'restaurant' table
    cur.execute('SELECT distinct cuisine_type FROM restaurant')
    restaurant_data = cur.fetchall()
    restaurant_columns = [col[0] for col in cur.description]
    cuisines = [dict(zip(restaurant_columns, row)) for row in restaurant_data]

    return render_template("/customers/index.html", users=users, cuisines=cuisines)

def fetch_food_item_from_database(item_id):
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT *
        FROM food_item
        WHERE item_id = %s
    ''', (item_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]
    return food_items

@app.route('/restaurants/<cuisine_type>')
@login_cust
def restaurants_by_cuisine(cuisine_type):
    cur = mysql.connection.cursor()

    # Execute query to fetch restaurants by cuisine type
    cur.execute('SELECT * FROM restaurant WHERE cuisine_type = %s', (cuisine_type,))
    restaurant_data = cur.fetchall()
    restaurant_columns = [col[0] for col in cur.description]
    restaurants = [dict(zip(restaurant_columns, row)) for row in restaurant_data]

    return render_template("/customers/restaurants.html", cuisine_type=cuisine_type, restaurants=restaurants)

@app.route('/restaurants/<cuisine_type>/<restaurant_id>')
@login_cust
def restaurant_menu(restaurant_id, cuisine_type):
    cur = mysql.connection.cursor()
    cur.execute('''
    SELECT *
    FROM food_item 
    JOIN restaurant ON food_item.restaurant_id = restaurant.restaurant_id 
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]

    cur.execute('''
    SELECT restaurant_name
    from restaurant
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id,))
    restaurant_name_data = cur.fetchall()
    restaurant_name_columns = [col[0] for col in cur.description]
    restaurant_name = [dict(zip(restaurant_name_columns, row)) for row in restaurant_name_data]
    # print(food_items)

    return render_template("/customers/menu.html",food_items=food_items,restaurant_name=restaurant_name)

@app.route('/review_submission/<restaurant_name>/<item_name>/<item_orders>/<ori_item_rating>', methods=['GET', 'POST'])
@login_cust
def review_submission(restaurant_name, item_name, item_orders, ori_item_rating):
    if request.method == 'POST':
        restaurant_name = restaurant_name[22:][:-3]
        new_review = request.form['restaurant-review']
        item_rating = request.form['item-rating']

        if int(item_orders) < 1:
            item_orders = 1

        new_item_rating = (float(ori_item_rating)*int(item_orders) + float(item_rating)) / (int(item_orders) + 1)
        new_item_rating = float(round(new_item_rating, 2))
        
        cur = mysql.connection.cursor()

        cur.execute('''
            SELECT review
            FROM Restaurant
            WHERE restaurant_name = %s
        ''', (restaurant_name,))

        old_review = cur.fetchone()

        if old_review[0] == None:
            new_restaurant_review = new_review

        else:
            new_restaurant_review = old_review[0] + "; " + new_review

        cur.execute('''
            SELECT rating
            FROM Restaurant
            WHERE restaurant_name = %s
        ''', (restaurant_name,))

        old_restaurant_rat = cur.fetchone()
        # print(old_restaurant_rat[0])
        new_restaurant_rat = (float(old_restaurant_rat[0])*int(item_orders) + float(item_rating)) / (int(item_orders) + 1)

        cur.execute('''
            UPDATE Restaurant
            SET review = %s
            WHERE restaurant_name = %s
        ''', (new_restaurant_review, restaurant_name))

        mysql.connection.commit()

        # Update the food_item table with the submitted item rating
        cur.execute('''
            UPDATE Food_Item
            SET item_rating = %s
            WHERE item_name = %s
        ''', (new_item_rating, item_name))
        
        mysql.connection.commit()

        cur.execute('''
            UPDATE Restaurant
            SET rating = %s
            WHERE restaurant_name = %s
        ''', (new_restaurant_rat, restaurant_name))
        
        mysql.connection.commit()
        
        cur.close()

    # Render the review submission template and pass restaurant_id to the template
    return render_template("/customers/review_submission.html") 


@app.route('/restaurant')
@login_rest
def restaurant_details():
    cur = mysql.connection.cursor()
    restaurant_id = session["restaurant_ID"]
    # Fetch restaurant details
    cur.execute('''
    SELECT *
    FROM restaurant
    WHERE restaurant_id = %s
    ''', (restaurant_id,))
    restaurant_details_data = cur.fetchone()
    restaurant_details_columns = [col[0] for col in cur.description]
    restaurant_details = dict(zip(restaurant_details_columns, restaurant_details_data))

    # Fetch order details
    cur.execute('''
    SELECT
       o.order_id,
       GROUP_CONCAT(oi.item_quantity) AS item_quantities,
       GROUP_CONCAT(oi.notes) AS notes,
       GROUP_CONCAT(fi.item_name) AS item_names,
       SUM(fi.item_price) AS total_price,
       AVG(fi.item_rating) AS avg_food_rating,
       o.order_status,
       o.placed_time,
       o.amount
    FROM orders o
    JOIN ordered_items oi ON o.order_id = oi.order_id
    JOIN food_item fi ON oi.item_id = fi.item_id
    WHERE fi.restaurant_id = %s
    GROUP BY o.order_id;
    ''', (restaurant_id,))
    order_details_data = cur.fetchall()
    order_details_columns = [col[0] for col in cur.description]
    order_details = [dict(zip(order_details_columns, row)) for row in order_details_data]
    

    cur.execute('''
    SELECT *
    FROM food_item 
    JOIN restaurant ON food_item.restaurant_id = restaurant.restaurant_id 
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]

    
    return render_template("/restaurants/details.html", restaurant_details=restaurant_details, order_details=order_details,menu=food_items)
@app.route('/restaurant/add_item', methods=['GET', 'POST'])
@login_rest
def add_item():
    if request.method == 'POST':
        # Fetch form data
        item_name = request.form['item_name']
        item_price = float(request.form['item_price'])
        item_type = request.form['item_type']
        item_img = request.form['item_img']
        vegetarian = True if request.form.get('vegetarian') else False
        availability = True if request.form.get('availability') else False
        restaurant_id = session["restaurant_ID"]
        cursor = mysql.connection.cursor()
        cursor.execute('select max(item_id) from food_item;')
        item_ID = cursor.fetchone()
        item_ID = str(int(item_ID[0]) + 1)
        # order_count = 0
        # Insert food item details into the database
        cur = mysql.connection.cursor()
        cur.execute('''
            INSERT INTO food_item (item_id,item_name, item_price, item_type, vegetarian, availability, restaurant_id, photo_url, item_rating)
            VALUES (%s,%s, %s, %s, %s, %s, %s, %s, %s)
        ''', (item_ID, item_name, item_price, item_type, vegetarian, availability, restaurant_id, item_img, 0))
        mysql.connection.commit()
        
        # Redirect the user back to the menu page after adding the new item
        return redirect(url_for('restaurant_details'))
    # return render_template('restaurants/details.html')
    else:
        return render_template('restaurants/add_item.html')
    
@app.route('/delete_item/<item_id>')  
@login_rest
def delete_item(item_id):
    cur = mysql.connection.cursor()
    cur.execute('''
        DELETE FROM food_item
        WHERE item_id = %s
    ''', (item_id,))
    mysql.connection.commit()
    return redirect(url_for('restaurant_details'))

@app.route('/restaurant/editmenu/<item_id>', methods=['GET', 'POST'])
@login_rest
def edit_menu(item_id):
    if request.method == 'POST':
        # Fetch form data
        new_item_name = request.form['item_name']
        new_item_price = float(request.form['item_price'])
        new_item_type = request.form['item_type']
        new_item_img = request.form['item_img']
        new_vegetarian = True if request.form.get('vegetarian') else False
        new_availability = True if request.form.get('availability') else False
        
        # Update food item details in the database
        cur = mysql.connection.cursor()
        cur.execute('''
            UPDATE food_item
            SET item_name = %s, item_price = %s, item_type = %s, photo_url = %s, vegetarian = %s, availability = %s
            WHERE item_id = %s
        ''', (new_item_name, new_item_price, new_item_type, new_item_img, new_vegetarian, new_availability, item_id))
        mysql.connection.commit()
        
        # Redirect the user back to the menu page after editing
        return redirect(url_for('restaurant_details'))  # Assuming 'menu' is the route for displaying the menu
    else:
        # Fetch the details of the food item with the given item_id from the database
        food_item = fetch_food_item_from_database(item_id)
        return render_template('restaurants/edit_menu.html', food_item=food_item)

@app.route('/userdetails')
@login_cust
# should contain some details of the user like account details, address, and orders made by the user
def userdetails():
    customer_id = session.get('customer_id')
    cur = mysql.connection.cursor()
    cur.execute('''
    SELECT *
    FROM Customers
    WHERE customer_id = %s
    ''', (customer_id,))
    user_data = cur.fetchall()
    user_columns = [col[0] for col in cur.description]
    user = [dict(zip(user_columns, row)) for row in user_data]

    cur.execute('''
    SELECT *
    FROM customer_address
    JOIN Address ON customer_address.address_id = Address.address_id
    WHERE customer_address.customer_id = %s
    ''', (customer_id,))
    address_data = cur.fetchall()
    address_columns = [col[0] for col in cur.description]
    address = [dict(zip(address_columns, row)) for row in address_data]

    cur.execute('''
    SELECT *
    FROM Orders
    WHERE customer_id = %s
    ''', (customer_id,))
    order_data = cur.fetchall()
    order_columns = [col[0] for col in cur.description]
    orders = [dict(zip(order_columns, row)) for row in order_data]

    order_ids = [order['order_id'] for order in orders]

    # once you have order_id we see the relation Ordered_items (order_id, item_id, item_quantity, item_rating, item_review, notes)
    # this relation is many to many relations between orders and food_items
    # so for one order_id we can have multiple food_items
    # by order_id we get item_id and then we can get the food_item details from food_item table

    food_items = []  # list of dictionaries which contain order_id and food_items corresponding to that order_id
    for order_id in order_ids:
        cur.execute('''
        SELECT *
        FROM Ordered_items
        WHERE order_id = %s
        ''', (order_id,))
        ordered_items_data = cur.fetchall()
        ordered_items_columns = [col[0] for col in cur.description]
        ordered_items = [dict(zip(ordered_items_columns, row)) for row in ordered_items_data]

        for item in ordered_items:
            cur.execute('''
            SELECT *
            FROM food_item
            WHERE item_id = %s
            ''', (item['item_id'],))
            food_item_data = cur.fetchall()
            food_item_columns = [col[0] for col in cur.description]
            food_item = [dict(zip(food_item_columns, row)) for row in food_item_data]
            food_items.append({'order_id': order_id, 'food_item': food_item[0]})
    
        # print(orders)
    contact_details = json.loads(user[0]['contact_details'])
    return render_template("/customers/userdetails.html", user=user[0], address=address, orders=orders, food_items=food_items, phone = contact_details.get('phone'), email = contact_details.get('email'))

@app.route('/update_userdetails', methods=['POST'])
@login_cust
def update_userdetails():
    customer_id = session.get('customer_id')

    first_name = request.form.get('first_name')
    middle_name = request.form.get('middle_name')
    last_name = request.form.get('last_name')
    email = request.form.get('email')
    password= request.form.get('password')
    phone = request.form.get('phone')
    dob = request.form.get('dob')

    building_name = request.form.get('building_name')
    street = request.form.get('street')
    city = request.form.get('city')
    pin_code = request.form.get('pin_code')
    state = request.form.get('state')

    cur = mysql.connection.cursor()

    # Update Customers table
    cur.execute('''
        UPDATE Customers
        SET first_name = %s, middle_name = %s, last_name = %s, password = %s, dob = %s, contact_details = %s
        WHERE customer_id = %s
    ''', (first_name, middle_name, last_name, password, dob,  json.dumps({'phone': phone, 'email': email}), customer_id))

    # Update Address table
    cur.execute('''
        UPDATE Address
        JOIN customer_address ON customer_address.address_id = Address.address_id
        SET building_name = %s, street = %s, city = %s, pin_code = %s, state = %s
        WHERE customer_address.customer_id = %s
    ''', (building_name, street, city, pin_code, state, customer_id))

    mysql.connection.commit()
    cur.close()

    flash('Details updated successfully!', 'success')
    return redirect(url_for('userdetails'))


@app.route('/ordersummary', methods=['GET', 'POST'])
@login_cust
def ordersummary():
    # Retrieve values from the request
    rest_id = request.args.get('rest_id')
    payment_method = request.args.get('payment_method')
    payment_status = request.args.get('payment_status')
    ordered_items = json.loads(request.args.get('ordered_items'))
    customer_id = session["customer_id"]
    order_status = "Processing"
    placed_time = datetime.now()
    amount = 0

    # Calculate the total amount based on ordered items
    for item in ordered_items:
        item_ID = item["item_id"]
        item_quantity = item["item_quantity"]
        item_price = item['item_price']
        if item_quantity != "0":
            amount += item_price * int(item_quantity)

    cursor = mysql.connection.cursor()

    # Generate new order_id and payment_id
    cursor.execute('SELECT max(order_id) FROM Orders;')
    order_ID = cursor.fetchone()[0] + 1
    cursor.execute('SELECT max(payment_id) FROM Payment;')
    payment_ID = cursor.fetchone()[0] + 1

    # Generate a random agent_id
    cursor.execute('SELECT max(agent_id) FROM delivery_agent')
    num_delivery_agents = cursor.fetchone()
    agent_id = random.randint(1, int(num_delivery_agents[0]))

    # Update restaurant balance
    cursor.execute('UPDATE restaurant SET balance_earned = balance_earned + %s/10 WHERE restaurant_id = %s;', (amount, rest_id))

    # Insert into payment, orders, and delivery tables
    cursor.execute('INSERT INTO payment (payment_id, payment_method, payment_status, amount, time) VALUES (%s, %s, %s, %s, %s);', (payment_ID, payment_method, payment_status, amount, placed_time))
    cursor.execute('INSERT INTO orders (order_id, customer_id, restaurant_id, payment_id, order_status, placed_time, amount) VALUES (%s, %s, %s, %s, %s, %s, %s);', (order_ID, customer_id, rest_id, payment_ID, order_status, placed_time, amount))
    cursor.execute('INSERT INTO delivery (order_id, agent_id, customer_id, restaurant_id, delivery_review, delivery_rating, delivery_charges, pickup_time, delivery_time, delivery_status, tip) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);', (order_ID, agent_id, customer_id, rest_id, "", random.randint(1, 5), random.randint(1, 9), datetime.now(), datetime.now() + timedelta(minutes=30), "Placed", random.randint(1, 5)))
    
    # Insert ordered items into the ordered_items table
    for item in ordered_items:
        item_ID = item["item_id"]
        item_quantity = item["item_quantity"]
        notes = item["notes"]
        if item_quantity != "0":
            cursor.execute('UPDATE food_item SET order_count = order_count + 1 WHERE item_id = %s;', (item_ID,))
            cursor.execute('INSERT INTO ordered_items (order_id, item_id, item_quantity, item_rating, item_review, notes) VALUES (%s, %s, %s, %s, %s, %s);', (order_ID, item_ID, item_quantity, 4, None, notes))
    
    # Commit changes
    mysql.connection.commit()

    # Fetch order summary data
    # cursor.execute('''
    #     SELECT p.payment_id, p.payment_method, p.amount, o.order_id, oi.item_quantity, fi.item_name
    #     FROM Orders o
    #     JOIN Payment p ON o.payment_id = p.payment_id
    #     JOIN Ordered_Items oi ON o.order_id = oi.order_id
    #     JOIN Food_Item fi ON oi.item_id = fi.item_id
    #     WHERE o.order_id = %s
    # ''', (order_ID,))

    cursor.execute('''
        SELECT p.payment_id, p.payment_method, p.amount, o.order_id, oi.item_quantity, fi.item_name
        FROM Orders o
        JOIN Payment p ON o.payment_id = p.payment_id
        JOIN Ordered_Items oi ON o.order_id = oi.order_id
        JOIN Food_Item fi ON oi.item_id = fi.item_id
        WHERE o.order_id = %s
    ''', (order_ID,))

    order_details = cursor.fetchall()
    order_details_columns = [col[0] for col in cursor.description]
    purchase = [dict(zip(order_details_columns, row)) for row in order_details]# Fetch all the rows from the query

    cursor.close()

    # If order_details is empty, raise an error or return a default response
    if not order_details:
        return "No order details found", 404

    # Render the order summary page with the fetched order details
    return render_template('customers/ordersummary.html', purchase=purchase)




@app.route('/delivery_dashboard', methods=['GET', 'POST'])
@login_agent
def index_deliveryagent():
    agent_id = session.get('agent_ID')
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Delivery WHERE agent_id = %s", (agent_id,))
    delivery_data = cur.fetchall()
    delivery_data_columns = [col[0] for col in cur.description]
    delivery = [dict(zip(delivery_data_columns, row)) for row in delivery_data]

    if not delivery:  # If no deliveries found
        agent_id = session.get('agent_ID')
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM Delivery_Agent WHERE agent_id = %s", (agent_id,))
        agent_data = cur.fetchall()
        agent_columns = [col[0] for col in cur.description]
        agent = [dict(zip(agent_columns, row)) for row in agent_data][0] 
        return render_template('delivery/no_deliveries.html', agent=agent)
    
    for delivery_item in delivery:
        # Fetch customer address
        customer_id = delivery_item['customer_id']
        cur.execute("SELECT a.building_name, a.street, a.pin_code, a.city, a.state FROM Customer_Address ca JOIN Address a ON ca.address_id = a.address_id WHERE ca.customer_id = %s", (customer_id,))
        customer_address_data = cur.fetchone()
        if customer_address_data:
            customer_address = {
                'building_name': customer_address_data[0],
                'street': customer_address_data[1],
                'pin_code': customer_address_data[2],
                'city': customer_address_data[3],
                'state': customer_address_data[4]
            }
        else:
            customer_address = None
        delivery_item['customer_address'] = customer_address
        
        # Fetch restaurant details
        restaurant_id = delivery_item['restaurant_id']
        cur.execute("SELECT a.building_name, a.street, a.pin_code, a.city, a.state FROM restaurant_address r JOIN Address a ON r.address_id = a.address_id WHERE r.restaurant_id = %s", (restaurant_id,))
        restaurant_address_data = cur.fetchone()
        if restaurant_address_data:
            restaurant_address = {
                'building_name': restaurant_address_data[0],
                'street': restaurant_address_data[1],
                'pin_code': restaurant_address_data[2],
                'city': restaurant_address_data[3],
                'state': restaurant_address_data[4]
            }
        else:
            restaurant_address = None
        delivery_item['restaurant_address'] = restaurant_address

        agent_id = session.get('agent_ID')
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM Delivery_Agent WHERE agent_id = %s", (agent_id,))
        agent_data = cur.fetchall()
        agent_columns = [col[0] for col in cur.description]
        agent = [dict(zip(agent_columns, row)) for row in agent_data][0] 
    return render_template('delivery/index.html', delivery=delivery, agent = agent)
    # return render_template('delivery/index.html', delivery=delivery)


# Add this route below your current routes

@app.route('/update_deliverydetails', methods=['POST'])
@login_agent
def update_deliverydetails():
    agent_id = session.get('agent_ID')  # Get current logged-in agent ID

    if not agent_id:
        return "Unauthorized", 401  # Safety check

    # Get form data
    updated_agent_id = request.form.get('agent_id')
    agent_name = request.form.get('agent_name')
    email = request.form.get('email')
    password = request.form.get('password')
    dob = request.form.get('dob')
    vehicle_number = request.form.get('vehichle')  # typo in your input field, correct spelling is 'vehicle'
    license_id = request.form.get('license')
    phone_num = request.form.get('phone')
    location = request.form.get('location')
    availability = request.form.get('availability')

    # Update the agent in the database
    cur = mysql.connection.cursor()
    cur.execute("""
        UPDATE Delivery_Agent
        SET 
            agent_id = %s,
            agent_name = %s,
            email = %s,
            password = %s,
            dob = %s,
            vehicle_number = %s,
            license_id = %s,
            phone_num = %s,
            location = %s,
            availability = %s
        WHERE agent_id = %s
    """, (
        updated_agent_id, agent_name, email, password, dob, vehicle_number,
        license_id, phone_num, location, availability, agent_id
    ))

    mysql.connection.commit()
    cur.close()

    # Update session if agent_id changed
    session['agent_ID'] = updated_agent_id

    return redirect('/delivery_dashboard#agent')

@app.route('/update_delivery_status', methods=['POST'])
@login_agent
def update_delivery_status():
    order_id = request.form.get('order_id')
    new_status = request.form.get('delivery_status')

    if not order_id or not new_status:
        return "Invalid request", 400

    cur = mysql.connection.cursor()
    cur.execute("""
        UPDATE Delivery
        SET delivery_status = %s
        WHERE order_id = %s
    """, (new_status, order_id))
    mysql.connection.commit()
    cur.close()

    return redirect('/delivery_dashboard#order')  # or wherever you want to reload

# @app.route('/tracker', methods=["POST", "GET"])
# def home1():
#     cur = mysql.connection.cursor()

#     if request.method == "POST":
#         if 'date-btn' in request.form:
#             date = request.form['date']
#             dt = datetime.strptime(date, '%Y-%m-%d')
#             database_date = datetime.strftime(dt, '%Y%m%d')
#             cur.execute('INSERT INTO log_date (entry_date) VALUES (%s)', [database_date])
#             mysql.connection.commit()

#         elif 'food-btn' in request.form:
#             name = request.form['food-name']
#             fat = int(request.form['fat'])
#             carbs = int(request.form['carbs'])
#             protein = int(request.form['protein'])
#             calories = protein * 4 + carbs * 4 + fat * 9

#             cur.execute(
#                 """
#                 INSERT INTO food (name, fat, protein, carbs, calories)
#                 VALUES (%s, %s, %s, %s, %s)
#                 """,
#                 (name, fat, protein, carbs, calories)
#             )
#             mysql.connection.commit()

#             cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
#             results = cur.fetchall()

#             return render_template('foods.html', results=results)

#     cur.execute(
#         """
#         SELECT log_date.entry_date,
#                SUM(food.protein) AS protein,
#                SUM(food.carbs) AS carbs,
#                SUM(food.fat) AS fat,
#                SUM(food.calories) AS calories
#         FROM log_date
#         LEFT JOIN food_date ON food_date.log_date_id = log_date.id
#         LEFT JOIN food ON food.id = food_date.food_id
#         GROUP BY log_date.id
#         ORDER BY log_date.entry_date DESC
#         """
#     )
#     results = cur.fetchall()
#     date_results_all = []

#     for i in results:
#         single_date = {
#             'entry_date': i[0],
#             'protein': i[1],
#             'carbs': i[2],
#             'fat': i[3],
#             'calories': i[4],
#             'readable_date': datetime.strptime(str(i[0]), '%Y-%m-%d').strftime('%B %d, %Y')
#         }
#         date_results_all.append(single_date)

#     return render_template('nutrienttracker/home1.html', results=date_results_all)

# @app.route('/tracker', methods=["POST", "GET"])

# @app.route('/tracker', methods=["POST", "GET"])
# @login_cust
# def home1():
#     customer_id = session.get('customer_id')  # Get customer_id from session
#     if not customer_id:
#         return redirect(url_for('login'))  # Redirect to login if session is missing

#     cur = mysql.connection.cursor()

#     # Automatically insert today's log_date on GET if not present
#     if request.method == "GET":
#         today = datetime.today()
#         database_date = today.strftime('%Y-%m-%d')

#         cur.execute(
#             "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
#             (database_date, customer_id)
#         )
#         existing = cur.fetchone()

#         if not existing:
#             cur.execute(
#                 "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
#                 (database_date, customer_id)
#             )
#             mysql.connection.commit()

#     # Handle POST requests
#     if request.method == "POST":
#         if 'date-btn' in request.form:
#             date = request.form['date']
#             dt = datetime.strptime(date, '%Y-%m-%d')
#             database_date = dt.strftime('%Y-%m-%d')

#             cur.execute(
#                 "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
#                 (database_date, customer_id)
#             )
#             existing = cur.fetchone()

#             if not existing:
#                 cur.execute(
#                     "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
#                     (database_date, customer_id)
#                 )
#                 mysql.connection.commit()

#         elif 'food-btn' in request.form:
#             name = request.form['food-name']
#             fat = int(request.form['fat'])
#             carbs = int(request.form['carbs'])
#             protein = int(request.form['protein'])
#             calories = protein * 4 + carbs * 4 + fat * 9

#             cur.execute(
#                 """
#                 INSERT INTO food (name, fat, protein, carbs, calories)
#                 VALUES (%s, %s, %s, %s, %s)
#                 """,
#                 (name, fat, protein, carbs, calories)
#             )
#             mysql.connection.commit()

#             cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
#             results = cur.fetchall()
#             return render_template('foods.html', results=results)
#     cur.execute(
#     "SELECT entry_date FROM log_date WHERE customer_id = %s",
#     (customer_id,)
#     )
#     print("Log dates for customer:", cur.fetchall())
#     # Fetch summary only for current customer
#     cur.execute(
#         """
#         SELECT log_date.entry_date,
#                SUM(food.protein) AS protein,
#                SUM(food.carbs) AS carbs,
#                SUM(food.fat) AS fat,
#                SUM(food.calories) AS calories
#         FROM log_date
#         LEFT JOIN food_date ON food_date.log_date_id = log_date.id
#         LEFT JOIN food ON food.id = food_date.food_id
#         WHERE log_date.customer_id = %s
#         GROUP BY log_date.id
#         ORDER BY log_date.entry_date DESC
#         """,
#         (customer_id,)
#     )
#     results = cur.fetchall()
#     date_results_all = []

#     for i in results:
#         single_date = {
#             'entry_date': i[0],
#             'protein': i[1],
#             'carbs': i[2],
#             'fat': i[3],
#             'calories': i[4],
#             'readable_date': datetime.strptime(str(i[0]), '%Y-%m-%d').strftime('%B %d, %Y')
#         }
#         date_results_all.append(single_date)
#     print(date_results_all)
#     return render_template('nutrienttracker/home1.html', results=date_results_all)

@app.route('/tracker', methods=["POST", "GET"])
@login_cust
def home1():
    customer_id = session.get('customer_id')
    if not customer_id:
        return redirect(url_for('login'))

    cur = mysql.connection.cursor()

    # ✅ Step 1: Insert today's entry ONCE per customer on GET
    if request.method == "GET":
        today = date.today()  # only date, not datetime!
        cur.execute(
            "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
            (today, customer_id)
        )
        existing = cur.fetchone()

        if not existing:
            cur.execute(
                "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
                (today, customer_id)
            )
            mysql.connection.commit()

    # ✅ Step 2: Handle manual date insert (calendar date form)
    if request.method == "POST":
        if 'date-btn' in request.form:
            input_date = request.form['date']
            try:
                formatted_date = datetime.strptime(input_date, '%Y-%m-%d').date()
            except ValueError:
                flash("Invalid date format.")
                return redirect(url_for('home1'))

            cur.execute(
                "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
                (formatted_date, customer_id)
            )
            existing = cur.fetchone()

            if not existing:
                cur.execute(
                    "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
                    (formatted_date, customer_id)
                )
                mysql.connection.commit()

        elif 'food-btn' in request.form:
            name = request.form['food-name']
            fat = int(request.form['fat'])
            carbs = int(request.form['carbs'])
            protein = int(request.form['protein'])
            calories = protein * 4 + carbs * 4 + fat * 9

            cur.execute("""
                INSERT INTO food (name, fat, protein, carbs, calories)
                VALUES (%s, %s, %s, %s, %s)
            """, (name, fat, protein, carbs, calories))
            mysql.connection.commit()

            cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
            results = cur.fetchall()
            return render_template('foods.html', results=results)

    # ✅ Step 3: Show nutrient summary
    cur.execute("""
        SELECT log_date.entry_date,
               SUM(food.protein) AS protein,
               SUM(food.carbs) AS carbs,
               SUM(food.fat) AS fat,
               SUM(food.calories) AS calories
        FROM log_date
        LEFT JOIN food_date ON food_date.log_date_id = log_date.id
        LEFT JOIN food ON food.id = food_date.food_id
        WHERE log_date.customer_id = %s
        GROUP BY log_date.id
        ORDER BY log_date.entry_date DESC
    """, (customer_id,))
    results = cur.fetchall()

    date_results_all = []
    for i in results:
        date_result = {
            'entry_date': i[0],
            'protein': i[1] or 0,
            'carbs': i[2] or 0,
            'fat': i[3] or 0,
            'calories': i[4] or 0,
            'readable_date': i[0].strftime('%B %d, %Y')
        }
        date_results_all.append(date_result)

    cur.close()
    return render_template('nutrienttracker/home1.html', results=date_results_all)


# @app.route('/tracker', methods=["GET", "POST"])
# @login_cust
# def home1():
#     customer_id = session.get('customer_id')

#     if not customer_id:
#         return redirect(url_for('login'))

#     cur = mysql.connection.cursor()

#     if request.method == "GET":
#         today = datetime.today().strftime('%Y-%m-%d')
#         cur.execute(
#             "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
#             (today, customer_id)
#         )
#         if not cur.fetchone():
#             cur.execute(
#                 "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
#                 (today, customer_id)
#             )
#             mysql.connection.commit()

#     if request.method == "POST":
#         if 'date-btn' in request.form:
#             date = request.form['date']
#             cur.execute(
#                 "SELECT id FROM log_date WHERE entry_date = %s AND customer_id = %s",
#                 (date, customer_id)
#             )
#             if not cur.fetchone():
#                 cur.execute(
#                     "INSERT INTO log_date (entry_date, customer_id) VALUES (%s, %s)",
#                     (date, customer_id)
#                 )
#                 mysql.connection.commit()

#     # Step 1: Get all log_date entries with food totals
#     cur.execute(
#         """
#         SELECT log_date.entry_date,
#                SUM(food.protein) AS protein,
#                SUM(food.carbs) AS carbs,
#                SUM(food.fat) AS fat,
#                SUM(food.calories) AS calories,
#                log_date.customer_id
#         FROM log_date
#         LEFT JOIN food_date ON food_date.log_date_id = log_date.id
#         LEFT JOIN food ON food.id = food_date.food_id
#         GROUP BY log_date.id
#         ORDER BY log_date.entry_date DESC
#         """
#     )

#     log_dates = cur.fetchall()
#     print("Step 1 - log_dates:", log_dates)

#  #customer_id and id from log_date and compare with filter_results
    
#     customer_id = session.get('customer_id')
#     if customer_id is not None:
#         customer_id = int(customer_id)
    
#     # Step 2: Filter only current customer's logs
#     filtered_results = []
#     for log in log_dates:
#         if log[5] == customer_id:
#             filtered_results.append({
#                 'entry_date': log[0],
#                 'protein': log[1],
#                 'carbs': log[2],
#                 'fat': log[3],
#                 'calories': log[4],
#                 'readable_date': log[0].strftime('%B %d, %Y')
#             })

#     print("Step 2 - filtered_results:", filtered_results)

#     cur.close()

#     # Step 3: Render
#     return render_template('nutrienttracker/home1.html', results=filtered_results)

# @app.route('/food-details', methods=["GET", "POST"])
# @login_cust
# def foodDetails():
#     cur = mysql.connection.cursor()
#     cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
#     # results = cur.fetchall()

#     rows = cur.fetchall()

#     results = [
#         {'name': r[0], 'protein': r[1], 'carbs': r[2], 'fat': r[3], 'calories': r[4]}
#         for r in rows
#     ]
#     return render_template('nutrienttracker/foods.html', results=results)

@app.route('/food-details', methods=["GET", "POST"])
@login_cust
def foodDetails():
    cur = mysql.connection.cursor()
    cur.execute('SELECT name, protein, carbs, fat, calories FROM food')
    rows = cur.fetchall()

    results = [
        {'name': r[0], 'protein': r[1], 'carbs': r[2], 'fat': r[3], 'calories': r[4]}
        for r in rows
    ]
    
    return render_template('nutrienttracker/foods.html', results=results)

@app.route('/search-food')
def search_food():
    query = request.args.get('query', '')
    
    # Ensure the query length is valid
    if len(query) < 3:
        return jsonify({'suggestions': []})  # Return empty if less than 3 characters
    
    # Query the database for food names matching the search query
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT name, protein, carbs, fat, calories 
        FROM food 
        WHERE name LIKE %s
    """, ('%' + query + '%',))
    rows = cur.fetchall()

    # Prepare suggestions list
    suggestions = [{'name': row[0], 'protein': row[1], 'carbs': row[2], 'fat': row[3], 'calories': row[4]} for row in rows]

    return jsonify({'suggestions': suggestions})


@app.route('/view/<date>', methods=["GET", "POST"])
@login_cust
def view(date):
    customer_id = session.get('customer_id')
    if not customer_id:
        return redirect(url_for('login'))  
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
        WHERE log_date.entry_date = %s and log_date.customer_id = %s
        """,
        [date,customer_id,]
    )
    log_results = cur.fetchall()

    totals = {'protein': 0, 'carbs': 0, 'fat': 0, 'calories': 0}
    for food in log_results:
        totals['protein'] += food[1]
        totals['carbs'] += food[2]
        totals['fat'] += food[3]
        totals['calories'] += food[4]
    


    return render_template('nutrienttracker/view.html', entry_date=date_result[1], readable_date=readable_date,
                           food_results=food_results, log_results=log_results, totals=totals)



if __name__ == '__main__':
    app.run(debug=True)
