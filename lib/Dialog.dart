import 'package:flutter/material.dart';
Future<String> PhoneDialog(
  BuildContext context,
  String phone1
)async => await showDialog(context: context, builder: (BuildContext ctx){
  TextEditingController Dt= TextEditingController();
  Dt.text=phone1;
  final _formKey = GlobalKey<FormState>();
    String phone= phone1;
    return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState){
      return SimpleDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.fromLTRB(24, 10, 24, 0),
        title: Text('Phone change'),
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8),
          child:Form(key:_formKey,child: TextFormField(
            controller: Dt,
        keyboardType: TextInputType.number,
          decoration: InputDecoration(
          labelText: 'Phone number',
          hintText: 'Enter phone number',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
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
      onChanged: (value)=>setState(()=>phone=value),
      ),),),Align(
            alignment: Alignment.bottomRight,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 90,
                child: Row(
                  children: <Widget>[


                    GestureDetector(
                      onTap: (){Navigator.of(context,rootNavigator: true).pop(null);},
                      child: Text("Cancel",style: TextStyle(color: Colors.red),),
                    ),SizedBox(width: 10,),GestureDetector(
                      onTap: (){if(_formKey.currentState.validate()){Navigator.of(context,rootNavigator: true).pop(Dt.text);}},
                      child: Text("Apply",style: TextStyle(color: Colors.blue),),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  });
Future<String> NameDialog(
    BuildContext context,
    String name1
    )async => await showDialog(context: context, builder: (BuildContext ctx){
  TextEditingController Dt= TextEditingController();
  Dt.text=name1;
  final _formKey1 = GlobalKey<FormState>();
  String name= name1;
  return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState){
    return SimpleDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.fromLTRB(24, 10, 24, 0),
      title: Text('Name change'),
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8),
          child:Form(key: _formKey1,
            child: TextFormField(
              controller: Dt,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter name',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Enter Name';
                }
                if(value.length<=1){
                  return 'Name does not long enough';
                }
                return null;
              },
              onChanged: (value)=>setState(()=>name=value),
            ),
          ),),
        Align(
          alignment: Alignment.bottomRight,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 90,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){Navigator.of(context,rootNavigator: true).pop(null);},
                    child: Text("Cancel",style: TextStyle(color: Colors.red),),
                  ),SizedBox(width: 10,),GestureDetector(
                    onTap: (){if(_formKey1.currentState.validate()){Navigator.of(context,rootNavigator: true).pop(Dt.text);}},
                    child: Text("Apply",style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  });
});
Future<String> BioDialog(
    BuildContext context,
    String bio1
    )async => await showDialog(context: context, builder: (BuildContext ctx){
  TextEditingController Dt= TextEditingController();
  Dt.text=bio1;
  String bio= bio1;
  return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState){
    return SimpleDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.fromLTRB(24, 10, 24, 0),
      title: Text('Add Bio'),
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8),
          child:TextFormField(
            controller: Dt,
            decoration: InputDecoration(
              labelText: 'Bio',
              hintText: 'Enter bio',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value)=>setState(()=>bio=value),
          ),),Align(
          alignment: Alignment.bottomRight,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 90,
              child: Row(
                children: <Widget>[


                  GestureDetector(
                    onTap: (){Navigator.of(context,rootNavigator: true).pop(null);},
                    child: Text("Cancel",style: TextStyle(color: Colors.red),),
                  ),SizedBox(width: 10,),GestureDetector(
                    onTap: (){Navigator.of(context,rootNavigator: true).pop(Dt.text);},
                    child: Text("Apply",style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  });
});