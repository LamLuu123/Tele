import 'dart:async';

import 'package:flutter/material.dart';

import 'Database.dart';
import 'Home.dart';
import 'data.dart';
import 'signup.dart';

class Otp extends StatefulWidget {
  final String Phone;
  const Otp({Key key, @required this.Phone}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool Exsis;
  Timer time;
  Duration duration = const Duration(seconds: 150);
  TextEditingController controll1 = TextEditingController();
  TextEditingController controll2 = TextEditingController();
  TextEditingController controll3 = TextEditingController();
  TextEditingController controll4 = TextEditingController();
  final _otpKey=GlobalKey<FormState>();
  String correct='';
  void getAcc(String phone) async {
    await FirebaseApi.getAcc(phone).then((value){
      String idUser;
      String name;
      String urlAvatar;
      String Bio;
      String Phone;
      if(value.size!=0){
        setState(() {
          Exsis=true;
        });
      value.docs.first.data().forEach((key, value) {
        switch(key){
          case "name":
            name=value;
            break;
          case "idUser":
            idUser=value;
            break;
          case "urlAvatar":
            urlAvatar=value;
            break;
          case "bio":
            Bio=value;
            break;
          case "phone":
            Phone=value;
            break;
        }
      });
      account = accData(idUser:idUser,name: name, urlAvatar: urlAvatar, Bio: Bio, Phone: Phone);
    }else {
        setState(() {
          Exsis=false;
        });
      }});
    //print(account.name.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StartTime();
    print(widget.Phone);
    getAcc(widget.Phone);
  }
  void subTime() {
    final sub = 1;
    setState(() {
      final Sec = duration.inSeconds - sub;
      if (Sec <= 0) time.cancel();
      duration = Duration(seconds: Sec);
    });
  }

  void StartTime() {
    time = Timer.periodic(const Duration(seconds: 1), (_) => subTime());
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {time.cancel();Navigator.pop(context);},
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                      width: 500,
                      height: 100,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Enter code',
                              style: TextStyle(fontSize: 36),
                            ),
                            Text(
                              'We’ve sent an SMS with an activation code to your phone ${widget.Phone}.',
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(
                                first: true, last: false, controll: controll1),
                            _textFieldOTP(
                                first: false, last: false, controll: controll2),
                            _textFieldOTP(
                                first: false, last: false, controll: controll3),
                            _LasttextFieldOTP(
                                first: false, last: true, controll: controll4)
                          ]),
                        if (!(correct=='Verifed!'))
                          Text(correct,
                            style: const TextStyle(color: Colors.red),)
                        else Text(correct,
                          style: const TextStyle(color: Colors.green),),
                        const SizedBox(
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BuildTime(),
                  )
                ],
              ),
            ),
          ),
        ));

  Widget _textFieldOTP({bool first,bool last, TextEditingController controll}) => Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          controller: controll,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              correct='';
            });
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              setState(() {
                correct='';
              });
            }
            if (value == '' && first == false || value == null && first == false){
              FocusScope.of(context).previousFocus();
              setState(() {
                correct='';
              });
            }
          },
          showCursor: true,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  Widget _LasttextFieldOTP({bool first,bool last, TextEditingController controll}) => Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          controller: controll,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              correct='';
            });
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              setState(() {
                correct='';
              });
            }
            if (value == '' && first == false || value == null && first == false||value.length == 0 && first == false){
              setState(() {
                correct='';
              });
              FocusScope.of(context).previousFocus();
            }
            if(controll1.text=='2'&&controll2.text=='8'&&controll3.text=='5'&&controll4.text=='1'){
              if(Exsis){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
              setState(() {
                correct='Verifed!';
              });}else{
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Singup(phone:widget.Phone)));
                setState(() {
                  correct='Verifed!';
                });
              }
            }else{
              if (value == ''){
                setState(() {
                  correct='';
                });
              }else{
              setState(() {
                correct='Incorect verification code!';
              });}
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Colors.white), borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Colors.purple), borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );

  Widget BuildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final min = duration.inMinutes.remainder(60);
    final sec = twoDigits(duration.inSeconds.remainder(60));
    bool timeOut = false;
    if (min.toInt() == 0 && sec.toString() == "00") {
      timeOut = true;
    }

    return !timeOut
        ? RichText(
      text: TextSpan(text: 'You can request a voice call in ',
          style: const TextStyle(color: Colors.white), children: <TextSpan>[
        TextSpan(text: '$min:$sec',
            style: const TextStyle(color: Colors.blue)),
      ]),
    )
        : RichText(
      text: const TextSpan(text: 'You can request a voice call in ',
          style: TextStyle(color: Colors.white), children: <TextSpan>[
        TextSpan(text: 'call now', style: TextStyle(color: Colors.blue)),
      ]),
    );
  }
}
