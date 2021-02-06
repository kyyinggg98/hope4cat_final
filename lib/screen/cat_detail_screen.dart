import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global_state.dart';
import 'package:geocoder/geocoder.dart';

class Cat_Detail_Screen extends StatefulWidget {
  int index;
  Cat_Detail_Screen(this.index);
  @override
  _Cat_Detail_Screen_State createState() => _Cat_Detail_Screen_State(index);
}

class _Cat_Detail_Screen_State extends State<Cat_Detail_Screen> {
  TextEditingController _comment_controller = TextEditingController();
  int index;
  _Cat_Detail_Screen_State(this.index);
  Global_State _global_key = Global_State.instance;
  List list;
  String _addressLine;

  List _comment_list;
  int _comment_list_size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (index == 0) {
      list = _global_key.cat_list;
      print("size ${_global_key.cat_list.length}");
    } else if (index == 2) {
      list = _global_key.posted_cat_list;
      print("size ${_global_key.posted_cat_list.length}");
    } else if (index == 3) {
      list = _global_key.adopted_cat_list;
      print("size ${_global_key.adopted_cat_list.length}");
    }

    setState(() {
      _getCatLocation(list[_global_key.selected_index]['latitude'],
          list[_global_key.selected_index]['longitude']);
      _load_comment();
    });
  }

  //translate latitude and longitude into address
  _getCatLocation(String latitude, String longitude) async {
    double lat = double.parse(latitude);
    double long = double.parse(longitude);
    final coordinates = Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var address = addresses.first;
    setState(() {
      _addressLine = address.addressLine;
    });
    print(_addressLine);
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Row(children: [
            Text(
              "Hope 4 Cat",
              style: TextStyle(fontSize: 30),
            ),
          ]),
          actions: [
            Container(
              child: RaisedButton(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
                color: Colors.red[300],
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  setState(() {
                    _getCatLocation(
                        list[_global_key.selected_index]['latitude'],
                        list[_global_key.selected_index]['longitude']);
                    _load_comment();
                  });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //upperpart
                Container(
                  height: _screen_height / 4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 150,
                        width: 210,
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          border: Border.all(
                            width: 2,
                            color: Colors.amberAccent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          "http://icebeary.com/hope4cat_image/${list[_global_key.selected_index]['image']}",
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _screen_width,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "${list[_global_key.selected_index]["catname"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                  ),
                ),
                //lowerpart
                Container(
                  color: Colors.amberAccent[100],
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 5),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  "Publisher",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${list[_global_key.selected_index]["publisher"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 5),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Cat Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${list[_global_key.selected_index]["gender"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 5),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Fee",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${list[_global_key.selected_index]["fee"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 5),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _addressLine == null
                                ? Container(
                                    child: Text(
                                      "Refresh to see location",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 60,
                                    width: 200,
                                    child: Text(
                                      "$_addressLine",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 15),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${list[_global_key.selected_index]["description"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //forum part
                Container(
                  height: 40,
                  width: _screen_width,
                  color: Colors.amberAccent[700],
                  alignment: Alignment.center,
                  child: Text(
                    "Comment",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  child: _comments(),
                ),

                //comment part
                index != 0
                    ? Container()
                    : Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: TextField(
                          controller: _comment_controller,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            icon: Icon(
                              Icons.chat,
                              color: Colors.orange,
                            ),
                            hintText: "Write a comment...",
                            suffixIcon: GestureDetector(
                              onTap: _comment_controller.text.isEmpty == true
                                  ? null
                                  : _upload_comment,
                              child: Icon(
                                Icons.send,
                                color: Colors.orange,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.orange,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ),
                Container(
                  child: SizedBox(
                    height: 60,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: index != 0
            ? //comment part
            Container(
                child: TextField(
                  controller: _comment_controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    icon: Icon(
                      Icons.chat,
                      color: Colors.orange,
                    ),
                    hintText: "Write a comment...",
                    suffixIcon: GestureDetector(
                      onTap: _comment_controller.text.isEmpty == true
                          ? null
                          : _upload_comment,
                      child: Icon(
                        Icons.send,
                        color: Colors.orange,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: _screen_width,
                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      _makePaymentDialog();
                    });
                  },
                  child: Text(
                    "Adopt",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.red[400],
                ),
              ),
      ),
    );
  }

  _adopt_cat() async {
    String _email = _global_key.user_list[0]["email"];
    String _catid = list[_global_key.selected_index]["catid"];
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Adopting Cat...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/adopt_cat.php", body: {
      "email": _email,
      "catid": _catid,
    }).then((res) {
      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Adopting failed",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Adopting success",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        Navigator.of(context).pop();
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  //stop at here
  void _load_comment() async {
    String _catid = list[_global_key.selected_index]["catid"];
    http.post(
      'http://icebeary.com/hope4cat/load_comment.php',
      body: {
        "catid": _catid,
      },
    ).then((res) {
      if (res.body == 'nodata') {
        print('no data');
      } else {
        var cats_jscode = json.decode(res.body);
        _comment_list = cats_jscode['comments'];
        _comment_list_size = _comment_list.length;
        print(_comment_list_size);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _upload_comment() async {
    String _catid = list[_global_key.selected_index]["catid"];
    String _name = _global_key.user_list[0]["name"];
    String _comment = _comment_controller.text;
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Uploading Comment...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/upload_comment.php", body: {
      "catid": _catid,
      "name": _name,
      "comment": _comment,
    }).then((res) {
      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Upload comment failed",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Upload comment success",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        _comment_controller.clear();
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  //previous comments part
  Widget _comments() {
    return _comment_list_size == null
        ? Container(
            height: 100,
          )
        : Container(
            height: 270,
            child: ListView.builder(
              itemCount: _comment_list_size,
              itemBuilder: (context, index) => Container(
                color: Colors.amberAccent[100],
                margin: EdgeInsets.fromLTRB(0, 0, 2, 5),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ListTile(
                    title: Text(
                      "${_comment_list[index]["name"]}",
                      style: TextStyle(
                        color: Colors.deepOrange[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${_comment_list[index]["comment"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _forum() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          //add new comment part
          Container(
            child: TextField(
              controller: _comment_controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
              decoration: InputDecoration(
                filled: true,
                icon: Container(
                  child: Icon(
                    Icons.chat,
                    color: Colors.amber,
                  ),
                ),
                hintText: "Write a comment...",
                suffixIcon: GestureDetector(
                  onTap: _comment_controller.text.isEmpty == true
                      ? null
                      : _upload_comment,
                  child: Icon(
                    Icons.send,
                    color: Colors.orange,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.orange,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _makePaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Proceed with payment?',
          style: TextStyle(
              //color: Colors.white,
              ),
        ),
        content: new Text(
          'Are you sure to pay RM ' +
              "${list[_global_key.selected_index]["fee"]}" +
              "?",
          style: TextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                _global_key.value = list[_global_key.selected_index]["fee"];
                _global_key.catid = list[_global_key.selected_index]["catid"];
                Navigator.of(context).pop(false);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/BillScreen', (Route<dynamic> route) => true);
              },
              child: Text(
                "Yes",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }
}
