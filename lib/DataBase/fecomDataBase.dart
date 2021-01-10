import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// Moor works by source gen. This file will all the generated code.
part 'fecomDataBase.g.dart';

/* ========================== SITE =============== */
class Sites extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get Nom => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/* ====================== Companys ====================== */
class Companys extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get Nom => text().withLength(min: 1, max: 100)();
  TextColumn get SiteId => text().withLength(min: 1, max: 100)();
  TextColumn get logo => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};

}

/* =========================== StockEntrepots ================================== */

class StockEntrepots extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get Nom => text().withLength(min: 1, max: 100)();
  TextColumn get CompanyId => text().withLength(min: 1, max: 100)();
  TextColumn get DirectionType => text().withLength(min: 0, max: 100).nullable()();
  TextColumn get DirectionId => text().withLength(min: 0, max: 100).nullable()();



  @override
  Set<Column> get primaryKey => {id};

}

/* ================================= StockSystems ===================================== */

class StockSystems extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get ProductId => text().withLength(min: 1, max: 100)();
  TextColumn get ProductLotId => text().withLength(min: 1, max: 100)();
  TextColumn get EmplacementId => text().withLength(min: 1, max: 100)();
  TextColumn get Quantity => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};

}

/* =============================== Emplacement ========================================= */
class Emplacements extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get Nom => text().withLength(min: 1, max: 100)();
  TextColumn get entrepotId => text().withLength(min: 1, max: 100)();
  TextColumn get barcodeemp => text().withLength(min: 1, max: 100)();


  @override
  Set<Column> get primaryKey => {id};

}

/* =============================== Product ====================================== */

class Products extends Table {
  TextColumn get id => text().withLength(min: 0, max: 100)();
  TextColumn get Nom => text().withLength(min: 0, max: 100)();
  TextColumn get ProductCode => text().withLength(min: 1, max: 100)();
  TextColumn get CategoryId => text().withLength(min: 1, max: 100)();
  TextColumn get GestionLot =>text().withLength(min: 1, max: 100)();
  TextColumn get ProductType => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/* ================================ ProductCategory ============================== */

class ProductCategorys extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get CategName => text().withLength(min: 1, max: 100)();
  TextColumn get CategCode => text().withLength(min: 1, max: 100)();
  TextColumn get ParentId => text().withLength(min: 1, max: 100)();
  TextColumn get ParentPath => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/* ============================= ProductLot =============================== */

class ProductLots extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get ProductId => text().withLength(min: 1, max: 100)();
  TextColumn get Numlot => text().withLength(min: 1, max: 100)();
  TextColumn get NumSerie => text().withLength(min: 1, max: 100)();
  TextColumn get Immatriculation => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/* ================================= Inventory =========================================  */
class Inventorys extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  DateTimeColumn get OpeningDate => dateTime().nullable()();
  DateTimeColumn get CloseDate => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

/* ====================== InventoryLine ================================ */
class InventoryLines extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get InventoryId => text().withLength(min: 1, max: 100)();
  TextColumn get ProductId => text().withLength(min: 1, max: 100)();
  TextColumn get EmplacementId => text().withLength(min: 1, max: 100)();
  TextColumn get ProductLotId => text().withLength(min: 1, max: 100)();
  TextColumn get Quantity => text().withLength(min: 1, max: 100)();
  TextColumn get QuantitySystem => text().withLength(min: 1, max: 100)();
  TextColumn get Difference => text().withLength(min: 1, max: 100)();
  TextColumn get Quality => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Sites, Companys, StockEntrepots, StockSystems, Emplacements, Products, ProductCategorys, ProductLots, Inventorys, InventoryLines], daos: [SitesDao, CompanysDao, StockEntrepotsDao, StockSystemsDao, EmplacementsDao, ProductsDao, ProductCategorysDao, ProductLotsDao, InventorysDao, InventoryLinesDao])
// _$AppDatabase is the name of the generated class
class FecomItDatabase extends _$FecomItDatabase {
  FecomItDatabase()
  // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    logStatements: true,
  )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

}



@UseDao(tables: [Sites])
class SitesDao extends DatabaseAccessor<FecomItDatabase> with _$SitesDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  SitesDao(this.db) : super(db);

  Future insertSite(Site s) => into(sites).insert(s);

  //Read all sites
  Future<List<Site>> getAllSites() => select(sites).get();


  //get site with search by id ==> return one site
  Future<Site> getSiteById(String id) {
    return (select(sites)..where((t) => t.id.equals(id))).getSingle();
  }

  //delete one(1) site with input site ==> need to delete every site on table
  Future deleteSites(Site site) => delete(sites).delete(site);



}

@UseDao(tables: [Companys])
class CompanysDao extends DatabaseAccessor<FecomItDatabase> with _$CompanysDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  CompanysDao(this.db) : super(db);

  Future insertCompany(Company s) => into(companys).insert(s);
  //Read all Companys
  Future<List<Company>> getAllCompanys() => select(companys).get();

  //get Company with search by id ==> return one Company
  Future<Company> getCompanyById(String id) {
    return (select(companys)..where((t) => t.id.equals(id))).getSingle();
  }
  //delete one(1) Company with input Company ==> need to delete every Company on table
  Future deleteCompanys(Company company) => delete(companys).delete(company);

  //get Company with search all companies on site
  Future<List<Company>> watchEntriesInCompany(Site c) {
    return (select(companys)..where((t) => t.SiteId.equals(c.id))).get();
  }



}

@UseDao(tables: [StockEntrepots])
class StockEntrepotsDao extends DatabaseAccessor<FecomItDatabase> with _$StockEntrepotsDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  StockEntrepotsDao(this.db) : super(db);

  Future insertStockEntrepot(StockEntrepot s) => into(stockEntrepots).insert(s);


  Future<List<StockEntrepot>> getAllStockEntrepots() => select(stockEntrepots).get();

  //fecth for 1 direction or service
  Future<StockEntrepot> getStockEntrepotsById(String id) {
    return (select(stockEntrepots)..where((t) => t.id.equals(id))).getSingle();
  }
  //delete one(1) StockEntrepot with input StockEntrepot ==> need to delete every StockEntrepot on table
  Future deleteStockEntrepots(StockEntrepot s) => delete(stockEntrepots).delete(s);

  //fetch for direction in company

  //fetch a services in direction on company
  Future<List<StockEntrepot>> FetchServicesOnComany(Company c , String e) {

    if(c == null){
      if(e == "null"){
        return (select(stockEntrepots)
          ..where((t) =>(t.DirectionId.equals("null")))).get();
      }else{
        return (select(stockEntrepots)..where((t) => (t.DirectionId.equals(e)))).get();
      }
    }else{
    if(e == "null"){
      return (select(stockEntrepots)
        ..where((t) =>
        ((t.CompanyId.equals(c.id)) & (t.DirectionId.equals("null"))))).get();
    }else{
      return (select(stockEntrepots)..where((t) => ((t.CompanyId.equals(c.id))&(t.DirectionId.equals(e))))).get();
        }

    }
  }
}

@UseDao(tables: [StockSystems])
class StockSystemsDao extends DatabaseAccessor<FecomItDatabase> with _$StockSystemsDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  StockSystemsDao(this.db) : super(db);

  Future insertStockSystem(StockSystem s) => into(stockSystems).insert(s);
  //Read all StockSystems
  Future<List<StockSystem>> getAllStockSystem() => select(stockSystems).get();

  //get StockSystem with id
  Future<StockSystem> getStockSystemById(String id) {
    return (select(stockSystems)..where((t) => t.id.equals(id))).getSingle();
  }
  //get StockSystem with productlot
  Future<StockSystem> getStockSystemByproductlot(String plot){
     return (select(stockSystems)..where((t) => t.ProductLotId.equals(plot) ) ).getSingle();
  }



  Future<StockSystem> getStockSystemByCodeBar(String plot){
    return (select(stockSystems)..where((t) => t.ProductLotId.equals(plot) ) ).getSingle();}
  


  //delete one(1) with object StockSystem
  Future deleteStockSystem(StockSystem s) => delete(stockSystems).delete(s);

  //get all StockSystem with product id
  Future<List<StockSystem>> fetchProductsInStockSystem(Product p) {
    return (select(stockSystems)..where((t) => t.ProductId.equals(p.id))).get();
  }
  //get all StockSystem with productLot id
  Future<List<StockSystem>> fetchProductLotInStockSystem(ProductLot p) {
    return (select(stockSystems)..where((t) => t.ProductLotId.equals(p.id))).get();
  }
  //get all StockSystem with emplacements id
  Future<List<StockSystem>> fetchStockSystemInEmplacement(Emplacement e) {
    return (select(stockSystems)..where((t) => (t.EmplacementId.equals(e.id)))).get();
  }

}

@UseDao(tables: [Emplacements])
class EmplacementsDao extends DatabaseAccessor<FecomItDatabase> with _$EmplacementsDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  EmplacementsDao(this.db) : super(db);
  Future insertEmplacement(Emplacement s) => into(emplacements).insert(s);
  Future<List<Emplacement>> getAllEmplacements() => select(emplacements).get();

  //get emplacements with search by id ==> return one Company
  Future<Emplacement> getEmplacementById(String id) {
    return (select(emplacements)..where((t) => t.id.equals(id))).getSingle();
  }
  Future<Emplacement> getEmplacementByCodeBar(String code) {
    return (select(emplacements)..where((t) => t.barcodeemp.equals(code))).getSingle();
  }


  //delete one(1) emplacement with emplacement  ==> need to delete every Company on table
  Future deleteEmplacements(Emplacement e) => delete(emplacements).delete(e);

  //get Company with search all companies on site
  Future<List<Emplacement>> fetchEmplaceWithService(StockEntrepot s) {
    return (select(emplacements)..where((t) => t.entrepotId.equals(s.id))).get();
  }

}


@UseDao(tables: [Products]) //TODO
class ProductsDao extends DatabaseAccessor<FecomItDatabase> with _$ProductsDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  ProductsDao(this.db) : super(db);

  Future insertProduct(Product s) => into(products).insert(s);
  //Read all Products
  Future<List<Product>> getAllProducts() => select(products).get();

  //get Product with search by id ==> return one Product
  Future<Product> getProductByStockSys(String stm) {
    return (select(products)..where((t) => t.id.equals(stm))).getSingle();
  }

  //delete one(1) Product with input Product ==> need to delete every Product on table
  Future deleteProducts(Product p) => delete(products).delete(p);

  //get Products with search all product on category
  Stream<List<Product>> watchEntriesInCompany(ProductCategory c) {
    return (select(products)..where((t) => t.CategoryId.equals(c.id))).watch();
  }

}

@UseDao(tables: [ProductCategorys])
class ProductCategorysDao extends DatabaseAccessor<FecomItDatabase> with _$ProductCategorysDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  ProductCategorysDao(this.db) : super(db);

  Future insertProductCategory(ProductCategory s) => into(productCategorys).insert(s);

  Future<List<ProductCategory>> getAllProductCategorys() => select(productCategorys).get();
  //get ProductCategorys with search by id ==> return one ProductCategorys
  Future<ProductCategory> getProductById(String id) {
    return (select(productCategorys)..where((t) => t.id.equals(id))).getSingle();
  }
  //delete one(1) ProductCategorys with input ProductCategorys ==> need to delete every ProductCategorys on table
  Future deleteProducts(ProductCategory p) => delete(productCategorys).delete(p);

  Future<ProductCategory> getProductByProduct(Product p) {
    return (select(productCategorys)..where((t) => t.id.equals(p.CategoryId))).getSingle();
  }

  //get ProductCategorys Parents  with search all ProductCategorys
  Future<ProductCategory> fetchparentProductCategory(ProductCategory c) {
    if(c.ParentId != "Null") {
      return (select(productCategorys)
        ..where((t) =>
        ((t.id.equals(c.ParentId)) & (t.CategName.equals(c.ParentPath)))))
          .getSingle();
    }else{return null;}
  }



}

@UseDao(tables: [ProductLots])
class ProductLotsDao extends DatabaseAccessor<FecomItDatabase> with _$ProductLotsDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  ProductLotsDao(this.db) : super(db);

  Future insertProductLot(ProductLot s) => into(productLots).insert(s);

  Future<List<ProductLot>> getAllProductLots() => select(productLots).get();

  //get ProductCategorys with search by id ==> return one ProductCategorys
  Future<ProductLot> getProductLotByCodeBar(String id) {
    return (select(productLots)
      ..where((t) => t.Numlot.equals(id))).getSingle();
  }

  Future<List<ProductLot>> getLotsByCodeBar(String id) {
    return (select(productLots)..where((t) => t.Numlot.like('%'+id+'%'))).get();
  }
  Future<ProductLot> getProductLotByID(String id) {
    return (select(productLots)..where((t) => t.id.equals(id))).getSingle();
  }
  //delete one(1) ProductCategorys with input ProductCategorys ==> need to delete every ProductCategorys on table
  Future deleteProductLot(ProductLot p) => delete(productLots).delete(p);

  //get Product lot with product
  Future<ProductLot> fetchFrProLotWStockSys(StockSystem c) {
    return (select(productLots)..where((t) => (t.id.equals(c.ProductLotId)))).getSingle();
  }

  //get product lot with inventory
  Future<List<ProductLot>> fetchFrProLotWInv(Inventory i ) {
    return (select(productLots)..where((t) => (t.Numlot.equals(i.id)))).get();
  }


}

@UseDao(tables: [Inventorys])
class InventorysDao extends DatabaseAccessor<FecomItDatabase> with _$InventorysDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  InventorysDao(this.db) : super(db);

  Future insertInventory(Inventory I) => into(inventorys).insert(I);

  //Read all inventorys
  Future<List<Inventory>> getAllInventorys() => select(inventorys).get();


  // Future<Inventory> getLastInventory() async => (select(inventorys).get() != null)? (await select(inventorys).get()).last : null;


  Future<Inventory> IncompleteInvent() => (select(inventorys)..where((tbl) => tbl.CloseDate.year.equals(1971))).getSingle();


  //get Inventory with search by id ==> return one site
  Future<Inventory> getInventoryById(String id) {
    return (select(inventorys)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> UpdateInv(Inventory inv){
   update(inventorys).replace(inv);
  }

  //delete one(1) site with input Inventory ==> need to delete every site on table
  Future deleteInventory(Inventory inv) => delete(inventorys).delete(inv);


}


@UseDao(tables: [InventoryLines])
class InventoryLinesDao extends DatabaseAccessor<FecomItDatabase> with _$InventoryLinesDaoMixin {
  final FecomItDatabase db;

  // Called by the AppDatabase class
  InventoryLinesDao(this.db) : super(db);
  Future insertInventoryLine(InventoryLine I) => into(inventoryLines).insert(I);

  //Read all inventorys
  Future<List<InventoryLine>> getAllInventoryLines(String idInv) {
    return (select(inventoryLines)..where((t)=> t.InventoryId.equals(idInv))).get();
  }

  Future<List<InventoryLine>> getInventoryLineByInv(Inventory inv) {
 
    return (select(inventoryLines)..where((t) => t.InventoryId.equals(inv.id))).get();
  }

    Future<List<InventoryLine>> getInvLByEmpIn(Inventory inv, Emplacement emp) {
 
    return (select(inventoryLines)..where((t) => ((t.InventoryId.equals(inv.id))&(t.EmplacementId.equals(emp.id))))).get();
  }

 Future<List<InventoryLine>> getInventoryLineByEmplacement(Emplacement emp) {
    return (select(inventoryLines)..where((t) => t.EmplacementId.equals(emp.id))).get();
  }

  Future<InventoryLine> getInventoryLineByBarcode(String code) {
    return (select(inventoryLines)..where((t) => t.ProductLotId.equals(code))).getSingle();
  }

Future<InventoryLine> checkSystemIsIn(String LotId , Inventory inv){
 return (select(inventoryLines)..where((t) => ((t.ProductLotId.equals(LotId))&(t.InventoryId.equals(inv.id))))).getSingle();
}

  //get Inventory with search by id ==> return one site
  Stream<InventoryLine> getInventoryLineById(String id) {
    return (select(inventoryLines)..where((t) => t.id.equals(id))).watchSingle();
  }

  //delete one(1) site with input Inventory ==> need to delete every site on table
  Future deleteInventoryLine(InventoryLine Invl) => delete(inventoryLines).delete(Invl);

 Future<void> UpdateInvLine(InventoryLine invL){
   update(inventoryLines).replace(invL);
  }

}
