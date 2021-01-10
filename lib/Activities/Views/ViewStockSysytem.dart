import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../Functions/Service/SharePreferences.dart';
import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';
import 'InfoStockSystem.dart';

class ViewLesProduits extends StatefulWidget {
  Emplacement  emplacement;
  String Chain = " ";
  Company comp;
  StockEntrepot strn;
  ViewLesProduits({this.emplacement , this.Chain , this.comp,this.strn});

  @override
  _ViewLesProduitsState createState() => _ViewLesProduitsState();
}
class _ViewLesProduitsState extends State<ViewLesProduits> {
  FecomItDatabase db = FecomItDatabase();
  Emplacement _emplacement;
 String _chain;
 StockEntrepot st;
 List<String> compoundChain;
  int _Number = 0 ;
  Company _comp;
  Share _sharing = Share();

  Future<List<StockSystem>> getListView() async{

   List<StockSystem> listStock = <StockSystem>[];

    final dao2 = InventoryLinesDao(db);

    Inventory inv = await InventorysDao(db).IncompleteInvent();

    final dao1 = StockSystemsDao(db);
    String name = (_emplacement.id != "null")?("emplacement : "+_emplacement.id):_sharing.keys[2];
    _Number = await _sharing.readInt(name);
    List<StockSystem> list= ((_emplacement.id != "null")?
    (await dao1.fetchStockSystemInEmplacement(_emplacement)) : (await dao1.getAllStockSystem()));
    if(list != null){
                for(StockSystem element in list){
                  //listInven = await dao2.checkSystemIsIn(element.ProductLotId ,inv);    
                  if((await dao2.checkSystemIsIn(element.ProductLotId ,inv)) == null){
                     
                    listStock.add(element);
                    }else listStock.remove(element);         
                                        }      
                      }
    
    
    return listStock.isNotEmpty?listStock:[];
  }
@override
  void initState() {
  _emplacement = widget.emplacement;
  print("i'm in intstate of stock sys *************");
  if(_emplacement == null ){_emplacement = new Emplacement(Nom: "null", id: "null",entrepotId: "null",barcodeemp: "null");}
  _chain = widget.Chain;
   _Number = 0 ;
   _comp = widget.comp;
   st = widget.strn;
  compoundChain = _chain.split(">");
  print("compoundChain");
  print(compoundChain);
  print("chain ");
  print(_chain);
 }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(

      appBar: MyAppBar( height:50,homeWidget:(_emplacement.id!="null")?"backEmplacement": "backHome",
                                  chain: (compoundChain.length>1)? _chain.substring(0 , _chain.indexOf(">"+compoundChain[compoundChain.length - 1])) : _chain,
                                  whereis: (compoundChain[0] != "home") ?st : null ,
                                  previous: (compoundChain[0] != "home") ? _comp :null,),
     bottomNavigationBar:BottomNavBar(height:100 ,chainScan: _chain,compScan: _comp,emplaceScan: _emplacement,strnScan: st,),
      endDrawer: EndDrawer() ,      
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          

          if(snapshot.hasData){ 
            List<StockSystem> Alist = snapshot.data;
            int diffrence = 0;
            if(Alist != null) diffrence = (_Number - Alist.length);
            return ListView(
              children: [

                Container(
                  height: 100,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top:5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:EdgeInsets.only(left: 5),
                                child: Text(_chain , style: TextStyle(color : Colors.black26 ,fontSize: 10 ,fontWeight: FontWeight.normal , fontStyle:FontStyle.italic),),
                              ),
                            ),

                          ],
                        ),
                      ),
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
                                                      Text(Alist[index].ProductLotId, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                      RichText(

                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(text: "Identifiant du produit :",
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                              ),
                                                              TextSpan(text:Alist[index].ProductId,
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.blue),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(text: "Quantité : ",
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                              ),
                                                              TextSpan(text: Alist[index].Quantity,
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
                                                          builder: (context) => InfoOFProduit(indx: Alist[index].ProductLotId),
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
                        child: Text("Erreur lors du chargement des données de la base de données, réessayez" ,style: TextStyle(color: Colors.black),),
                      ),

                      FlatButton(
                        height: 30,
                        color: Colors.red,
                        child: Icon(Icons.replay_rounded, size: 25, color: Colors.white,),
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