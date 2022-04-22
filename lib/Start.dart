import 'package:flutter/material.dart';
import 'Home.dart';

class Start extends StatefulWidget {
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<Start> {
  @override
  Widget build(BuildContext context) {
    final _button = ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Home(),
              transitionsBuilder: (c, anim, a2, child) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                    parent: anim,
                    curve: Curves.easeOut,
                  )),
                  child: child),
              transitionDuration: const Duration(milliseconds: 2000),
              //transitionDuration: Duration(milliseconds: 2000),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          primary: const Color.fromRGBO(0, 0, 255, 0.8),
        ),
        child: const Text(
          'Start Messaging',
        ));
    final box = SizedBox(height: 50, width: 200, child: _button);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 80,
                  left: MediaQuery.of(context).size.width * 0.5 - box.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: box,
                  ),
                )
              ],
            )));
  }

}
