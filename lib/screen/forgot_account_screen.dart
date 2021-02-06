import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class Forgot_Account extends StatefulWidget {
  @override
  Forgot_Account_State createState() => Forgot_Account_State();
}

class Forgot_Account_State extends State<Forgot_Account> {
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();

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
                      height: _screen_height - (_screen_height / 2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 250,
                            width: 250,
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    //lowerpart
                    Container(
                      height: _screen_height - (_screen_height / 2),
                      color: Colors.amberAccent,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
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
                                    errorText: 'Please fill in email'),
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
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              controller: _password_controller,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please fill in new password'),
                                MinLengthValidator(5,
                                    errorText:
                                        'Password must be longer than 4 letters'),
                              ]),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'New Password',
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
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 70,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(10, 0, 35, 25),
                            child: Container(
                              child: SizedBox(
                                height: 100,
                                width: 240,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    //if the 2 input are corect, process this
                                    if (_form_key.currentState.validate()) {
                                      _redeem_account();
                                    }
                                    // if the any input is failed, process this
                                    else {
                                      print('failed');
                                    }
                                  },
                                  child: Text(
                                    "Change Password",
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

  void _redeem_account() async {
    String _email = _email_controller.text;
    String _password = _email_controller.text;
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Redeem Account...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/forgot_account.php", body: {
      "email": _email,
      "password": _password,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Change password success. An email has been sent to .$_email. Please check your email for your password changing verification",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "No registered email",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
