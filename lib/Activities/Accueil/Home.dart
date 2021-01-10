import 'package:fecom_xpress_app/Functions/Service/SharePreferences.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import 'HomeFunction.dart';
import 'package:flutter/material.dart';
import '../../MaterialDesignCustom/AppBar.dart' ;
import '../../MaterialDesignCustom/bottomNavBar.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState(){
    return HomeState();
  }
}

class HomeState extends State<Home>{

  Widget build(BuildContext context){
        print("Home.dart ****** ");
        
       
    return Directionality( textDirection: TextDirection.ltr, /* rtl : dir kolech right to left ; ltr : left to right ; */
                            child: Scaffold(
                                      backgroundColor: Colors.white, /* ki choghl winha li applique 3Liha text direction  */
                                      appBar: MyAppBar( height:50,homeWidget: "true",chain: null,whereis: null,previous: null,),
                                      endDrawer: EndDrawer() ,
                                      body: HomeFunction(),

                                      bottomNavigationBar: BottomNavBar(height:100 , where: "null",chainScan: "home",),

                                     )
    );
  }
}
