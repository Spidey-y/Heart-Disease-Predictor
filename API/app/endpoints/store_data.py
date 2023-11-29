from fastapi import APIRouter, Depends, HTTPException
import sqlite3
from .user_model import UserData
import random as rnd


router = APIRouter()


@router.post("/store_data")
def store_data(user_data: UserData):
    db = sqlite3.connect("data.db")
    query = """INSERT INTO users (
        name,
        address,
        sex,
        age,
        isSmoker,
        ciggPerDay,
        BPMeds,
        PrevStroke,
        PrevHyp,
        Diabetes,
        TotChol,
        SysBP,
        DiaBP,
        BMI,
        HeartRate,
        Glucose,
        CHDrisk
    ) VALUES (
     ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
    )"""
    # TODO: add CHDrisk to the query and run model
    db.execute(query, (
        user_data.name,
        user_data.address,
        user_data.sex,
        user_data.age,
        user_data.isSmoker,
        user_data.ciggPerDay,
        user_data.BPMeds,
        user_data.PrevStroke,
        user_data.PrevHyp,
        user_data.Diabetes,
        user_data.TotChol,
        user_data.SysBP,
        user_data.DiaBP,
        user_data.BMI,
        user_data.HeartRate,
        user_data.Glucose,
        rnd.choice([0, 1])
    ))
    db.commit()
    return {"message": "Data stored successfully", "data": rnd.choice([0, 1])}
