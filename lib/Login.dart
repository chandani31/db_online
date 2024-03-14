import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_db_form/Dashboard.dart';
import 'package:online_db_form/Registration.dart';
import 'package:online_db_form/widgets/textFormFields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  late SharedPreferences loginData;
  late bool newUser;
  var isLoading = false;

  TextEditingController MobileNoController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String MobileNo = "";
  String Password = "";

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? false);
    print("newUser: $newUser");
    if (newUser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(height: 190,),
            myTextField(
              controller: MobileNoController,
              labelText: "MobileNo",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter MobileNo";
                }
                return null;
              },
              onSaved: (value) {
                MobileNoController = value!;
              },
            ),
            myTextField(
              controller: PasswordController,
              labelText: "Password",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Password";
                }
                return null;
              },
              onSaved: (value) {
                PasswordController = value!;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final isValid = _formkey.currentState!.validate();
                if (!isValid) {
                  return;
                }
                _formkey.currentState?.save();

                var url = "https://begrimed-executions.000webhostapp.com/digital_society/login/login_view.php";
                var response = await http.post(Uri.parse(url), body: {
                  "MobileNo": MobileNoController.text.toString(),
                  "Password": PasswordController.text.toString(),
                });

                if (response.statusCode == 200) {
                  var data = json.decode(response.body);
                  if (data == 0) {
                    // Incorrect login credentials
                    print("Invalid credentials");
                  } else {
                    // Successful login
                    print("Login successful");
                    String mob = MobileNoController.text.toString();
                    String pass = PasswordController.text.toString();

                    // Save user credentials
                    loginData.setBool('login', true);
                    loginData.setString('mob', mob);
                    loginData.setString('Pass', pass);

                    // Navigate to Dashboard
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                  }
                } else {
                  // Handle server error
                  print("Failed to login. Server error");
                }
              },
              child: Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Registration()));
              },
              child: Text("Don't have an Account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
