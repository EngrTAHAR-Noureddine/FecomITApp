import '../../Functions/Service/SharePreferences.dart';
import '../../Functions/Service/services.dart';
import '../Accueil/Home.dart';
import 'LogIn.dart';
import 'package:flutter/material.dart';

class LogFunction extends StatefulWidget {
  String pass;

  LogFunction({ this.pass});
  @override
  _LogFunctionState createState() => _LogFunctionState();
}

class _LogFunctionState extends State<LogFunction> {

  String _pass;

  @override
  void initState() {

    _pass = widget.pass;
  }


  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
      future: Services().Login(_pass),
      builder: (context , snapshot){
        print("snapshot ***** ");
        print(snapshot.hasData);
        print(snapshot.data);
        print(snapshot.hasError);
        print(snapshot.error);
       
        
        if(snapshot.hasData) {
          String value = snapshot.data;
          if (value != "null") {

            return Home();
          } else {

            return LogIn(messageError: "ce n'est pas le mot de pass ",);
          }
        }else{

          return  Center(
              child: CircularProgressIndicator(),
               );
        }
      },

    ),
    );
  }
}
