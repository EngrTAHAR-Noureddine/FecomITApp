import 'dart:io';

import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';

import 'UpdateBody.dart';


class Update extends StatefulWidget {
  File file;
  Update({this.file});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
 File _file;
 @override
  void initState() {
    _file = widget.file;
  }
  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
              backgroundColor: Colors.white, /* ki choghl winha li applique 3Liha text direction  */
              appBar: MyAppBar( height:50,homeWidget: "backHome",chain: null,whereis: null,previous: null,),
              body: BodyUpdateFunction(file: _file),
              
    );
  }
}