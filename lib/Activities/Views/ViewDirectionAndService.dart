import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';
import 'ViewEmplacement.dart';
class ViewDirection extends StatefulWidget {
  Company comp;
  String  direcservice = "null";
  String Chain = " ";
  ViewDirection({this.comp , this.direcservice , this.Chain});

  @override
  _ViewDirectionState createState() => _ViewDirectionState();
}



class _ViewDirectionState extends State<ViewDirection> {
  FecomItDatabase db = FecomItDatabase();
  List<String> compoundChain;
  Company _comp;
  String _direc;
  String _chain;


  Future<List> getListView() async{
    final dao1 = StockEntrepotsDao(db);

    return dao1.FetchServicesOnComany(_comp,_direc);
  }


@override
  // ignore: must_call_super
  void initState(){
  _comp = widget.comp;
  _direc = widget.direcservice;
  _chain = widget.Chain;
   compoundChain = _chain.split(">"); 
    print("compoundChain");
   print(compoundChain);
   //if(_comp!=null) _site= (await SitesDao(db).getSiteById(_comp.SiteId));

  }

  @override
  Widget build(BuildContext context) {
    initState();
    
  
    return Scaffold(
      appBar:  MyAppBar( height:50,homeWidget: ((_comp!=null)?((_direc!="null")?"backDirection":"backCompany"):"backHome"),
                                      chain: ((_direc!="null")?((compoundChain.length>1)? compoundChain[0]+">"+compoundChain[1] :"home" ): compoundChain[0] ), 
                                      whereis:((_comp!=null)?((_direc!="null")?_comp:(compoundChain[0] == "home")?"null" :_comp.SiteId):null),
                                      previous:((_comp!=null)?"null":null),),
      bottomNavigationBar: BottomNavBar(height:100, where: "null",),
      endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            // ignore: non_constant_identifier_names
            List<StockEntrepot> Alist = snapshot.data;
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
                              title: Text((Alist[index].DirectionType!= null?Alist[index].DirectionType : "pas trouvé")+" : "+(Alist[index].id!=null ?Alist[index].id : "pas trouvé") ),
                              subtitle:Text(Alist[index].Nom!=null ?Alist[index].Nom : "pas trouvé" ) ,
                              onTap: (){
                                Navigator.pop(context);
                                if(Alist[index].DirectionId == "null"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewDirection(comp : _comp  , direcservice : Alist[index].id , Chain: _chain+">"+Alist[index].DirectionType,),
                                    ),
                                  );}else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewEmplacement(st : Alist[index],  Chain: _chain+">"+Alist[index].DirectionType, comp: _comp,),
                                    ),
                                  );
                                }
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
                        Navigator.pop(context , true);
                      },
                    ),
                    Text("il n'y a pas des "+(_direc=="Null"?"Direction":"Service")+"s", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 10),),
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
                    icon: Icon(Icons.replay_rounded, color:HexColor("#F2F2F2") ,size: 20,) ,
                    label: Text(""),
                    onPressed: (){
                      Navigator.pop(context , true);
                    },
                  ),
                  Text("Erreur lors du chargement des données de ", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 10),),
                  Text(" la base de données, réessayez", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 10),),

                ],
              ),
            );
          }

        },
      ),
    );
  }
}
