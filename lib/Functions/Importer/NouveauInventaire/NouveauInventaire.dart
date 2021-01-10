import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/Functions/Service/SharePreferences.dart';

import '../../../MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import '../../../Activities/Accueil/Home.dart';

class NouveauInventaire extends StatefulWidget {
 
  @override
  _NouveauInventaireState createState() => _NouveauInventaireState();
}

class _NouveauInventaireState extends State<NouveauInventaire> {
  Share _sharing = Share();
  /// help variables to save in database
  final _dao1 = SitesDao(FecomItDatabase());
  final _dao2 = CompanysDao(FecomItDatabase());
  final _dao3 = StockEntrepotsDao(FecomItDatabase());
  final _dao4 = StockSystemsDao(FecomItDatabase());
  final _dao5 = EmplacementsDao(FecomItDatabase());
  final _dao6 = ProductsDao(FecomItDatabase());
  final _dao7 = ProductCategorysDao(FecomItDatabase());
  final _dao8 = ProductLotsDao(FecomItDatabase());

  final _dao9 = InventorysDao(FecomItDatabase());
  final _dao10 = InventoryLinesDao(FecomItDatabase());


  Future<bool> nouveauInventaireFun()async{

/* to check if tables empty or not  */

    List listing = _sharing.keys[3];
    bool loading = false;
    /* check site  */
    if((await _dao1.getAllSites()).isNotEmpty) {
      _sharing.saveValueString(listing[0] ,"Done");
    } else _sharing.saveValueString(listing[0] ,"Failed");

    /* check company  */
    if((await _dao2.getAllCompanys()).isNotEmpty){
      _sharing.saveValueString(listing[1] ,"Done");
    }else _sharing.saveValueString(listing[1] ,"Failed") ;

    /* check entrepot */
    if((await _dao3.getAllStockEntrepots()).isNotEmpty){
      _sharing.saveValueString(listing[2] ,"Done");
    }else _sharing.saveValueString(listing[2] ,"Failed");

    /* stock system  */
    if((await _dao4.getAllStockSystem()).isNotEmpty){
      _sharing.saveValueString(listing[3] ,"Done");//10
      int lengthS = (await _dao4.getAllStockSystem()).length;
      _sharing.saveValueInt(_sharing.keys[2] ,lengthS);//10
      /// this instruction to save each emplacement has stock system
      if((await _dao5.getAllEmplacements()).isNotEmpty){
        List<Emplacement> emplist = (await _dao5.getAllEmplacements());
        for(Emplacement element in emplist){
          String name = "emplacement : "+element.id;
          int lengthtotal = (await _dao4.fetchStockSystemInEmplacement(element)).length;
          _sharing.saveValueInt(name, lengthtotal);
        }
      }
    }else{
      _sharing.saveValueString(listing[3] ,"Failed") ;
      _sharing.saveValueInt(_sharing.keys[2] ,0);//10
    }

    /** emplacement  */
    if((await _dao5.getAllEmplacements()).isNotEmpty){
      _sharing.saveValueString(listing[4] ,"Done");
    }else _sharing.saveValueString(listing[4] ,"Failed") ;

    /* products  */
    if((await _dao6.getAllProducts()).isNotEmpty){
      _sharing.saveValueString(listing[5] ,"Done");
    }else _sharing.saveValueString(listing[5],"Failed") ;

    /* product category  */
    if((await _dao7.getAllProductCategorys()).isNotEmpty){
      _sharing.saveValueString(listing[6] ,"Done");
    }else _sharing.saveValueString(listing[6] ,"Failed") ;
    /* product lot  */
    if((await _dao8.getAllProductLots()).isNotEmpty){
      _sharing.saveValueString(listing[7] ,"Done");
      /* ==================== create inventory =================== */
      List<Inventory> Inv = await _dao9.getAllInventorys();
      int NewId = 1;
      (Inv.isNotEmpty) ?
      NewId = int.parse(Inv.last.id)+ NewId : NewId ;
      await  _dao9.insertInventory(Inventory(id:NewId.toString(),CloseDate:DateTime.utc(1971, 1, 1) , OpeningDate: DateTime.now() ));
      /* ==================== end create inventory =================== */

      loading = true;
    }else{ _sharing.saveValueString(listing[7] ,"Failed") ; throw "il n'y a pas des lots";}


    print("loading outside");
    return loading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar( height:50,homeWidget: "backHome",chain: null,previous: null,whereis: null,),
      body: FutureBuilder(
      future:nouveauInventaireFun(),
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
                                                      Text("Nouveau Inventaire...")
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
                                                                      Text("Nouveau Inventaire...")
                                                                      ],
                                                                  ),
                                                          );
                                              }
                              },

                            ),
    );

              }
}
