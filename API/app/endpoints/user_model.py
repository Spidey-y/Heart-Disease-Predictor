from pydantic import BaseModel


class UserData(BaseModel):
    name: str
    address: str
    sex: str
    age: int
    isSmoker: bool
    ciggPerDay: int
    BPMeds: bool
    PrevStroke: bool
    PrevHyp: bool
    Diabetes: bool
    TotChol: int
    SysBP: int
    DiaBP: int
    BMI: float
    HeartRate: int
    Glucose: int
    CHDrisk: int
