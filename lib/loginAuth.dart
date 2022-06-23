import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'home.dart';
import 'registeraccount.dart';

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginAuthPage(),
//     ));
// SharedPreferences? prefs;

class LoginAuthPage extends StatefulWidget {
  @override
  State<LoginAuthPage> createState() => _LoginAuthPageState();
}

class _LoginAuthPageState extends State<LoginAuthPage> {
  late bool _passwordVisible;

  bool isEnabled = true;

  // enableButton() {
  //   setState(() {
  //     isEnabled = true;
  //   });
  // }

  // disableButton() {
  //   setState(() {
  //     isEnabled = false;
  //   });
  // }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black45,
          ),
        );
      },
    );
  }

  // signin() {
  //   if (email.text.isEmpty || password.text.isEmpty) {
  //     CoolAlert.show(
  //       context: context,
  //       type: CoolAlertType.error,
  //       text: 'Note: Check for valid inputs',
  //       loopAnimation: false,
  //     ).whenComplete(() => isEnabled = true);
  //   } else {
  //     Future<Map<String, dynamic>> fetchPost() async {
  //       try {
  //         final response = await http.post(
  //             Uri.parse("https://hrap.ce-construction.com/hrtoken"),
  //             headers: {
  //               HttpHeaders.authorizationHeader: "Bearer token",
  //               HttpHeaders.contentTypeHeader:
  //                   "application/x-www-form-urlencoded"
  //             },
  //             encoding: Encoding.getByName("utf-8"),
  //             body: {
  //               "username": email.text,
  //               "password": password.text,
  //               "grant_type": "password"
  //             });
  //         final responseJson = json.decode(response.body);

  //         if (response.statusCode == 200) {
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setString('access_token', responseJson['access_token']);
  //           ScaffoldMessenger.of(context)
  //               .showSnackBar(SnackBar(
  //                 content: Text('Login successful'),
  //                 duration: Duration(milliseconds: 150),
  //               ))
  //               .closed
  //               .then((value) => isEnabled = true);

  //           return (responseJson);
  //         } else {
  //           ScaffoldMessenger.of(context)
  //               .showSnackBar(SnackBar(
  //                 content: Text('Login Unsuccessful'),
  //                 duration: Duration(milliseconds: 50),
  //               ))
  //               .closed
  //               .then((value) => isEnabled = true);

  //           //print(response.body);

  //           // If the server did not return a 201 CREATED response,
  //           // then throw an exception.
  //           throw Exception('Failed to create');
  //         }
  //       } on SocketException {
  //         throw Container();
  //       }
  //     }

  //     fetchPost();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background1.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                      Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/lightoff.png'))),
                          )),
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(top: 70),
                        child: Center(
                          child: Text(
                            "CE HRMS Login",
                            style: TextStyle(
                                color: Color(0xFFFFD831),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Shannon'),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                  hintText: "Phone Number Example:9800000000",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Shannon'),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                obscureText: !_passwordVisible,
                                controller: password,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontFamily: 'Shannon')),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          primary: Color.fromRGBO(255, 216, 49, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color(0xFF1C212D), fontFamily: 'Shannon'),
                        ),
                        onPressed: () async {
                          print(
                              'Email: ${email.text}, Password: ${password.text}');

                          final message = await AuthService().login(
                            email: email.text,
                            password: password.text,
                          );
                          if (message!.contains('Success')) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
                Text(
                  "Note: Please contact HR if you forget your password.",
                  style: TextStyle(
                      color: Color(0xFF1C212D), fontFamily: 'Shannon'),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
