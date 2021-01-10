
import 'package:fecom_xpress_app/Activities/LogIn/LogIn.dart';
import 'package:fecom_xpress_app/Activities/Views/changePassword.dart';
import 'package:fecom_xpress_app/Functions/Service/SharePreferences.dart';
import 'package:fecom_xpress_app/Functions/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class EndDrawer extends StatefulWidget {
  @override
  _EndDrawerState createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  Share _sharing = Share();
   String logo;
  String etat;


  Future<void> getInfo() async{
    setState(() async{
      logo = await _sharing.readString(_sharing.keys[0][1]);
      etat = await _sharing.readString(_sharing.keys[1][3]);
   });

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future:  getInfo(),
      builder: (context, snapshot){
        return Drawer(

          child: Container(
            alignment: Alignment.centerLeft,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  currentAccountPicture:  SvgPicture.asset("assets/images/svg/fecomit.svg" ,color: HexColor("#E3020E"), width:15,height:15,),
                  accountName: Text("FecomIT", style:TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.w300 , fontFamily: "Calligraffitti")),
                  accountEmail: Padding(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((logo!=null)?logo:"  ", style:TextStyle(color: Colors.black, fontSize: 12)),
                        Text((etat!=null)?etat:"  ", style:TextStyle(color: Colors.black, fontSize: 10)),
                      ],
                    ),),

                ),
                ListTile(
                  trailing: Icon(Icons.security , color: Colors.blue,),
                  title: Text("Changer le mot de pass",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ),
                    );
                  },
                ),
                (etat!="Admin")?SizedBox(
                  height: 20,
                ):ListTile(
                  trailing: Icon(Icons.security , color: Colors.blue,),
                  title: Text("initialiser le mot de pass du utilisateur",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
                  onTap: () {
                    return showDialog(context: context, builder: (context){

                      return AlertDialog(
                        shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                        title: Center(child: Text("Initialiser le mot de pass du utilisateur " , style: TextStyle(color: Colors.black),),),
                        content: SingleChildScrollView(
                          child: Container(
                            child: Column(

                              children: [

                                 Text("Êtes-vous sûr d'initialiser !!", style: TextStyle(color: Colors.black)) ,



                                FlatButton(
                                  color: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: Text("initialiser",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
                                  onPressed: () async{
                                   Navigator.pop(context);
                                    Services().resetPassword().whenComplete((){
                                     setState(() { });
                                    });
                                    },
                                ),

                                FlatButton(
                                  color: Colors.transparent,
                                  shape: Border.fromBorderSide(BorderSide.none),
                                  splashColor: Colors.transparent,
                                  child: Text("Annuler",style:TextStyle(fontSize : 14 ,color: HexColor("#009dff"),),),
                                  onPressed: () {
                                    Navigator.pop(context);

                                  },
                                ),
                              ],
                            ),),


                        ),
                      );
                    });},

                ),
                ListTile(
                  trailing: Icon(Icons.exit_to_app_outlined , color: Colors.red,),
                  title: Text("Se déconnecter",style:TextStyle( fontSize : 14,color: Colors.red,),),
                  onTap: () {
                    return showDialog(context: context, builder: (context){

                      return AlertDialog(
                        shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                        title: Center(child: Text("Se déconnecter" , style: TextStyle(color: Colors.black),),),
                        content: SingleChildScrollView(
                          child: Container(
                            child: Column(

                              children: [
                                Text("Êtes-vous sûr de vous déconnecter !!", style: TextStyle(color: Colors.black)) ,



                                FlatButton(
                                  color: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: Text("Se déconnecter",style:TextStyle( fontSize : 14,color: HexColor("#009dff"),),),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LogIn(messageError: "nothing"),
                                      ),
                                    );},
                                ),

                                FlatButton(
                                  color: Colors.transparent,
                                  shape: Border.fromBorderSide(BorderSide.none),
                                  splashColor: Colors.transparent,
                                  child: Text("Annuler",style:TextStyle(fontSize : 14 ,color: HexColor("#009dff"),),),
                                  onPressed: () {
                                    Navigator.pop(context);

                                  },
                                ),
                              ],
                            ),),


                        ),
                      );
                    });

                  },
                ),
              ],
            ),
          ),
        );
      },
    );


  }
}
