
import 'package:fecom_xpress_app/MaterialDesignCustom/EndDrawer.dart';

import '../../DataBase/fecomDataBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../MaterialDesignCustom/AppBar.dart' ;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:barcode_keyboard_listener/barcode_keyboard_listener.dart';

class Scan extends StatefulWidget {
  Emplacement  emplaceScan;
  String chainScan = " ";
  Company compScan;
  StockEntrepot strnScan;
  Scan({this.strnScan, this.compScan,this.chainScan,this.emplaceScan});
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
/*______________________Variables ________________________ */
  Emplacement get emplaceScan => widget.emplaceScan;
  String get chainScan => widget.chainScan; 
  Company get compScan => widget.compScan;
  StockEntrepot get strnScan => widget.strnScan;
  String _scanBarcode ="init";
  String  emplacementId =  "null";
  String emplacementName = "null";
  String  trouver = "null";
  String etatProduit= "null";
  String switching;
  FecomItDatabase db = FecomItDatabase();
  bool isAdding = false;
  TextEditingController addCodeBar = TextEditingController();
  ProductLot st;

/* ____________________Scan _____________________ */
  Future<bool> Searching()async {
    if (switching == "camera") {
      print("camera");
      String C = "";
      try {
        C = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Annuler", true, ScanMode.DEFAULT);
      } catch (e) {
        C = '';
      }
      _scanBarcode = ((C.isEmpty) || (C == "-1")) ? "null" : C;
    }
    else{
              print("the default ");
              isAdding = false;
            }
print("_scanbarecode ============= ");
print(_scanBarcode);

    if(_scanBarcode == "init") return false;


    String barcode = _scanBarcode;
_scanBarcode = "...";
    List<InventoryLine> invL ;
    InventoryLine InvenLine;
    int idI = 1;
    final dao1 = ProductLotsDao(db);
    final dao2 = EmplacementsDao(db);
    final dao3 = InventoryLinesDao(db);
    final dao4 = InventorysDao(db);
    Inventory inve = (await dao4.IncompleteInvent());
    if(inve!=null)  invL = await dao3.getInventoryLineByInv(inve);

    int lengtStock = (await dao1.getAllProductLots()).length;
if((barcode != "...")&(barcode!="init")){
    if((await dao2.getEmplacementByCodeBar(barcode)) != null){
      emplacementId = (await dao2.getEmplacementByCodeBar(barcode)).id;
      emplacementName = (await dao2.getEmplacementByCodeBar(barcode)).Nom;
      return true;

    }else if((await dao1.getProductLotByCodeBar(barcode)) != null){
      st = (await dao1.getProductLotByCodeBar(barcode));
print("st ====================");
print(st.Numlot);
      if(invL.length<lengtStock){
       (invL != null)? idI = invL.length + 1 : idI = 1;
      if(st!=null){
        if((await dao3.getInventoryLineByBarcode(st.Numlot)) == null){
          if(etatProduit==null) etatProduit = "null";
          print("enter to dao3.getInventoryLineByBarcode(st.Numlot) === ");
          InvenLine = InventoryLine(
              id: idI.toString(),
              InventoryId: inve.id,
              ProductId: st.ProductId,
              EmplacementId:(emplacementId!=null)? emplacementId: "null",
              ProductLotId: st.id,
              Quantity: "1", QuantitySystem:"1", Difference: "0",
              Quality: etatProduit.toString());

        }
      }
    if(InvenLine != null ) {
      dao3.insertInventoryLine(InvenLine).whenComplete((){
      return true;//_scanBarcode = "...";  addCodeBar.clear();

    });  }

       return true;

      }else{
        InvenLine = null;
        dao4.UpdateInv(new Inventory(
            id:inve.id ,
            CloseDate:DateTime.now() ,
            OpeningDate:inve.OpeningDate
        )).whenComplete((){return true;});
      }



    }else return false;
}




  }
 



/* ______________________________________IsValide________________________________ */

  Future Validation(ProductLot st)async{
    final dao1 = ProductLotsDao(db);
    final dao2 = InventorysDao(db);
    final dao3 = InventoryLinesDao(db);
    List<InventoryLine> invL ;
    InventoryLine InvenLine;
    int idI = 1;
    Inventory inve = (await dao2.IncompleteInvent());
    if(inve!=null)  invL = await dao3.getInventoryLineByInv(inve);

    int lengtStock = (await dao1.getAllProductLots()).length;

    if(st != null){
      if(invL.length<lengtStock){
        (invL != null)? idI = invL.length + 1 : idI = 1;
        
            if(etatProduit==null) etatProduit = "null";
            InvenLine = InventoryLine(
                id: idI.toString(),
                InventoryId: inve.id,
                ProductId: st.ProductId,
                EmplacementId:(emplacementId!=null)? emplacementId: "null",
                ProductLotId: st.id,
                Quantity: "1", QuantitySystem:"1", Difference: "0",
                Quality: etatProduit.toString());

           if(InvenLine!=null){await dao3.UpdateInvLine(InvenLine);}
          return true;
          
          }
      }else{
        InvenLine = null;
        dao2.UpdateInv(new Inventory(
            id:inve.id ,
            CloseDate:DateTime.now() ,
            OpeningDate:inve.OpeningDate
        )).whenComplete((){return true;});
      }
    



  }
  


/*___________________________ Build ___________________________ */
  @override
  Widget build(BuildContext context) {
print("scan ");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar( height:50,homeWidget:(emplaceScan!=null)? "backStockSys" : ((chainScan == "home")?"backHome":"false"),chain:chainScan, whereis: emplaceScan, previous: compScan,backstrn: strnScan,),
      endDrawer: EndDrawer() ,
      body: FutureBuilder(
        future: Searching(),
        builder: (context,snapshot){
          bool check = false;
          if(snapshot.hasData){
                check = snapshot.data; /* true or false */


          }else{
                st = null;

                }


          return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width ,
          child: ListView(
          children: [
            Container( /* Text au fond */
              width: MediaQuery.of(context).size.width ,
              alignment: Alignment.center,
              height: 50,
              padding: EdgeInsets.only(top: 10),
              color: Colors.white,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text( "Placez le scanner de codes à barres ", style:TextStyle( fontSize : 12 , color: Colors.black,)),
                        Text("devant le code à barre",style:TextStyle(fontSize : 12 , color: Colors.black,)),
                      ]),

                    ),
            Container(/* image de bar scanner */
              height: 50,
              alignment: Alignment.center,
              child: Center(
                child: SvgPicture.asset("assets/images/svg/scanner.svg" , height: 50, width: 50,),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: 50,
              padding: EdgeInsets.only(left:10, right: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:[
               Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 5),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      onPressed: () {
                        switching ="camera";
                        setState(() {});
                      },
                      child: Text("Par caméra")
                        ),
                ),

                 Container(
                   height: 50,
                   margin: EdgeInsets.only(right: 5),
                   child: RaisedButton(
                       textColor: Colors.white,
                       color: Colors.green,
                       onPressed: ((st!=null)?

                       ()=> Validation(st).whenComplete((){
                         print("when complete ");
                         print(_scanBarcode);
                         st = null;
                         _scanBarcode ="init";
                         etatProduit= "null";
                         addCodeBar.clear();
                         setState(() {});
                       })

                           :null),
                       child: Text("Valider")
                   ),
                 ),


               ]),
            ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top:20),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left:10,right: 10),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // SystemChannels.textInput.invokeMethod('TextInput.hide');
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child:TextFormField(
                autofocus: true,
                showCursor: true,
                //focusNode: FocusNode(),
                decoration: InputDecoration(

                  hintText:"...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    backgroundColor: Colors.transparent,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  border:  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),

                minLines: 1,
                maxLines: 1,
                controller: addCodeBar,
                // onTap:()=> addCodeBar.clear(),
                /*  onSubmitted: (text){
                                                          _scanBarcode = addCodeBar.text;
                                                          switching = "adding";
                                                           setState(() {});
                                                                 },*/
                enabled: true,
                textInputAction: TextInputAction.done,
                /* hadi li zedtha ....... */
                onEditingComplete: (){
                    _scanBarcode = addCodeBar.text;
                  addCodeBar.clear();
                  switching = "adding";
                  setState(() {});  
                },
                /*onFieldSubmitted: (value){
                  _scanBarcode = addCodeBar.text;
                  addCodeBar.clear();
                  switching = "adding";
                  setState(() {});
                }, *///to handle submit from keyboard
                validator: (value){
                  //to handle submit from hardware barcode reader
                  if(value.contains('\n') || value.contains('\t')){
                    addCodeBar.text = value.replaceAll('\t', ''); /*.replaceAll('\n', '')*/
                    _scanBarcode = addCodeBar.text;
                    addCodeBar.clear();
                    switching = "adding";
                    setState(() {});
                  }
                  return null;
                },

              ),),
          ),

            Container(
              height: 30,
              margin: EdgeInsets.only(top:20),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ID d'emplacement : " , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  Text(((emplacementId!=null)?emplacementId:"  "), style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal, color: Colors.black),)

                ],
              ),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nom d'emplacement : " , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  Text(((emplacementName!=null)?emplacementName:"  "), style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal, color: Colors.black),)

                ],
              ),
            ),

            Container(
              height: 50,
              //margin: EdgeInsets.only(top:0),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:10,right: 10),
              color:(_scanBarcode != "init")? ((st!=null)?Colors.green:Colors.red) : Colors.white,
              child: Text(
                 (_scanBarcode != "init")? ((st!=null)?"Trouver":"Pas Trouver") : "  "
                ,style: TextStyle(color: Colors.white),
              ),
            ),
            (st!=null)?
             Container(
              height: 30,
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("code à Barre"
                  , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  Text(st.Numlot, style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal, color: Colors.black),)

                ],
              ),
            ) : Text(" "),
            (st!=null)?
             Container(
              height: 30,
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Id de produit"
                  , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  Text(st.ProductId, style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal, color: Colors.black),)

                ],
              ),
            ) : Text(" "),
          Container(
            height: 50,
            margin: EdgeInsets.only(top:20),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left:10, right:10),
            child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        // SystemChannels.textInput.invokeMethod('TextInput.hide');
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                      },
                                      child: TextField(
                                    autofocus: false,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: " l'état : bon / pas bon",
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 18,
                                        backgroundColor: Colors.transparent,
                                      ),

                                      border:  UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: 100,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    controller: TextEditingController(),
                                    onTap: (){
                                      TextEditingController().clear();
                                    },
                                    maxLength: 100,
                                    minLines: 1,
                                    maxLines: 1,
                                    onSubmitted: (text){
                                       etatProduit = text.toString();
                                    },
                                    enabled: (_scanBarcode != "init")? ((st!=null)?true:false):false,
                                  ),),
          ),




          ]),
                  );


        }),


            );
    }

    }


