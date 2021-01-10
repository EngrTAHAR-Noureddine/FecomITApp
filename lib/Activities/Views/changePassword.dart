import 'package:fecom_xpress_app/Functions/Service/services.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String msg = "nothing";
  String oldpass ;
  String newpass ;
  String confpass;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(height: 50,chain: null,homeWidget: "false" , previous: null,whereis: null,backstrn: null,),
      
      body: FutureBuilder(
        future: Services().changePassword(newpass, confpass,oldpass),
        builder: (context,snapshot){

          if(snapshot.hasData){
            msg = "nothing";
          }else if(snapshot.hasError){
            msg = snapshot.error.toString();
          }else{
            msg = snapshot.error.toString();
          }

          return  Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    margin: EdgeInsets.only(top:5, left: 10, right: 10),
                    alignment: Alignment.center,
                    child : Text(msg=="nothing"?"" :msg ,
                      style: TextStyle(color:msg=="nothing"?Colors.transparent :Colors.white),),
                    height: 30,
                    decoration: BoxDecoration(
                      color :msg=="nothing"?Colors.transparent: Colors.red ,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  ListTile(  /* old password *****  */
                   title:GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // SystemChannels.textInput.invokeMethod('TextInput.hide');
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: TextField(
                        autofocus: false,
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: "Mot de pass precedent",
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),

                          border:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        controller: oldPassword,
                        obscureText: true,
                        minLines: 1,
                        maxLines: 1,
                        /*onSubmitted: (text){
                          oldPassword = text;
                        },*/
                        enabled: true,
                      ),),
                  ), /* end  old password *****  */
                  ListTile( /* new  password *****  */
                    title:GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // SystemChannels.textInput.invokeMethod('TextInput.hide');
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: TextField(
                        autofocus: false,
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: "Nouveau mot de pass",
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),

                          border:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        controller: newPassword,
                        obscureText: true,
                        minLines: 1,
                        maxLines: 1,
                        /*onSubmitted: (text){
                          oldPassword = text;
                        },*/
                        enabled: true,
                      ),),
                  ), /* end new password *****  */
                  ListTile( /* confirm  password *****  */
                    title:GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // SystemChannels.textInput.invokeMethod('TextInput.hide');
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: TextField(
                        autofocus: false,
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: "Confirmer nouveau mot de pass",
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),

                          border:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        controller: confirmPassword,
                        obscureText: true,
                        minLines: 1,
                        maxLines: 1,
                        /*onSubmitted: (text){
                          oldPassword = text;
                        },*/
                        enabled: true,
                      ),),
                  ), /* end confirm password *****  */
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                    child: Text("Changer",style: TextStyle(color: HexColor("#FFF6F2"),),),
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                    onPressed: (){
                      oldpass = oldPassword.text;
                      oldPassword.clear();
                      newpass = newPassword.text;
                      newPassword.clear();
                      confpass = confirmPassword.text;
                      confirmPassword.clear();

                          setState(() { });

                    },
                    autofocus: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
