from app.app import app

def test_home_route():
    # Create a test client for the Flask app
    client = app.test_client()

    # Send GET request to "/"
    response = client.get("/")

    # Verify the status code
    assert response.status_code == 200

    # Verify the response text
    assert b"Hello, CI/CD pipeline is working!" in response.data

