

import 'dart:io';

import 'package:fecom_xpress_app/Functions/Importer/parFichier/FichierImporterBody.dart';
import 'package:fecom_xpress_app/Functions/Service/services.dart';

import 'package:flutter/material.dart';

class DeleteAll extends StatefulWidget {
  File file;
  DeleteAll({this.file});
  @override
  _DeleteAllState createState() => _DeleteAllState();
}

class _DeleteAllState extends State<DeleteAll> {
  File file;
  @override
  void initState() {
    file = widget.file;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  FutureBuilder(
      future: Services().supprimer(),
      builder: (context , snapshot){
        if(snapshot.hasData) {

          bool value = snapshot.data;
          if (value == true) {

            return BodyImporteFichier(file: file);

          } else {
            return Center(child: 

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircularProgressIndicator(),
                 Text("supprimer (il ne fault pas de sortir)...")
              ],
            ),
            );
          }
        }else{
          return Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                 CircularProgressIndicator(),
                 Text("supprimer (il ne fault pas de sortir)...")
              ],
            ),
            );
          
        
        }
      },

    ),
    );
  }
}