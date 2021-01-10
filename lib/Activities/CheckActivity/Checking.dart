import 'package:fecom_xpress_app/Activities/LogIn/LogIn.dart';

import '../../Functions/Service/SharePreferences.dart';
import 'CheckInfo.dart';
import '../Accueil/Home.dart';
import 'package:flutter/material.dart';

class Checking extends StatefulWidget {

  @override
  _CheckingState createState()=>_CheckingState();
}

class _CheckingState extends State<Checking> {
  Share _sharing = Share();
  bool value;
  bool CheckFile = false;



  // ignore: non_constant_identifier_names
  Future<bool> Check()async{

    

      List<String> Passwords = _sharing.keys[1];
      if((await _sharing.IsExist(Passwords[0])) != true){
     await  _sharing.saveValueString(Passwords[0], "12345678");
     await _sharing.saveValueString(Passwords[1], "1234");
      await _sharing.saveValueString(Passwords[2], "1234");
      }
    CheckFile = await _sharing.IsExist(_sharing.keys[0][0]); 

    return CheckFile;
  }

 


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Check(),
        builder: (context, snap){
          if(snap.hasData){
            value = snap.data;
            if(value==true){return LogIn(messageError: "nothing",);} /// si true accede à l'application
            else return CheckInfo();  /// si licence =/= licence dans base des donnees

          }else return Center(
            child : CircularProgressIndicator(),
          ); /// si licence =/= licence dans base des donnees


        },

      ),
    );
  }
}







