import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/MaterialDesignCustom/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io' as Io;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class ExportFunction extends StatefulWidget {
  Inventory idInv;
  ExportFunction({this.idInv});
  @override
  _ExportFunctionState createState() => _ExportFunctionState();
}

class _ExportFunctionState extends State<ExportFunction> {
 Inventory _idInve;
  DateTime dateTime = new DateTime.now();
  
FecomItDatabase db = FecomItDatabase();
  
  Future<bool> saveFile()async{
    final dao1 = InventoryLinesDao(db);
    String fileName = "null";
    List<InventoryLine> data = await dao1.getInventoryLineByInv(_idInve);
  var excel = Excel.createExcel();
  var sheet = excel['mySheet'];
  for(InventoryLine item in data){
      List<String> row = [item.id,item.ProductId,item.ProductLotId,item.EmplacementId,item.Quantity,item.QuantitySystem,item.Difference,item.Quality,item.InventoryId,];
  sheet.appendRow(row);	
  }


  excel.setDefaultSheet(sheet.sheetName).then((value){
    if(value){
      print("is default");
    }else print("not isn't default");
  });

  
  
  List<List<String>> csvData = [
      <String>['id','Id.Product','Id.ProductLot','Id.Emplacement','Quantite','Quantite System','Diffrence','Qualite','Inventaire'],
      ...data.map((item)=>[item.id,item.ProductId,item.ProductLotId,item.EmplacementId,item.Quantity,item.QuantitySystem,item.Difference,item.Quality,item.InventoryId,]),
    ];

      fileName = "Invetaire_"+_idInve.id+"("+dateTime.day.toString()+"-"+dateTime.month.toString()+"-"+dateTime.year.toString()+")"+".csv";
      print(fileName);
    String csv = const ListToCsvConverter().convert(csvData);

String pathes;

    Io.Directory directory;
    try{
      if(Io.Platform.isAndroid){  /* Android  */
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          print(directory.path);
          String newPath ="";
          List<String> folders = directory.path.split("/");
              for(int x=1; x<folders.length;x++){
            String folder = folders[x];
            if(folder != "Android"){
              newPath += "/"+folder;
            }else break;
          }
          newPath = newPath+"/FecomIt/Exportation";
          directory = Io.Directory(newPath);
          pathes = newPath;
          print(directory.path);
        }else{ /* we haven't permission */
          return false;
        }
      }else{ /* IOS */
        return false;}

    }catch(e){print("this is an error one : "+e);}

    if(!await directory.exists()){
      await directory.create(recursive: true);
    }
    else{
      print("rani lahna fi excel encode");
        excel.encode().then((onValue){
          File(join(pathes+"/inventory.xlsx"))..createSync(recursive:true)..writeAsBytesSync(onValue);
          });
        
      Io.File file = new Io.File(directory.path+"/$fileName");
      file.writeAsString(csv, mode:Io.FileMode.write, encoding:utf8,flush: false);
      print(directory.path+"/$fileName");
      return true;
    }

    
  
  }

  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }




@override
  void initState() {
    _idInve = widget.idInv;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      appBar: MyAppBar( height:50,homeWidget: "backHome",chain: null,previous: null,whereis: null,),
          backgroundColor: Colors.white,
          body: FutureBuilder(
        future: saveFile(),
        builder: (context , snapshot){
          print("snapshote of export body ");
          print(snapshot.hasData);
          print(snapshot.data);
          print(snapshot.hasError);
          print(snapshot.error);
          
          if(snapshot.hasData){
            return Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
               margin: EdgeInsets.all(10),
                            
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                               color: Colors.green,
                            ),
                alignment: Alignment.center,
                child:  Center(child : ListTile(
                  leading: Icon(Icons.check_circle_outline_sharp,color: Colors.white,size: 25, ),
                  title: Text("Succés ! :D",style: TextStyle(color: Colors.white),),
                ),),
              
               
              ),
            );



          } else return Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                            
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                                color: Colors.white30,
                            ),
                alignment: Alignment.center,
            child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text("Exporter...",style: TextStyle(color: Colors.black45),),
            ),
           

          ));



   
        },
      ),
    );
  }
}