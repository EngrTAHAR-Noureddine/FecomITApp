import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'CheckInfoFunction.dart';

import 'package:flutter/material.dart';



class CheckInfo extends StatefulWidget {
  @override
  _CheckInfoState createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Center(
       child: Container(
         padding: EdgeInsets.all(10),
         height: 300,
         width: MediaQuery.of(context).size.width,

         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("Si vous souhaitez Utilisé cette application,",style: TextStyle(fontSize: 10),
             ),
             Text("Mettez vous fichier des informations",
             style: TextStyle(fontSize: 10),
             ),
              FlatButton.icon(
                icon: Icon(Icons.file_upload , color: Colors.black87, size: 30,),
                label: Text(" "),
                onPressed: ()async{
                  
                  try{
                          FilePickerResult result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['xlsx'],
                          );

                          if(result != null) {
                            File file1 = File(result.files.first.path);
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckInfoFunction(f: file1,),
                                      ),
                                    ); 
                             }
                             }catch(e){print(e.toString());}
                     
                },
                
              ),
           ],),
       ),
       ),
   );
  }
}
