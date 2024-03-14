import 'package:flutter/material.dart';
import 'package:online_db_form/Login.dart';
import 'package:online_db_form/widgets/textFormFields.dart';
import 'package:http/http.dart' as http;

import 'Dashboard.dart';

enum GenderSelect {Male, Female}
class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  String selectedWing = 'A';
  GenderSelect _gender = GenderSelect.Male;
  final _formkey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool dancing = false;
  bool singing = false;
  bool drawing = false;
  bool cooking = false;

  String dropdownvalue = 'Rajkot';
  List<String> city = [
    "Ahmedabad",
    "Rajkot",
    "Pune",
    "Vadodara"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80,),
                myTextField(
                    controller: firstName,
                    labelText: "First Name",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter FirstName";
                      }
                    }
                    ),
                myTextField(
                    controller: lastName,
                    labelText: "Last Name",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter LastName";
                      }
                    }),
                Text("Address(Wing)", style: TextStyle(color: Colors.black87),),
                SizedBox(width: 4),
                DropdownButton<String>(
                  value: selectedWing,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedWing = newValue!;
                    });
                  },
                  items: ['A', 'B', 'C', 'D', 'E', 'F']
                      .map((wing) => DropdownMenuItem<String>(
                    value: wing,
                    child: Text(wing),
                  ))
                      .toList(),
                ),
                myTextField(
                    controller: mobileNo,
                    labelText: "MobileNo",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter MobileNo";
                      }
                    }),
                myTextField(
                    controller: email,
                    labelText: "Email",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter Email";
                      }
                    }),
                myTextField(
                    controller: password,
                    labelText: "Password",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter Password";
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
        
                      Text("Gender", style: TextStyle(color: Colors.black87),),
        
                      SizedBox(width: 4),
        
                      Flexible(
                        child: Radio(
                          value: GenderSelect.Male,
                          groupValue: _gender,
                          onChanged: (GenderSelect? value) {
                            setState(()
                            {
                              _gender = value!;
        
                            });
        
                          },
                        ),
                      ),
        
                      Text("Male"),
        
                      Flexible(
                        child: Radio(
                          value: GenderSelect.Female,
                          groupValue: _gender,
                          onChanged: (GenderSelect? value) {
        
                            setState(() {
        
                              _gender = value!;
        
        
                            });
                          },
                        ),
                      ),
                      Text("Female"),
                    ],
                  ),
                ),
                // DropdownButton(
                //   value: dropdownvalue,
                //
                //   // Down Arrow Icon
                //   icon: const Icon(Icons.keyboard_arrow_down),
                //   items: city.map((String items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownvalue = newValue!;
                //       print(dropdownvalue);
                //     });
                //   },
                // ),
                // Text("Hobbies"),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Dancing',
                //       style: TextStyle(fontSize: 17.0),
                //     ), //Text
                //     SizedBox(width: 10), //SizedBox
                //     Checkbox(
                //       value: this.dancing,
                //       onChanged: (value) {
                //         setState(() {
                //           this.dancing = value!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Singing',
                //       style: TextStyle(fontSize: 17.0),
                //     ), //Text
                //     SizedBox(width: 10), //SizedBox
                //     Checkbox(
                //       value: this.singing,
                //       onChanged: (value) {
                //         setState(() {
                //           this.singing = value!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Drawing',
                //       style: TextStyle(fontSize: 17.0),
                //     ), //Text
                //     SizedBox(width: 10), //SizedBox
                //     Checkbox(
                //       value: this.drawing,
                //       onChanged: (value) {
                //         setState(() {
                //           this.drawing = value!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Cooking',
                //       style: TextStyle(fontSize: 17.0),
                //     ), //Text
                //     SizedBox(width: 10), //SizedBox
                //     Checkbox(
                //       value: this.cooking,
                //       onChanged: (value) {
                //         setState(() {
                //           this.cooking = value!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                ElevatedButton(
                    onPressed: ()
                    {
                      if(_formkey.currentState!.validate())
                        {
                          var Url =Uri.parse("https://begrimed-executions.000webhostapp.com/digital_society/register/register_insert.php");
                          String Gender = _gender == GenderSelect.Male ? "Male" : "Female";
        
                          http.post(Url, body: {
                            "FirstName" : firstName.text.toString(),
                            "LastName" : lastName.text.toString(),
                            "Email" : email.text.toString(),
                            "Password" : password.text.toString(),
                            "Gender" : Gender.toString(),
        
        
                          });
        
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                        }
                    }, child: Text("Register")),
        
                TextButton(
                    onPressed: ()
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Already have an Account? Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}