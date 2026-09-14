# AIDER_5058_TEST_TRIGGERED

def authenticate(username, password):
    if not username or not password:
        raise ValueError("Username and password cannot be empty")
    
    if username == "admin" and password == "test":
        return True
    
    return False
