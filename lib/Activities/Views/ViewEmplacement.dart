import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';
import 'ViewStockSysytem.dart';

class ViewEmplacement extends StatefulWidget {
  StockEntrepot st ;
  Company comp;
  String Chain= " ";
  
  ViewEmplacement({this.st , this.comp, this.Chain});

  @override
  _ViewEmplacementState createState() => _ViewEmplacementState();
}

class _ViewEmplacementState extends State<ViewEmplacement> {
  FecomItDatabase db = FecomItDatabase();
  StockEntrepot _stock ;
  String _chain;
  Company _comp;
  List<String> compoundChain;

  Future<List> getListView() async{
    final dao1 = EmplacementsDao(db);
    return (_stock.id != "null")?dao1.fetchEmplaceWithService(_stock):dao1.getAllEmplacements();
  }
@override
  void initState() {
  _stock = widget.st;
  _chain = widget.Chain;
  _comp = widget.comp;
  compoundChain = _chain.split(">");
  if(_stock == null ){ _stock = new StockEntrepot(id: "null" ,
  Nom: "null", CompanyId: "null" ,DirectionId: "null",DirectionType: "null");}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar( height:50,homeWidget:(_stock.id!=null)?((compoundChain[0] != "home") ?"backDirection" : "backHome" ): "backHome",
                                chain: (compoundChain.length>1)? (compoundChain[0]+">"+compoundChain[1]+">"+compoundChain[2]) : "home" ,
                                previous:  (compoundChain[0] != "home") ? _stock.DirectionId : null,
                                whereis: (compoundChain[0] != "home") ? _comp : null ,),
      bottomNavigationBar: BottomNavBar(height:100 , where: "null",),
      endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            List<Emplacement> Alist = snapshot.data;
            if(Alist.length>0){
              return ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 50,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    child: ListView.builder(
                        itemCount: Alist.length,
                        padding: EdgeInsets.all(20),

                        itemBuilder: (BuildContext context, int index) {

                          return Container(

                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:HexColor("#C8FCEA"),
                            ),
                            child: ListTile(
                              title: Text("Bureau : "+(Alist[index].id!=null ?Alist[index].id : "pas trouvé") ),
                              subtitle:Text(Alist[index].Nom!=null ?Alist[index].Nom : "pas trouvé" ) ,
                              onTap: (){
                                print("i'm in veiw emplacement *************************");
                                print(Alist[index].id );
                                print("is string :");
                                print(Alist[index].id is String);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewLesProduits(emplacement : Alist[index], Chain: _chain+">"+Alist[index].Nom,comp: _comp,strn: _stock,),
                                  ),
                                );
                              },
                            ),

                          );


                        }),
                  ),
                ],
              );
            }
            else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                      height: 20,
                      color: Colors.red,
                      icon: Icon(Icons.arrow_back, color:HexColor("#F2F2F2") ,size: 20,) ,
                      label: Text(""),
                      onPressed: (){
                        Navigator.pop(context , false);
                      },
                    ),
                    Text("il n'y a pas des Bureaux", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 10),),
                  ],
                ),
              );
            }

          }else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                    height: 20,
                    color: Colors.red,
                    icon: Icon(Icons.arrow_back, color:HexColor("#F2F2F2") ,size: 20,) ,
                    label: Text(""),
                    onPressed: (){
                      Navigator.pop(context , false);
                    },
                  ),
                  Text("Erreur lors du chargement des données de ", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 20),),
                  Text(" la base de données, réessayez", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 20),),

                ],
              ),
            );
          }

        },
      ),
    );
  }
}
