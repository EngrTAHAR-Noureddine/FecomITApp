
import 'dart:io';

import 'package:fecom_xpress_app/Functions/Importer/parFichier/FichierImport.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class ImporterBotton  {

 Botton(context){
   print("return ImporterBotton().Botton(context) body ta3ha **************");
     return showDialog(context: context, builder: (context){
                 return AlertDialog(
                   shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                   title: Center(child: Text("Importer Inventaire" , style: TextStyle(color: Colors.black , fontSize: 14),),),
                   content: SingleChildScrollView(
                      child: Container(
                        child: Column(

                       children: [
                        Text("Si vous souhaitez importer les données, les données enregistrées dans l'appareil seront supprimées", style: TextStyle(color: Colors.black,fontSize: 10)) ,
                        
                        
                      
                        FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text("Nouveau Importation par fichier zip",style:TextStyle( fontSize : 12,color: HexColor("#009dff"),),),
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
                                                    builder: (context) => ImportFile(file:file1), //Nedjm(),//
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
