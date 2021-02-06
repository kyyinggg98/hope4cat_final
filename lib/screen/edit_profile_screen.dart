import 'package:flutter/material.dart';
import '../global_state.dart';
import 'package:toast/toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class Edit_Profile_Screen extends StatefulWidget {
  @override
  _Edit_Profile_Screen_State createState() => _Edit_Profile_Screen_State();
}

class _Edit_Profile_Screen_State extends State<Edit_Profile_Screen> {
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();

  Global_State _global_key = Global_State.instance;

  //key for currentstate, it is used for the email & password input validator
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email_controller.text = "${_global_key.user_list[0]["email"]}";
    _name_controller.text = "${_global_key.user_list[0]["name"]}";
    _phone_controller.text = "${_global_key.user_list[0]["phone"]}";
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            "Hope 4 Cat",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body:
            //lowerpart
            Form(
          key: _form_key,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.amberAccent,
              child: Column(
                children: [
                  //upperpart
                  Container(
                    height: _screen_height / 3,
                    width: _screen_width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  //lowerpart
                  Container(
                    height: _screen_height - (_screen_height / 3),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 90,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            controller: _email_controller,
                            keyboardType: TextInputType.emailAddress,
                            autovalidate: true,
                            enabled: false,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill your email'),
                              EmailValidator(errorText: 'Invalid email format'),
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
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
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
                        SizedBox(height: 20),
                        Container(
                          height: 60,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(10, 0, 35, 25),
                          child: Container(
                            child: SizedBox(
                              height: 120,
                              width: 200,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  //if the 2 input are corect, process this
                                  if (_form_key.currentState.validate()) {
                                    print(_name_controller.text);
                                    print(_email_controller.text);
                                    print(_phone_controller.text);
                                    _edit();
                                  }
                                  // if the any input is failed, process this
                                  else {
                                    Toast.show(
                                      "Please complete all the requirements",
                                      context,
                                      duration: 4,
                                      gravity: Toast.BOTTOM,
                                    );
                                  }
                                },
                                child: Text(
                                  "Save Changes",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _edit() async {
    String _name = _name_controller.text;
    String _email = _email_controller.text;
    String _phone = _phone_controller.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Edit Confirmation'),
          contentPadding: EdgeInsets.fromLTRB(25, 5, 10, 0),
          children: [
            Text(
                'Input your current password to confirm chaging profile information.'),
            Container(
              height: 90,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password_controller,
                obscureText: true,
                autovalidate: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please fill in password'),
                  MinLengthValidator(5,
                      errorText: 'Password must be longer than 4 letters'),
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
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () async {
                    if (_password_controller.text == _global_key.password) {
                      ProgressDialog pr = ProgressDialog(context,
                          type: ProgressDialogType.Normal,
                          isDismissible: false);
                      pr.style(message: "Editing Profile...");
                      await pr.show();
                      http.post("http://icebeary.com/hope4cat/edit_profile.php",
                          body: {
                            "email": _email,
                            "name": _name,
                            "phone": _phone,
                          }).then((res) {
                        print(res.body);
                        if (res.body == "success") {
                          _global_key.user_list[0]["name"] = _name;
                          _global_key.user_list[0]["phone"] = _phone;
                          Toast.show(
                            "Edit profile success",
                            context,
                            duration: 4,
                            gravity: Toast.BOTTOM,
                          );
                          _password_controller.clear();
                          Navigator.of(context).pop();
                        } else {
                          Toast.show(
                            "Edit profile failed",
                            context,
                            duration: 4,
                            gravity: Toast.BOTTOM,
                          );
                        }
                      }).catchError((err) {
                        print(err);
                      });
                      await pr.hide();
                    } else {
                      Toast.show(
                        "Wrong password",
                        context,
                        duration: 4,
                        gravity: Toast.BOTTOM,
                      );
                    }
                  },
                  child: Text('Confirm'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
