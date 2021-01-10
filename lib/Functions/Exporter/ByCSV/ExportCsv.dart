import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/Functions/Exporter/ByCSV/ExportFunction.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Export extends StatefulWidget {
  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
   FecomItDatabase db = FecomItDatabase();
   Inventory invInc;

/*____________________Check Inventory: ______________________ */
Future<List<Inventory>> checkInventory()async{
        final dao= InventorysDao(db);
        final dao1 = InventoryLinesDao(db);
        List<Inventory> dataList = <Inventory>[];
        List<Inventory> data = await dao.getAllInventorys();
        
        for(Inventory element in data){
          
          if((await dao1.getAllInventoryLines(element.id)).length > 0){
        
              dataList.add(element);
          }
        }
        invInc = await dao.IncompleteInvent();
         return dataList;
                                            }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar( height:50,homeWidget: "false",chain: null,whereis: null,previous: null,),
          backgroundColor: Colors.white,
          body: FutureBuilder(
        future: checkInventory(),
        builder: (context, snapshot) {
         print("snapshot export ");
         print(snapshot.hasData);
         print(snapshot.data);
         print(snapshot.hasError);
         print(snapshot.error);
          if(snapshot.hasData) {
                        List<Inventory> invList = snapshot.data;
                        
                        if(invList.isNotEmpty){
                        return ListView.builder(
                          
                          itemCount: invList.length,
                          itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding:EdgeInsets.all(10) ,
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: (invInc != null )?(invList[index].id == invInc.id)? HexColor("#E5CAC8"):HexColor("#009C46") : HexColor("#009C46") ,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Icon(Icons.inventory , color: Colors.black,),
                              tileColor:Colors.transparent,
                              title: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                             Text("Inventory : "+invList[index].id),
                             FlatButton(
                                   child: Text("Export",style: TextStyle(color: HexColor("#FFF6F2"),),),
                                   color: HexColor("#FF0707"),
                                   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                                   onPressed: (){ 
                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ExportFunction(idInv: invList[index],),
                                              ),
                                            );
                                     
                                   },
                                   autofocus: true,
                             ),

                               ],
                              ),

                            ),
                          );
                         },
                        );}
                        else {
                              return Center(
                                      child: Text("Il n'y a pas" ,style: TextStyle(color: Colors.black),),
                                    );

                                  }



                                  }else{
                                    return Center(
                                      child: Text("Il n'y a pas" ,style: TextStyle(color: Colors.black),),
                                    );

                                  }
        },
      ),
    );
  }
}