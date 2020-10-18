import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: RegisterScreen(),),);
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _first_name = TextEditingController();
  TextEditingController _last_name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone_number = TextEditingController();
  Map<String, String> headers = {"Content-type": "application/json"};
  String body="";

  Future<User> login(String email, String first_name, String last_name, String address, String phone_number) async {
    final http.Response response = await http.post(
      'https://calendlio.sarayulabs.com/api/auth/register',
      headers: headers,
      body:jsonEncode(<String, String>{
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
        "address": address,
        "phone_number": phone_number
      }),
    );
    print("phone number "+phone_number);

    if (response.statusCode == 201) {
      print('successfully created !');
      body= response.body;
      print(body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create ' + response.statusCode.toString());
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
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _first_name,
                decoration: const InputDecoration(labelText: 'First Name', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _last_name,
                decoration: const InputDecoration(labelText: 'Last Name', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'Address', contentPadding: EdgeInsets.all(15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
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
              FlatButton(
                child: Text("Register"),
                textColor: Colors.white,
                onPressed: (){
                  login(_email.text.toString(), _first_name.text.toString(), _last_name.text.toString(), _address.text.toString(), _phone_number.text.toString());   // fetchPost();
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

//  @override
//  void initState(){
//    login(_otp.toString(), _phone_number.toString());   // fetchPost();
//  }
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