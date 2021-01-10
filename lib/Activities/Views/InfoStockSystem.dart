import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../DataBase/fecomDataBase.dart';


class InfoOFProduit extends StatefulWidget {
  String indx;
  InfoOFProduit({this.indx});
  @override
  _InfoOFProduitState createState() => _InfoOFProduitState();
}
class _InfoOFProduitState extends State<InfoOFProduit> {
  FecomItDatabase db = FecomItDatabase();
  Product _Myproduct;
  ProductLot _proLot;
  ProductCategory _procat ;
  ProductCategory _procatparent;
  String info;


  initState(){

    _Myproduct = new Product(id: "null", ProductType: "null",ProductCode: "null",Nom: "null",GestionLot: "null",CategoryId: "null");
    _proLot = new ProductLot(id: "null",NumSerie: "null",Numlot: "null",Immatriculation: "null",ProductId: "null");
    _procat = new ProductCategory(id: "null",ParentPath: "null",ParentId: "null",CategName: "null",CategCode: "null");
    _procatparent = new ProductCategory(id: "null",ParentPath: "null",ParentId: "null",CategName: "null",CategCode: "null");

    info = widget.indx;

  }

  Future<void> getInfo()async{

    final dao2 = ProductLotsDao(db);
    final dao1 = ProductsDao(db);
    final dao3 = ProductCategorysDao(db);

   _proLot = await  dao2.getProductLotByID(info);

    if(_proLot != null) {
      _Myproduct = await dao1.getProductByStockSys(_proLot.ProductId);
      
      if(_Myproduct != null){ _procat = await dao3.getProductById(_Myproduct.CategoryId); }
      if(_procat != null ){_procatparent = await dao3.getProductById(_procat.id); }

      if(_Myproduct==null){_Myproduct = Product(id: "null", ProductType: "null",ProductCode: "null",Nom: "null",GestionLot: "null",CategoryId: "null");}
      if(_proLot==null){_proLot = ProductLot(id: "null",NumSerie: "null",Numlot: "null",Immatriculation: "null",ProductId: "null");}
      if(_procat==null){_procat = ProductCategory(id: "null",ParentPath: "null",ParentId: "null",CategName: "null",CategCode: "null");}
      if(_procatparent==null){_procatparent = ProductCategory(id: "Null",ParentPath: "Null",ParentId: "Null",CategName: "Null",CategCode: "Null");}



    }

  }


  @override
  Widget build(BuildContext context) {
    initState();


    return Scaffold(


      appBar: MyAppBar( height:50,homeWidget:"false",chain: null,previous: null,whereis: null,),
     endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future:getInfo(),
        builder: (context , snapshot){
          if(!snapshot.hasError){
            return Card(
                child: ListView(
                  children: [
                    Container(
                      height: 150,
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded( //TODO dir photo common like meuble.svg
                              flex: 2,
                              child:Container(
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/images/svg/table.svg" , color: Colors.black ,height: 50, width: 50,),
                              )),
                          Expanded(
                            flex:3,
                            child: Container(
                              alignment: Alignment.center, //_Myproduct.Nom
                              child: Text(_Myproduct.Nom!=null?_Myproduct.Nom:"pas trouvé", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 12),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Identifiant du produit : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_proLot.ProductId!=null?_proLot.ProductId:"pas trouvé", style: TextStyle(color: Colors.black, fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Nom du produit : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_Myproduct.Nom!=null?_Myproduct.Nom:"pas trouvé", style: TextStyle(color: Colors.black,fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Immatriculation : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_proLot.Immatriculation!=null?_Myproduct.Nom:"pas trouvé", style: TextStyle(color: Colors.black,fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Numero Série : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_proLot.NumSerie!=null?_proLot.NumSerie:"pas trouvé", style: TextStyle(color: Colors.black,fontSize: 10),),
                                )
                        )
                           ] ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("code à barre : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_proLot.Numlot!=null?_proLot.Numlot:"pas trouvé", style: TextStyle(color: Colors.black, fontSize: 10),),
                                )
                            ),

                          ],
                        )

                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Code produit: ",  style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10)),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_Myproduct.ProductCode!=null?_Myproduct.ProductCode:"pas trouvé", style: TextStyle(color: Colors.black , fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),

                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Type de produit: ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_Myproduct.ProductType!=null?_Myproduct.ProductType:"pas trouvé", style: TextStyle(color: Colors.black ,fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),

                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Catégorie : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text((_procatparent!=null?_procatparent.CategName:" ")+"/"+(_procat.CategName!=null?_procat.CategName:"pas trouvé"), style: TextStyle(color: Colors.black, fontSize: 10),),
                                )
                            ),

                          ],
                        )

                    ),
                    Container(
                        padding: EdgeInsets.only(top : 5),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Gestion Lot : ", style: TextStyle(color: Color(0xFF094D24)/* #094D24*/ , fontWeight: FontWeight.bold , fontSize: 10),),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_Myproduct.GestionLot!=null?_Myproduct.Nom:"pas trouvé", style: TextStyle(color: Colors.black,fontSize: 10),),
                                )
                            ),

                          ],
                        )
                    ),


                  ],
                ));
          }else if(snapshot.hasError){
                return Center(
                  child: Text("il n'y a pas des informations"),
                );
          }
          else return CircularProgressIndicator();
        },
      ),

    );
  }
}