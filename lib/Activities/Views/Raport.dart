import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Functions/Service/SharePreferences.dart';
import '../../DataBase/fecomDataBase.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}
class emplacementItem{
  int total;
  int scan;
  String name;
  emplacementItem({this.total , this.scan , this.name});
  }


class _ReportState extends State<Report> {

 int totalStock;
 int ScanStock;
 FecomItDatabase db= FecomItDatabase();
 Share _sharing = Share();
 @override
  void initState() {
    totalStock = 0;
    ScanStock = 0;
  }

 Future <List<emplacementItem>> ListItemFunction()async {
   final dao1 = InventoryLinesDao(db);
   final dao2 = EmplacementsDao(db);
   final dao3 = InventorysDao(db);
   List<emplacementItem> list = <emplacementItem>[];

   int totalOnScan = 0;


   int onScan = 0; /* emplacement */
   int all = 0; /* emplacement */
   String name; /* emplacement */
   List<Emplacement> emplaceList = await dao2.getAllEmplacements();
   Inventory invincomp = await dao3.IncompleteInvent();
   if ((await StockSystemsDao(db).getAllStockSystem()).isNotEmpty){
     if (emplaceList != null) {
       if (invincomp != null) {
         for (Emplacement element in emplaceList) {
           name = "emplacement : " + element.id;
           all = await _sharing.readInt(name);

           if ((await dao1.getInvLByEmpIn(invincomp, element)).isNotEmpty) {
             onScan = (await dao1.getInvLByEmpIn(invincomp, element)).length;
           } else
             onScan = 0;


           list.add(new emplacementItem(scan: onScan, total: all, name: name));

           totalOnScan = onScan + totalOnScan;
         }
       } else
         list = [];
     } else
       list = [];
 }else
     list = [];
   totalStock = (await ProductLotsDao(db).getAllProductLots()).length;
    ScanStock = (invincomp!=null)?(await dao1.getAllInventoryLines(invincomp.id)).length:0;



//if (list != null) list.add(new emplacementItem(name: "  " ,scan:-1,total: -1));
    
   return (list != null)?list: [];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality( textDirection: TextDirection.ltr, /* rtl : dir kolech right to left ; ltr : left to right ; */
                            child: Scaffold(
                                      backgroundColor: Colors.white, /* ki choghl winha li applique 3Liha text direction  */
                                      appBar: MyAppBar( height:50,homeWidget: "false",chain: null,whereis: null,previous: null,),
                                      endDrawer: EndDrawer() ,
                                      body: FutureBuilder(
                                              future: ListItemFunction(),
                                              builder: (context , snapshot){
                                                print("Snapshot of Stock system");
                                                print(snapshot.hasData);
                                                print(snapshot.data);
                                                print(snapshot.hasError);
                                                print(snapshot.error);
                                                if(snapshot.hasData){ 
                                                List<emplacementItem> Alist = snapshot.data;
                                                return ListView(
                                                    children: [
                                                        /* Header  */
                                                        Container(
                                                        height: 100,
                                                        child:Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment.topLeft,
                                                              padding: EdgeInsets.only(top:5),
                                                              height:5,
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
                                                                              style: TextStyle(color : Colors.black ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                                                            ),
                                                                            TextSpan(text:totalStock.toString(),
                                                                              style: TextStyle(color : HexColor("#1C8855") ,fontSize: 16 ,fontWeight: FontWeight.bold),
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
                                                                                                          style: TextStyle(color : Colors.black ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                  TextSpan(text:ScanStock.toString(),
                                                                                                    style: TextStyle(color : HexColor("#1C8855") ,fontSize: 16 ,fontWeight: FontWeight.bold),
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
                                                  /* Body  */
                                                  Container(
                                                        height: MediaQuery.of(context).size.height -200,
                                                        child: ListView.separated(
                                                            itemCount: Alist.length,
                                                            padding: EdgeInsets.all(5),
                                                            separatorBuilder: (_, __) => Divider(height: 0.5),
                                                            itemBuilder: (BuildContext context, int index) {
                                                                  
                                                              return Padding(
                                                                padding: EdgeInsets.all(2),
                                                                child: Directionality(
                                                                    textDirection: TextDirection.ltr,
                                                                    child: Container(
                                                                        height: 100,

                                                                        child: Card(
                                                                              child: ListTile(
                                                                                leading:Icon(Icons.inventory , color : Colors.blueAccent),
                                                                                title: Text(Alist[index].name),
                                                                                subtitle: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Container(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text("Total : ", style: TextStyle(color: Colors.black45 ,fontStyle: FontStyle.italic)),
                                                                                            Text(Alist[index].total.toString(), style: TextStyle(color: Colors.grey ,fontStyle: FontStyle.italic)),  
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Container(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text("Scan : ", style: TextStyle(color: Colors.black45 ,fontStyle: FontStyle.italic)),
                                                                                            Text(Alist[index].scan.toString(), style: TextStyle(color: Colors.grey ,fontStyle: FontStyle.italic)),  
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),


                                                                                  ),
                                                                        ),),);},),),

                                                                          
                                                    
                                                    
                                                    
                                                    ]);
                                                
                                                
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
                                                              child: Text("Erreur lors du chargement des données de la base de données, réessayez" ,style: TextStyle(color: Colors.black , fontSize: 10),),
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

                                            
                                              },),

                                                                        
                                                                          ));
    
    
    
  }
}
