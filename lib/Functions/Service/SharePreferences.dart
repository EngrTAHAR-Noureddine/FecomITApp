import 'package:shared_preferences/shared_preferences.dart';

class Share {

  static final Share _instance = Share.internal();
  factory Share() => _instance;
  Share.internal();

  List keys = [
/*00 */ [  /* information de CSV file  */
        /* 0 file is exist  */ "checkingFile",
        /*1*/ "LogoName",
        /*2*/ "logoimage",
        /*3*/  "telephone",
        /*4*/  "addressEntre",
         ],

 /* 01 */   [
            /*0*/  "Adminpassword",
            /*1*/  "UserpasswordReset",
            /*2*/  "UserpasswordActually",
            /*3*/   "etat",
            ],





 /*02*/   "AllStock",
/*03*/  [ /* 0*/ "SitesTable", /* check if tables exist in database or not*/
        /* 1*/   "CompanyTable",
        /* 2*/   "Stock d'entrepriseTable",
        /* 3*/   "Stock de SystemTable",
        /* 4*/   "Les BureauxTable",
        /* 5*/   "Les ProduitsTable",
        /* 6*/   "Les Categories des ProduitsTable",
        /* 7 */  "LesProductLots"
        ], 

  /* 04 pour the name of files */
  [
 /*40 */   "Site",
 /*41 */   "Company",
  /*42 */  "Entrepot",
  /*43 */  "Emplacement",
  /*44 */  "StockSystem",
  /*45 */  "Product",
 /*46 */   "Lot",
 /*47 */    "Category",
  ]
  ];



  saveValueString(String key ,String value) async {
    print("save value string  .dart ****** ");
    SharedPreferences l = await SharedPreferences.getInstance();
    l.setString(key , value);
  }

  Future<String> readString(String key) async {
    print("save value string .dart ****** ");
    final l = await SharedPreferences.getInstance();
    return l.getString(key);
  }

  saveValueInt(String key ,int value) async {
    print("save value int  .dart ****** ");
    SharedPreferences l = await SharedPreferences.getInstance();
    l.setInt(key , value);

  }

  Future<int> readInt(String key) async {
    final l = await SharedPreferences.getInstance();
    return l.getInt(key);
  }


  Future<bool> remove(String key) async {
    print("remove share  .dart ****** ");
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)==true) {
      prefs.remove(key);
      return true ;}else return false;
  }

  Future<bool> IsExist(String key)async{
    final prefs = await SharedPreferences.getInstance();
   if(prefs.containsKey(key)){ return true ;}else return false;

  }




}