import 'package:flutter/material.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 233, 240, 1),
      body: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your name',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 25.0),
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueGrey.withOpacity(0.6), width: .5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          )),
    );
  }
}
