# Major-Project
# ABSTRACT
This project presents a web-based application that integrates food ordering and nutrition tracking into a single platform. It allows users to browse restaurants, place orders, and simultaneously track their dietary intake using a nutrition module. Built using Flask, MySQL, and Google OAuth, the system ensures secure login, real-time food logging, and modular role access for customers, restaurants, and delivery agents. The application aims to simplify food access while encouraging health-conscious decisions.
# INTRODUCTION
Rising demand for food delivery applications
Growing awareness of nutrition and calorie tracking
Lack of integrated platforms for food ordering + nutrition
Our solution bridges both functionalities
Roles supported: Customer, Restaurant, Delivery Agent
# EXISTING-SYSTEM
The existing systems in the food delivery and nutritional tracking space are mainly divided into two categories: 
food delivery apps and nutritional tracking apps.
Many of these systems operate independently of one another, with food delivery apps focusing on convenience and variety, while nutritional tracking apps focus on health and meal logging. 
EXAMPLE:
Food apps like Swiggy/Zomato provide delivery but no nutrition info
Nutrition apps like MyFitnessPal don't support food ordering
❌ Limitations:
Users must switch between apps to log meals
No real-time integration between order and dietary tracking
# PROPOSED-SYSTEM
Our proposed system is a
A unified web application that combines food delivery and nutrition tracking.
Supports role-based access:
👤 Customer – place orders, track food, log nutrition
👨‍🍳 Restaurant – manage menus, view orders
🚚 Delivery Agent – view & update delivery tasks

🌟Advantages:
✅ Real-time food-to-nutrition mapping : Food items ordered are instantly linked to the nutrition tracker.
✅ Simplified experience through one platform : No need to switch between separate apps for food and health tracking.
✅ Health-aware decision-making : Users can see nutritional impact before placing an order.
✅ Secure and modular user access : Separate access control for each user type using Google OAuth & custom logins.
# SYSTEM ARCHITECTURE
The system architecture of the Food Delivery and Nutrition Tracking Application is based on a modular, layered design that ensures scalability, security, and clear separation of concerns across components.

1)User Interface (Frontend - HTML/JS): Provides a web-based interface for users to interact with the system, including login, restaurant browsing, order placement, and nutrition tracking.

2)OAuth 2.0 (Google Authentication): Used for secure and seamless customer login via Google accounts, ensuring identity verification and reducing credential management overhead.

3)Flask Backend(app.py): Acts as the core application logic layer. It handles routing, user roles, form submissions, session management, and coordinates interactions between frontend and database.

4)MySQL Database: Stores structured data including user details, restaurant menus, food items, orders, delivery info, and nutrition logs. Enables efficient querying and data integrity.

5)Food Order Module: Manages restaurant menus, customer cart functionality, order processing, delivery assignments, and payment integration.

6)Nutrition Module: Allows users to log food intake, calculates macros (calories, protein, carbs, fat), and stores data by date for health tracking.
# SYSTEM REQUIREMENTS
🔧 Software Requirements:
Python 3.x
Flask Framework
MySQL Database
HTML, JS, CSS
Google OAuth 2.0
🖥 Hardware Requirements:
Minimum 4GB RAM
Modern browser (Chrome/Firefox)
Localhost or cloud deployment (optional)
# METHODOLOGY
📌 Steps:
1)User authentication (Google OAuth) : Secure login for customers using Google; credentials-based login for other roles.
2)Role-based dashboard navigation : Post-login, users are redirected to dashboards based on their role.
3)Restaurant/food menu handling : Restaurants manage menus through add/edit/delete actions.
4)Order placement and delivery assignment : Customers place orders; delivery agents are assigned automatically or manually.
5)Database operations : Core operations are performed using MySQL for storing and retrieving data.
6)Order status tracking : Delivery agents update statuses like "In Transit" or "Delivered"; customers can track them.
7)Nutrition data logging : Users log food items; macros and calories are calculated automatically.
8)Visualization of nutrient intake : Graphs and tables summarize daily nutrition intake for each user.
9)Review and feedback collection : Users provide reviews and ratings to improve quality and transparency.
# RESULTS
Successfully integrated food ordering + nutrition logging
Orders and food logs are stored and tracked
Daily nutrition summaries generated
System handles multi-role logic effectively
# CONCLUSION
The Food Delivery and Nutrition Tracking System bridges two critical daily needs — food convenience and health awareness — in a unified, secure, and user-friendly platform.
By combining food ordering with real-time nutrition tracking, the system encourages users to make informed dietary choices without disrupting convenience.
It supports role-based access for customers, restaurants, and delivery agents, each with tailored features that promote smooth interaction and operational efficiency.
With a strong backend (Flask & MySQL) and an intuitive frontend, the application lays a solid foundation for scaling into a full-fledged, health-integrated food service solution.
# FUTURE SCOPE
Add AI-based food recommendations Implement machine learning to suggest healthier food choices based on user preferences, order history, and nutritional goals. 
Mobile app version (Android/iOS) Develop dedicated mobile applications to make food ordering and nutrition tracking more accessible on the go.
Integration with fitness trackers (e.g., Fitbit) Sync data with wearable fitness devices to correlate calorie intake with physical activity for holistic health tracking.
Real-time delivery tracking with maps Incorporate GPS-based tracking to allow users to view the live location of delivery agents and estimated delivery time.

# NOTE
## 🔐 Google OAuth 2.0 Setup

This project uses **Google OAuth 2.0** for user authentication.

To enable Google Login:

1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or use an existing one.
3. Navigate to **APIs & Services > Credentials**.
4. Click **"Create Credentials" > "OAuth 2.0 Client IDs"**.
5. Choose **Web application** and set authorized redirect URIs (e.g., `http://localhost:5000/`).
6. Download the `client.json` file.




