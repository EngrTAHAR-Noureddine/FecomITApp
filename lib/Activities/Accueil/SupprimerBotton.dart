import 'package:fecom_xpress_app/Functions/Delete/deleteWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';

class SupprimerBotton{
  Inventory inv ;

  SupprimerBotton({this.inv});
  Botton(context){
    print("Suppremer button .dart ****** ");
    return showDialog(context: context, builder: (context){
      return AlertDialog(
                   shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                   title: Center(child: Text("Supprimer Inventaire" , style: TextStyle(color: Colors.black),),),
                   content: SingleChildScrollView(
                      child: Container(
                        child: Column(

                       children: [
                        Text("Si vous souhaitez Supprimer les données, vos travailles enregistrées dans l'appareil seront supprimées", style: TextStyle(color: Colors.black)) ,
                        
                        
                        FlatButton(
                            color: Colors.transparent,
                            shape: Border.fromBorderSide(BorderSide.none),
                            splashColor: Colors.transparent,
                            child: Text("Supprimer",style:TextStyle(fontSize : 14 ,color: Colors.red,),),
                            onPressed: () {
                                Navigator.pop(context);
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  SupprimerFonctWidget(inv:inv ,), //Nedjm(),//
                                                            ),
                                                  );
                                            },
                                    ),
                        FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text("Annuler",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
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