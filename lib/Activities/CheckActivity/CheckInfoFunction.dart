import 'dart:io';

import '../../Functions/Service/services.dart';
import 'CheckInfo.dart';
import '../LogIn/LogIn.dart';
import 'package:flutter/material.dart';

class CheckInfoFunction extends StatefulWidget {
File f;
   CheckInfoFunction({this.f});

  @override
  _CheckInfoFunctionState createState() => _CheckInfoFunctionState();
}

class _CheckInfoFunctionState extends State<CheckInfoFunction> {

File file;
@override
  void initState() {
    file = widget.f;
  }

  @override
  Widget build(BuildContext context) {
initState();
    return Scaffold(
                      backgroundColor: Colors.white,
            body:  FutureBuilder(
      future: Services().GetInformation(file),
      builder: (context , snapshot){
      print("snapshot");
      print(snapshot.hasData);
      print(snapshot.data);
      print(snapshot.hasError);
      print(snapshot.error);
      print("------------------");
        if(snapshot.hasData) {

          bool value = snapshot.data;
          if (value == true) {

            return LogIn(messageError: "nothing",);

          } else {
            return Center(child:  CircularProgressIndicator(),);
          }
        }else{
          return Center(
            child:  CircularProgressIndicator(),   
            );
          
        
        }
      },

    ),
    );
    
    
   
  }
}
