from pydantic import BaseModel


class UserData(BaseModel):
    name: str
    address: str
    sex: int
    age: int
    isSmoker: int
    ciggPerDay: int
    BPMeds: int
    PrevStroke: int
    PrevHyp: int
    Diabetes: int
    TotChol: int
    SysBP: int
    DiaBP: int
    BMI: float
    HeartRate: int
    Glucose: int
