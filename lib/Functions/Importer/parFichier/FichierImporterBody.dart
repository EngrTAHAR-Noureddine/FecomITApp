import 'dart:io';

import 'package:fecom_xpress_app/Activities/Accueil/Home.dart';
import 'package:fecom_xpress_app/Functions/Service/services.dart';
import 'package:flutter/material.dart';


class BodyImporteFichier extends StatefulWidget {
  File file;
  BodyImporteFichier({this.file});
  @override
  _BodyImporteFichierState createState() => _BodyImporteFichierState();
}

class _BodyImporteFichierState extends State<BodyImporteFichier> {

    File _myfile;
    @override
  void initState() {
    _myfile =widget.file;
  }
  @override
  Widget build(BuildContext context) {
    initState();
  
    return FutureBuilder(
        future:Services().import(_myfile),

        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData) {
                    bool check = snapshot.data;    
               if(check== true){
                            return Center(child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children : [Icon(Icons.check_circle , color: Colors.green,) ,Text("  Réussi")]
                                ),
                              FlatButton(
                                              color: Colors.green,
                                              child: Text("Aller à" , style: TextStyle(color: Colors.white),),
                                              onPressed: (){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Home(),
                                                  ),
                                                );                                             
                                                    },
                                                  )
                            ],
                          ),
                  );
               }else{
                 return Center(child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                Text("Importer (il ne fault pas de sortir)...")
                              ],
                            ),
                            );
               }
          
          }else if(snapshot.hasError){
                   return Center(child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children : [Icon(Icons.highlight_remove_rounded , color: Colors.red,) ,Text(snapshot.error.toString(), style: TextStyle(fontSize: 12),)]
                                               ), 
                                             FlatButton(
                                                color: Colors.red,
                                                child: Text("Retour" , style: TextStyle(color: Colors.white),),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Home(),
                                                    ),
                                                  );
                                                },
                                              )
                            ],
                          ),
                  );
          }else{
           return Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircularProgressIndicator(),
                 Text("Importer (il ne fault pas de sortir)...")
              ],
            ),
            );
          }
          
        
        },

      );

  }
}