// ignore: unused_import
import 'package:intl/intl.dart';

class UserModel {
  String name;
  String address;
  int sex;
  int age;
  int isSmoker;
  int ciggPerDay;
  int bPMeds;
  int prevStroke;
  int prevHyp;
  int diabetes;
  int totChol;
  int sysBP;
  int diaBP;
  double bMI;
  int heartRate;
  int glucose;
  int chdrisk;
  String addedOn;

  UserModel({
    required this.name,
    required this.address,
    required this.sex,
    required this.age,
    required this.isSmoker,
    required this.ciggPerDay,
    required this.bPMeds,
    required this.prevStroke,
    required this.prevHyp,
    required this.diabetes,
    required this.totChol,
    required this.sysBP,
    required this.diaBP,
    required this.bMI,
    required this.heartRate,
    required this.glucose,
    required this.chdrisk,
    required this.addedOn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      address: json['address'],
      sex: json['sex'],
      age: json['age'],
      isSmoker: json['isSmoker'],
      ciggPerDay: json['ciggPerDay'],
      bPMeds: json['BPMeds'],
      prevStroke: json['PrevStroke'],
      prevHyp: json['PrevHyp'],
      diabetes: json['Diabetes'],
      totChol: json['TotChol'],
      sysBP: json['SysBP'],
      diaBP: json['DiaBP'],
      bMI: double.parse(json['BMI'].toStringAsFixed(2)),
      heartRate: json['HeartRate'],
      glucose: json['Glucose'],
      chdrisk: json['CHDrisk'],
      addedOn: json['added_on'],
    );
  }
}
