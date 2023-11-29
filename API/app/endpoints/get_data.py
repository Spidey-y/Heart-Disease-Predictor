from fastapi import APIRouter, Depends
import sqlite3
from .user_model import UserData

router = APIRouter()
# TODO add pagination


@router.get("/get_data")
def get_data():
    db = sqlite3.connect("data.db")
    query = "SELECT * FROM users"
    cursor = db.execute(query)
    rows = cursor.fetchall()
    data = [dict(zip([column[0] for column in cursor.description], row))
            for row in rows]
    return data
