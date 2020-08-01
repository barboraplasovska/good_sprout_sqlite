// login_screen.dart
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_sprout/components/already_have_account_check.dart';
import 'package:good_sprout/components/rounded_button.dart';
import 'package:good_sprout/components/rounded_input_field.dart';
import 'package:good_sprout/components/rounded_password_field.dart';
import 'package:good_sprout/screens/signup/signup_screen.dart';

import 'package:good_sprout/services/auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormMode { LOGIN }

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();
  ScrollController scrollController = new ScrollController();

  String _email;
  String _password;
  // ignore: unused_field
  String _displayName;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        _showErrorMessage();
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: Text(
                          'Already have an account?',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      RoundedInputField(
                        hintText: 'email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          }); //get the value entered by user.
                        },
                      ),
                      RoundedPasswordField(
                        hintText: 'password',
                        validator: (value) => value.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          }); //get the value entered by user.
                        },
                      ),
                      RoundedButton(
                        text: 'Login',
                        press: () {
                          _validateAndSubmit();
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      AlreadyHaveAnAccountCheck(
                        login: true,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Error'),
                content: Text(_errorMessage),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close me!'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
  */
