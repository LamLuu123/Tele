import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'otp.dart';

class Singin extends StatefulWidget {
  const Singin({Key key}) : super(key: key);

  @override
  _Singin createState() => _Singin();
}

class _Singin extends State<Singin> {
  String DialCode = '+84';
  TextEditingController phone =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Otp(Phone: phone.text,))),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      children: const <Widget>[
                        Text('Your Phone Number', style: TextStyle(fontSize: 32)),
                        Text(
                          'Please confirm your contry code and enter your phone number.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 58,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CountryCodePicker(
                          initialSelection: 'VN',
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          alignLeft: true,
                          dialogBackgroundColor: Colors.black,
                          onChanged: (countryCode) {
                            setState(() {
                              DialCode = countryCode.dialCode;
                              print(DialCode);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Form(
                        key: _formKey,
                        child:
                      TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Phone number',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Text(
                              DialCode,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        maxLength: 10,
                        validator: (value) {
                            if(value.isEmpty) {
                              return 'Enter Phone number';
                            }
                            if(value.length<10||!RegExp(r'^[0-9]+$').hasMatch(value)){
                              return 'Invalid Phone number';
                            }
                            return null;
                        },
                      ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(_formKey.currentState.validate()){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) =>Otp(Phone: phone.text)));}},
            backgroundColor: Colors.blue,
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ));
}
