import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../MaterialDesignCustom/AppBar.dart';
import '../../MaterialDesignCustom/bottomNavBar.dart';
import '../Accueil/Home.dart';
import 'package:flutter/material.dart';
import 'ViewCompany.dart';
import '../../DataBase/fecomDataBase.dart';
import 'package:hexcolor/hexcolor.dart';
class ViewSites extends StatefulWidget {
  @override
  _ViewSitesState createState() => _ViewSitesState();
}

class _ViewSitesState extends State<ViewSites> {
  FecomItDatabase db = FecomItDatabase();

  Future<List> getListView() async{
    final dao1 = SitesDao(db);
    return await dao1.getAllSites();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar( height:50,homeWidget: "backHome",chain: null,previous:null ,whereis: null,),
      bottomNavigationBar: BottomNavBar(height:100 , where: "null",),
      endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: getListView(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            List<Site> Alist = snapshot.data;
            if(Alist.length>0){
              return Center(
                child: ListView.builder(
                    itemCount: Alist.length,
                    padding: EdgeInsets.all(20),

                    itemBuilder: (BuildContext context, int index) {
                      return  Container(

                            padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                                color:HexColor("#C8FCEA"),
                              ),
                          child: ListTile(
                            title: Text("Site : "+(Alist[index].id!=null ?Alist[index].id : "pas trouvé") ),
                            subtitle:Text(Alist[index].Nom!=null ?Alist[index].Nom : "pas trouvé" ) ,
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewCompany(siteId : Alist[index].id , Chain: Alist[index].Nom,),
                                ),
                              );
                            },
                          ),

                      );
                    }),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                        },
                    ),
                    Text("il n'y a pas des Sites", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 12),),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                  Text("Erreur lors du chargement des données de ", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 12),),
                  Text("la base de données, réessayez", style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 12),),

                ],
              ),
            );
          }

        },
      ),
    );
  }
}
