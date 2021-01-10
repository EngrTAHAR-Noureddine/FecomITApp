
import 'Activities/Accueil/Home.dart';
import 'Activities/Views/ProductLot.dart';
import 'Activities/Views/ViewDirectionAndService.dart';
import 'Activities/Views/ViewEmplacement.dart';
import 'Activities/Views/ViewStockSysytem.dart';
import 'Activities/CheckActivity/Checking.dart';
import 'Activities/Views/ViewCompany.dart';
import 'Activities/Views/ViewSites.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'DataBase/fecomDataBase.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {

    final db = FecomItDatabase();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                  statusBarColor: HexColor("#f2f2f2"),
                                                  statusBarIconBrightness: Brightness.dark,//or set color with: Color(0xFF0000FF)
                                                ));

    return MultiProvider(
      providers:[
        Provider(create: (_)=>db.sitesDao),
        Provider(create: (_)=>db.companysDao),
        Provider(create: (_)=>db.emplacementsDao),
        Provider(create: (_)=>db.stockSystemsDao),
        Provider(create: (_)=>db.productCategorysDao),
        Provider(create: (_)=>db.stockEntrepotsDao),
        Provider(create: (_)=>db.productLotsDao),
        Provider(create: (_)=>db.productsDao,),
        Provider(create: (_)=>db.inventorysDao,),
        Provider(create: (_)=>db.inventoryLinesDao,),
      ],


      child : MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FecomXpress',
          home:Checking(),// Home(),//  /// recherch l'existance de licence et username et password.
          routes: {
            
            "ViewSites": (context) { /// pour vister à Sites activity
              return ViewSites();
            },
            "ViewCompany": (context) { /// pour vister à company activity
              return ViewCompany(Chain: "home",siteId: "null",);
            },
            "ViewDirection": (context) { /// pour vister à company activity
              return ViewDirection(Chain: "home",comp: null,direcservice: "null",);
            },
            "ViewEmplacement": (context) { /// pour vister à company activity
              return ViewEmplacement(Chain: "home",st: null,comp: null,);
            },
            "ViewStockSys": (context) { /// pour vister à company activity
              return ViewLesProduits(Chain: "home",emplacement: null,comp: null,strn: null,);
            },
            
            "ViewLesProduitLots": (context) { /// pour vister à company activity
              return ViewLesProduitLots();
            },
            


            


          }),);

  }
}
