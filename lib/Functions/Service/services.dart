import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'SharePreferences.dart';

import '../../DataBase/fecomDataBase.dart';
import 'dart:async';


// *************  Site *************
class Services{ //**01**

  static final Services _instance = Services.internal();
  factory Services() => _instance;
  Services.internal();

  FecomItDatabase db = FecomItDatabase();
  Share _sharing = Share();
  final _dao1 = SitesDao(FecomItDatabase());
  final _dao2 = CompanysDao(FecomItDatabase());
  final _dao3 = StockEntrepotsDao(FecomItDatabase());
  final _dao4 = StockSystemsDao(FecomItDatabase());
  final _dao5 = EmplacementsDao(FecomItDatabase());
  final _dao6 = ProductsDao(FecomItDatabase());
  final _dao7 = ProductCategorysDao(FecomItDatabase());
  final _dao8 = ProductLotsDao(FecomItDatabase());

  final _dao9 = InventorysDao(FecomItDatabase());
  final _dao10 = InventoryLinesDao(FecomItDatabase());

/// get licence ********************************************************************************
  Future<bool> GetInformation(File file1)async{

    var bytes = file1.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    bool toggle = true;
    List<String> infolist = _sharing.keys[0];
    List<dynamic> firstLine;
    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        if(toggle == true){  firstLine = row; toggle=false;}
          if(row!= firstLine){
              await _sharing.saveValueString(infolist[0], "exist");
              await _sharing.saveValueString(infolist[1], row[firstLine.indexOf("LogoName")].toString());
              await _sharing.saveValueString(infolist[2], row[firstLine.indexOf("logoimage")].toString());
             await _sharing.saveValueString(infolist[3], row[firstLine.indexOf("telephone")].toString());
             await _sharing.saveValueString(infolist[4], row[firstLine.indexOf("addressEntre")].toString());  
          }
        

      }
    }
    return (await _sharing.IsExist(infolist[0]))==true;


}


  /// log in ************************************************************************************
  Future<String> Login(String password)async{
    List<String> infolist = _sharing.keys[1];
  if((await _sharing.IsExist(infolist[0])) & (await _sharing.IsExist(infolist[2]))){
    String admin= await _sharing.readString(infolist[0]);
    String user = await _sharing.readString(infolist[2]);
    if((admin!=null)&(user != null)){
      if(password == admin){

                           await _sharing.saveValueString(infolist[3], "Admin");
                           return "success";
      }else if(password == user){
        await _sharing.saveValueString(infolist[3], "user");
        return "success";
      }else return "null";
    }

  }else throw "aucun mot de pass ";
  }

/// reset function ******************************************************************************
Future<bool> Reset(Inventory invenIncomplete)async{

  try{
    if((await _dao10.getInventoryLineByInv(invenIncomplete)).isNotEmpty)
     {(await _dao10.getInventoryLineByInv(invenIncomplete)).forEach((element)
   async{await _dao10.deleteInventoryLine(element);});}
  }catch(e){return false;} 
  return true;    
}

///*****************************************************************************************************

Future<String> changePassword(String newPassword ,String confirmPass, String oldPassword )async{
    if(confirmPass != newPassword) throw "confirmation mot de pass pas correct";
    if((newPassword == null) & (oldPassword == null)) return "success";
     List<String> infolist = _sharing.keys[1];
   String etat= await  _sharing.readString(infolist[3]);
   if(etat == "Admin"){
      
     if(oldPassword == (await _sharing.readString(infolist[0]))){
                 if((await _sharing.remove(infolist[0])) == true){
                           await _sharing.saveValueString(infolist[0], newPassword);
                           return "success";
                 }
     }else throw "ce n'est pas le mot de pass ";


   }else if(etat == "user"){

     if(oldPassword == (await _sharing.readString(infolist[2]))){
               if((await _sharing.remove(infolist[2])) == true){
                           await _sharing.saveValueString(infolist[2], newPassword);
                           return "success";
               }
     }else throw "ce n'est pas le mot de pass ";


   }else  throw "nothing";

}
///*****************************************************************************

  Future<bool> resetPassword()async{
    List<String> infolist = _sharing.keys[1];
    String etat = await  _sharing.readString(infolist[3]);
    if(etat != null){
    if(etat == "Admin"){
      if(await _sharing.IsExist(infolist[1])){
        if((await _sharing.remove(infolist[2])) == true){
          await _sharing.saveValueString(infolist[2], (await _sharing.readString(infolist[1])));
          return true;
        }
      }else return false;

    } else return false ;
    }

  }
///***************************PERMISSION **************************************************
///
  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }
///************************************* DELETE ALL **********************************************
///
  Future supprimer()async{
    List listing = _sharing.keys[3];
    /// remove all rows of every tables and we will add again with new rows **************************************

    for(var l in listing) {
      var remove = await _sharing.remove(l);
    }
    if((await _dao1.getAllSites()).isNotEmpty){
      for(var element in (await _dao1.getAllSites())){

        await _dao1.deleteSites(element);
      }}
    //Delete Company
    if((await _dao2.getAllCompanys()).isNotEmpty){
      for(var c in (await _dao2.getAllCompanys())){
        await _dao2.deleteCompanys(c);
      }}
    //Delete StockEntrePot
    if((await _dao3.getAllStockEntrepots()).isNotEmpty){
      for(var st in (await _dao3.getAllStockEntrepots())){

        await _dao3.deleteStockEntrepots(st);
      }}
    //Delete StockSys
    if((await _dao4.getAllStockSystem()).isNotEmpty){
      for(var ss in (await _dao4.getAllStockSystem())) {
        await _dao4.deleteStockSystem(ss);
      }}
    //Delete Emplacement
    if((await _dao5.getAllEmplacements()).isNotEmpty){
      for(var em in (await _dao5.getAllEmplacements())){
        await _dao5.deleteEmplacements(em);
      }}
    if((await _dao6.getAllProducts()).isNotEmpty){
      for(var pr in (await _dao6.getAllProducts())){
        await  _dao6.deleteProducts(pr);
      }}
    //Delete Products
    if((await _dao7.getAllProductCategorys()).isNotEmpty){
      for(var pc in (await _dao7.getAllProductCategorys())) {
        await  _dao7.deleteProducts(pc);
      }}
    //Delete Product Lots
    if((await _dao8.getAllProductLots()).isNotEmpty){
      for(var pl in (await _dao8.getAllProductLots())){
        await  _dao8.deleteProductLot(pl);
      }}

    Inventory inv = await _dao9.IncompleteInvent();
    //Delete Inventory
    inv != null ? (await _dao10.getInventoryLineByInv(inv)).forEach((element) {_dao10.deleteInventoryLine(element);}) : null;
    inv!=null ? _dao9.deleteInventory(inv) : null;


    return (((await _dao1.getAllSites()).isEmpty)&((await _dao2.getAllCompanys()).isEmpty)&((await _dao3.getAllStockEntrepots()).isEmpty)&((await _dao4.getAllStockSystem()).isEmpty)&((await _dao5.getAllEmplacements()).isEmpty)&((await _dao6.getAllProducts()).isEmpty)&((await _dao7.getAllProductCategorys()).isEmpty)&((await _dao8.getAllProductLots()).isEmpty));
  }
///************************************ IMPORTER le fichier  ************************************
///
  Future<bool> import(File file1)async{

    /* variables  */

    String newPath ="";
    File file2;


    List<String> filesName = _sharing.keys[4];




    /* instructors  */

    Directory directory;
    try{
      /// get the directory of FecomIt folder  *********************************************************
      if(Platform.isAndroid){  /* Android  */
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          print(directory.path);
          List<String> folders = directory.path.split("/");
          for(int x=1; x<folders.length;x++){
            String folder = folders[x];
            if(folder != "Android"){
              newPath += "/"+folder;
            }else break;
          }
          newPath = newPath+"/FecomIt/";
          directory = Directory(newPath);
          print(("paths ::::: ////"));
          print(directory.path);
          final dir = Directory(newPath+"Importation");
          dir.deleteSync(recursive: true);

          if(!(await dir.exists())){
            print("dir is not exist ");
            if((await file1.exists())==true){
              print("file 1 exist : "+file1.path);
              newPath = newPath +"Importation/"+basename(file1.path);
              file2 = File(newPath)..createSync(recursive: true);
              file2 = (await  file1.copy(newPath));
              if((await file2.exists())==true){
                print("file2 exist : "+file2.path);
                print("filesname ");
                print(filesName);
               // var bytes = file2.readAsBytesSync();
                var byt = (await file2.readAsBytes());
                
                var excel ;
                if(byt!=null){
               excel = Excel.decodeBytes(byt);
                print("excel ");
                }
if(excel != null){
                if(excel.tables.keys.contains(filesName[0])){
                  /* Site */
                  if((await _dao1.getAllSites()).isEmpty){
                    List<dynamic> firstSite;
                    firstSite = excel.tables[filesName[0]].rows.first;
                    for (var row in excel.tables[filesName[0]].rows) {


                      if(!row.contains("id")){
                        await _dao1.insertSite(new Site(
                          id: (firstSite.indexOf("id")<0)?"null":row[firstSite.indexOf("id")].toString(),
                          Nom:(firstSite.indexOf("nom")<0)?"null": row[firstSite.indexOf("nom")].toString(),
                        ));
                      }
                    }
                  }
                }

                /* Company */
                if(excel.tables.keys.contains(filesName[1])){
                  if((await _dao2.getAllCompanys()).isEmpty){
                    List<dynamic> firstcompany;
                    firstcompany = excel.tables[filesName[1]].rows.first;
                    for (var row in excel.tables[filesName[1]].rows) {

                      if(!row.contains("id")){
                        await _dao2.insertCompany(new Company(
                          id: (firstcompany.indexOf("id")<0)?"null":row[firstcompany.indexOf("id")].toString(),
                          Nom: (firstcompany.indexOf("nom")<0)?"null":row[firstcompany.indexOf("nom")].toString(),
                          SiteId: (firstcompany.indexOf("site_id")<0)?"null":row[firstcompany.indexOf("site_id")].toString(),
                          logo: (firstcompany.indexOf("logo")<0)?"null":row[firstcompany.indexOf("logo")].toString(),

                        ));
                      }
                    }
                  }
                }

                /* StockEntrePot */
                if(excel.tables.keys.contains(filesName[2])){
                  if((await _dao3.getAllStockEntrepots()).isEmpty){
                    List<dynamic> firststock;
                    firststock = excel.tables[filesName[2]].rows.first;

                    for (var row in excel.tables[filesName[2]].rows) {

                      if(!row.contains("id")){
                        await  _dao3.insertStockEntrepot(new StockEntrepot(
                          id: (firststock.indexOf("id")<0)?"null":row[firststock.indexOf("id")].toString(),
                          DirectionType : (firststock.indexOf("DirectionType")<0)?"null":row[firststock.indexOf("DirectionType")].toString(),
                          CompanyId: (firststock.indexOf("CompanyId")<0)?"null":row[firststock.indexOf("CompanyId")].toString() ,
                          DirectionId: (firststock.indexOf("DirectionId")<0)?"null":row[firststock.indexOf("DirectionId")].toString(),
                          Nom: (firststock.indexOf("nom")<0)?"null":row[firststock.indexOf("nom")].toString(),
                        )
                        );
                      }
                    }

                  }
                }

                /* Emplacement */
                if(excel.tables.keys.contains(filesName[3])){
                  if((await _dao5.getAllEmplacements()).isEmpty){
                    List<dynamic> firstemplacement;
                    firstemplacement = excel.tables[filesName[3]].rows.first;

                    for (var row in excel.tables[filesName[3]].rows) {

                      if(!row.contains("id")){
                        await _dao5.insertEmplacement(new Emplacement(
                          id:(firstemplacement.indexOf("id")<0)?"null":row[firstemplacement.indexOf("id")].toString(),
                          Nom: (firstemplacement.indexOf("nom")<0)?"null":row[firstemplacement.indexOf("nom")].toString(),
                          entrepotId: (firstemplacement.indexOf("enterpot-id")<0)?"null":row[firstemplacement.indexOf("enterpot-id")].toString(),
                          barcodeemp: (firstemplacement.indexOf("barcodeemp")<0)?"null":row[firstemplacement.indexOf("barcodeemp")].toString(),

                        ));
                      }
                    }
                  }
                }

                /* stocksys */
                if(excel.tables.keys.contains(filesName[4])){
                  if((await _dao4.getAllStockSystem()).isEmpty){
                    List<dynamic> firstSsys;
                    firstSsys = excel.tables[filesName[4]].rows.first;

                    for (var row in excel.tables[filesName[4]].rows) {

                      if(!row.contains("id")){
                        print("stock sys \n");
                        print(firstSsys);
                        print(row);
                        print(firstSsys.indexOf("EmplacmentId"));
                        print("==================");
                        await _dao4.insertStockSystem(new StockSystem(
                          id: (firstSsys.indexOf("id")<0)?"null":row[firstSsys.indexOf("id")].toString(),
                          EmplacementId:(firstSsys.indexOf("EmplacmentId")<0)?"null":row[firstSsys.indexOf("EmplacmentId")].toString(),
                          ProductId:(firstSsys.indexOf("ProductId")<0)?"null":row[firstSsys.indexOf("ProductId")].toString(),
                          ProductLotId:(firstSsys.indexOf("ProductLotId")<0)?"null":row[firstSsys.indexOf("ProductLotId")].toString(),
                          Quantity:(firstSsys.indexOf("Quantity")<0)?"null":row[firstSsys.indexOf("Quantity")].toString(),
                        )
                        );
                      }
                    }

                  }
                }

                /* ProductLot */
                if(excel.tables.keys.contains(filesName[6])){
                  if((await _dao8.getAllProductLots()).isEmpty){
                    List<dynamic> firstprod;
                    firstprod = excel.tables[filesName[6]].rows.first;

                    for (var row in excel.tables[filesName[6]].rows) {


                      if(!row.contains("id")){
                        
                        await  _dao8.insertProductLot(new ProductLot(
                          id:(firstprod.indexOf("id")<0)?"null":row[firstprod.indexOf("id")].toString(),
                          Immatriculation:(firstprod.indexOf("immatriculation")<0)?"null":row[firstprod.indexOf("immatriculation")].toString(),
                          NumSerie:(firstprod.indexOf("num_serie")<0)?"null":row[firstprod.indexOf("num_serie")].toString(),
                          Numlot:(firstprod.indexOf("num_lot")<0)?"null":row[firstprod.indexOf("num_lot")].toString(),
                          ProductId:(firstprod.indexOf("product_id")<0)?"null":row[firstprod.indexOf("product_id")].toString(),
                        ));
                      }else continue;
                    }
                  }
                }

                /* Product */
                if(excel.tables.keys.contains(filesName[5])){
                  if((await _dao6.getAllProducts()).isEmpty){
                    List<dynamic> firstproducts;
                    firstproducts = excel.tables[filesName[5]].rows.first;

                    for (var row in excel.tables[filesName[5]].rows) {


                      if(!row.contains("id")){

                        await  _dao6.insertProduct(new Product(
                          id:(firstproducts.indexOf("id")<0)?"null":row[firstproducts.indexOf("id")].toString(),
                          ProductCode :(firstproducts.indexOf("code")<0)?"null":row[firstproducts.indexOf("code")].toString(),
                          Nom:(firstproducts.indexOf("nom")<0)?"null":row[firstproducts.indexOf("nom")].toString(),
                          CategoryId:(firstproducts.indexOf("categoryId")<0)?"null":row[firstproducts.indexOf("categoryId")].toString(),
                          GestionLot:(firstproducts.indexOf("gestionLot")<0)?"null":row[firstproducts.indexOf("gestionLot")].toString(),
                          ProductType:(firstproducts.indexOf("producttype")<0)?"null":row[firstproducts.indexOf("producttype")].toString(),
                        )
                        );
                      }
                    }
                  }
                }

                /* ProductCate */
                if(excel.tables.keys.contains(filesName[7])){
                  if((await _dao7.getAllProductCategorys()).isEmpty){
                    List<dynamic> productcate;
                    productcate = excel.tables[filesName[7]].rows.first;

                    for (var row in excel.tables[filesName[7]].rows) {

                      if(!row.contains("id")){

                        await  _dao7.insertProductCategory(new ProductCategory(
                          id:(productcate.indexOf("id")<0)?"null":row[productcate.indexOf("id")].toString(),
                          CategName:(productcate.indexOf("nom")<0)?"null":row[productcate.indexOf("nom")].toString(),
                          CategCode:(productcate.indexOf("code")<0)?"null":row[productcate.indexOf("code")].toString(),
                          ParentId:(productcate.indexOf("parentId")<0)?"null":row[productcate.indexOf("parentId")].toString(),
                          ParentPath:(productcate.indexOf("parentPath")<0)?"null":row[productcate.indexOf("parentPath")].toString(),

                        ));
                      }
                    }
                  }
                }
}
              }else throw "we haven't a copy ";


            }else{ throw "we haven't a file";}


          }else print("dir is exist");

        }else throw "we haven't a permission ";
      }else throw "the platform is not ios";
    }catch(e){ print("catch error : "+e.toString());}

/* to check if tables empty or not  */

    List listing = _sharing.keys[3];
    bool loading = false;
    /* check site  */
    if((await _dao1.getAllSites()).isNotEmpty) {
      _sharing.saveValueString(listing[0] ,"Done");
    } else _sharing.saveValueString(listing[0] ,"Failed");

    /* check company  */
    if((await _dao2.getAllCompanys()).isNotEmpty){
      _sharing.saveValueString(listing[1] ,"Done");
    }else _sharing.saveValueString(listing[1] ,"Failed") ;

    /* check entrepot */
    if((await _dao3.getAllStockEntrepots()).isNotEmpty){
      _sharing.saveValueString(listing[2] ,"Done");
    }else _sharing.saveValueString(listing[2] ,"Failed");

    /* stock system  */
    if((await _dao4.getAllStockSystem()).isNotEmpty){
      _sharing.saveValueString(listing[3] ,"Done");//10
      int lengthS = (await _dao4.getAllStockSystem()).length;
      _sharing.saveValueInt(_sharing.keys[2] ,lengthS);//10
      /// this instruction to save each emplacement has stock system
      if((await _dao5.getAllEmplacements()).isNotEmpty){
        List<Emplacement> emplist = (await _dao5.getAllEmplacements());
        for(Emplacement element in emplist){
          String name = "emplacement : "+element.id;
          int lengthtotal = (await _dao4.fetchStockSystemInEmplacement(element)).length;
          _sharing.saveValueInt(name, lengthtotal);
        }
      }
    }else{
      _sharing.saveValueString(listing[3] ,"Failed") ;
      _sharing.saveValueInt(_sharing.keys[2] ,0);//10
    }

    /** emplacement  */
    if((await _dao5.getAllEmplacements()).isNotEmpty){
      _sharing.saveValueString(listing[4] ,"Done");
    }else _sharing.saveValueString(listing[4] ,"Failed") ;

    /* products  */
    if((await _dao6.getAllProducts()).isNotEmpty){
      _sharing.saveValueString(listing[5] ,"Done");
    }else _sharing.saveValueString(listing[5],"Failed") ;

    /* product category  */
    if((await _dao7.getAllProductCategorys()).isNotEmpty){
      _sharing.saveValueString(listing[6] ,"Done");
    }else _sharing.saveValueString(listing[6] ,"Failed") ;
    /* product lot  */
    if((await _dao8.getAllProductLots()).isNotEmpty){
      _sharing.saveValueString(listing[7] ,"Done");
      /* ==================== create inventory =================== */
      List<Inventory> Inv = await _dao9.getAllInventorys();
      int NewId = 1;
      (Inv.isNotEmpty) ?
      NewId = int.parse(Inv.last.id)+ NewId : NewId ;
      await  _dao9.insertInventory(Inventory(id:NewId.toString(),CloseDate:DateTime.utc(1971, 1, 1) , OpeningDate: DateTime.now() ));
      /* ==================== end create inventory =================== */

      loading = true;
    }else{ _sharing.saveValueString(listing[7] ,"Failed") ; throw "il n'y a pas des lots";}


    print("loading outside");
    return loading;


  }

///********************************************** Updating *************************************
/// search if it contains that row or not if not we'll add in database

  Future<bool> Update(File file1)async{

    /* variables  */

    String newPath ="";
    File file2;


    List<String> filesName = _sharing.keys[4];




    /* instructors  */

    Directory directory;
    try{
      /// get the directory of FecomIt folder  *********************************************************
      if(Platform.isAndroid){  /* Android  */
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          print(directory.path);
          List<String> folders = directory.path.split("/");
          for(int x=1; x<folders.length;x++){
            String folder = folders[x];
            if(folder != "Android"){
              newPath += "/"+folder;
            }else break;
          }
          newPath = newPath+"/FecomIt/";
          directory = Directory(newPath);
          print(("paths ::::: ////"));
          print(directory.path);
          final dir = Directory(newPath+"Importation");
          dir.deleteSync(recursive: true);

          if(!(await dir.exists())){
            print("dir is not exist ");
            if((await file1.exists())==true){
              print("file 1 exist : "+file1.path);
              newPath = newPath +"Importation/"+basename(file1.path);
              file2 = File(newPath)..createSync(recursive: true);
              file2 = (await  file1.copy(newPath));
              if((await file2.exists())==true){
                print("file2 exist : "+file2.path);
                print("filesname ");
                print(filesName);
                var bytes = file2.readAsBytesSync();
                var excel = Excel.decodeBytes(bytes);
                print("excel ");


                if(excel.tables.keys.contains(filesName[0])){
                  /* Site */
                  if((await _dao1.getAllSites()).isEmpty){
                    List<dynamic> firstSite;

                    for (var row in excel.tables[filesName[0]].rows) {

                      firstSite = excel.tables[filesName[0]].rows.first;

                      if(row!= firstSite){
                        if (!(await _dao1.getAllSites()).contains(Site(
                          id: (firstSite.indexOf("id")<0)?"null":row[firstSite.indexOf("id")].toString(),
                          Nom:(firstSite.indexOf("nom")<0)?"null": row[firstSite.indexOf("nom")].toString(),
                        ))){
                          await _dao1.insertSite(new Site(
                            id: (firstSite.indexOf("id")<0)?"null":row[firstSite.indexOf("id")].toString(),
                            Nom:(firstSite.indexOf("nom")<0)?"null": row[firstSite.indexOf("nom")].toString(),
                          ));
                        }

                      }
                    }
                  }
                }

                /* Company */
                if(excel.tables.keys.contains(filesName[1])){
                  if((await _dao2.getAllCompanys()).isEmpty){
                    List<dynamic> firstcompany;
                    for (var row in excel.tables[filesName[1]].rows) {
                      firstcompany = excel.tables[filesName[1]].rows.first;

                      if(row!= firstcompany){
                    if (!(await _dao2.getAllCompanys()).contains(
                        Company(
                          id: (firstcompany.indexOf("id")<0)?"null":row[firstcompany.indexOf("id")].toString(),
                          Nom: (firstcompany.indexOf("nom")<0)?"null":row[firstcompany.indexOf("nom")].toString(),
                          SiteId: (firstcompany.indexOf("site_id")<0)?"null":row[firstcompany.indexOf("site_id")].toString(),
                          logo: (firstcompany.indexOf("logo")<0)?"null":row[firstcompany.indexOf("logo")].toString(),

                        )
                    )){
                      await _dao2.insertCompany(new Company(
                        id: (firstcompany.indexOf("id")<0)?"null":row[firstcompany.indexOf("id")].toString(),
                        Nom: (firstcompany.indexOf("nom")<0)?"null":row[firstcompany.indexOf("nom")].toString(),
                        SiteId: (firstcompany.indexOf("site_id")<0)?"null":row[firstcompany.indexOf("site_id")].toString(),
                        logo: (firstcompany.indexOf("logo")<0)?"null":row[firstcompany.indexOf("logo")].toString(),

                      ));
                    }

                      }
                    }
                  }
                }

                /* StockEntrePot */
                if(excel.tables.keys.contains(filesName[2])){
                  if((await _dao3.getAllStockEntrepots()).isEmpty){
                    List<dynamic> firststock;
                    for (var row in excel.tables[filesName[2]].rows) {
                      firststock = excel.tables[filesName[2]].rows.first;

                      if(row!= firststock){
                    if (!(await _dao3.getAllStockEntrepots()).contains(StockEntrepot(
                      id: (firststock.indexOf("id")<0)?"null":row[firststock.indexOf("id")].toString(),
                      DirectionType : (firststock.indexOf("DirectionType")<0)?"null":row[firststock.indexOf("DirectionType")].toString(),
                      CompanyId: (firststock.indexOf("CompanyId")<0)?"null":row[firststock.indexOf("CompanyId")].toString() ,
                      DirectionId: (firststock.indexOf("DirectionId")<0)?"null":row[firststock.indexOf("DirectionId")].toString(),
                      Nom: (firststock.indexOf("nom")<0)?"null":row[firststock.indexOf("nom")].toString(),
                    ))){
                      await  _dao3.insertStockEntrepot(new StockEntrepot(
                        id: (firststock.indexOf("id")<0)?"null":row[firststock.indexOf("id")].toString(),
                        DirectionType : (firststock.indexOf("DirectionType")<0)?"null":row[firststock.indexOf("DirectionType")].toString(),
                        CompanyId: (firststock.indexOf("CompanyId")<0)?"null":row[firststock.indexOf("CompanyId")].toString() ,
                        DirectionId: (firststock.indexOf("DirectionId")<0)?"null":row[firststock.indexOf("DirectionId")].toString(),
                        Nom: (firststock.indexOf("nom")<0)?"null":row[firststock.indexOf("nom")].toString(),
                      )
                      );

                    }

                      }
                    }

                  }
                }

                /* Emplacement */
                if(excel.tables.keys.contains(filesName[3])){
                  if((await _dao5.getAllEmplacements()).isEmpty){
                    List<dynamic> firstemplacement;
                    for (var row in excel.tables[filesName[3]].rows) {
                      firstemplacement = excel.tables[filesName[3]].rows.first;

                      if(row!= firstemplacement){
                        if ((await _dao5.getAllEmplacements()).contains(
                            Emplacement(
                              id:(firstemplacement.indexOf("id")<0)?"null":row[firstemplacement.indexOf("id")].toString(),
                              Nom: (firstemplacement.indexOf("nom")<0)?"null":row[firstemplacement.indexOf("nom")].toString(),
                              entrepotId: (firstemplacement.indexOf("enterpot-id")<0)?"null":row[firstemplacement.indexOf("enterpot-id")].toString(),
                              barcodeemp: (firstemplacement.indexOf("barcodeemp")<0)?"null":row[firstemplacement.indexOf("barcodeemp")].toString(),

                            )
                        )){
                          await _dao5.insertEmplacement(new Emplacement(
                            id:(firstemplacement.indexOf("id")<0)?"null":row[firstemplacement.indexOf("id")].toString(),
                            Nom: (firstemplacement.indexOf("nom")<0)?"null":row[firstemplacement.indexOf("nom")].toString(),
                            entrepotId: (firstemplacement.indexOf("enterpot-id")<0)?"null":row[firstemplacement.indexOf("enterpot-id")].toString(),
                            barcodeemp: (firstemplacement.indexOf("barcodeemp")<0)?"null":row[firstemplacement.indexOf("barcodeemp")].toString(),
                          ));
                        }

                      }
                    }
                  }
                }

                /* stocksys */
                if(excel.tables.keys.contains(filesName[4])){
                  if((await _dao4.getAllStockSystem()).isEmpty){
                    List<dynamic> firstSsys;
                    for (var row in excel.tables[filesName[4]].rows) {
                      firstSsys = excel.tables[filesName[4]].rows.first;

                      if(row!= firstSsys){
                        if ((await _dao4.getAllStockSystem()).contains(StockSystem(
                          id: (firstSsys.indexOf("id")<0)?"null":row[firstSsys.indexOf("id")].toString(),
                          EmplacementId:(firstSsys.indexOf("EmplacementId")<0)?"null":row[firstSsys.indexOf("EmplacementId")].toString(),
                          ProductId:(firstSsys.indexOf("ProductId")<0)?"null":row[firstSsys.indexOf("ProductId")].toString(),
                          ProductLotId:(firstSsys.indexOf("ProductLotId")<0)?"null":row[firstSsys.indexOf("ProductLotId")].toString(),
                          Quantity:(firstSsys.indexOf("Quantity")<0)?"null":row[firstSsys.indexOf("Quantity")].toString(),
                        ))){
                          await _dao4.insertStockSystem(new StockSystem(
                            id: (firstSsys.indexOf("id")<0)?"null":row[firstSsys.indexOf("id")].toString(),
                            EmplacementId:(firstSsys.indexOf("EmplacementId")<0)?"null":row[firstSsys.indexOf("EmplacementId")].toString(),
                            ProductId:(firstSsys.indexOf("ProductId")<0)?"null":row[firstSsys.indexOf("ProductId")].toString(),
                            ProductLotId:(firstSsys.indexOf("ProductLotId")<0)?"null":row[firstSsys.indexOf("ProductLotId")].toString(),
                            Quantity:(firstSsys.indexOf("Quantity")<0)?"null":row[firstSsys.indexOf("Quantity")].toString(),
                          )
                          );
                        }

                      }
                    }

                  }
                }

                /* ProductLot */
                if(excel.tables.keys.contains(filesName[6])){
                  if((await _dao8.getAllProductLots()).isEmpty){
                    List<dynamic> firstprod;
                    for (var row in excel.tables[filesName[6]].rows) {
                      firstprod = excel.tables[filesName[6]].rows.first;


                      if(row!= firstprod){
                        print(row);
                  if (!(await _dao8.getAllProductLots()).contains(ProductLot(
                    id:(firstprod.indexOf("id")<0)?"null":row[firstprod.indexOf("id")].toString(),
                    Immatriculation:(firstprod.indexOf("immatriculation")<0)?"null":row[firstprod.indexOf("immatriculation")].toString(),
                    NumSerie:(firstprod.indexOf("num_serie")<0)?"null":row[firstprod.indexOf("num_serie")].toString(),
                    Numlot:(firstprod.indexOf("num_lot")<0)?"null":row[firstprod.indexOf("num_lot")].toString(),
                    ProductId:(firstprod.indexOf("product_id")<0)?"null":row[firstprod.indexOf("product_id")].toString(),
                  ))){
                    await  _dao8.insertProductLot(new ProductLot(
                      id:(firstprod.indexOf("id")<0)?"null":row[firstprod.indexOf("id")].toString(),
                      Immatriculation:(firstprod.indexOf("immatriculation")<0)?"null":row[firstprod.indexOf("immatriculation")].toString(),
                      NumSerie:(firstprod.indexOf("num_serie")<0)?"null":row[firstprod.indexOf("num_serie")].toString(),
                      Numlot:(firstprod.indexOf("num_lot")<0)?"null":row[firstprod.indexOf("num_lot")].toString(),
                      ProductId:(firstprod.indexOf("product_id")<0)?"null":row[firstprod.indexOf("product_id")].toString(),
                    ));
                  }

                      }
                    }
                  }
                }

                /* Product */
                if(excel.tables.keys.contains(filesName[5])){
                  if((await _dao6.getAllProducts()).isEmpty){
                    List<dynamic> firstproducts;
                    for (var row in excel.tables[filesName[5]].rows) {
                      firstproducts = excel.tables[filesName[5]].rows.first;


                      if(row!= firstproducts){
                   if (!(await _dao6.getAllProducts()).contains(Product(
                     id:(firstproducts.indexOf("id")<0)?"null":row[firstproducts.indexOf("id")].toString(),
                     ProductCode :(firstproducts.indexOf("code")<0)?"null":row[firstproducts.indexOf("code")].toString(),
                     Nom:(firstproducts.indexOf("nom")<0)?"null":row[firstproducts.indexOf("nom")].toString(),
                     CategoryId:(firstproducts.indexOf("categoryId")<0)?"null":row[firstproducts.indexOf("categoryId")].toString(),
                     GestionLot:(firstproducts.indexOf("gestionLot")<0)?"null":row[firstproducts.indexOf("gestionLot")].toString(),
                     ProductType:(firstproducts.indexOf("producttype")<0)?"null":row[firstproducts.indexOf("producttype")].toString(),
                   ))){
                     await  _dao6.insertProduct(new Product(
                       id:(firstproducts.indexOf("id")<0)?"null":row[firstproducts.indexOf("id")].toString(),
                       ProductCode :(firstproducts.indexOf("code")<0)?"null":row[firstproducts.indexOf("code")].toString(),
                       Nom:(firstproducts.indexOf("nom")<0)?"null":row[firstproducts.indexOf("nom")].toString(),
                       CategoryId:(firstproducts.indexOf("categoryId")<0)?"null":row[firstproducts.indexOf("categoryId")].toString(),
                       GestionLot:(firstproducts.indexOf("gestionLot")<0)?"null":row[firstproducts.indexOf("gestionLot")].toString(),
                       ProductType:(firstproducts.indexOf("producttype")<0)?"null":row[firstproducts.indexOf("producttype")].toString(),
                     )
                     );
                   }

                      }
                    }
                  }
                }

                /* ProductCate */
                if(excel.tables.keys.contains(filesName[7])){
                  if((await _dao7.getAllProductCategorys()).isEmpty){
                    List<dynamic> productcate;
                    for (var row in excel.tables[filesName[7]].rows) {
                      productcate = excel.tables[filesName[7]].rows.first;

                      if(row!= productcate){
                  if (!(await _dao7.getAllProductCategorys()).contains(
                      ProductCategory(
                        id:(productcate.indexOf("id")<0)?"null":row[productcate.indexOf("id")].toString(),
                        CategName:(productcate.indexOf("nom")<0)?"null":row[productcate.indexOf("nom")].toString(),
                        CategCode:(productcate.indexOf("code")<0)?"null":row[productcate.indexOf("code")].toString(),
                        ParentId:(productcate.indexOf("parentId")<0)?"null":row[productcate.indexOf("parentId")].toString(),
                        ParentPath:(productcate.indexOf("parentPath")<0)?"null":row[productcate.indexOf("parentPath")].toString(),

                      )
                  )){
                    await  _dao7.insertProductCategory(new ProductCategory(
                      id:(productcate.indexOf("id")<0)?"null":row[productcate.indexOf("id")].toString(),
                      CategName:(productcate.indexOf("nom")<0)?"null":row[productcate.indexOf("nom")].toString(),
                      CategCode:(productcate.indexOf("code")<0)?"null":row[productcate.indexOf("code")].toString(),
                      ParentId:(productcate.indexOf("parentId")<0)?"null":row[productcate.indexOf("parentId")].toString(),
                      ParentPath:(productcate.indexOf("parentPath")<0)?"null":row[productcate.indexOf("parentPath")].toString(),

                    ));
                  }

                      }
                    }
                  }
                }

              }else throw "we haven't a copy ";


            }else{ throw "we haven't a file";}


          }else print("dir is exist");

        }else throw "we haven't a permission ";
      }else throw "the platform is not ios";
    }catch(e){ print("catch error : "+e.toString());}

/* to check if tables empty or not  */

    List listing = _sharing.keys[3];
    bool loading = false;
    /* check site  */
    if((await _dao1.getAllSites()).isNotEmpty) {
      _sharing.saveValueString(listing[0] ,"Done");
    } else _sharing.saveValueString(listing[0] ,"Failed");

    /* check company  */
    if((await _dao2.getAllCompanys()).isNotEmpty){
      _sharing.saveValueString(listing[1] ,"Done");
    }else _sharing.saveValueString(listing[1] ,"Failed") ;

    /* check entrepot */
    if((await _dao3.getAllStockEntrepots()).isNotEmpty){
      _sharing.saveValueString(listing[2] ,"Done");
    }else _sharing.saveValueString(listing[2] ,"Failed");

    /* stock system  */
    if((await _dao4.getAllStockSystem()).isNotEmpty){
      _sharing.saveValueString(listing[3] ,"Done");//10
      int lengthS = (await _dao4.getAllStockSystem()).length;
      _sharing.saveValueInt(_sharing.keys[2] ,lengthS);//10
      /// this instruction to save each emplacement has stock system
      if((await _dao5.getAllEmplacements()).isNotEmpty){
        List<Emplacement> emplist = (await _dao5.getAllEmplacements());
        for(Emplacement element in emplist){
          String name = "emplacement : "+element.id;
          int lengthtotal = (await _dao4.fetchStockSystemInEmplacement(element)).length;
          _sharing.saveValueInt(name, lengthtotal);
        }
      }
    }else{
      _sharing.saveValueString(listing[3] ,"Failed") ;
      _sharing.saveValueInt(_sharing.keys[2] ,0);//10
    }

    /** emplacement  */
    if((await _dao5.getAllEmplacements()).isNotEmpty){
      _sharing.saveValueString(listing[4] ,"Done");
    }else _sharing.saveValueString(listing[4] ,"Failed") ;

    /* products  */
    if((await _dao6.getAllProducts()).isNotEmpty){
      _sharing.saveValueString(listing[5] ,"Done");
    }else _sharing.saveValueString(listing[5],"Failed") ;

    /* product category  */
    if((await _dao7.getAllProductCategorys()).isNotEmpty){
      _sharing.saveValueString(listing[6] ,"Done");
    }else _sharing.saveValueString(listing[6] ,"Failed") ;
    /* product lot  */
    if((await _dao8.getAllProductLots()).isNotEmpty){
      _sharing.saveValueString(listing[7] ,"Done");

      loading = true;
    }else{ _sharing.saveValueString(listing[7] ,"Failed") ; throw "il n'y a pas des lots";}


    print("loading outside");
    return loading;


  }

}



