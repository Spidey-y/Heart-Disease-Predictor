from fastapi import APIRouter, Depends, HTTPException
import sqlite3
from .user_model import UserData
import pandas as pd
import numpy as np
import pickle
import sklearn

model=pickle.load(open('/app/endpoints/ETC.pkl','rb'))

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
    Data= {'male': user_data.sex ,'currentSmoker':user_data.isSmoker,'BPMeds': user_data.BPMeds, 'prevalentStroke': user_data.PrevStroke,'prevalentHyp':user_data.PrevHyp, 'diabetes': user_data.Diabetes, 
     'age': user_data.age, 'education': 4,'cigsPerDay':user_data.ciggPerDay,   'totChol':user_data.TotChol, 'sysBP':user_data.SysBP, 'diaBP': user_data.DiaBP, 'BMI':user_data.BMI, 'heartRate':user_data.HeartRate, 'glucose':user_data.Glucose }
    print(Data)
    input_df = pd.DataFrame([Data])
    result=int(model.predict(input_df)[0])
    print(result)


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
        result
    ))
    db.commit()
    return {"message": "Data stored successfully", "data": result}
