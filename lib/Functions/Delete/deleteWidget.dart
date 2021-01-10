import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import '../../Activities/Accueil/Home.dart';
import 'deleteFunction.dart';

class SupprimerFonctWidget extends StatefulWidget {
 Inventory inv ; 
SupprimerFonctWidget({this.inv});
  @override
  _SupprimerFonctWidgetState createState() => _SupprimerFonctWidgetState();
}

class _SupprimerFonctWidgetState extends State<SupprimerFonctWidget> {

  Inventory get _inv => widget.inv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar( height:50,homeWidget: "backHome",chain: null,previous: null,whereis: null,),
      body: FutureBuilder(
        future: DeleteFunction().SupprimerInv(_inv),
        builder: (context,  snapshot){
          if(snapshot.hasData){
            var listing = snapshot.data ;
           if(listing == true){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children : [Icon(Icons.check_circle , color: Colors.green,) ,Text("  Réussi")]),
                  FlatButton(
                    color: Colors.green,
                    child: Text("Aller à" , style: TextStyle(color: Colors.white),),
                    onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );

                    },
                  )
                ],
              ));
            }
            else{
              return Center(
                child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                     children : [
                   Icon(Icons.highlight_remove_rounded , color: Colors.red,) ,Text("  Echoué")]),
                 FlatButton(
                    color: Colors.green,
                    child: Text("Retour" , style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  )
                ],
              ));
            }
          }else if(snapshot.hasError){
          return Center(
            child :Column(
              mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Row(mainAxisAlignment: MainAxisAlignment.center,
               children : [Icon(Icons.replay_rounded , color: Colors.red,) ,Text("  Échec de la connexion,")]),
           FlatButton(
          color: Colors.redAccent,
          child: Text("Réessayez" , style: TextStyle(color: Colors.white),),
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
          ));

          }else return Center(
            child: Directionality(
                textDirection: TextDirection.ltr,
                child : Column(

                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("   "),
                    ),

                    Container(
                      height: 30,
                      color: Colors.white38,
                      child: Text("Supprimer... " ,style: TextStyle(color: Colors.black),),
                    ),

                    CircularProgressIndicator(),

                    Expanded(
                      flex: 2,
                      child: Text("   "),
                    ),
                  ],
                )
            ),);//Center(child: CircularProgressIndicator());




        },
      ) ,
    );
  }
}
