import 'package:authenticationdemo/calendar.dart';
import 'package:authenticationdemo/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;

void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      home: MyHomePage(title: 'SIGN UP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                 //   alignment: Alignment(20, -6),
                    image: AssetImage('images/thumbnail.png'),
//                  fit: BoxFit.contain,
                  )
              ),
              child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'WELCOME',
                              style: TextStyle(color: Colors.black,
                                  fontSize: 35,
                                  fontFamily: 'YellowTail')
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FlatButton(
                          color: Colors.black,
                          child: Text("Login"),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FlatButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text("Register"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
                        ),
                        FlatButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text("Calendar"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Calendar()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        )
    );
  }
}