import 'package:fecom_xpress_app/Functions/Service/SharePreferences.dart';
import 'package:flutter_svg/svg.dart';

import 'LogInFunction.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LogIn extends StatefulWidget {

  String messageError = "nothing";
  LogIn({this.messageError});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

Share _sharing = Share();
  String _msg; /// messsage erreur
  String logo;
  String logoName;
  String telNumber;
  String address;

Future<void> getInfo() async{
  List<String> infolist = _sharing.keys[0];
  setState(() async{
    logo = await _sharing.readString(infolist[2]);
    logoName = await _sharing.readString(infolist[1]);
    telNumber = await _sharing.readString(infolist[3]);
    address = await _sharing.readString(infolist[4]);
    
  });

}

  TextEditingController _passwrd=new TextEditingController();


  @override
  void initState(){
  _msg = widget.messageError;
  }
  @override
  Widget build(BuildContext context) {
    initState();

    return FutureBuilder(
      future: getInfo(),
      builder: (context, snapshot){
        return Scaffold(
          backgroundColor: Colors.white,

          body:  GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    height: (MediaQuery.of(context).size.height- MediaQuery.of(context).size.width)>0?(MediaQuery.of(context).size.height- MediaQuery.of(context).size.width):(MediaQuery.of(context).size.width - MediaQuery.of(context).size.height),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex:1,
                            child :Container(

                              padding: EdgeInsets.only(left: 10),
                              child : Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Text("Fec", style:TextStyle(fontSize:22,color: Colors.black,fontWeight: FontWeight.w300 , fontFamily: "Calligraffitti")),
                                  SvgPicture.asset("assets/images/svg/fecomit.svg" ,color: HexColor("#E3020E"), width:20,height:20,),
                                  Text("m", style:TextStyle(fontSize:22,color: Colors.black,fontWeight: FontWeight.w300 , fontFamily: "Calligraffitti")),
                                  Text("IT", style:TextStyle(fontSize: 24 ,color: Colors.black,fontWeight: FontWeight.bold, fontFamily: "Calligraffitti")),


                                ],
                              ),),),
                          /// logo de l'application
                          Expanded(
                            flex: 2,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                   SvgPicture.asset("assets/images/svg/fecomit.svg" ,color: HexColor("#E3020E"), width:50,height:50,),
                                
                                  Text((logoName!=null)?logoName:"  ",style:TextStyle(fontSize: 28 ,color: Colors.black,fontWeight: FontWeight.bold,)),
                          
                            ],)
                          ),
                        ]),
                  ),

                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width,
                    width:MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(25) , topRight:Radius.circular(25) ),
                      color:HexColor("#1C8855"),
                    ),
                    padding: EdgeInsets.fromLTRB(20,0,20,20),
                    child: Form( /// form pour ecrire username et password
                      child: ListView(
                        children: [
                          Container(

                            margin: EdgeInsets.only(top:5, left: 10, right: 10),
                            alignment: Alignment.center,
                            child : Text(_msg=="nothing"?"" :_msg ,
                              style: TextStyle(color:_msg=="nothing"?Colors.transparent :Colors.white),),
                            height: 30,
                            decoration: BoxDecoration(
                              color :_msg=="nothing"?Colors.transparent: Colors.red ,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextField(
                              autofocus: true,
                              showCursor: true,
                              decoration: InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  backgroundColor: Colors.transparent,
                                  fontStyle: FontStyle.italic,
                                ),
                                contentPadding: EdgeInsets.only(left: 25),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),

                                ),
                              ),
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller:  _passwrd,

                              enabled: true,
                            ),
                          ),
                          Container(height: 50,margin: EdgeInsets.only(top: 10),),
                          RaisedButton(
                            color: HexColor("#2f82ff"),
                            elevation: 0.0,
                            child: Text("Inscrit",style:TextStyle(
                              fontSize : 18 ,
                              color: Colors.white,),),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LogFunction(pass: _passwrd.text,),
                                ),
                              );
                            },
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 30),


                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text((address!=null)?address:"  ", style: TextStyle(color: Colors.black45 , fontSize: 16),),
                                Text((telNumber!=null)?telNumber:"  ", style: TextStyle(color: Colors.black45 , fontSize: 16),),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),),

        );

      },
    );
      }
}
