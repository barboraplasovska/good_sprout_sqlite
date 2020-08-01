// signup_screen.dart
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:good_sprout/components/already_have_account_check.dart';
import 'package:good_sprout/components/rounded_button.dart';
import 'package:good_sprout/components/rounded_input_field.dart';
import 'package:good_sprout/components/rounded_password_field.dart';
import 'package:good_sprout/screens/login/login_screen.dart';
import 'package:good_sprout/services/auth.dart';
import 'package:logging/logging.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

enum FormMode { SIGNUP }

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _registerFormKey = GlobalKey<FormState>();
  ScrollController scrollController = new ScrollController();

  final log = Logger('_validateAndSubmit');

  String _email;
  String _password;
  // ignore: unused_field
  String _displayName;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.SIGNUP;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _registerFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.SIGNUP) {
          log.info(widget.auth);
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
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
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Text(
                        'Hi there, I\'m',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SvgPicture.asset(
                        'assets/images/goodsprout.svg',
                        height: size.height * 0.1,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Here\'s your first step!',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      RoundedInputField(
                        hintText: 'username',
                        validator: (value) =>
                            value.isEmpty ? 'Enter an username' : null,
                        onChanged: (value) {
                          setState(() {
                            _displayName = value.trim();
                          }); //get the value entered by user.
                        },
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
                        text: 'Sing up',
                        press: () {
                          _validateAndSubmit();
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
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
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color.fromRGBO(8, 121, 47, 1),
        ),
      ));
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

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
  */
