import 'dart:io';

import 'package:fecom_xpress_app/Activities/Views/Raport.dart';
import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/Functions/Importer/NouveauInventaire/NouveauInventaire.dart';
import 'package:fecom_xpress_app/Functions/Exporter/ByCSV/ExportCsv.dart';
import 'package:fecom_xpress_app/Functions/Importer/parFichier/FichierImport.dart';
import 'package:file_picker/file_picker.dart';

import '../Activities/Scan/Scan.dart';
import '../Activities/Search/SearchBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
   String where = "null";
  Emplacement  emplaceScan;
  String chainScan = " ";
  Company compScan;
  StockEntrepot strnScan;
  BottomNavBar({Key key, @required this.height , this.where,this.emplaceScan,this.chainScan,this.compScan,this.strnScan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
print("Bottom nav bar  .dart ****** ");
   return Stack(
     alignment: AlignmentDirectional.bottomCenter,
     children: [
       Container(
         alignment: Alignment.center,
         margin: EdgeInsets.only(bottom: 10),
         height: 50,
        width: 290,//MediaQuery.of(context).size.width * 0.81,
         constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width * 0.81 ,minWidth: 290 ),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(100),
           color: Colors.white,
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 3,
               blurRadius: 7,
               offset: Offset(0, 3), // changes position of shadow
             ),
           ],
         ),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
         CircleAvatar(
           backgroundColor: HexColor("#F2F2F2"),
           child: IconButton(
             icon: Icon(Icons.add_circle_rounded, color: Colors.black,),
             iconSize:25,
             splashColor: Colors.transparent,
             onPressed: (){
                 return showDialog(context: context, builder: (context){
                 return AlertDialog(
                   shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                   title: Center(child: Text("Importer Inventaire" , style: TextStyle(color: Colors.black),),),
                   content: SingleChildScrollView(
                      child: Container(
                        child: Column(

                       children: [
                        Text("Si vous souhaitez importer les données, les données enregistrées dans l'appareil seront supprimées", style: TextStyle(color: Colors.black)) ,
                        
                        FlatButton(
                            color: Colors.transparent,
                            shape: Border.fromBorderSide(BorderSide.none),
                            splashColor: Colors.transparent,
                            child: Text("Nouveau Inventaire",style:TextStyle(fontSize : 14 ,color: HexColor("#009dff")),),
                            onPressed: () {
                              Navigator.pop(context);
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NouveauInventaire(),
                                                            ),
                                                  );
                             
                            },
                                  ),

                        FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text("Nouveau Importation par fichier zip",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
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
                       ],
                     ),),
                     
                     
                   ),
                 ); });

             },
           ),
         ),
             SizedBox(
               width: 20,
             ),
             CircleAvatar(
               backgroundColor: HexColor("#F2F2F2"),
               child: IconButton(

                 icon: SvgPicture.asset("assets/images/svg/magnifying-glass.svg" ,),
                 iconSize:25,
                 splashColor: Colors.transparent,
                 onPressed: (){
                   //  Navigator.pop(context);
                   //ViewSearchBar
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => ViewSearchBar(Where: where ,),
                     ),
                   );
                 },
               ),
             ),
             SizedBox(
               width: 20,
             ),
             SizedBox(
               width: 50,
               height: 50,
               child: CircleAvatar(
                 backgroundColor: HexColor("#1C8855"),
                 child: IconButton(

                   icon: SvgPicture.asset("assets/images/svg/qr-code-scan.svg" , color: Colors.white ,),
                   iconSize:35,
                   splashColor: Colors.transparent,
                   onPressed: (){
                      Navigator.pop(context);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => Scan(chainScan: chainScan,compScan: compScan,emplaceScan: emplaceScan,strnScan: strnScan,),
                       ),
                     );

                   },
                 ),
               ),
             ),
             SizedBox(
               width: 20,
             ),
             CircleAvatar(
               backgroundColor: HexColor("#F2F2F2"),
               child: IconButton(
                 icon: SvgPicture.asset("assets/images/svg/clipboard.svg" ,),
                 iconSize:25,
                 splashColor: Colors.transparent,
                 onPressed: (){
                  //  Navigator.pop(context);
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) =>  Report(),//Nedjm(),//Report(),//NONO(),//NONO(),//TAHAR(),//NONO(),//TAHAR(),//Report(),
                       ),
                     );

                   
                 },
               ),
             ),
             SizedBox(
               width: 20,
             ),
             CircleAvatar(
               backgroundColor: HexColor("#F2F2F2"),
               child: IconButton(
                 icon: SvgPicture.asset("assets/images/svg/export.svg" ,),
                 iconSize:25,
                 splashColor: Colors.transparent,
                 onPressed: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => Export(),
                       ),
                     );
                 },
               ),
             ),

           ],
         ),
       ),
     ],
   );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

