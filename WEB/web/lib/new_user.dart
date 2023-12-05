import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:web/result_page.dart';
import 'package:web/settings.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
  bool isError = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int colesterol = 0;
  int sysBP = 0;
  int diaBP = 0;
  int heartRate = 0;
  int glucose = 0;
  int gender = -1;
  int age = 0;
  int isSmoke = -1;
  int isBloodPressure = -1;
  int isStroke = -1;
  int isHyper = -1;
  int isDiabetes = -1;
  double weight = 0.0;
  int height = 0;
  double ciggPerDay = 0.0;
  bool loading = false;
  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 245, 250),
      body: Center(
        child: isError
            ? errorPage()
            : loading
                ? loadingPage()
                : Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: PageView(
                          controller: pageController,
                          children: [fistPage(), secondPage(), thirdPage()],
                        ),
                      ),
                      returnButton(context),
                    ],
                  ),
      ),
    );
  }

  InkWell returnButton(BuildContext context) {
    return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (pageController.page == 0) {
            Navigator.of(context).pop();
          } else {
            pageController.animateToPage(
                int.parse(pageController.page.toString()) - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey[200]!, width: 4),
            ),
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 50,
              color: Colors.grey[800],
            )));
  }

  Column loadingPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WebsafeSvg.asset(
          'assets/ai.svg',
          width: 400,
          height: 400,
        ),
        const SizedBox(height: 20),
        LoadingAnimationWidget.staggeredDotsWave(color: Colors.blue, size: 60),
        const SizedBox(height: 10),
        Text("The model is thinking, please wait",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ],
    );
  }

  Column errorPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WebsafeSvg.asset(
          'assets/error.svg',
          width: 400,
          height: 400,
        ),
        const SizedBox(height: 30),
        Text("Opps something went wrong",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ],
    );
  }

  submitButton() {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        setState(() {
          loading = true;
        });
        await Future.delayed(const Duration(seconds: 5));

        if (nameController.text.isNotEmpty &&
            addressController.text.isNotEmpty &&
            gender != -1 &&
            age != 0 &&
            isSmoke != -1 &&
            isBloodPressure != -1 &&
            isStroke != -1 &&
            isHyper != -1 &&
            isDiabetes != -1 &&
            colesterol != 0 &&
            sysBP != 0 &&
            diaBP != 0 &&
            weight != 0 &&
            height != 0 &&
            heartRate != 0 &&
            glucose != 0) {
          setState(() {
            loading = true;
          });
          //send post to api
          var data = {
            "name": nameController.text,
            "address": addressController.text,
            "sex": gender,
            "age": age,
            "isSmoker": isSmoke,
            "ciggPerDay": int.parse(ciggPerDay.toString()),
            "BPMeds": isBloodPressure,
            "PrevStroke": isStroke,
            "PrevHyp": isHyper,
            "Diabetes": isDiabetes,
            "TotChol": colesterol,
            "SysBP": sysBP,
            "DiaBP": diaBP,
            "BMI": weight / (height * height / 10000),
            "HeartRate": heartRate,
            "Glucose": glucose,
          };
          try {
            final response = await http.post(
              Uri.parse('$apiURL/store_data'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data),
            );
            if (response.statusCode == 200) {
              var data = jsonDecode(response.body);

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      ResultPage(isHeartDisease: data['data'])));
            } else {
              setState(() {
                isError = true;
              });
            }
          } catch (e) {
            setState(() {
              isError = true;
            });
          }
        } else {
          setState(() {
            loading = false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Please fill all the fields and answer all the questions'),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text("Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ),
    );
  }

  thirdPage() {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter the patient cholesterol level",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(
                            124
                            600,
                            colesterol,
                            (v) => setState(() {
                                  colesterol = v.toInt();
                                }),
                            ""),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the patient systolic blood pressure",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(84, 295, sysBP, (v) {
                          setState(() {
                            sysBP = v.toInt();
                          });
                        }, ""),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the patient diastolic blood pressure",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(48, 142, diaBP, (v) {
                          setState(() {
                            diaBP = v.toInt();
                          });
                        }, ""),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the patient glucose level",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(40, 390, glucose, (v) {
                          setState(() {
                            glucose = v.toInt();
                          });
                        }, ""),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter the patient weight",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(0, 200, weight, (v) {
                          setState(() {
                            weight = v.toInt().toDouble();
                          });
                        }, " KG"),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the patient height",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(
                            0, 
                            250,
                            height,
                            (v) => setState(() {
                                  height = v.toInt();
                                }),
                            " CM"),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the patient heart rate",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(45, 140, heartRate, (v) {
                          setState(() {
                            heartRate = v.toInt();
                          });
                        }, ""),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                submitButton(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  secondPage() {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do the patient smoke?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            yesOrNoButtons(() {
                              setState(() {
                                isSmoke = 1;
                              });
                            }, (v) {
                              setState(() {
                                isHoverSY = v;
                              });
                            }, isHoverSY, isSmoke, Icons.check, Colors.green,
                                1),
                            const SizedBox(width: 20),
                            yesOrNoButtons(() {
                              setState(() {
                                isSmoke = 0;
                              });
                            }, (v) {
                              setState(() {
                                isHoverSN = v;
                              });
                            }, isHoverSN, isSmoke, Icons.close, Colors.red, 0),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "How many cigarettes does the patient smoke per day?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        customSlider(0, 70, ciggPerDay, (v) {
                          setState(() {
                            ciggPerDay = v.toInt().toDouble();
                          });
                        }, ""),
                        const SizedBox(height: 20),
                        Text(
                          "Does the patient have high blood pressure?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            yesOrNoButtons(() {
                              setState(() {
                                isBloodPressure = 1;
                              });
                            }, (v) {
                              setState(() {
                                isHoverBPY = v;
                              });
                            }, isHoverBPY, isBloodPressure, Icons.check,
                                Colors.green, 1),
                            const SizedBox(width: 20),
                            yesOrNoButtons(() {
                              setState(() {
                                isBloodPressure = 0;
                              });
                            }, (v) {
                              setState(() {
                                isHoverBPN = v;
                              });
                            }, isHoverBPN, isBloodPressure, Icons.close,
                                Colors.red, 0)
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Did the patient previously have a stroke?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            yesOrNoButtons(() {
                              setState(() {
                                isStroke = 1;
                              });
                            }, (v) {
                              setState(() {
                                isHoverStrokeY = v;
                              });
                            }, isHoverStrokeY, isStroke, Icons.check,
                                Colors.green, 1),
                            const SizedBox(width: 20),
                            yesOrNoButtons(() {
                              setState(() {
                                isStroke = 0;
                              });
                            }, (v) {
                              setState(() {
                                isHoverStrokeN = v;
                              });
                            }, isHoverStrokeN, isStroke, Icons.close,
                                Colors.red, 0),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Does the patient have hyper tension?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            yesOrNoButtons(() {
                              setState(() {
                                isHyper = 1;
                              });
                            }, (v) {
                              setState(() {
                                isHoverHyperY = v;
                              });
                            }, isHoverHyperY, isHyper, Icons.check,
                                Colors.green, 1),
                            const SizedBox(width: 20),
                            yesOrNoButtons(() {
                              setState(() {
                                isHyper = 0;
                              });
                            }, (v) {
                              setState(() {
                                isHoverHyperN = v;
                              });
                            }, isHoverHyperN, isHyper, Icons.close, Colors.red,
                                0),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Does the patient have diabetes?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            yesOrNoButtons(() {
                              setState(() {
                                isDiabetes = 1;
                              });
                            }, (v) {
                              setState(() {
                                isHoverDiabetesY = v;
                              });
                            }, isHoverDiabetesY, isDiabetes, Icons.check,
                                Colors.green, 1),
                            const SizedBox(width: 20),
                            yesOrNoButtons(() {
                              setState(() {
                                isDiabetes = 0;
                              });
                            }, (v) {
                              setState(() {
                                isHoverDiabetesN = v;
                              });
                            }, isHoverDiabetesN, isDiabetes, Icons.close,
                                Colors.red, 0)
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                nextButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  fistPage() {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
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
                Text(
                  "Enter the patient age",
                  style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                ),
                const SizedBox(height: 10),
                customSlider(32, 69, age, (v) {
                  setState(() {
                    age = v.toInt().toDouble();
                  });
                }, " yo"),
                const SizedBox(height: 20),
                Text(
                  "Pick Gender",
                  style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    genderBox(() {
                      setState(() {
                        gender = 1;
                      });
                    }, (v) {
                      setState(() {
                        isHoverM = v;
                      });
                    }, isHoverM, gender, Icons.male, Colors.blue, 1),
                    const SizedBox(width: 20),
                    genderBox(() {
                      setState(() {
                        gender = 0;
                      });
                    }, (v) {
                      setState(() {
                        isHoverF = v;
                      });
                    }, isHoverF, gender, Icons.female, Colors.pink, 0),
                  ],
                ),
                const SizedBox(height: 50),
                nextButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell nextButton() {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        pageController.animateToPage(
            int.parse(pageController.page.toString()) + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.white,
          border: Border.all(
            color: Colors.blue.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Text("Next",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            )),
      ),
    );
  }

  customSlider(min, max, value, onChanged, cur) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Slider(
              min: min,
              max: max,
              divisions: max,
              label: value.toString(),
              value: value.toDouble(),
              onChanged: (v) {
                onChanged(v);
              }),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!, width: 4)),
          child: FittedBox(
            child: Text(
              "$value$cur",
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
          ),
        ),
      ]),
    );
  }

  InkWell yesOrNoButtons(ontap, onHover, isHover, isSmoke, icon, color, val) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        ontap();
      },
      onHover: (v) {
        onHover(v);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isHover || isSmoke == val ? color : Colors.grey[200]!,
              width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }

  genderBox(onTap, onHover, isHover, isMale, icon, color, val) {
    return InkWell(
      onTap: () {
        onTap();
      },
      onHover: (v) {
        onHover(v);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isHover || isMale == val ? color : Colors.grey[200]!,
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

  formField(BuildContext context, hint, controller, validation) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blueGrey.withOpacity(0.6), width: .5),
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
      ),
    );
  }
}
