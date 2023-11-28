import sqlite3
from fastapi import FastAPI
from endpoints import store_data, get_data


app = FastAPI()
app.include_router(store_data.router, tags=["store user data"])
app.include_router(get_data.router, tags=["get all data"])
conn = sqlite3.connect("data.db", check_same_thread=False)
cursor = conn.cursor()
cursor.execute("""CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT,    
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    sex TEXT NOT NULL,
    age INTEGER NOT NULL,
    isSmoker INTEGER NOT NULL,
    ciggPerDay INTEGER NOT NULL,
    BPMeds INTEGER NOT NULL,
    PrevStroke INTEGER NOT NULL,
    PrevHyp INTEGER NOT NULL,
    Diabetes INTEGER NOT NULL,
    TotChol INTEGER NOT NULL,
    SysBP INTEGER NOT NULL,
    DiaBP INTEGER NOT NULL,
    BMI REAL NOT NULL,
    HeartRate INTEGER NOT NULL,
    Glucose INTEGER NOT NULL,
    CHDrisk INTEGER NOT NULL,
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
    )""")
conn.commit()
