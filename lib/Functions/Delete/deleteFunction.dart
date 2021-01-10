import 'package:fecom_xpress_app/DataBase/fecomDataBase.dart';
import 'package:fecom_xpress_app/Functions/Service/SharePreferences.dart';


class DeleteFunction{
  static final DeleteFunction _instance = DeleteFunction.internal();
  factory DeleteFunction() => _instance;
  DeleteFunction.internal();
  Share _sharing = Share();


  final _dao9 = InventorysDao(FecomItDatabase());
  final _dao10 = InventoryLinesDao(FecomItDatabase());


  Future<bool>SupprimerInv(Inventory inv)async{
     List<InventoryLine>  invl = await _dao10.getInventoryLineByInv(inv);
     if(invl.isNotEmpty){
       for(InventoryLine i in invl){
         await _dao10.deleteInventoryLine(i);
       }
     }
     if((await _dao10.getInventoryLineByInv(inv)).isEmpty){
       await _dao9.deleteInventory(inv);
     }
    return ((await _dao9.getInventoryById(inv.id))== null);
  }


}