import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: LoginScreen(),),);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _otp = TextEditingController();
  TextEditingController _phone_number = TextEditingController();
  Map<String, String> headers = {"Content-type": "application/json"};
  String body="";

   Future<User> login(String otp, String phone_number) async {
    final http.Response response = await http.post(
      'https://calendlio.sarayulabs.com/api/auth/login',
      headers: headers,
      body:jsonEncode(<String, String>{
        "otp": otp,//edit text
        "phone_number": phone_number,//edit text
      }),
    );
    print("otp "+otp);
    print("phone number "+phone_number);

    if (response.statusCode == 200) {
      print('logged in successfully!');
      body= response.body;
      print(body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album. ' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phone_number,
                decoration: const InputDecoration(labelText: 'Phone Number', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _otp,
                decoration: const InputDecoration(labelText: 'OTP', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                child: Text("Login"),
                textColor: Colors.white,
                onPressed: (){
                  login(_otp.text.toString(), _phone_number.text.toString());   // fetchPost();
                },
                color: Colors.black,
              ),
              Text(body),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
  login(_otp.toString(), _phone_number.toString());   // fetchPost();
  }
}

class User {
  final String otp;
  final String phone_number;

  User({this.otp, this.phone_number});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      otp: json['otp'],
      phone_number: json['phone_number'],
    );
  }
}