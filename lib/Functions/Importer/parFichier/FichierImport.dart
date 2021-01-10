import 'dart:io';

import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';

import 'SupprimerTous.dart';

class ImportFile extends StatefulWidget {
  File file;
  ImportFile({this.file});
  @override
  _ImportFileState createState() => _ImportFileState();
}

class _ImportFileState extends State<ImportFile> {
  
  File _myfile;
  @override
  void initState() {
    _myfile=widget.file;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    print("csv importer widget mother ********");
    return Scaffold(
              backgroundColor: Colors.white, 
              appBar: MyAppBar( height:50,homeWidget: "true",chain: null,previous: null,whereis: null,),
              body: DeleteAll(file: _myfile), //Container(),
        
    );
  }
}