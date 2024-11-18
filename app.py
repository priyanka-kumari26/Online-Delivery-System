from flask import Flask, render_template, request, jsonify
import MySQLdb

app = Flask(__name__)

# MySQL database configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'priya12'
app.config['MYSQL_DB'] = 'online_food_delivery'

# Initialize the MySQL connection
mysql = MySQLdb.connect(
    host=app.config['MYSQL_HOST'],
    user=app.config['MYSQL_USER'],
    passwd=app.config['MYSQL_PASSWORD'],
    db=app.config['MYSQL_DB']
)

@app.route('/')
def home():
    """Render the feedback form."""
    return render_template('feedback.html')

@app.route('/submit-feedback', methods=['POST'])
def submit_feedback():
    """Handle feedback submission."""
    order_id = request.form['orderId']
    rating = request.form['rating']
    review = request.form['review']

    try:
        cursor = mysql.cursor()
        # Attempt to insert feedback into the Feedback table
        cursor.execute(
            """
            INSERT INTO Feedback (OrderID, FeedbackDate, Rating, Review)
            VALUES (%s, CURDATE(), %s, %s)
            """,
            (order_id, rating, review)
        )
        mysql.commit()
        return jsonify({'success': True, 'message': 'Feedback submitted successfully!'})
    except MySQLdb.Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/test-db')
def test_db():
    """Test the database connection."""
    try:
        cursor = mysql.cursor()
        cursor.execute("SELECT DATABASE();")  # Query to check current database
        db_name = cursor.fetchone()  # Fetch the result
        return jsonify({'success': True, 'database': db_name[0], 'message': 'Database connection is successful!'})
    except MySQLdb.Error as e:
        return jsonify({'success': False, 'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
