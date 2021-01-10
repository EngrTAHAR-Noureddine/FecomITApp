import 'package:fecom_xpress_app/Activities/Accueil/Home.dart';
import 'package:fecom_xpress_app/Activities/Views/InfoStockSystem.dart';
import 'package:fecom_xpress_app/Activities/Views/ViewCompany.dart';
import 'package:fecom_xpress_app/Activities/Views/ViewDirectionAndService.dart';
import 'package:fecom_xpress_app/Activities/Views/ViewEmplacement.dart';
import 'package:fecom_xpress_app/Activities/Views/ViewSites.dart';
import 'package:fecom_xpress_app/Activities/Views/ViewStockSysytem.dart';
import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String homeWidget;
  final  whereis;
  final previous;
  final String chain;
  final StockEntrepot backstrn;
  const MyAppBar({
    Key key,
    @required this.height,
    @required this.homeWidget,
    @required this.previous,
    @required this.whereis,
    @required this.chain,
    this.backstrn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
print("App bat  .dart ****** ");

    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,

     actionsIconTheme: IconThemeData(color: Colors.black , ),

      leading:(homeWidget != "true")? IconButton(
        icon: Icon(Icons.arrow_back , color:HexColor("#4d4d4d"),),
        onPressed: () {
          
          switch(homeWidget){
              case "backHome":
               //Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                        break;
              case "backSite":
               //Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewSites(),
                                  ),
                                );
                        break;
              case "backCompany":
               //Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewCompany(Chain: chain,siteId: whereis,),
                                  ),
                                );
                        break;
              case "backDirection":
              // Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDirection(Chain: chain,comp: whereis,direcservice:previous ,),
                                  ),
                                );
                        break;
              case "backEmplacement":
               //Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewEmplacement(Chain: chain,st:whereis,comp: previous,),
                                  ),
                                );
                        break;
              case "backStockSys":
             // Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewLesProduits(emplacement : whereis,Chain: chain,comp: previous,strn: backstrn,),
                                  ),
                                );
                        break;

              case "backInfo":
               //Navigator.pop(context);
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InfoOFProduit(indx: whereis,),
                                  ),
                                );
                        break;

              default :
               Navigator.pop(context ,true);
               break;          
          }
         
        },

      ):null,
      elevation: 3,
      title: Text("FecomXpress" ,style: TextStyle(color: Colors.black ,),),
      centerTitle: true,

    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height);
}
