from connect_postgres import connect_postgres
from sqlalchemy import text

username = input("Enter username:")
password = input("Enter password:")

with connect_postgres().connect() as conn:
    result = conn.execute(
        text(
            "SELECT * FROM users WHERE username = :username AND password = :password;"
        ),
        {"username": username, "password": password},
        
    )

    if result.fetchall():
        print("login success")
        print(f"You can now hack all you want")
    else: 
        print("another failure, try again")
        
