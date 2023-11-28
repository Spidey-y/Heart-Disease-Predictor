import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web/settings.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  bool isHoverM = false;
  bool isHoverF = false;
  bool isHoverSY = false;
  bool isHoverSN = false;
  bool isHoverBPY = false;
  bool isHoverBPN = false;
  bool isHoverStrokeY = false;
  bool isHoverStrokeN = false;
  bool isHoverHyperY = false;
  bool isHoverHyperN = false;
  bool isHoverDiabetesY = false;
  bool isHoverDiabetesN = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController colesterolController = TextEditingController();
  TextEditingController sysBPController = TextEditingController();
  TextEditingController diaBPController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController glucoseController = TextEditingController();
  late Future<String?> _futureResponse;
  final _formKey = GlobalKey<FormState>();
  int gender = -1;
  int isSmoke = -1;
  int isBloodPressure = -1;
  int isStroke = -1;
  int isHyper = -1;
  int isDiabetes = -1;
  double weight = 0.0;
  int height = 0;
  double ciggPerDay = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 233, 240, 1),
      body: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    formField(context, 'Enter the patient name', nameController,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the patient name';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    formField(
                        context, 'Enter the patient address', addressController,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the patient address';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    formField(context, 'Enter the patient age', ageController,
                        (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return 'Please enter the patient age';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    //pick gender
                    Text(
                      "Pick Gender",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        genderBoxM(Icons.male, Colors.blue, 1),
                        const SizedBox(width: 20),
                        genderBoxF(Icons.female, Colors.pink, 0),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Do the patient smoke?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        smokeButtonY(),
                        const SizedBox(width: 20),
                        smokeButtonN(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "How many cigarettes does the patient smoke per day?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    ciggPerDaySlider(),
                    const SizedBox(height: 20),
                    Text(
                      "Does the patient have high blood pressure?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        blooPY(),
                        const SizedBox(width: 20),
                        blooPN(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Did the patient previously have a stroke?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        strokeY(),
                        const SizedBox(width: 20),
                        strokeN(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Does the patient have hyper tension?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        hyperY(),
                        const SizedBox(width: 20),
                        hyperN(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Does the patient have diabetes?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        diabetesY(),
                        const SizedBox(width: 20),
                        diabetesN(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    formField(context, 'Enter the patient colesterol level',
                        colesterolController, (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter the patient colesterol level';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    formField(
                        context,
                        'Enter the patient systolic blood pressure',
                        sysBPController, (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter the patient systolic blood pressure';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    formField(
                        context,
                        'Enter the patient diastolic blood pressure',
                        diaBPController, (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter the patient diastolic blood pressure';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    Text(
                      "Enter the patient weight",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    weightSlider(),
                    const SizedBox(height: 20),
                    Text(
                      "Enter the patient height",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 10),
                    heighSlider(),
                    const SizedBox(height: 20),
                    formField(context, 'Enter the patient heart rate',
                        heartRateController, (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter the patient heart rate';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    formField(context, 'Enter the patient glucose level',
                        glucoseController, (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter the patient glucose level';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //send post to api
                          _sendPostRequest({
                            "name": nameController.text,
                            "address": addressController.text,
                            "sex": gender,
                            "age": int.parse(ageController.text),
                            "isSmoker": isSmoke,
                            "ciggPerDay": int.parse(ciggPerDay.toString()),
                            "BPMeds": isBloodPressure,
                            "PrevStroke": isStroke,
                            "PrevHyp": isHyper,
                            "Diabetes": isDiabetes,
                            "TotChol": int.parse(colesterolController.text),
                            "SysBP": int.parse(sysBPController.text),
                            "DiaBP": int.parse(diaBPController.text),
                            "BMI": weight / (height * height / 10000),
                            "HeartRate": int.parse(heartRateController.text),
                            "Glucose": int.parse(glucoseController.text),
                          });
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<String?> _sendPostRequest(Map data) async {
    print(data);
    final response = await http.post(
      Uri.parse('$apiURL/store_data'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Row heighSlider() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Slider(
            max: 250,
            min: 0,
            divisions: 250,
            label: height.toString(),
            value: height.toDouble(),
            onChanged: (v) {
              setState(() {
                height = v.toInt();
              });
            }),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[200]!, width: 4)),
        child: Text(
          height.toString(),
          style: TextStyle(fontSize: 20, color: Colors.grey[400]),
        ),
      ),
    ]);
  }

  Row weightSlider() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Slider(
            max: 200,
            min: 0,
            divisions: 200,
            label: weight.toString(),
            value: weight,
            onChanged: (v) {
              setState(() {
                weight = double.parse(v.toInt().toString());
              });
            }),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[200]!, width: 4)),
        child: Text(
          weight.toString(),
          style: TextStyle(fontSize: 20, color: Colors.grey[400]),
        ),
      ),
    ]);
  }

  InkWell diabetesN() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isDiabetes = 0;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverDiabetesN = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverDiabetesN || isDiabetes == 0
                  ? Colors.red
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell diabetesY() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isDiabetes = 1;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverDiabetesY = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverDiabetesY || isDiabetes == 1
                  ? Colors.green
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell hyperN() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isHyper = 0;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverHyperN = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverHyperN || isHyper == 0
                  ? Colors.red
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell hyperY() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isHyper = 1;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverHyperY = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverHyperY || isHyper == 1
                  ? Colors.green
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell strokeY() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isStroke = 1;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverStrokeY = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverStrokeY || isStroke == 1
                  ? Colors.green
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell strokeN() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isStroke = 0;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverStrokeN = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverStrokeN || isStroke == 0
                  ? Colors.red
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  Row ciggPerDaySlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Slider(
              max: 50,
              min: 0,
              divisions: 50,
              label: ciggPerDay.toString(),
              value: ciggPerDay,
              onChanged: (v) {
                setState(() {
                  ciggPerDay = double.parse(v.toInt().toString());
                });
              }),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!, width: 4)),
          child: Text(
            ciggPerDay.toString(),
            style: TextStyle(fontSize: 20, color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }

  InkWell blooPY() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isBloodPressure = 1;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverBPY = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverBPY || isBloodPressure == 1
                  ? Colors.green
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell blooPN() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isBloodPressure = 0;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverBPN = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverBPN || isBloodPressure == 0
                  ? Colors.red
                  : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell smokeButtonY() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isSmoke = 1;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverSY = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color:
                  isHoverSY || isSmoke == 1 ? Colors.green : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  InkWell smokeButtonN() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          isSmoke = 0;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverSN = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHoverSN || isSmoke == 0 ? Colors.red : Colors.grey[200]!,
              width: 4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  genderBoxM(icon, color, val) {
    return InkWell(
      onTap: () {
        setState(() {
          gender = val;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverM = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isHoverM || gender == val ? color : Colors.grey[200]!,
              width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  genderBoxF(icon, color, val) {
    return InkWell(
      onTap: () {
        setState(() {
          gender = val;
        });
      },
      onHover: (v) {
        setState(() {
          isHoverF = v;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isHoverF || gender == val ? color : Colors.grey[200]!,
              width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField formField(BuildContext context, hint, controller, validation) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Icon(
          //     icon,
          //     color: Colors.grey,
          //   ),
          // ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.blueGrey.withOpacity(0.6), width: .5),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          )),
      validator: (value) {
        validation(value);
        return null;
      },
    );
  }
}
