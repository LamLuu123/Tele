import 'package:flutter/material.dart';

import 'Database.dart';
import 'Home.dart';
import 'Singin.dart';
import 'user.dart';

class Singup extends StatefulWidget {
  final String phone;
  const Singup({Key key,@required this.phone}) : super(key: key);

  @override
  _Singup createState() => _Singup();
}

class _Singup extends State<Singup> {
  User newUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController First=TextEditingController();
    TextEditingController Last=TextEditingController();
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Singin())),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                      width: 400,
                      height: 100,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Profile  info',
                              style: TextStyle(fontSize: 36),
                            ),
                            Text(
                              'Enter your name and add a profile picture',
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              width: 150,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: TextFormField(
                                  //autofocus: true,
                                  controller: First,
                                  onChanged: (value) {},
                                  showCursor: true,
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(counter: Offstage(), enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.purple), borderRadius: BorderRadius.circular(12)), hintText: "First name"),
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 150,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: TextFormField(
                                  //autofocus: true,
                                  controller: Last,
                                  onChanged: (value) {},
                                  showCursor: true,
                                  readOnly: false,
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(counter: Offstage(), enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.purple), borderRadius: BorderRadius.circular(12)), hintText: "Last name"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Align(
                    child: Text('By signing up,'),
                    alignment: Alignment.bottomLeft,
                  ),
                  Align(
                    child: RichText(
                      text: TextSpan(text: 'you agree to the ', style: TextStyle(color: Colors.white), children: <TextSpan>[
                        TextSpan(text: 'Term of Service', style: TextStyle(color: Colors.blue)),
                      ]),
                    ),
                    alignment: Alignment.bottomLeft,
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue, onPressed: () {
              setState(() {
                newUser=User(urlAvatar: 'https://i.pinimg.com/originals/57/fb/31/57fb3190d0cc1726d782c4e25e8561e9.png', LastMess: 'Say Hi...', Bio: 'Bio', name: First.text+" "+Last.text, Phone: widget.phone, lastMessageTime: DateTime.now());
              });
              FirebaseApi.addNewUsers(newUser);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
          ),
        ));
  }
}
