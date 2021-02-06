import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class Register_Screen extends StatefulWidget {
  @override
  Register_Screen_State createState() => Register_Screen_State();
}

class Register_Screen_State extends State<Register_Screen> {
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  bool _term_n_condition = false;

  //key for currentstate, it is used for the email & password input validator
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          child: Form(
            key: _form_key,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //upperpart
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                            "assets/images/logo.png",
                            height: 130,
                            width: 130,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      height: _screen_height / 4,
                      color: Colors.white,
                    ),
                    //lowerpart
                    Container(
                      height: _screen_height - (_screen_height / 4),
                      color: Colors.amberAccent,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              controller: _name_controller,
                              keyboardType: TextInputType.name,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please fill your name'),
                                PatternValidator(r"^[A-Za-z ]+$",
                                    errorText: 'Input alphabet only'),
                                MaxLengthValidator(50,
                                    errorText: 'Invalid name format.')
                              ]),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Name',
                                icon: Icon(Icons.person),
                                labelStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              controller: _email_controller,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please fill your email'),
                                EmailValidator(
                                    errorText: 'Invalid email format'),
                              ]),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Email',
                                icon: Icon(Icons.mail),
                                labelStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              controller: _phone_controller,
                              keyboardType: TextInputType.phone,
                              autovalidate: true,
                              maxLength: 11,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please fill your phone number'),
                                LengthRangeValidator(
                                    min: 10,
                                    max: 11,
                                    errorText: 'Input 10 - 11 numbers only.'),
                                PatternValidator(r"^[0-9]+$",
                                    errorText: "Input numbers only.")
                              ]),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Phone Number',
                                helperText: "0123456789",
                                icon: Icon(Icons.phone),
                                labelStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _password_controller,
                              obscureText: true,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please fill password'),
                                MinLengthValidator(5,
                                    errorText:
                                        'Password must be longer than 4 letters'),
                              ]),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Password',
                                icon: Icon(Icons.lock),
                                labelStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  value: _term_n_condition,
                                  onChanged: (bool value) {
                                    _onChange(value);
                                  },
                                ),
                                GestureDetector(
                                  onTap: _show_TnC,
                                  child: Text('I Agree to Terms and Conditions',
                                      style: TextStyle(
                                          color: Colors.brown[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 60,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(10, 0, 35, 25),
                            child: Container(
                              child: SizedBox(
                                height: 100,
                                width: 130,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    //if the 2 input are corect, process this
                                    if (_form_key.currentState.validate() &&
                                        _term_n_condition) {
                                      print(_name_controller);
                                      print(_email_controller.text);
                                      print(_phone_controller);
                                      print(_password_controller.text);
                                      _register();
                                    }
                                    //if all text field is filled, but not agree terms and conditions
                                    else if (_form_key.currentState
                                            .validate() &&
                                        !_term_n_condition) {
                                      Toast.show(
                                        "Please agree terms and conditions",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                      );
                                    }
                                    // if the any input is failed, process this
                                    else {
                                      Toast.show(
                                        "Please complete all the requirements",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.deepOrange[400],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed("/LoginScreen"),
                            child: Text(
                              '< Back to login page',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChange(bool value) {
    setState(() {
      _term_n_condition = value;
      //savepref(value);
    });
  }

  void _register() async {
    String _name = _name_controller.text;
    String _email = _email_controller.text;
    String _password = _password_controller.text;
    String _phone = _phone_controller.text;

    //final dateTime = DateTime.now();
    //String base64Image = base64Encode(_image.readAsBytesSync());
    //print(base64Image);
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Registration...");
    await pr.show();
    http.post("http://icebeary.com/hope4cat/register.php", body: {
      "name": _name,
      "email": _email,
      "phone": _phone,
      "password": _password,
      //"location": selectedLoc,
      //"encoded_string": base64Image,
      //"imagename": _phone + "-${dateTime.microsecondsSinceEpoch}",
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Registration success. An email has been sent to .$_email. Please check your email for OTP verification. Also check in your spam folder.",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Registration failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _show_TnC() {
    double _screen_height = MediaQuery.of(context).size.height;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Term and Condition"),
          content: Container(
            height: _screen_height / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Icebeary. This agreement governs your acquisition and use of our Hope 4 Cat software (Software) directly from Icebeary or indirectly through a Icebeary authorized reseller or distributor (a Reseller).Please read this agreement carefully before completing the installation process and using the Hope 4 Cat software. It provides a license to use the Hope 4 Cat software and contains warranty information and liability disclaimers. If you register for a free trial of the Hope 4 Cat software, this agreement will also govern that trial. By clicking accept or installing and/or using the Hope 4 Cat software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this agreement. If you are entering into this agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this agreement, do not install or use the Software, and you must not accept this agreement.This agreement shall apply only to the Software supplied by Icebeary herewith regardless of whether other software is referred to or described herein. The terms also apply to any Icebeary updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This was created by Template for Hope 4 Cat. Icebeary shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Icebeary. Icebeary reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
