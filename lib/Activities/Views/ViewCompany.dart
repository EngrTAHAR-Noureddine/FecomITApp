import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../DataBase/fecomDataBase.dart';
import 'ViewDirectionAndService.dart';
class ViewCompany extends StatefulWidget {
  String siteId = "null";
  
  String Chain = " ";
  ViewCompany({this.siteId , this.Chain});

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
  FecomItDatabase db = FecomItDatabase();
  String _siteId ;
  Site _site;
  String _chain ;
@override
  // ignore: must_call_super
  initState(){
    _siteId = widget.siteId;
    _chain = widget.Chain;
    if(_siteId == "null" ){_site = new Site(id: "null" , Nom: "null"); }

  }

  Future<List> getListView() async{
    final dao1 = CompanysDao(db);
      if(_siteId != "null" ){_site = (await SitesDao(db).getSiteById(_siteId));}
    return (_siteId != "null" )? dao1.watchEntriesInCompany(_site):dao1.getAllCompanys();
  }


  @override
  Widget build(BuildContext context) {
    initState();
    print("rani fi company");
    
    return Scaffold(
      appBar:  MyAppBar( height:50,homeWidget:((_siteId != "null" )? "backSite":"backHome"),chain: _chain,previous: null,whereis: _site,),
      bottomNavigationBar: BottomNavBar(height:100, where: "null",),
      endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            // ignore: non_constant_identifier_names
            List<Company> Alist = snapshot.data;
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
                    height: MediaQuery.of(context).size.height-50,
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
                              title: Text("Entreprise : "+(Alist[index].id!=null ?Alist[index].id : "pas trouvé") ),
                              subtitle:Text(Alist[index].Nom!=null ?Alist[index].Nom : "pas trouvé" ) ,
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDirection(comp : Alist[index] , direcservice :null.toString() ,Chain: _chain+">"+Alist[index].Nom,),
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
                         Navigator.pop(context);
                        Navigator.of(context).pushNamed("ViewSites");
                      },
                    ),
                    Text("il n'y a pas des companies", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 10),),
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
                       Navigator.pop(context);
                      Navigator.of(context).pushNamed("ViewSites");
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
