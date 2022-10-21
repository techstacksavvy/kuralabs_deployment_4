from application import app, greet



 def test_home_page():
    response = app.test_client().get('/')
    assert response.status_code == 200
