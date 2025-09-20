from flask import Flask

# Create a Flask app instance
app = Flask(__name__)


@app.route("/")
def home():
    """Route for the home page."""
    return "Hello, CI/CD pipeline is working!"


if __name__ == "__main__":
    # Run the app in debug mode
    app.run(debug=True)
