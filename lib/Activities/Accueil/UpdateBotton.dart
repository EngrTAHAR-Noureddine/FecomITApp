import 'dart:io';

import 'package:fecom_xpress_app/Functions/Update/Update.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdateBotton{

  Botton(context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
                   shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                   title: Center(child: Text("Mettre à jours L'inventaire" , style: TextStyle(color: Colors.black , fontSize: 14),),),
                   content: SingleChildScrollView(
                      child: Container(
                        child: Column(

                       children: [
                        Text("vous souhaitez mettre à jours les données ?", style: TextStyle(color: Colors.black,fontSize: 10)) ,
                        
                        
                        
                        FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text("Mis à jours par fichier zip",style:TextStyle( fontSize : 12,color: HexColor("#009dff"),),),
                            onPressed: ()async{

                              File file1;
                              try{
                                FilePickerResult result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['xlsx'],
                                );

                                if(result != null) {
                                  file1  = File(result.files.first.path);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Update(file:file1), //Nedjm(),//
                                    ),
                                  );


                                }
                              }catch(e){throw "aucun fichier ";}


                            },
                                    ), 
                        FlatButton(
                            color: Colors.transparent,
                            shape: Border.fromBorderSide(BorderSide.none),
                            splashColor: Colors.transparent,
                            child: Text("Annuler",style:TextStyle(fontSize : 12 ,color: HexColor("#009dff"),),),
                            onPressed: () {
                                Navigator.pop(context); 
                                            },
                                    ),            
                       ],
                     ),),
                     
                     
                   ),
                 ); });
  }
} 