import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../Functions/Service/SharePreferences.dart';
import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';
import 'InfoStockSystem.dart';

class ViewLesProduitLots extends StatefulWidget {

  @override
  _ViewLesProduitLotsState createState() => _ViewLesProduitLotsState();
}
class _ViewLesProduitLotsState extends State<ViewLesProduitLots> {
  FecomItDatabase db = FecomItDatabase();

  int _Number = 0 ;
    int diffrence = 0;
  Company _comp;
  Share _sharing = Share();

/* ************************************************************* */
  Future<List<ProductLot>> getListView() async{
      final dao1 = ProductLotsDao(db);
      final dao2 = InventoryLinesDao(db);
      final dao3 = InventorysDao(db);

   List<ProductLot> listproduct = <ProductLot>[];

      List<String> idProductLot = <String>[];
      _Number = (await dao1.getAllProductLots()).length;
      List<ProductLot> plot = await dao1.getAllProductLots();
     Inventory invInc = await dao3.IncompleteInvent();
      if(invInc != null){
        List<InventoryLine> listinv = await dao2.getAllInventoryLines(invInc.id);
        if(listinv.length>0){

      diffrence = listinv.length;
            for(InventoryLine element in listinv){
                    idProductLot.add(element.ProductLotId);
            }
            for(ProductLot element in plot){
                  if(!idProductLot.contains(element.id)){
                    listproduct.add(element);
                  }
            }


        }else{
          diffrence = 0;
              listproduct = plot;
        }
        return (listproduct!=null)?listproduct:[];
      
      }

  }
/* ******************************************************************************** */  
@override
  void initState() {

   _Number = 0 ;

 }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(

      appBar: MyAppBar( height:50,homeWidget: "backHome",
                                  chain: null,
                                  whereis: null ,
                                  previous: null,),
     bottomNavigationBar:BottomNavBar(height:100 ,),
    endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          

          if(snapshot.hasData){ 
            List<ProductLot> Alist = snapshot.data;
          
            return ListView(
              children: [

                Container(
                  height: 100,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        alignment: Alignment.bottomLeft,

                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:EdgeInsets.only(left: 10),
                                child: RichText(
                                    text: TextSpan(children: [

                                      TextSpan(text:"Total : ",
                                        style: TextStyle(color : Colors.black ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text:_Number.toString(),
                                        style: TextStyle(color : HexColor("#1C8855") ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                      ),

                                    ])
                                )

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 10),
                                  child: RichText(
                                      text: TextSpan(children: [

                                                            TextSpan(text:"Scan : ",
                                                                     style: TextStyle(color : Colors.black ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                                     ),
                                                            TextSpan(text:diffrence.toString(),
                                                              style: TextStyle(color : HexColor("#1C8855") ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                            ),

                                  ])
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                      itemCount: Alist.length,
                      padding: EdgeInsets.all(5),

                      itemBuilder: (BuildContext context, int index) {

                        return Padding(
                          padding: EdgeInsets.all(2),
                          child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Container(
                                  height: 100,

                                  child: Card(

                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: CircleAvatar(child: SvgPicture.asset("assets/images/svg/table.svg" , color: Colors.white ,height:20, width:20,))),
                                          Expanded(
                                              flex: 3,
                                              child:Padding(
                                                  padding: EdgeInsets.only(top: 5),
                                                  child:Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(Alist[index].id, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                      RichText(

                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(text: "Code à barre  :",
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                              ),
                                                              TextSpan(text:Alist[index].Numlot,
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.blue),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(text: "Identifiant du produit :",
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                              ),
                                                              TextSpan(text: Alist[index].ProductId,
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.blue),
                                                              ),
                                                            ]
                                                        ),
                                                      ),

                                                    ],
                                                  ))
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child:SizedBox(
                                                  height:100,
                                                  child : FlatButton(
                                                    //Info2Produit
                                                    child: Icon(Icons.info_outline, size:20, color: Colors.blue,),
                                                    onPressed: (){
                                                      
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => InfoOFProduit(indx: Alist[index].id),
                                                        ),
                                                      );

                                                    },

                                                  ))),


                                        ],
                                      )
                                  )


                              ))

                          ,);
                      }),
                ),
              ],
            );
          }else{
            return Center(
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
                        child: Text("Erreur lors du chargement des données de la base de données, réessayez" ,style: TextStyle(color: Colors.black,fontSize: 10),),
                      ),

                      FlatButton(
                        height: 30,
                        color: Colors.red,
                        child: Icon(Icons.replay_rounded, size: 20, color: Colors.white,),
                        onPressed: () { setState(() {});}, 
                      ),

                      Expanded(
                        flex: 2,
                        child: Text("   "),
                      ),
                    ],
                  )
              ),
              );
          }

        },
      ),
    );
  }
}