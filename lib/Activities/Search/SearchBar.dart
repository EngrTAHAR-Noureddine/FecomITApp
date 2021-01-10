import '../../MaterialDesignCustom/AppBar.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../DataBase/fecomDataBase.dart';

import '../Views/InfoStockSystem.dart';

class ViewSearchBar extends StatefulWidget {
  String Where="null";
  ViewSearchBar({this.Where});
  @override
  _ViewSearchBarState createState() => _ViewSearchBarState();
}

class _ViewSearchBarState extends State<ViewSearchBar> {

  String _where;
  @override
  void initState() {
    _where = widget.Where;
  }

  Future<List<ProductLot>> searchfunction(String CodeBar)async{

    final dao = ProductLotsDao(FecomItDatabase());

    return await dao.getLotsByCodeBar(CodeBar);
  }


  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      appBar: MyAppBar(height: 50,homeWidget: "false",chain: null,previous:null,whereis: null,),
      body:SafeArea(
     child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 20),
       child: SearchBar(
           onSearch: searchfunction,
           searchBarStyle: SearchBarStyle(
             borderRadius:  BorderRadius.circular(10),
             padding: EdgeInsets.all(5),
           ),
           cancellationWidget: Text("Annuler"),
         hintText: "Recherche...",
         hintStyle: TextStyle(
           color: Colors.black38,
         ),
         textStyle: TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
         ),

           emptyWidget: Center(
             child: Directionality(
               textDirection: TextDirection.ltr,
               child :
               Container(
                 height: 30,
                 color: Colors.white38,
                 child: Text("pas trouvé" ,style: TextStyle(color: Colors.black),),
               ),


             ),),
           onError:  (error) {
             return Center(
               child: Directionality(
                   textDirection: TextDirection.ltr,
                   child :
                       Container(
                         height: 30,
                         color: Colors.white38,
                         child: Text("problem :/" ,style: TextStyle(color: Colors.black),),
                       ),


               ),);
           },
           //cancellationText: Text("Annuler"),
           loader: Center(
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
                       child: Text("Recherche... " ,style: TextStyle(color: Colors.black),),
                     ),

                     CircularProgressIndicator(),

                     Expanded(
                       flex: 2,
                       child: Text("   "),
                     ),
                   ],
                 )
             ),),
            onItemFound: (ProductLot Lot,int index){
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
                                   child: CircleAvatar(child: SvgPicture.asset("assets/images/svg/table.svg" , color: Colors.white ,height:25, width:25,))),
                               Expanded(
                                   flex: 3,
                                   child:Padding(
                                       padding: EdgeInsets.only(top: 5),
                                       child:Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(Lot.id, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                           RichText(

                                             text: TextSpan(
                                                 children: [
                                                   TextSpan(text: "Identifiant du produit :",
                                                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                   ),
                                                   TextSpan(text:Lot.ProductId,
                                                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.blue),
                                                   ),
                                                 ]
                                             ),
                                           ),
                                           RichText(
                                             text: TextSpan(
                                                 children: [
                                                   TextSpan(text: "Code à barre : ",
                                                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.black),

                                                   ),
                                                   TextSpan(text: Lot.Numlot,
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
                                         child: Icon(Icons.info_outline, size:25, color: Colors.blue,),
                                         onPressed: (){



                                           Navigator.push(
                                             context,
                                             MaterialPageRoute(
                                               builder: (context) => InfoOFProduit(indx: Lot.id),
                                             ),
                                           );

                                         },

                                       ))),


                             ],
                           )
                       )


                   ))

               ,);
            },

       ),
     ),
      ) ,
    );
  }
}
