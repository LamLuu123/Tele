import 'package:flutter/material.dart';
Future<String> PhoneDialog(
  BuildContext context,
  String phone1
)async => await showDialog(context: context, builder: (BuildContext ctx){
    String phone= phone1;
    return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState){
      return SimpleDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.fromLTRB(24, 10, 24, 0),
        title: Text('Phone change'),
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8),
          child:TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone number',
              hintText: 'Enter phone number',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value)=>setState(()=>phone=value),
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
                      onTap: (){Navigator.of(context,rootNavigator: true).pop(phone);},
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
  String name= name1;
  return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState){
    return SimpleDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.fromLTRB(24, 10, 24, 0),
      title: Text('Name change'),
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8),
          child:TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter name',focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value)=>setState(()=>name=value),
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
                    onTap: (){Navigator.of(context,rootNavigator: true).pop(name);},
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
                    onTap: (){Navigator.of(context,rootNavigator: true).pop(bio);},
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