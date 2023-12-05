from fastapi import APIRouter, Depends, HTTPException
import sqlite3
from .user_model import UserData
import random as rnd
import pandas as pd
import skfuzzy as fuzz
import numpy as np
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt
import pickle
from .myfuzzy import Fuzzify, get_rule, feature_names, target_name
file = open('/app/endpoints/rules', 'rb')
rules_obj = pickle.load(file)
classifying = rules_obj['classifying']

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
    print( user_data.age)
    print( user_data.ciggPerDay )
    print( user_data.TotChol )
    print( user_data.SysBP )
    print( user_data.BMI )
    print( user_data.HeartRate )
    bmi = round(user_data.BMI)
    if bmi < 16:
        bmi = 16
    elif bmi > 56:
        bmi = 56
    classifying.input['age'] = user_data.age
    classifying.input['cigsPerDay'] = user_data.ciggPerDay
    classifying.input['totChol'] = user_data.TotChol
    classifying.input['sysBP'] = user_data.SysBP
    classifying.input['BMI'] = bmi
    classifying.input['heartRate'] = user_data.HeartRate
    classifying.compute()
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
        bmi,
        user_data.HeartRate,
        user_data.Glucose,
        classifying.output[target_name]
    ))
    db.commit()
    return {"message": "Data stored successfully", "data": round(classifying.output[target_name])}
