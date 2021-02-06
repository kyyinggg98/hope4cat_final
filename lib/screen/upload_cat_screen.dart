import 'dart:convert';

import 'package:flutter/material.dart';
import '../global_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Upload_Cat_Screen extends StatefulWidget {
  @override
  Upload_Cat_Screen_State createState() => Upload_Cat_Screen_State();
}

class Upload_Cat_Screen_State extends State<Upload_Cat_Screen> {
  Global_State _global_key = Global_State.instance;
  TextEditingController _catname_controller = TextEditingController();
  TextEditingController _fee_controller = TextEditingController();
  TextEditingController _gender_controller = TextEditingController();
  TextEditingController _cat_detail_controller = TextEditingController();
  //key for currentstate, it is used for the email & password input validator
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();
  File _image;
  String _base64Image;
  String _filename;

  Future _get_image() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _base64Image = base64Encode(_image.readAsBytesSync());
      _filename = _image.path.split("/").last;
      print(_image);
      print(_base64Image);
      print(_filename);
    });
  }

  _getLocation() async {
    Position _center = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      LatLng _lastMapPosition = LatLng(_center.latitude, _center.longitude);
      print(_lastMapPosition);
      _global_key.latitude = _lastMapPosition.latitude;
      _global_key.longitude = _lastMapPosition.longitude;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            "Hope 4 Cat",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form_key,
            child: Container(
              child: Column(
                children: [
                  //upperpart
                  Container(
                    height: _screen_height / 3.3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 150,
                          width: 210,
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            child: _image == null
                                ? Icon(
                                    Icons.image,
                                    size: 130,
                                    color: Colors.white,
                                  )
                                : Image.file(_image),
                            onTap: _get_image,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //lowerpart
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            controller: _catname_controller,
                            keyboardType: TextInputType.text,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill in Cat Name'),
                            ]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: 'Cat Name',
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
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 90,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _gender_controller,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill in gender'),
                            ]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: 'Cat Gender',
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
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 90,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _fee_controller,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill in fee required'),
                            ]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: 'Fee',
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
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/MapScreen',
                                            (Route<dynamic> route) => true);
                                  },
                                  child: Text(
                                    "Select Location",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.red[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                          child: TextFormField(
                            maxLines: 7,
                            keyboardType: TextInputType.multiline,
                            controller: _cat_detail_controller,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill in the cat detail'),
                            ]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: 'Cat Detail',
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
                                borderRadius: BorderRadius.circular(10),
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
                              width: 130,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  //if the 2 input are corect, process this
                                  if (_form_key.currentState.validate()) {
                                    _upload_cat();
                                  }
                                  // if the any input is failed, process this
                                  else {
                                    Toast.show(
                                      "Please fill in email and password",
                                      context,
                                      duration: 4,
                                      gravity: Toast.BOTTOM,
                                    );
                                  }
                                },
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.red[300],
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
        bottomNavigationBar: Row(
          children: [
            _build_bottom_navigation_bar_item(
              index: 0,
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              title: "Home",
            ),
            _build_bottom_navigation_bar_item(
              index: 1,
              icon: Icon(
                Icons.upload_file,
                size: 30,
              ),
              title: "Upload",
            ),
            _build_bottom_navigation_bar_item(
              index: 2,
              icon: Icon(
                Icons.done,
                size: 30,
              ),
              title: "Posted",
            ),
            _build_bottom_navigation_bar_item(
              index: 3,
              icon: Icon(
                Icons.person_pin,
                size: 30,
              ),
              title: "Account",
            ),
          ],
        ),
      ),
    );
  }

  //customised bottom navigation bar item
  Widget _build_bottom_navigation_bar_item(
      {int index, Icon icon, String title}) {
    return GestureDetector(
      onTap: () => setState(
        () {
          _global_key.navigation_bar_index = index;
          print(index); //check index
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
            _global_key.latitude = null;
            _global_key.longitude = null;
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed("/PostedScreen");
            _global_key.latitude = null;
            _global_key.longitude = null;
          } else if (index == 3) {
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
            _global_key.latitude = null;
            _global_key.longitude = null;
          }
        },
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          gradient: _global_key.navigation_bar_index == index
              ? LinearGradient(
                  colors: [
                    Colors.yellowAccent.withOpacity(0.9),
                    Colors.yellowAccent.withOpacity(0.01),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
        ),
        child: Column(
          children: [
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }

  void _upload_cat() async {
    String _cat_name = _catname_controller.text;
    String _gender = _gender_controller.text;
    String _fee = _fee_controller.text;
    String _latitude = _global_key.latitude.toStringAsFixed(6);
    String _longitude = _global_key.longitude.toStringAsFixed(6);
    String _cat_detail = _cat_detail_controller.text;
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Upload Cat Information...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/upload_cat.php", body: {
      "base64Image": _base64Image,
      "image": _filename,
      "email": _global_key.user_list[0]['email'],
      "publisher": _global_key.user_list[0]["name"],
      "gender": _gender,
      "fee": _fee,
      "latitude": _latitude,
      "longitude": _longitude,
      "cat_detail": _cat_detail,
      "cat_name": _cat_name,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Upload cat information success",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        _global_key.latitude = null;
        _global_key.longitude = null;
        _catname_controller.clear();
        _gender_controller.clear();
        _fee_controller.clear();
        _cat_detail_controller.clear();
      } else {
        Toast.show(
          "Upload cat detail failed",
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
