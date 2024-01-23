import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/BStudent.dart';
import 'package:untitled4/BCompany.dart';
import 'package:untitled4/ForgotPassworD.dart';
import 'package:untitled4/HomePage.dart';
import 'package:untitled4/student/HomeStu.dart';

class Login extends StatefulWidget {
  Login({super.key});
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  String? id;
  String email = "";
  String? pwd;
  bool offsecure = true;
  RegExp regex = RegExp(r'^s\d{8}@stu\.najah\.edu$');
  RegExp gmail = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  RegExp yahoo = RegExp(r'^[a-zA-Z0-9._%+-]+@yahoo\.com$');
  RegExp outlook = RegExp(r'^[a-zA-Z0-9._%+-]+@outlook\.com$');

  TextEditingController _Email = TextEditingController();
  TextEditingController _Password = TextEditingController();
  GlobalKey<FormState> loginform = GlobalKey();
  final networkHandler = NetworkHandlerS();
  final networkHandlerC = NetworkHandlerC();
  void _togglePasswordVisibility() {
    setState(() {
      offsecure = !offsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 430),
              child: Image.asset(
                "images/logggin.jpeg",
                //fit: BoxFit.cover,

                width: 500,
                height: 1080,
              ),
              //child: Text("login"),
            ),
            Positioned(
              bottom: -40,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffE5E4E2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                ),
                padding: EdgeInsets.all(20),
                width: 410,
                height: 500,
                child: Form(
                  key: loginform,
                  child: PageView(
                    //Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _Email,
                            enableSuggestions: true,
                            onFieldSubmitted: (value) {
                              print("sumbited");
                            },
                            // padding: EdgeInsets.all(20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Colors.white,
                              hintText: "Insert your id",
                              hintStyle: GoogleFonts.salsa(
                                  textStyle: TextStyle(fontSize: 20)),
                              icon: Icon(
                                Icons.email,
                                size: 40,
                                color: Color.fromARGB(255, 10, 1, 71),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 10, 1, 71),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onSaved: (val) {
                              id = val;
                              //email.text= id!;
                              _Email.text = val!;
                            },

                            validator: (value) {
                              //if(value != Null){
                              if (value!.isEmpty) {
                                return "Empty Feild";
                              }
                              /*if(value.length<8 || (!value.contains('@')) ){
                      return "Empty Feild";
                    }*/

                              if (value.contains('@')) {
                                if (!regex.hasMatch(value) &&
                                    !gmail.hasMatch(value) &&
                                    !yahoo.hasMatch(value) &&
                                    !outlook.hasMatch(value)) {
                                  print("not match");
                                  return "invalid email";
                                } else {
                                  print("Match");
                                }
                              }
                              //if(value.length<8){return"";}
                              //}
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _Password,
                            obscureText: offsecure,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  size: 30,
                                  Icons.remove_red_eye_outlined,
                                  color: Color.fromARGB(255, 10, 1, 71),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _togglePasswordVisibility();
                                  });
                                },
                              ),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Colors.white,
                              hintText: "Password",
                              hintStyle: GoogleFonts.salsa(
                                  textStyle: TextStyle(fontSize: 20)),
                              icon: Icon(
                                Icons.key,
                                size: 40,
                                color: Color.fromARGB(255, 10, 1, 71),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 10, 1, 71),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onSaved: (val) {
                              pwd = val;
                              _Password.text = val!;
                            },
                            validator: (value) {
                              //if(value != Null){
                              if (value!.isEmpty) {
                                return "Empty Feild";
                              }
                              // Check the length (at least 8 characters)
                              if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              }

                              // Check for lowercase, uppercase, digit, and special character
                              if (!RegExp(
                                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])')
                                  .hasMatch(value)) {
                                return "Password must contain at least one lowercase letter,\n one uppercase letter, one digit, and one special character";
                              }

                              //if(value.length<8){return"";}
                              //}
                            },
                          ),
                          Container(
                            width: 453,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(38, 20, 1, 10),
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: MaterialButton(
                                child: Text(
                                  "LOGIN",
                                  style: GoogleFonts.salsa(
                                      textStyle: TextStyle(fontSize: 28)),
                                ),
                                textColor: Colors.white,
                                color: Color(0xff007BA7),
                                onPressed: () async {
                                  if (loginform.currentState!.validate()) {
                                    loginform.currentState!.save();
                                    print("valid");
                                    print(_Email.text);
                                    print(_Password.text);
                                    if (_Email.text.length == 5) {
                                      bool result =
                                          await networkHandlerC.LoginID(
                                              _Email.text, _Password.text);
                                      if (result == true) {
                                        print("success Login.....");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(0)));
                                      } else {
                                        print("Failed Login.....");
                                      }
                                    } else if (_Email.text.length == 8) {
                                      bool result =
                                          await networkHandler.LoginStudentID(
                                              _Email.text, _Password.text);
                                      if (result == true) {
                                        print("success Login.....");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomeStu(0)));
                                      } else {
                                        print("Failed Login.....");
                                      }
                                    } else if (regex.hasMatch(_Email.text)) {
                                      bool result = await networkHandler
                                          .LoginStudentFmail(
                                              _Email.text, _Password.text);
                                      if (result == true) {
                                        print("success Login.....");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(0)));
                                      } else {
                                        setState(() {
                                          loginform.printInfo(
                                              info: "invalid email");
                                          // return "invalid email";
                                        });
                                      }
                                    }
                                    if (gmail.hasMatch(_Email.text) ||
                                        yahoo.hasMatch(_Email.text) ||
                                        outlook.hasMatch(_Email.text)) {
                                      bool result =
                                          await networkHandlerC.LoginEmail(
                                              _Email.text, _Password.text);
                                      if (result == true) {
                                        print("success Login.....");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(0)));
                                      } else {
                                        print("Failed Login.....");
                                        /*setState(() {
                                loginform.printInfo(info:"invalid email",printFunction: GetUtils.);
                               // return "invalid email";
                              });*/
                                      }
                                    }
                                  } else {
                                    print("invalid");
                                  }
                                },
                                /*onPressed: () {
                        print("pressed");
                  },*/
                              ),
                            ),
                          ),
                          Container(
                            width: 433,
                            height: 30,
                            margin: EdgeInsets.fromLTRB(38, 20, 1, 20),
                            child: MaterialButton(
                              child: Text(
                                "Forgot password?",
                                style: GoogleFonts.salsa(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              textColor: Color(0xff555555),

                              // color: Color.fromARGB(255 ,248, 154, 0),
                              onPressed: () {
                               /* if (loginform.currentState!.validate()) {
                                  loginform.currentState!.save();
                                  print("valid");
                                  print("$id");
                                } else {
                                  print("invalid");
                                }*/

                                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ForgotPassworD()));
               

                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
