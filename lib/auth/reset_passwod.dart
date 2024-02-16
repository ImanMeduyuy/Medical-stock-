import 'package:flutter/material.dart';
import 'package:stock_medical/auth/signin_screen.dart';

class reset_password extends StatefulWidget {
  @override
  _reset_passwordState createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasSpecialCharacter = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final regExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      _hasSpecialCharacter = false;
      if (regExp.hasMatch(password)) _hasSpecialCharacter = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                      child: Text('Set New Password',
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 200.0, 10.0, 0.0),
                      child: Text(
                          'Please create a strong password including the following criteria below.',
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.black87)),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (password) => onPasswordChanged(password),
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                          filled: true,
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: _isPasswordEightCharacters
                                    ? Colors.green
                                    : Colors.transparent,
                                border: _isPasswordEightCharacters
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Contains at least 8 characters")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: _hasPasswordOneNumber
                                    ? Colors.green
                                    : Colors.transparent,
                                border: _hasPasswordOneNumber
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Contains at least 1 number")
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: _hasSpecialCharacter
                                    ? Colors.green
                                    : Colors.transparent,
                                border: _hasSpecialCharacter
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Contains at least 1 special character")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.lightBlueAccent,
                          elevation: 15.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()),
                              );
                            },
                            child: Center(
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ))
            ])));
  }
}
