import 'dart:io';

import 'package:fecom_xpress_app/Functions/Exporter/ByCSV/ExportFunction.dart';
import 'package:fecom_xpress_app/Functions/Importer/parFichier/FichierImport.dart';
import 'package:fecom_xpress_app/Functions/Service/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Functions/Service/SharePreferences.dart';
import '../../DataBase/fecomDataBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' as Io;
import 'ImporterBotton.dart';
import 'SupprimerBotton.dart';
import 'UpdateBotton.dart';


class HomeFunction extends StatefulWidget {
  @override
  _HomeFunctionState createState() => _HomeFunctionState();
}
/* class pour sauvegarder les donnees de inventaire et tout  ses informations */
class invItem{
  Inventory inv;
  bool complete; /* if complete ==> no import, no update,no reset */
  bool export;
  bool reset;

  invItem({this.complete,this.export,
              this.inv,this.reset});
}


class _HomeFunctionState extends State<HomeFunction> {
  FecomItDatabase db= FecomItDatabase();
  Share _sharing = Share();

 

final _dao1 = InventorysDao(FecomItDatabase());

  Future<List<invItem>> getInventory()async{

      CreateOwnFolder();
      final  dao2 = InventoryLinesDao(db);

      List<invItem> myList = <invItem>[];

   
   
    List<Inventory> inventor = await _dao1.getAllInventorys();
    
    if(inventor.isNotEmpty){
     
           for(Inventory element in inventor){
                 if((await dao2.getInventoryLineByInv(element)).isEmpty){
                        myList.add(new invItem(
                                  inv: element,
                                  complete: (element.CloseDate.year != 1971),
                                  export: false,
                                  reset: false
                                                  ));
                  }else{
                    myList.add(new invItem(
                                  inv: element,
                                  complete: (element.CloseDate.year != 1971),
                                  export: true,
                                  reset: (true & (element.CloseDate.year == 1971))
                                                  ));

                  }
     
                                         }
                                      
                                }
   
   return (myList.isNotEmpty) ? myList : null;
  }

  _goToTheNext()async{
    List<String> listdone = _sharing.keys[3];
    if((await _sharing.readString(listdone[3])) == "Done"){
    if((await _sharing.readString(listdone[0])) == "Done")
        { Navigator.of(context).pushNamed("ViewSites");}
    else if((await _sharing.readString(listdone[1])) == "Done")
        { Navigator.of(context).pushNamed("ViewCompany");}
    else if((await _sharing.readString(listdone[2])) == "Done")
        { Navigator.of(context).pushNamed("ViewDirection");}   
    else if((await _sharing.readString(listdone[4])) == "Done")
        { Navigator.of(context).pushNamed("ViewEmplacement");}
    else if((await _sharing.readString(listdone[3])) == "Done")
        { Navigator.of(context).pushNamed("ViewStockSys");}
    }else{
      Navigator.of(context).pushNamed("ViewLesProduitLots");
    }
  }

Future<void> termine(Inventory inv)async{
  await  _dao1.UpdateInv(new Inventory(
                                        id:inv.id ,
                                        CloseDate:DateTime.now() ,
                                        OpeningDate:inv.OpeningDate
                                     ));
}



  @override
  Widget build(BuildContext context){
    print("HomeFunction.dart ****** ");
return FutureBuilder(
  future: getInventory(),

  builder: (context , snapshot){

    if(snapshot.hasData){ /* we had an inventory(ies) */
      List<invItem> list = snapshot.data;
     
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, indx){
          int index = list.length - indx -1;
          return Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Terminer',

                  color: Colors.lightBlue,
                  icon: Icons.check,     
                  onTap:((!list[index].complete)?(){
                                      termine(list[index].inv).whenComplete(() => setState((){}));
                      }:null),
                )
                    ],
      child: Container(
        margin: EdgeInsets.all(10),
        height:100,
        child: Column(
            children: [
              Container(
                height: 50,
                padding : EdgeInsets.only(left:10,right: 10,top:5,bottom: 5),
                decoration: BoxDecoration(
                    color: ((!list[index].complete)?HexColor("#C0FAFF"):HexColor("#00C59B")),
                      
                ),
                
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text("Inventory : "+list[index].inv.id , style: TextStyle(fontSize:12),),

                  (!list[index].complete)?
                 RaisedButton(
                      child: Text(("En Cours" ),
                            style: TextStyle(
                              color : Colors.white
                              , fontSize: 10),
                              ),

                      color:HexColor("#66C7E4"),
                      onPressed: _goToTheNext,
                      elevation: 1,
                     

                    ): Text("Complete",
                            style: TextStyle(color :
                              Colors.white
                            , fontSize: 10),
                              ),
                  ],),
              ),
          Container(
                  height: 40,
                  decoration: BoxDecoration(
                          color: HexColor("#F2F2F2"),

                          ),
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     ///  /* Importer  */
                      IconButton(
                      icon: Icon(Icons.download_rounded ,color:(!list[index].complete)?HexColor("#00C6FF"):HexColor("#C2C9B7"),size: 20,),
                   
                      splashColor: Colors.transparent,
                      onPressed: (!list[index].complete)?(){
                        print("return ImporterBotton().Botton(context); *************");
                                         return ImporterBotton().Botton(context);
                                                              }:null,
                                 ),
                     /// /* Mis à jours  */
                      IconButton(
                        icon: Icon(Icons.update ,color:(!list[index].complete)?HexColor("#00C6FF"):HexColor("#C2C9B7"),size: 20,),
                      
                       splashColor: Colors.transparent,
                        onPressed: (!list[index].complete)?(){
                                                return UpdateBotton().Botton(context);
                                                    }:null,
                      ),
                      /// /* Reset les donnees  */
                      IconButton(
                        icon: Icon(Icons.settings_backup_restore_outlined ,color: (list[index].reset)?HexColor("#00C6FF"):HexColor("#C2C9B7"),size: 20,),
                        
                        splashColor: Colors.transparent,
                        onPressed: (list[index].reset) ? ()async{
                          return showDialog(context: context, builder: (context){
                          return AlertDialog(
                               shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                               title: Center(child: Text("Réinitialiser L'inventaire" , style: TextStyle(color: Colors.black, fontSize: 14),),),
                               content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(

                                       children: [
                                        Text("vous souhaitez Réinitialiser les données ?", style: TextStyle(color: Colors.black,fontSize: 10)) ,


                                        FlatButton(
                                            color: Colors.transparent,
                                            shape: Border.fromBorderSide(BorderSide.none),
                                            splashColor: Colors.transparent,
                                            child: Text("Réinitialiser",style:TextStyle(fontSize : 12 ,color: HexColor("#009dff"),),),
                                            onPressed: () async{
                                              Navigator.pop(context);
                                                  bool wait = await Services().Reset(list[index].inv);
                                                              if(wait == true){
                                                              setState(() {});
                                                        }},

                                                    ),
                                        FlatButton(
                                            color: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Text("Annuler",style:TextStyle( fontSize : 12,color: HexColor("#009dff"),),),
                                            onPressed: () {
                                                  Navigator.pop(context);
                                                              },
                                                    ),
                                       ],
                                     ),),
                     
                     
                   ),
                 );
                          });
                          }      
                         : null,
                      ),

                    /// /* Supprimer les donnees  */
                      IconButton(
                        icon: Icon(Icons.delete ,color: HexColor("#00C6FF"),size: 20,),
                      
                       splashColor: Colors.transparent,
                        onPressed: (){
                           return SupprimerBotton(inv: list[index].inv).Botton(context);
                      },
                        
                        ),
                      IconButton( /* Exporter les donnees  */
                        icon: Icon(Icons.upload_rounded ,color: list[index].export?HexColor("#00C6FF"):HexColor("#C2C9B7"),size: 20,),
                        
                        splashColor: Colors.transparent,
                        onPressed:list[index].export?(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExportFunction(idInv: list[index].inv),
                            ),
                          );
                        }:null,
                      ),],
                  ),
                ),
            ],
        ),
      ),
                      );
        },
      );
      
    

    }else { /* inventory empty  */
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              height: 100,
              color: Colors.transparent,
              icon: Icon(Icons.add_circle_rounded, color: HexColor("#C2C9B7"),size: 100,) ,
              label: Text(""),
              onPressed: (){
                  return showDialog(context: context, builder: (context){
                 return AlertDialog(
                   shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                   title: Center(child: Text("Importer Inventaire" , style: TextStyle(color: Colors.black,fontSize: 14),),),
                   content: SingleChildScrollView(
                      child: Container(
                        child: Column(

                       children: [
                        Text("Pour nouveau inventaire appuyez sur les boutons suivant et pour Annuler appuyez hors boite dialog", style: TextStyle(color: Colors.black ,fontSize: 10)) ,
                        
                        
                        
                        FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text("Nouveau Importation par fichier excel",style:TextStyle( fontSize : 12,color: HexColor("#009dff"),),),
                            onPressed: ()async{
                                 // Navigator.pop(context);
                                        File file1;
                                        try{
                                        FilePickerResult result = await FilePicker.platform.pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: ['xlsx'],
                                                );
                                                
                                            if(result != null) {
                                            file1  = File(result.files.first.path);
                                            Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ImportFile(file:file1), //Nedjm(),//
                                                                    ),
                                                          );
                                            

                                            }
                                        }catch(e){throw "aucun fichier ";}

                                  
                                              },
                                    ),
                         FlatButton(
                           color: Colors.transparent,
                           shape: Border.fromBorderSide(BorderSide.none),
                           splashColor: Colors.transparent,
                           child: Text("Annuler",style:TextStyle(fontSize : 12 ,color: HexColor("#009dff"),),),
                           onPressed: () {
                             Navigator.pop(context);
                           },
                         ),
                       ],
                     ),),
                     
                     
                   ),
                 ); });
              },
            ),
            Text("Importez le fichier", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
          ],
        ),
      );
    }




    },



);
  }
  
  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }
  Future<void> CreateOwnFolder()async{
     Io.Directory directory;
    try{
      if(Io.Platform.isAndroid){  /* Android  */
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          print(directory.path);
          String newPath ="";
          String path1,path2;
          List<String> folders = directory.path.split("/");
              for(int x=1; x<folders.length;x++){
            String folder = folders[x];
            if(folder != "Android"){
              newPath += "/"+folder;
            }else break;
          }
          path1 = newPath+"/FecomIt/Exportation";
          directory = Io.Directory(path1);
          path2 = newPath+"/FecomIt/Importation";
          directory = Io.Directory(path2);
          print(directory.path);
        }
      }else{ /* IOS */
        
        }

    }catch(e){print("this is an error one : "+e);}

    if(!await directory.exists()){
      await directory.create(recursive: true);
    }
   

    
  
  

  }

}
 

