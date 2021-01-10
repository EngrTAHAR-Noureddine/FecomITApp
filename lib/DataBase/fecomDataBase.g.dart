// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fecomDataBase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Site extends DataClass implements Insertable<Site> {
  final String id;
  final String Nom;
  Site({@required this.id, @required this.Nom});
  factory Site.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Site(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      Nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || Nom != null) {
      map['nom'] = Variable<String>(Nom);
    }
    return map;
  }

  SitesCompanion toCompanion(bool nullToAbsent) {
    return SitesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      Nom: Nom == null && nullToAbsent ? const Value.absent() : Value(Nom),
    );
  }

  factory Site.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<String>(json['id']),
      Nom: serializer.fromJson<String>(json['Nom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'Nom': serializer.toJson<String>(Nom),
    };
  }

  Site copyWith({String id, String Nom}) => Site(
        id: id ?? this.id,
        Nom: Nom ?? this.Nom,
      );
  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('Nom: $Nom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, Nom.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Site && other.id == this.id && other.Nom == this.Nom);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<String> id;
  final Value<String> Nom;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.Nom = const Value.absent(),
  });
  SitesCompanion.insert({
    @required String id,
    @required String Nom,
  })  : id = Value(id),
        Nom = Value(Nom);
  static Insertable<Site> custom({
    Expression<String> id,
    Expression<String> Nom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (Nom != null) 'nom': Nom,
    });
  }

  SitesCompanion copyWith({Value<String> id, Value<String> Nom}) {
    return SitesCompanion(
      id: id ?? this.id,
      Nom: Nom ?? this.Nom,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (Nom.present) {
      map['nom'] = Variable<String>(Nom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SitesCompanion(')
          ..write('id: $id, ')
          ..write('Nom: $Nom')
          ..write(')'))
        .toString();
  }
}

class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  final GeneratedDatabase _db;
  final String _alias;
  $SitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NomMeta = const VerificationMeta('Nom');
  GeneratedTextColumn _Nom;
  @override
  GeneratedTextColumn get Nom => _Nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, Nom];
  @override
  $SitesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sites';
  @override
  final String actualTableName = 'sites';
  @override
  VerificationContext validateIntegrity(Insertable<Site> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _NomMeta, Nom.isAcceptableOrUnknown(data['nom'], _NomMeta));
    } else if (isInserting) {
      context.missing(_NomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Site.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(_db, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final String id;
  final String Nom;
  final String SiteId;
  final String logo;
  Company(
      {@required this.id,
      @required this.Nom,
      @required this.SiteId,
      @required this.logo});
  factory Company.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Company(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      Nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
      SiteId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}site_id']),
      logo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}logo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || Nom != null) {
      map['nom'] = Variable<String>(Nom);
    }
    if (!nullToAbsent || SiteId != null) {
      map['site_id'] = Variable<String>(SiteId);
    }
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    return map;
  }

  CompanysCompanion toCompanion(bool nullToAbsent) {
    return CompanysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      Nom: Nom == null && nullToAbsent ? const Value.absent() : Value(Nom),
      SiteId:
          SiteId == null && nullToAbsent ? const Value.absent() : Value(SiteId),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
    );
  }

  factory Company.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<String>(json['id']),
      Nom: serializer.fromJson<String>(json['Nom']),
      SiteId: serializer.fromJson<String>(json['SiteId']),
      logo: serializer.fromJson<String>(json['logo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'Nom': serializer.toJson<String>(Nom),
      'SiteId': serializer.toJson<String>(SiteId),
      'logo': serializer.toJson<String>(logo),
    };
  }

  Company copyWith({String id, String Nom, String SiteId, String logo}) =>
      Company(
        id: id ?? this.id,
        Nom: Nom ?? this.Nom,
        SiteId: SiteId ?? this.SiteId,
        logo: logo ?? this.logo,
      );
  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('SiteId: $SiteId, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(Nom.hashCode, $mrjc(SiteId.hashCode, logo.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.Nom == this.Nom &&
          other.SiteId == this.SiteId &&
          other.logo == this.logo);
}

class CompanysCompanion extends UpdateCompanion<Company> {
  final Value<String> id;
  final Value<String> Nom;
  final Value<String> SiteId;
  final Value<String> logo;
  const CompanysCompanion({
    this.id = const Value.absent(),
    this.Nom = const Value.absent(),
    this.SiteId = const Value.absent(),
    this.logo = const Value.absent(),
  });
  CompanysCompanion.insert({
    @required String id,
    @required String Nom,
    @required String SiteId,
    @required String logo,
  })  : id = Value(id),
        Nom = Value(Nom),
        SiteId = Value(SiteId),
        logo = Value(logo);
  static Insertable<Company> custom({
    Expression<String> id,
    Expression<String> Nom,
    Expression<String> SiteId,
    Expression<String> logo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (Nom != null) 'nom': Nom,
      if (SiteId != null) 'site_id': SiteId,
      if (logo != null) 'logo': logo,
    });
  }

  CompanysCompanion copyWith(
      {Value<String> id,
      Value<String> Nom,
      Value<String> SiteId,
      Value<String> logo}) {
    return CompanysCompanion(
      id: id ?? this.id,
      Nom: Nom ?? this.Nom,
      SiteId: SiteId ?? this.SiteId,
      logo: logo ?? this.logo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (Nom.present) {
      map['nom'] = Variable<String>(Nom.value);
    }
    if (SiteId.present) {
      map['site_id'] = Variable<String>(SiteId.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanysCompanion(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('SiteId: $SiteId, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }
}

class $CompanysTable extends Companys with TableInfo<$CompanysTable, Company> {
  final GeneratedDatabase _db;
  final String _alias;
  $CompanysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NomMeta = const VerificationMeta('Nom');
  GeneratedTextColumn _Nom;
  @override
  GeneratedTextColumn get Nom => _Nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _SiteIdMeta = const VerificationMeta('SiteId');
  GeneratedTextColumn _SiteId;
  @override
  GeneratedTextColumn get SiteId => _SiteId ??= _constructSiteId();
  GeneratedTextColumn _constructSiteId() {
    return GeneratedTextColumn('site_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _logoMeta = const VerificationMeta('logo');
  GeneratedTextColumn _logo;
  @override
  GeneratedTextColumn get logo => _logo ??= _constructLogo();
  GeneratedTextColumn _constructLogo() {
    return GeneratedTextColumn('logo', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, Nom, SiteId, logo];
  @override
  $CompanysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'companys';
  @override
  final String actualTableName = 'companys';
  @override
  VerificationContext validateIntegrity(Insertable<Company> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _NomMeta, Nom.isAcceptableOrUnknown(data['nom'], _NomMeta));
    } else if (isInserting) {
      context.missing(_NomMeta);
    }
    if (data.containsKey('site_id')) {
      context.handle(_SiteIdMeta,
          SiteId.isAcceptableOrUnknown(data['site_id'], _SiteIdMeta));
    } else if (isInserting) {
      context.missing(_SiteIdMeta);
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo'], _logoMeta));
    } else if (isInserting) {
      context.missing(_logoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Company.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CompanysTable createAlias(String alias) {
    return $CompanysTable(_db, alias);
  }
}

class StockEntrepot extends DataClass implements Insertable<StockEntrepot> {
  final String id;
  final String Nom;
  final String CompanyId;
  final String DirectionType;
  final String DirectionId;
  StockEntrepot(
      {@required this.id,
      @required this.Nom,
      @required this.CompanyId,
      this.DirectionType,
      this.DirectionId});
  factory StockEntrepot.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return StockEntrepot(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      Nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
      CompanyId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      DirectionType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direction_type']),
      DirectionId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}direction_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || Nom != null) {
      map['nom'] = Variable<String>(Nom);
    }
    if (!nullToAbsent || CompanyId != null) {
      map['company_id'] = Variable<String>(CompanyId);
    }
    if (!nullToAbsent || DirectionType != null) {
      map['direction_type'] = Variable<String>(DirectionType);
    }
    if (!nullToAbsent || DirectionId != null) {
      map['direction_id'] = Variable<String>(DirectionId);
    }
    return map;
  }

  StockEntrepotsCompanion toCompanion(bool nullToAbsent) {
    return StockEntrepotsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      Nom: Nom == null && nullToAbsent ? const Value.absent() : Value(Nom),
      CompanyId: CompanyId == null && nullToAbsent
          ? const Value.absent()
          : Value(CompanyId),
      DirectionType: DirectionType == null && nullToAbsent
          ? const Value.absent()
          : Value(DirectionType),
      DirectionId: DirectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(DirectionId),
    );
  }

  factory StockEntrepot.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return StockEntrepot(
      id: serializer.fromJson<String>(json['id']),
      Nom: serializer.fromJson<String>(json['Nom']),
      CompanyId: serializer.fromJson<String>(json['CompanyId']),
      DirectionType: serializer.fromJson<String>(json['DirectionType']),
      DirectionId: serializer.fromJson<String>(json['DirectionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'Nom': serializer.toJson<String>(Nom),
      'CompanyId': serializer.toJson<String>(CompanyId),
      'DirectionType': serializer.toJson<String>(DirectionType),
      'DirectionId': serializer.toJson<String>(DirectionId),
    };
  }

  StockEntrepot copyWith(
          {String id,
          String Nom,
          String CompanyId,
          String DirectionType,
          String DirectionId}) =>
      StockEntrepot(
        id: id ?? this.id,
        Nom: Nom ?? this.Nom,
        CompanyId: CompanyId ?? this.CompanyId,
        DirectionType: DirectionType ?? this.DirectionType,
        DirectionId: DirectionId ?? this.DirectionId,
      );
  @override
  String toString() {
    return (StringBuffer('StockEntrepot(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('CompanyId: $CompanyId, ')
          ..write('DirectionType: $DirectionType, ')
          ..write('DirectionId: $DirectionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          Nom.hashCode,
          $mrjc(CompanyId.hashCode,
              $mrjc(DirectionType.hashCode, DirectionId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is StockEntrepot &&
          other.id == this.id &&
          other.Nom == this.Nom &&
          other.CompanyId == this.CompanyId &&
          other.DirectionType == this.DirectionType &&
          other.DirectionId == this.DirectionId);
}

class StockEntrepotsCompanion extends UpdateCompanion<StockEntrepot> {
  final Value<String> id;
  final Value<String> Nom;
  final Value<String> CompanyId;
  final Value<String> DirectionType;
  final Value<String> DirectionId;
  const StockEntrepotsCompanion({
    this.id = const Value.absent(),
    this.Nom = const Value.absent(),
    this.CompanyId = const Value.absent(),
    this.DirectionType = const Value.absent(),
    this.DirectionId = const Value.absent(),
  });
  StockEntrepotsCompanion.insert({
    @required String id,
    @required String Nom,
    @required String CompanyId,
    this.DirectionType = const Value.absent(),
    this.DirectionId = const Value.absent(),
  })  : id = Value(id),
        Nom = Value(Nom),
        CompanyId = Value(CompanyId);
  static Insertable<StockEntrepot> custom({
    Expression<String> id,
    Expression<String> Nom,
    Expression<String> CompanyId,
    Expression<String> DirectionType,
    Expression<String> DirectionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (Nom != null) 'nom': Nom,
      if (CompanyId != null) 'company_id': CompanyId,
      if (DirectionType != null) 'direction_type': DirectionType,
      if (DirectionId != null) 'direction_id': DirectionId,
    });
  }

  StockEntrepotsCompanion copyWith(
      {Value<String> id,
      Value<String> Nom,
      Value<String> CompanyId,
      Value<String> DirectionType,
      Value<String> DirectionId}) {
    return StockEntrepotsCompanion(
      id: id ?? this.id,
      Nom: Nom ?? this.Nom,
      CompanyId: CompanyId ?? this.CompanyId,
      DirectionType: DirectionType ?? this.DirectionType,
      DirectionId: DirectionId ?? this.DirectionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (Nom.present) {
      map['nom'] = Variable<String>(Nom.value);
    }
    if (CompanyId.present) {
      map['company_id'] = Variable<String>(CompanyId.value);
    }
    if (DirectionType.present) {
      map['direction_type'] = Variable<String>(DirectionType.value);
    }
    if (DirectionId.present) {
      map['direction_id'] = Variable<String>(DirectionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockEntrepotsCompanion(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('CompanyId: $CompanyId, ')
          ..write('DirectionType: $DirectionType, ')
          ..write('DirectionId: $DirectionId')
          ..write(')'))
        .toString();
  }
}

class $StockEntrepotsTable extends StockEntrepots
    with TableInfo<$StockEntrepotsTable, StockEntrepot> {
  final GeneratedDatabase _db;
  final String _alias;
  $StockEntrepotsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NomMeta = const VerificationMeta('Nom');
  GeneratedTextColumn _Nom;
  @override
  GeneratedTextColumn get Nom => _Nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _CompanyIdMeta = const VerificationMeta('CompanyId');
  GeneratedTextColumn _CompanyId;
  @override
  GeneratedTextColumn get CompanyId => _CompanyId ??= _constructCompanyId();
  GeneratedTextColumn _constructCompanyId() {
    return GeneratedTextColumn('company_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _DirectionTypeMeta =
      const VerificationMeta('DirectionType');
  GeneratedTextColumn _DirectionType;
  @override
  GeneratedTextColumn get DirectionType =>
      _DirectionType ??= _constructDirectionType();
  GeneratedTextColumn _constructDirectionType() {
    return GeneratedTextColumn('direction_type', $tableName, true,
        minTextLength: 0, maxTextLength: 100);
  }

  final VerificationMeta _DirectionIdMeta =
      const VerificationMeta('DirectionId');
  GeneratedTextColumn _DirectionId;
  @override
  GeneratedTextColumn get DirectionId =>
      _DirectionId ??= _constructDirectionId();
  GeneratedTextColumn _constructDirectionId() {
    return GeneratedTextColumn('direction_id', $tableName, true,
        minTextLength: 0, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, Nom, CompanyId, DirectionType, DirectionId];
  @override
  $StockEntrepotsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stock_entrepots';
  @override
  final String actualTableName = 'stock_entrepots';
  @override
  VerificationContext validateIntegrity(Insertable<StockEntrepot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _NomMeta, Nom.isAcceptableOrUnknown(data['nom'], _NomMeta));
    } else if (isInserting) {
      context.missing(_NomMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(_CompanyIdMeta,
          CompanyId.isAcceptableOrUnknown(data['company_id'], _CompanyIdMeta));
    } else if (isInserting) {
      context.missing(_CompanyIdMeta);
    }
    if (data.containsKey('direction_type')) {
      context.handle(
          _DirectionTypeMeta,
          DirectionType.isAcceptableOrUnknown(
              data['direction_type'], _DirectionTypeMeta));
    }
    if (data.containsKey('direction_id')) {
      context.handle(
          _DirectionIdMeta,
          DirectionId.isAcceptableOrUnknown(
              data['direction_id'], _DirectionIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockEntrepot map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return StockEntrepot.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StockEntrepotsTable createAlias(String alias) {
    return $StockEntrepotsTable(_db, alias);
  }
}

class StockSystem extends DataClass implements Insertable<StockSystem> {
  final String id;
  final String ProductId;
  final String ProductLotId;
  final String EmplacementId;
  final String Quantity;
  StockSystem(
      {@required this.id,
      @required this.ProductId,
      @required this.ProductLotId,
      @required this.EmplacementId,
      @required this.Quantity});
  factory StockSystem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return StockSystem(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ProductId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      ProductLotId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_lot_id']),
      EmplacementId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}emplacement_id']),
      Quantity: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || ProductId != null) {
      map['product_id'] = Variable<String>(ProductId);
    }
    if (!nullToAbsent || ProductLotId != null) {
      map['product_lot_id'] = Variable<String>(ProductLotId);
    }
    if (!nullToAbsent || EmplacementId != null) {
      map['emplacement_id'] = Variable<String>(EmplacementId);
    }
    if (!nullToAbsent || Quantity != null) {
      map['quantity'] = Variable<String>(Quantity);
    }
    return map;
  }

  StockSystemsCompanion toCompanion(bool nullToAbsent) {
    return StockSystemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ProductId: ProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductId),
      ProductLotId: ProductLotId == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductLotId),
      EmplacementId: EmplacementId == null && nullToAbsent
          ? const Value.absent()
          : Value(EmplacementId),
      Quantity: Quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(Quantity),
    );
  }

  factory StockSystem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return StockSystem(
      id: serializer.fromJson<String>(json['id']),
      ProductId: serializer.fromJson<String>(json['ProductId']),
      ProductLotId: serializer.fromJson<String>(json['ProductLotId']),
      EmplacementId: serializer.fromJson<String>(json['EmplacementId']),
      Quantity: serializer.fromJson<String>(json['Quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ProductId': serializer.toJson<String>(ProductId),
      'ProductLotId': serializer.toJson<String>(ProductLotId),
      'EmplacementId': serializer.toJson<String>(EmplacementId),
      'Quantity': serializer.toJson<String>(Quantity),
    };
  }

  StockSystem copyWith(
          {String id,
          String ProductId,
          String ProductLotId,
          String EmplacementId,
          String Quantity}) =>
      StockSystem(
        id: id ?? this.id,
        ProductId: ProductId ?? this.ProductId,
        ProductLotId: ProductLotId ?? this.ProductLotId,
        EmplacementId: EmplacementId ?? this.EmplacementId,
        Quantity: Quantity ?? this.Quantity,
      );
  @override
  String toString() {
    return (StringBuffer('StockSystem(')
          ..write('id: $id, ')
          ..write('ProductId: $ProductId, ')
          ..write('ProductLotId: $ProductLotId, ')
          ..write('EmplacementId: $EmplacementId, ')
          ..write('Quantity: $Quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ProductId.hashCode,
          $mrjc(ProductLotId.hashCode,
              $mrjc(EmplacementId.hashCode, Quantity.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is StockSystem &&
          other.id == this.id &&
          other.ProductId == this.ProductId &&
          other.ProductLotId == this.ProductLotId &&
          other.EmplacementId == this.EmplacementId &&
          other.Quantity == this.Quantity);
}

class StockSystemsCompanion extends UpdateCompanion<StockSystem> {
  final Value<String> id;
  final Value<String> ProductId;
  final Value<String> ProductLotId;
  final Value<String> EmplacementId;
  final Value<String> Quantity;
  const StockSystemsCompanion({
    this.id = const Value.absent(),
    this.ProductId = const Value.absent(),
    this.ProductLotId = const Value.absent(),
    this.EmplacementId = const Value.absent(),
    this.Quantity = const Value.absent(),
  });
  StockSystemsCompanion.insert({
    @required String id,
    @required String ProductId,
    @required String ProductLotId,
    @required String EmplacementId,
    @required String Quantity,
  })  : id = Value(id),
        ProductId = Value(ProductId),
        ProductLotId = Value(ProductLotId),
        EmplacementId = Value(EmplacementId),
        Quantity = Value(Quantity);
  static Insertable<StockSystem> custom({
    Expression<String> id,
    Expression<String> ProductId,
    Expression<String> ProductLotId,
    Expression<String> EmplacementId,
    Expression<String> Quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ProductId != null) 'product_id': ProductId,
      if (ProductLotId != null) 'product_lot_id': ProductLotId,
      if (EmplacementId != null) 'emplacement_id': EmplacementId,
      if (Quantity != null) 'quantity': Quantity,
    });
  }

  StockSystemsCompanion copyWith(
      {Value<String> id,
      Value<String> ProductId,
      Value<String> ProductLotId,
      Value<String> EmplacementId,
      Value<String> Quantity}) {
    return StockSystemsCompanion(
      id: id ?? this.id,
      ProductId: ProductId ?? this.ProductId,
      ProductLotId: ProductLotId ?? this.ProductLotId,
      EmplacementId: EmplacementId ?? this.EmplacementId,
      Quantity: Quantity ?? this.Quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ProductId.present) {
      map['product_id'] = Variable<String>(ProductId.value);
    }
    if (ProductLotId.present) {
      map['product_lot_id'] = Variable<String>(ProductLotId.value);
    }
    if (EmplacementId.present) {
      map['emplacement_id'] = Variable<String>(EmplacementId.value);
    }
    if (Quantity.present) {
      map['quantity'] = Variable<String>(Quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockSystemsCompanion(')
          ..write('id: $id, ')
          ..write('ProductId: $ProductId, ')
          ..write('ProductLotId: $ProductLotId, ')
          ..write('EmplacementId: $EmplacementId, ')
          ..write('Quantity: $Quantity')
          ..write(')'))
        .toString();
  }
}

class $StockSystemsTable extends StockSystems
    with TableInfo<$StockSystemsTable, StockSystem> {
  final GeneratedDatabase _db;
  final String _alias;
  $StockSystemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductIdMeta = const VerificationMeta('ProductId');
  GeneratedTextColumn _ProductId;
  @override
  GeneratedTextColumn get ProductId => _ProductId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductLotIdMeta =
      const VerificationMeta('ProductLotId');
  GeneratedTextColumn _ProductLotId;
  @override
  GeneratedTextColumn get ProductLotId =>
      _ProductLotId ??= _constructProductLotId();
  GeneratedTextColumn _constructProductLotId() {
    return GeneratedTextColumn('product_lot_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _EmplacementIdMeta =
      const VerificationMeta('EmplacementId');
  GeneratedTextColumn _EmplacementId;
  @override
  GeneratedTextColumn get EmplacementId =>
      _EmplacementId ??= _constructEmplacementId();
  GeneratedTextColumn _constructEmplacementId() {
    return GeneratedTextColumn('emplacement_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _QuantityMeta = const VerificationMeta('Quantity');
  GeneratedTextColumn _Quantity;
  @override
  GeneratedTextColumn get Quantity => _Quantity ??= _constructQuantity();
  GeneratedTextColumn _constructQuantity() {
    return GeneratedTextColumn('quantity', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ProductId, ProductLotId, EmplacementId, Quantity];
  @override
  $StockSystemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stock_systems';
  @override
  final String actualTableName = 'stock_systems';
  @override
  VerificationContext validateIntegrity(Insertable<StockSystem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_ProductIdMeta,
          ProductId.isAcceptableOrUnknown(data['product_id'], _ProductIdMeta));
    } else if (isInserting) {
      context.missing(_ProductIdMeta);
    }
    if (data.containsKey('product_lot_id')) {
      context.handle(
          _ProductLotIdMeta,
          ProductLotId.isAcceptableOrUnknown(
              data['product_lot_id'], _ProductLotIdMeta));
    } else if (isInserting) {
      context.missing(_ProductLotIdMeta);
    }
    if (data.containsKey('emplacement_id')) {
      context.handle(
          _EmplacementIdMeta,
          EmplacementId.isAcceptableOrUnknown(
              data['emplacement_id'], _EmplacementIdMeta));
    } else if (isInserting) {
      context.missing(_EmplacementIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_QuantityMeta,
          Quantity.isAcceptableOrUnknown(data['quantity'], _QuantityMeta));
    } else if (isInserting) {
      context.missing(_QuantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockSystem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return StockSystem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StockSystemsTable createAlias(String alias) {
    return $StockSystemsTable(_db, alias);
  }
}

class Emplacement extends DataClass implements Insertable<Emplacement> {
  final String id;
  final String Nom;
  final String entrepotId;
  final String barcodeemp;
  Emplacement(
      {@required this.id,
      @required this.Nom,
      @required this.entrepotId,
      @required this.barcodeemp});
  factory Emplacement.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Emplacement(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      Nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
      entrepotId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}entrepot_id']),
      barcodeemp: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}barcodeemp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || Nom != null) {
      map['nom'] = Variable<String>(Nom);
    }
    if (!nullToAbsent || entrepotId != null) {
      map['entrepot_id'] = Variable<String>(entrepotId);
    }
    if (!nullToAbsent || barcodeemp != null) {
      map['barcodeemp'] = Variable<String>(barcodeemp);
    }
    return map;
  }

  EmplacementsCompanion toCompanion(bool nullToAbsent) {
    return EmplacementsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      Nom: Nom == null && nullToAbsent ? const Value.absent() : Value(Nom),
      entrepotId: entrepotId == null && nullToAbsent
          ? const Value.absent()
          : Value(entrepotId),
      barcodeemp: barcodeemp == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeemp),
    );
  }

  factory Emplacement.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Emplacement(
      id: serializer.fromJson<String>(json['id']),
      Nom: serializer.fromJson<String>(json['Nom']),
      entrepotId: serializer.fromJson<String>(json['entrepotId']),
      barcodeemp: serializer.fromJson<String>(json['barcodeemp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'Nom': serializer.toJson<String>(Nom),
      'entrepotId': serializer.toJson<String>(entrepotId),
      'barcodeemp': serializer.toJson<String>(barcodeemp),
    };
  }

  Emplacement copyWith(
          {String id, String Nom, String entrepotId, String barcodeemp}) =>
      Emplacement(
        id: id ?? this.id,
        Nom: Nom ?? this.Nom,
        entrepotId: entrepotId ?? this.entrepotId,
        barcodeemp: barcodeemp ?? this.barcodeemp,
      );
  @override
  String toString() {
    return (StringBuffer('Emplacement(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('entrepotId: $entrepotId, ')
          ..write('barcodeemp: $barcodeemp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(Nom.hashCode, $mrjc(entrepotId.hashCode, barcodeemp.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Emplacement &&
          other.id == this.id &&
          other.Nom == this.Nom &&
          other.entrepotId == this.entrepotId &&
          other.barcodeemp == this.barcodeemp);
}

class EmplacementsCompanion extends UpdateCompanion<Emplacement> {
  final Value<String> id;
  final Value<String> Nom;
  final Value<String> entrepotId;
  final Value<String> barcodeemp;
  const EmplacementsCompanion({
    this.id = const Value.absent(),
    this.Nom = const Value.absent(),
    this.entrepotId = const Value.absent(),
    this.barcodeemp = const Value.absent(),
  });
  EmplacementsCompanion.insert({
    @required String id,
    @required String Nom,
    @required String entrepotId,
    @required String barcodeemp,
  })  : id = Value(id),
        Nom = Value(Nom),
        entrepotId = Value(entrepotId),
        barcodeemp = Value(barcodeemp);
  static Insertable<Emplacement> custom({
    Expression<String> id,
    Expression<String> Nom,
    Expression<String> entrepotId,
    Expression<String> barcodeemp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (Nom != null) 'nom': Nom,
      if (entrepotId != null) 'entrepot_id': entrepotId,
      if (barcodeemp != null) 'barcodeemp': barcodeemp,
    });
  }

  EmplacementsCompanion copyWith(
      {Value<String> id,
      Value<String> Nom,
      Value<String> entrepotId,
      Value<String> barcodeemp}) {
    return EmplacementsCompanion(
      id: id ?? this.id,
      Nom: Nom ?? this.Nom,
      entrepotId: entrepotId ?? this.entrepotId,
      barcodeemp: barcodeemp ?? this.barcodeemp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (Nom.present) {
      map['nom'] = Variable<String>(Nom.value);
    }
    if (entrepotId.present) {
      map['entrepot_id'] = Variable<String>(entrepotId.value);
    }
    if (barcodeemp.present) {
      map['barcodeemp'] = Variable<String>(barcodeemp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmplacementsCompanion(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('entrepotId: $entrepotId, ')
          ..write('barcodeemp: $barcodeemp')
          ..write(')'))
        .toString();
  }
}

class $EmplacementsTable extends Emplacements
    with TableInfo<$EmplacementsTable, Emplacement> {
  final GeneratedDatabase _db;
  final String _alias;
  $EmplacementsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NomMeta = const VerificationMeta('Nom');
  GeneratedTextColumn _Nom;
  @override
  GeneratedTextColumn get Nom => _Nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _entrepotIdMeta = const VerificationMeta('entrepotId');
  GeneratedTextColumn _entrepotId;
  @override
  GeneratedTextColumn get entrepotId => _entrepotId ??= _constructEntrepotId();
  GeneratedTextColumn _constructEntrepotId() {
    return GeneratedTextColumn('entrepot_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _barcodeempMeta = const VerificationMeta('barcodeemp');
  GeneratedTextColumn _barcodeemp;
  @override
  GeneratedTextColumn get barcodeemp => _barcodeemp ??= _constructBarcodeemp();
  GeneratedTextColumn _constructBarcodeemp() {
    return GeneratedTextColumn('barcodeemp', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, Nom, entrepotId, barcodeemp];
  @override
  $EmplacementsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'emplacements';
  @override
  final String actualTableName = 'emplacements';
  @override
  VerificationContext validateIntegrity(Insertable<Emplacement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _NomMeta, Nom.isAcceptableOrUnknown(data['nom'], _NomMeta));
    } else if (isInserting) {
      context.missing(_NomMeta);
    }
    if (data.containsKey('entrepot_id')) {
      context.handle(
          _entrepotIdMeta,
          entrepotId.isAcceptableOrUnknown(
              data['entrepot_id'], _entrepotIdMeta));
    } else if (isInserting) {
      context.missing(_entrepotIdMeta);
    }
    if (data.containsKey('barcodeemp')) {
      context.handle(
          _barcodeempMeta,
          barcodeemp.isAcceptableOrUnknown(
              data['barcodeemp'], _barcodeempMeta));
    } else if (isInserting) {
      context.missing(_barcodeempMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Emplacement map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Emplacement.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EmplacementsTable createAlias(String alias) {
    return $EmplacementsTable(_db, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String Nom;
  final String ProductCode;
  final String CategoryId;
  final String GestionLot;
  final String ProductType;
  Product(
      {@required this.id,
      @required this.Nom,
      @required this.ProductCode,
      @required this.CategoryId,
      @required this.GestionLot,
      @required this.ProductType});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Product(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      Nom: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nom']),
      ProductCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_code']),
      CategoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      GestionLot: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}gestion_lot']),
      ProductType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || Nom != null) {
      map['nom'] = Variable<String>(Nom);
    }
    if (!nullToAbsent || ProductCode != null) {
      map['product_code'] = Variable<String>(ProductCode);
    }
    if (!nullToAbsent || CategoryId != null) {
      map['category_id'] = Variable<String>(CategoryId);
    }
    if (!nullToAbsent || GestionLot != null) {
      map['gestion_lot'] = Variable<String>(GestionLot);
    }
    if (!nullToAbsent || ProductType != null) {
      map['product_type'] = Variable<String>(ProductType);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      Nom: Nom == null && nullToAbsent ? const Value.absent() : Value(Nom),
      ProductCode: ProductCode == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductCode),
      CategoryId: CategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(CategoryId),
      GestionLot: GestionLot == null && nullToAbsent
          ? const Value.absent()
          : Value(GestionLot),
      ProductType: ProductType == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductType),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      Nom: serializer.fromJson<String>(json['Nom']),
      ProductCode: serializer.fromJson<String>(json['ProductCode']),
      CategoryId: serializer.fromJson<String>(json['CategoryId']),
      GestionLot: serializer.fromJson<String>(json['GestionLot']),
      ProductType: serializer.fromJson<String>(json['ProductType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'Nom': serializer.toJson<String>(Nom),
      'ProductCode': serializer.toJson<String>(ProductCode),
      'CategoryId': serializer.toJson<String>(CategoryId),
      'GestionLot': serializer.toJson<String>(GestionLot),
      'ProductType': serializer.toJson<String>(ProductType),
    };
  }

  Product copyWith(
          {String id,
          String Nom,
          String ProductCode,
          String CategoryId,
          String GestionLot,
          String ProductType}) =>
      Product(
        id: id ?? this.id,
        Nom: Nom ?? this.Nom,
        ProductCode: ProductCode ?? this.ProductCode,
        CategoryId: CategoryId ?? this.CategoryId,
        GestionLot: GestionLot ?? this.GestionLot,
        ProductType: ProductType ?? this.ProductType,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('ProductCode: $ProductCode, ')
          ..write('CategoryId: $CategoryId, ')
          ..write('GestionLot: $GestionLot, ')
          ..write('ProductType: $ProductType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          Nom.hashCode,
          $mrjc(
              ProductCode.hashCode,
              $mrjc(CategoryId.hashCode,
                  $mrjc(GestionLot.hashCode, ProductType.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.Nom == this.Nom &&
          other.ProductCode == this.ProductCode &&
          other.CategoryId == this.CategoryId &&
          other.GestionLot == this.GestionLot &&
          other.ProductType == this.ProductType);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> Nom;
  final Value<String> ProductCode;
  final Value<String> CategoryId;
  final Value<String> GestionLot;
  final Value<String> ProductType;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.Nom = const Value.absent(),
    this.ProductCode = const Value.absent(),
    this.CategoryId = const Value.absent(),
    this.GestionLot = const Value.absent(),
    this.ProductType = const Value.absent(),
  });
  ProductsCompanion.insert({
    @required String id,
    @required String Nom,
    @required String ProductCode,
    @required String CategoryId,
    @required String GestionLot,
    @required String ProductType,
  })  : id = Value(id),
        Nom = Value(Nom),
        ProductCode = Value(ProductCode),
        CategoryId = Value(CategoryId),
        GestionLot = Value(GestionLot),
        ProductType = Value(ProductType);
  static Insertable<Product> custom({
    Expression<String> id,
    Expression<String> Nom,
    Expression<String> ProductCode,
    Expression<String> CategoryId,
    Expression<String> GestionLot,
    Expression<String> ProductType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (Nom != null) 'nom': Nom,
      if (ProductCode != null) 'product_code': ProductCode,
      if (CategoryId != null) 'category_id': CategoryId,
      if (GestionLot != null) 'gestion_lot': GestionLot,
      if (ProductType != null) 'product_type': ProductType,
    });
  }

  ProductsCompanion copyWith(
      {Value<String> id,
      Value<String> Nom,
      Value<String> ProductCode,
      Value<String> CategoryId,
      Value<String> GestionLot,
      Value<String> ProductType}) {
    return ProductsCompanion(
      id: id ?? this.id,
      Nom: Nom ?? this.Nom,
      ProductCode: ProductCode ?? this.ProductCode,
      CategoryId: CategoryId ?? this.CategoryId,
      GestionLot: GestionLot ?? this.GestionLot,
      ProductType: ProductType ?? this.ProductType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (Nom.present) {
      map['nom'] = Variable<String>(Nom.value);
    }
    if (ProductCode.present) {
      map['product_code'] = Variable<String>(ProductCode.value);
    }
    if (CategoryId.present) {
      map['category_id'] = Variable<String>(CategoryId.value);
    }
    if (GestionLot.present) {
      map['gestion_lot'] = Variable<String>(GestionLot.value);
    }
    if (ProductType.present) {
      map['product_type'] = Variable<String>(ProductType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('Nom: $Nom, ')
          ..write('ProductCode: $ProductCode, ')
          ..write('CategoryId: $CategoryId, ')
          ..write('GestionLot: $GestionLot, ')
          ..write('ProductType: $ProductType')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 0, maxTextLength: 100);
  }

  final VerificationMeta _NomMeta = const VerificationMeta('Nom');
  GeneratedTextColumn _Nom;
  @override
  GeneratedTextColumn get Nom => _Nom ??= _constructNom();
  GeneratedTextColumn _constructNom() {
    return GeneratedTextColumn('nom', $tableName, false,
        minTextLength: 0, maxTextLength: 100);
  }

  final VerificationMeta _ProductCodeMeta =
      const VerificationMeta('ProductCode');
  GeneratedTextColumn _ProductCode;
  @override
  GeneratedTextColumn get ProductCode =>
      _ProductCode ??= _constructProductCode();
  GeneratedTextColumn _constructProductCode() {
    return GeneratedTextColumn('product_code', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _CategoryIdMeta = const VerificationMeta('CategoryId');
  GeneratedTextColumn _CategoryId;
  @override
  GeneratedTextColumn get CategoryId => _CategoryId ??= _constructCategoryId();
  GeneratedTextColumn _constructCategoryId() {
    return GeneratedTextColumn('category_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _GestionLotMeta = const VerificationMeta('GestionLot');
  GeneratedTextColumn _GestionLot;
  @override
  GeneratedTextColumn get GestionLot => _GestionLot ??= _constructGestionLot();
  GeneratedTextColumn _constructGestionLot() {
    return GeneratedTextColumn('gestion_lot', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductTypeMeta =
      const VerificationMeta('ProductType');
  GeneratedTextColumn _ProductType;
  @override
  GeneratedTextColumn get ProductType =>
      _ProductType ??= _constructProductType();
  GeneratedTextColumn _constructProductType() {
    return GeneratedTextColumn('product_type', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, Nom, ProductCode, CategoryId, GestionLot, ProductType];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _NomMeta, Nom.isAcceptableOrUnknown(data['nom'], _NomMeta));
    } else if (isInserting) {
      context.missing(_NomMeta);
    }
    if (data.containsKey('product_code')) {
      context.handle(
          _ProductCodeMeta,
          ProductCode.isAcceptableOrUnknown(
              data['product_code'], _ProductCodeMeta));
    } else if (isInserting) {
      context.missing(_ProductCodeMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _CategoryIdMeta,
          CategoryId.isAcceptableOrUnknown(
              data['category_id'], _CategoryIdMeta));
    } else if (isInserting) {
      context.missing(_CategoryIdMeta);
    }
    if (data.containsKey('gestion_lot')) {
      context.handle(
          _GestionLotMeta,
          GestionLot.isAcceptableOrUnknown(
              data['gestion_lot'], _GestionLotMeta));
    } else if (isInserting) {
      context.missing(_GestionLotMeta);
    }
    if (data.containsKey('product_type')) {
      context.handle(
          _ProductTypeMeta,
          ProductType.isAcceptableOrUnknown(
              data['product_type'], _ProductTypeMeta));
    } else if (isInserting) {
      context.missing(_ProductTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final String id;
  final String CategName;
  final String CategCode;
  final String ParentId;
  final String ParentPath;
  ProductCategory(
      {@required this.id,
      @required this.CategName,
      @required this.CategCode,
      @required this.ParentId,
      @required this.ParentPath});
  factory ProductCategory.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ProductCategory(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      CategName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categ_name']),
      CategCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categ_code']),
      ParentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      ParentPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || CategName != null) {
      map['categ_name'] = Variable<String>(CategName);
    }
    if (!nullToAbsent || CategCode != null) {
      map['categ_code'] = Variable<String>(CategCode);
    }
    if (!nullToAbsent || ParentId != null) {
      map['parent_id'] = Variable<String>(ParentId);
    }
    if (!nullToAbsent || ParentPath != null) {
      map['parent_path'] = Variable<String>(ParentPath);
    }
    return map;
  }

  ProductCategorysCompanion toCompanion(bool nullToAbsent) {
    return ProductCategorysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      CategName: CategName == null && nullToAbsent
          ? const Value.absent()
          : Value(CategName),
      CategCode: CategCode == null && nullToAbsent
          ? const Value.absent()
          : Value(CategCode),
      ParentId: ParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(ParentId),
      ParentPath: ParentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(ParentPath),
    );
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<String>(json['id']),
      CategName: serializer.fromJson<String>(json['CategName']),
      CategCode: serializer.fromJson<String>(json['CategCode']),
      ParentId: serializer.fromJson<String>(json['ParentId']),
      ParentPath: serializer.fromJson<String>(json['ParentPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'CategName': serializer.toJson<String>(CategName),
      'CategCode': serializer.toJson<String>(CategCode),
      'ParentId': serializer.toJson<String>(ParentId),
      'ParentPath': serializer.toJson<String>(ParentPath),
    };
  }

  ProductCategory copyWith(
          {String id,
          String CategName,
          String CategCode,
          String ParentId,
          String ParentPath}) =>
      ProductCategory(
        id: id ?? this.id,
        CategName: CategName ?? this.CategName,
        CategCode: CategCode ?? this.CategCode,
        ParentId: ParentId ?? this.ParentId,
        ParentPath: ParentPath ?? this.ParentPath,
      );
  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('CategName: $CategName, ')
          ..write('CategCode: $CategCode, ')
          ..write('ParentId: $ParentId, ')
          ..write('ParentPath: $ParentPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          CategName.hashCode,
          $mrjc(CategCode.hashCode,
              $mrjc(ParentId.hashCode, ParentPath.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.CategName == this.CategName &&
          other.CategCode == this.CategCode &&
          other.ParentId == this.ParentId &&
          other.ParentPath == this.ParentPath);
}

class ProductCategorysCompanion extends UpdateCompanion<ProductCategory> {
  final Value<String> id;
  final Value<String> CategName;
  final Value<String> CategCode;
  final Value<String> ParentId;
  final Value<String> ParentPath;
  const ProductCategorysCompanion({
    this.id = const Value.absent(),
    this.CategName = const Value.absent(),
    this.CategCode = const Value.absent(),
    this.ParentId = const Value.absent(),
    this.ParentPath = const Value.absent(),
  });
  ProductCategorysCompanion.insert({
    @required String id,
    @required String CategName,
    @required String CategCode,
    @required String ParentId,
    @required String ParentPath,
  })  : id = Value(id),
        CategName = Value(CategName),
        CategCode = Value(CategCode),
        ParentId = Value(ParentId),
        ParentPath = Value(ParentPath);
  static Insertable<ProductCategory> custom({
    Expression<String> id,
    Expression<String> CategName,
    Expression<String> CategCode,
    Expression<String> ParentId,
    Expression<String> ParentPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (CategName != null) 'categ_name': CategName,
      if (CategCode != null) 'categ_code': CategCode,
      if (ParentId != null) 'parent_id': ParentId,
      if (ParentPath != null) 'parent_path': ParentPath,
    });
  }

  ProductCategorysCompanion copyWith(
      {Value<String> id,
      Value<String> CategName,
      Value<String> CategCode,
      Value<String> ParentId,
      Value<String> ParentPath}) {
    return ProductCategorysCompanion(
      id: id ?? this.id,
      CategName: CategName ?? this.CategName,
      CategCode: CategCode ?? this.CategCode,
      ParentId: ParentId ?? this.ParentId,
      ParentPath: ParentPath ?? this.ParentPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (CategName.present) {
      map['categ_name'] = Variable<String>(CategName.value);
    }
    if (CategCode.present) {
      map['categ_code'] = Variable<String>(CategCode.value);
    }
    if (ParentId.present) {
      map['parent_id'] = Variable<String>(ParentId.value);
    }
    if (ParentPath.present) {
      map['parent_path'] = Variable<String>(ParentPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategorysCompanion(')
          ..write('id: $id, ')
          ..write('CategName: $CategName, ')
          ..write('CategCode: $CategCode, ')
          ..write('ParentId: $ParentId, ')
          ..write('ParentPath: $ParentPath')
          ..write(')'))
        .toString();
  }
}

class $ProductCategorysTable extends ProductCategorys
    with TableInfo<$ProductCategorysTable, ProductCategory> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductCategorysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _CategNameMeta = const VerificationMeta('CategName');
  GeneratedTextColumn _CategName;
  @override
  GeneratedTextColumn get CategName => _CategName ??= _constructCategName();
  GeneratedTextColumn _constructCategName() {
    return GeneratedTextColumn('categ_name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _CategCodeMeta = const VerificationMeta('CategCode');
  GeneratedTextColumn _CategCode;
  @override
  GeneratedTextColumn get CategCode => _CategCode ??= _constructCategCode();
  GeneratedTextColumn _constructCategCode() {
    return GeneratedTextColumn('categ_code', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ParentIdMeta = const VerificationMeta('ParentId');
  GeneratedTextColumn _ParentId;
  @override
  GeneratedTextColumn get ParentId => _ParentId ??= _constructParentId();
  GeneratedTextColumn _constructParentId() {
    return GeneratedTextColumn('parent_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ParentPathMeta = const VerificationMeta('ParentPath');
  GeneratedTextColumn _ParentPath;
  @override
  GeneratedTextColumn get ParentPath => _ParentPath ??= _constructParentPath();
  GeneratedTextColumn _constructParentPath() {
    return GeneratedTextColumn('parent_path', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, CategName, CategCode, ParentId, ParentPath];
  @override
  $ProductCategorysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_categorys';
  @override
  final String actualTableName = 'product_categorys';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('categ_name')) {
      context.handle(_CategNameMeta,
          CategName.isAcceptableOrUnknown(data['categ_name'], _CategNameMeta));
    } else if (isInserting) {
      context.missing(_CategNameMeta);
    }
    if (data.containsKey('categ_code')) {
      context.handle(_CategCodeMeta,
          CategCode.isAcceptableOrUnknown(data['categ_code'], _CategCodeMeta));
    } else if (isInserting) {
      context.missing(_CategCodeMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_ParentIdMeta,
          ParentId.isAcceptableOrUnknown(data['parent_id'], _ParentIdMeta));
    } else if (isInserting) {
      context.missing(_ParentIdMeta);
    }
    if (data.containsKey('parent_path')) {
      context.handle(
          _ParentPathMeta,
          ParentPath.isAcceptableOrUnknown(
              data['parent_path'], _ParentPathMeta));
    } else if (isInserting) {
      context.missing(_ParentPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductCategory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductCategorysTable createAlias(String alias) {
    return $ProductCategorysTable(_db, alias);
  }
}

class ProductLot extends DataClass implements Insertable<ProductLot> {
  final String id;
  final String ProductId;
  final String Numlot;
  final String NumSerie;
  final String Immatriculation;
  ProductLot(
      {@required this.id,
      @required this.ProductId,
      @required this.Numlot,
      @required this.NumSerie,
      @required this.Immatriculation});
  factory ProductLot.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ProductLot(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ProductId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      Numlot:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}numlot']),
      NumSerie: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}num_serie']),
      Immatriculation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}immatriculation']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || ProductId != null) {
      map['product_id'] = Variable<String>(ProductId);
    }
    if (!nullToAbsent || Numlot != null) {
      map['numlot'] = Variable<String>(Numlot);
    }
    if (!nullToAbsent || NumSerie != null) {
      map['num_serie'] = Variable<String>(NumSerie);
    }
    if (!nullToAbsent || Immatriculation != null) {
      map['immatriculation'] = Variable<String>(Immatriculation);
    }
    return map;
  }

  ProductLotsCompanion toCompanion(bool nullToAbsent) {
    return ProductLotsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ProductId: ProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductId),
      Numlot:
          Numlot == null && nullToAbsent ? const Value.absent() : Value(Numlot),
      NumSerie: NumSerie == null && nullToAbsent
          ? const Value.absent()
          : Value(NumSerie),
      Immatriculation: Immatriculation == null && nullToAbsent
          ? const Value.absent()
          : Value(Immatriculation),
    );
  }

  factory ProductLot.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductLot(
      id: serializer.fromJson<String>(json['id']),
      ProductId: serializer.fromJson<String>(json['ProductId']),
      Numlot: serializer.fromJson<String>(json['Numlot']),
      NumSerie: serializer.fromJson<String>(json['NumSerie']),
      Immatriculation: serializer.fromJson<String>(json['Immatriculation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ProductId': serializer.toJson<String>(ProductId),
      'Numlot': serializer.toJson<String>(Numlot),
      'NumSerie': serializer.toJson<String>(NumSerie),
      'Immatriculation': serializer.toJson<String>(Immatriculation),
    };
  }

  ProductLot copyWith(
          {String id,
          String ProductId,
          String Numlot,
          String NumSerie,
          String Immatriculation}) =>
      ProductLot(
        id: id ?? this.id,
        ProductId: ProductId ?? this.ProductId,
        Numlot: Numlot ?? this.Numlot,
        NumSerie: NumSerie ?? this.NumSerie,
        Immatriculation: Immatriculation ?? this.Immatriculation,
      );
  @override
  String toString() {
    return (StringBuffer('ProductLot(')
          ..write('id: $id, ')
          ..write('ProductId: $ProductId, ')
          ..write('Numlot: $Numlot, ')
          ..write('NumSerie: $NumSerie, ')
          ..write('Immatriculation: $Immatriculation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ProductId.hashCode,
          $mrjc(Numlot.hashCode,
              $mrjc(NumSerie.hashCode, Immatriculation.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductLot &&
          other.id == this.id &&
          other.ProductId == this.ProductId &&
          other.Numlot == this.Numlot &&
          other.NumSerie == this.NumSerie &&
          other.Immatriculation == this.Immatriculation);
}

class ProductLotsCompanion extends UpdateCompanion<ProductLot> {
  final Value<String> id;
  final Value<String> ProductId;
  final Value<String> Numlot;
  final Value<String> NumSerie;
  final Value<String> Immatriculation;
  const ProductLotsCompanion({
    this.id = const Value.absent(),
    this.ProductId = const Value.absent(),
    this.Numlot = const Value.absent(),
    this.NumSerie = const Value.absent(),
    this.Immatriculation = const Value.absent(),
  });
  ProductLotsCompanion.insert({
    @required String id,
    @required String ProductId,
    @required String Numlot,
    @required String NumSerie,
    @required String Immatriculation,
  })  : id = Value(id),
        ProductId = Value(ProductId),
        Numlot = Value(Numlot),
        NumSerie = Value(NumSerie),
        Immatriculation = Value(Immatriculation);
  static Insertable<ProductLot> custom({
    Expression<String> id,
    Expression<String> ProductId,
    Expression<String> Numlot,
    Expression<String> NumSerie,
    Expression<String> Immatriculation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ProductId != null) 'product_id': ProductId,
      if (Numlot != null) 'numlot': Numlot,
      if (NumSerie != null) 'num_serie': NumSerie,
      if (Immatriculation != null) 'immatriculation': Immatriculation,
    });
  }

  ProductLotsCompanion copyWith(
      {Value<String> id,
      Value<String> ProductId,
      Value<String> Numlot,
      Value<String> NumSerie,
      Value<String> Immatriculation}) {
    return ProductLotsCompanion(
      id: id ?? this.id,
      ProductId: ProductId ?? this.ProductId,
      Numlot: Numlot ?? this.Numlot,
      NumSerie: NumSerie ?? this.NumSerie,
      Immatriculation: Immatriculation ?? this.Immatriculation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ProductId.present) {
      map['product_id'] = Variable<String>(ProductId.value);
    }
    if (Numlot.present) {
      map['numlot'] = Variable<String>(Numlot.value);
    }
    if (NumSerie.present) {
      map['num_serie'] = Variable<String>(NumSerie.value);
    }
    if (Immatriculation.present) {
      map['immatriculation'] = Variable<String>(Immatriculation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductLotsCompanion(')
          ..write('id: $id, ')
          ..write('ProductId: $ProductId, ')
          ..write('Numlot: $Numlot, ')
          ..write('NumSerie: $NumSerie, ')
          ..write('Immatriculation: $Immatriculation')
          ..write(')'))
        .toString();
  }
}

class $ProductLotsTable extends ProductLots
    with TableInfo<$ProductLotsTable, ProductLot> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductLotsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductIdMeta = const VerificationMeta('ProductId');
  GeneratedTextColumn _ProductId;
  @override
  GeneratedTextColumn get ProductId => _ProductId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NumlotMeta = const VerificationMeta('Numlot');
  GeneratedTextColumn _Numlot;
  @override
  GeneratedTextColumn get Numlot => _Numlot ??= _constructNumlot();
  GeneratedTextColumn _constructNumlot() {
    return GeneratedTextColumn('numlot', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _NumSerieMeta = const VerificationMeta('NumSerie');
  GeneratedTextColumn _NumSerie;
  @override
  GeneratedTextColumn get NumSerie => _NumSerie ??= _constructNumSerie();
  GeneratedTextColumn _constructNumSerie() {
    return GeneratedTextColumn('num_serie', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ImmatriculationMeta =
      const VerificationMeta('Immatriculation');
  GeneratedTextColumn _Immatriculation;
  @override
  GeneratedTextColumn get Immatriculation =>
      _Immatriculation ??= _constructImmatriculation();
  GeneratedTextColumn _constructImmatriculation() {
    return GeneratedTextColumn('immatriculation', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ProductId, Numlot, NumSerie, Immatriculation];
  @override
  $ProductLotsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_lots';
  @override
  final String actualTableName = 'product_lots';
  @override
  VerificationContext validateIntegrity(Insertable<ProductLot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_ProductIdMeta,
          ProductId.isAcceptableOrUnknown(data['product_id'], _ProductIdMeta));
    } else if (isInserting) {
      context.missing(_ProductIdMeta);
    }
    if (data.containsKey('numlot')) {
      context.handle(_NumlotMeta,
          Numlot.isAcceptableOrUnknown(data['numlot'], _NumlotMeta));
    } else if (isInserting) {
      context.missing(_NumlotMeta);
    }
    if (data.containsKey('num_serie')) {
      context.handle(_NumSerieMeta,
          NumSerie.isAcceptableOrUnknown(data['num_serie'], _NumSerieMeta));
    } else if (isInserting) {
      context.missing(_NumSerieMeta);
    }
    if (data.containsKey('immatriculation')) {
      context.handle(
          _ImmatriculationMeta,
          Immatriculation.isAcceptableOrUnknown(
              data['immatriculation'], _ImmatriculationMeta));
    } else if (isInserting) {
      context.missing(_ImmatriculationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductLot map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductLot.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductLotsTable createAlias(String alias) {
    return $ProductLotsTable(_db, alias);
  }
}

class Inventory extends DataClass implements Insertable<Inventory> {
  final String id;
  final DateTime OpeningDate;
  final DateTime CloseDate;
  Inventory({@required this.id, this.OpeningDate, this.CloseDate});
  factory Inventory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Inventory(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      OpeningDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}opening_date']),
      CloseDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}close_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || OpeningDate != null) {
      map['opening_date'] = Variable<DateTime>(OpeningDate);
    }
    if (!nullToAbsent || CloseDate != null) {
      map['close_date'] = Variable<DateTime>(CloseDate);
    }
    return map;
  }

  InventorysCompanion toCompanion(bool nullToAbsent) {
    return InventorysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      OpeningDate: OpeningDate == null && nullToAbsent
          ? const Value.absent()
          : Value(OpeningDate),
      CloseDate: CloseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(CloseDate),
    );
  }

  factory Inventory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Inventory(
      id: serializer.fromJson<String>(json['id']),
      OpeningDate: serializer.fromJson<DateTime>(json['OpeningDate']),
      CloseDate: serializer.fromJson<DateTime>(json['CloseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'OpeningDate': serializer.toJson<DateTime>(OpeningDate),
      'CloseDate': serializer.toJson<DateTime>(CloseDate),
    };
  }

  Inventory copyWith({String id, DateTime OpeningDate, DateTime CloseDate}) =>
      Inventory(
        id: id ?? this.id,
        OpeningDate: OpeningDate ?? this.OpeningDate,
        CloseDate: CloseDate ?? this.CloseDate,
      );
  @override
  String toString() {
    return (StringBuffer('Inventory(')
          ..write('id: $id, ')
          ..write('OpeningDate: $OpeningDate, ')
          ..write('CloseDate: $CloseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(OpeningDate.hashCode, CloseDate.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Inventory &&
          other.id == this.id &&
          other.OpeningDate == this.OpeningDate &&
          other.CloseDate == this.CloseDate);
}

class InventorysCompanion extends UpdateCompanion<Inventory> {
  final Value<String> id;
  final Value<DateTime> OpeningDate;
  final Value<DateTime> CloseDate;
  const InventorysCompanion({
    this.id = const Value.absent(),
    this.OpeningDate = const Value.absent(),
    this.CloseDate = const Value.absent(),
  });
  InventorysCompanion.insert({
    @required String id,
    this.OpeningDate = const Value.absent(),
    this.CloseDate = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Inventory> custom({
    Expression<String> id,
    Expression<DateTime> OpeningDate,
    Expression<DateTime> CloseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (OpeningDate != null) 'opening_date': OpeningDate,
      if (CloseDate != null) 'close_date': CloseDate,
    });
  }

  InventorysCompanion copyWith(
      {Value<String> id,
      Value<DateTime> OpeningDate,
      Value<DateTime> CloseDate}) {
    return InventorysCompanion(
      id: id ?? this.id,
      OpeningDate: OpeningDate ?? this.OpeningDate,
      CloseDate: CloseDate ?? this.CloseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (OpeningDate.present) {
      map['opening_date'] = Variable<DateTime>(OpeningDate.value);
    }
    if (CloseDate.present) {
      map['close_date'] = Variable<DateTime>(CloseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventorysCompanion(')
          ..write('id: $id, ')
          ..write('OpeningDate: $OpeningDate, ')
          ..write('CloseDate: $CloseDate')
          ..write(')'))
        .toString();
  }
}

class $InventorysTable extends Inventorys
    with TableInfo<$InventorysTable, Inventory> {
  final GeneratedDatabase _db;
  final String _alias;
  $InventorysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _OpeningDateMeta =
      const VerificationMeta('OpeningDate');
  GeneratedDateTimeColumn _OpeningDate;
  @override
  GeneratedDateTimeColumn get OpeningDate =>
      _OpeningDate ??= _constructOpeningDate();
  GeneratedDateTimeColumn _constructOpeningDate() {
    return GeneratedDateTimeColumn(
      'opening_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _CloseDateMeta = const VerificationMeta('CloseDate');
  GeneratedDateTimeColumn _CloseDate;
  @override
  GeneratedDateTimeColumn get CloseDate => _CloseDate ??= _constructCloseDate();
  GeneratedDateTimeColumn _constructCloseDate() {
    return GeneratedDateTimeColumn(
      'close_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, OpeningDate, CloseDate];
  @override
  $InventorysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'inventorys';
  @override
  final String actualTableName = 'inventorys';
  @override
  VerificationContext validateIntegrity(Insertable<Inventory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('opening_date')) {
      context.handle(
          _OpeningDateMeta,
          OpeningDate.isAcceptableOrUnknown(
              data['opening_date'], _OpeningDateMeta));
    }
    if (data.containsKey('close_date')) {
      context.handle(_CloseDateMeta,
          CloseDate.isAcceptableOrUnknown(data['close_date'], _CloseDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inventory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Inventory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $InventorysTable createAlias(String alias) {
    return $InventorysTable(_db, alias);
  }
}

class InventoryLine extends DataClass implements Insertable<InventoryLine> {
  final String id;
  final String InventoryId;
  final String ProductId;
  final String EmplacementId;
  final String ProductLotId;
  final String Quantity;
  final String QuantitySystem;
  final String Difference;
  final String Quality;
  InventoryLine(
      {@required this.id,
      @required this.InventoryId,
      @required this.ProductId,
      @required this.EmplacementId,
      @required this.ProductLotId,
      @required this.Quantity,
      @required this.QuantitySystem,
      @required this.Difference,
      @required this.Quality});
  factory InventoryLine.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return InventoryLine(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      InventoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}inventory_id']),
      ProductId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      EmplacementId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}emplacement_id']),
      ProductLotId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_lot_id']),
      Quantity: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      QuantitySystem: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity_system']),
      Difference: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}difference']),
      Quality:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}quality']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || InventoryId != null) {
      map['inventory_id'] = Variable<String>(InventoryId);
    }
    if (!nullToAbsent || ProductId != null) {
      map['product_id'] = Variable<String>(ProductId);
    }
    if (!nullToAbsent || EmplacementId != null) {
      map['emplacement_id'] = Variable<String>(EmplacementId);
    }
    if (!nullToAbsent || ProductLotId != null) {
      map['product_lot_id'] = Variable<String>(ProductLotId);
    }
    if (!nullToAbsent || Quantity != null) {
      map['quantity'] = Variable<String>(Quantity);
    }
    if (!nullToAbsent || QuantitySystem != null) {
      map['quantity_system'] = Variable<String>(QuantitySystem);
    }
    if (!nullToAbsent || Difference != null) {
      map['difference'] = Variable<String>(Difference);
    }
    if (!nullToAbsent || Quality != null) {
      map['quality'] = Variable<String>(Quality);
    }
    return map;
  }

  InventoryLinesCompanion toCompanion(bool nullToAbsent) {
    return InventoryLinesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      InventoryId: InventoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(InventoryId),
      ProductId: ProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductId),
      EmplacementId: EmplacementId == null && nullToAbsent
          ? const Value.absent()
          : Value(EmplacementId),
      ProductLotId: ProductLotId == null && nullToAbsent
          ? const Value.absent()
          : Value(ProductLotId),
      Quantity: Quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(Quantity),
      QuantitySystem: QuantitySystem == null && nullToAbsent
          ? const Value.absent()
          : Value(QuantitySystem),
      Difference: Difference == null && nullToAbsent
          ? const Value.absent()
          : Value(Difference),
      Quality: Quality == null && nullToAbsent
          ? const Value.absent()
          : Value(Quality),
    );
  }

  factory InventoryLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return InventoryLine(
      id: serializer.fromJson<String>(json['id']),
      InventoryId: serializer.fromJson<String>(json['InventoryId']),
      ProductId: serializer.fromJson<String>(json['ProductId']),
      EmplacementId: serializer.fromJson<String>(json['EmplacementId']),
      ProductLotId: serializer.fromJson<String>(json['ProductLotId']),
      Quantity: serializer.fromJson<String>(json['Quantity']),
      QuantitySystem: serializer.fromJson<String>(json['QuantitySystem']),
      Difference: serializer.fromJson<String>(json['Difference']),
      Quality: serializer.fromJson<String>(json['Quality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'InventoryId': serializer.toJson<String>(InventoryId),
      'ProductId': serializer.toJson<String>(ProductId),
      'EmplacementId': serializer.toJson<String>(EmplacementId),
      'ProductLotId': serializer.toJson<String>(ProductLotId),
      'Quantity': serializer.toJson<String>(Quantity),
      'QuantitySystem': serializer.toJson<String>(QuantitySystem),
      'Difference': serializer.toJson<String>(Difference),
      'Quality': serializer.toJson<String>(Quality),
    };
  }

  InventoryLine copyWith(
          {String id,
          String InventoryId,
          String ProductId,
          String EmplacementId,
          String ProductLotId,
          String Quantity,
          String QuantitySystem,
          String Difference,
          String Quality}) =>
      InventoryLine(
        id: id ?? this.id,
        InventoryId: InventoryId ?? this.InventoryId,
        ProductId: ProductId ?? this.ProductId,
        EmplacementId: EmplacementId ?? this.EmplacementId,
        ProductLotId: ProductLotId ?? this.ProductLotId,
        Quantity: Quantity ?? this.Quantity,
        QuantitySystem: QuantitySystem ?? this.QuantitySystem,
        Difference: Difference ?? this.Difference,
        Quality: Quality ?? this.Quality,
      );
  @override
  String toString() {
    return (StringBuffer('InventoryLine(')
          ..write('id: $id, ')
          ..write('InventoryId: $InventoryId, ')
          ..write('ProductId: $ProductId, ')
          ..write('EmplacementId: $EmplacementId, ')
          ..write('ProductLotId: $ProductLotId, ')
          ..write('Quantity: $Quantity, ')
          ..write('QuantitySystem: $QuantitySystem, ')
          ..write('Difference: $Difference, ')
          ..write('Quality: $Quality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          InventoryId.hashCode,
          $mrjc(
              ProductId.hashCode,
              $mrjc(
                  EmplacementId.hashCode,
                  $mrjc(
                      ProductLotId.hashCode,
                      $mrjc(
                          Quantity.hashCode,
                          $mrjc(
                              QuantitySystem.hashCode,
                              $mrjc(Difference.hashCode,
                                  Quality.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is InventoryLine &&
          other.id == this.id &&
          other.InventoryId == this.InventoryId &&
          other.ProductId == this.ProductId &&
          other.EmplacementId == this.EmplacementId &&
          other.ProductLotId == this.ProductLotId &&
          other.Quantity == this.Quantity &&
          other.QuantitySystem == this.QuantitySystem &&
          other.Difference == this.Difference &&
          other.Quality == this.Quality);
}

class InventoryLinesCompanion extends UpdateCompanion<InventoryLine> {
  final Value<String> id;
  final Value<String> InventoryId;
  final Value<String> ProductId;
  final Value<String> EmplacementId;
  final Value<String> ProductLotId;
  final Value<String> Quantity;
  final Value<String> QuantitySystem;
  final Value<String> Difference;
  final Value<String> Quality;
  const InventoryLinesCompanion({
    this.id = const Value.absent(),
    this.InventoryId = const Value.absent(),
    this.ProductId = const Value.absent(),
    this.EmplacementId = const Value.absent(),
    this.ProductLotId = const Value.absent(),
    this.Quantity = const Value.absent(),
    this.QuantitySystem = const Value.absent(),
    this.Difference = const Value.absent(),
    this.Quality = const Value.absent(),
  });
  InventoryLinesCompanion.insert({
    @required String id,
    @required String InventoryId,
    @required String ProductId,
    @required String EmplacementId,
    @required String ProductLotId,
    @required String Quantity,
    @required String QuantitySystem,
    @required String Difference,
    @required String Quality,
  })  : id = Value(id),
        InventoryId = Value(InventoryId),
        ProductId = Value(ProductId),
        EmplacementId = Value(EmplacementId),
        ProductLotId = Value(ProductLotId),
        Quantity = Value(Quantity),
        QuantitySystem = Value(QuantitySystem),
        Difference = Value(Difference),
        Quality = Value(Quality);
  static Insertable<InventoryLine> custom({
    Expression<String> id,
    Expression<String> InventoryId,
    Expression<String> ProductId,
    Expression<String> EmplacementId,
    Expression<String> ProductLotId,
    Expression<String> Quantity,
    Expression<String> QuantitySystem,
    Expression<String> Difference,
    Expression<String> Quality,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (InventoryId != null) 'inventory_id': InventoryId,
      if (ProductId != null) 'product_id': ProductId,
      if (EmplacementId != null) 'emplacement_id': EmplacementId,
      if (ProductLotId != null) 'product_lot_id': ProductLotId,
      if (Quantity != null) 'quantity': Quantity,
      if (QuantitySystem != null) 'quantity_system': QuantitySystem,
      if (Difference != null) 'difference': Difference,
      if (Quality != null) 'quality': Quality,
    });
  }

  InventoryLinesCompanion copyWith(
      {Value<String> id,
      Value<String> InventoryId,
      Value<String> ProductId,
      Value<String> EmplacementId,
      Value<String> ProductLotId,
      Value<String> Quantity,
      Value<String> QuantitySystem,
      Value<String> Difference,
      Value<String> Quality}) {
    return InventoryLinesCompanion(
      id: id ?? this.id,
      InventoryId: InventoryId ?? this.InventoryId,
      ProductId: ProductId ?? this.ProductId,
      EmplacementId: EmplacementId ?? this.EmplacementId,
      ProductLotId: ProductLotId ?? this.ProductLotId,
      Quantity: Quantity ?? this.Quantity,
      QuantitySystem: QuantitySystem ?? this.QuantitySystem,
      Difference: Difference ?? this.Difference,
      Quality: Quality ?? this.Quality,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (InventoryId.present) {
      map['inventory_id'] = Variable<String>(InventoryId.value);
    }
    if (ProductId.present) {
      map['product_id'] = Variable<String>(ProductId.value);
    }
    if (EmplacementId.present) {
      map['emplacement_id'] = Variable<String>(EmplacementId.value);
    }
    if (ProductLotId.present) {
      map['product_lot_id'] = Variable<String>(ProductLotId.value);
    }
    if (Quantity.present) {
      map['quantity'] = Variable<String>(Quantity.value);
    }
    if (QuantitySystem.present) {
      map['quantity_system'] = Variable<String>(QuantitySystem.value);
    }
    if (Difference.present) {
      map['difference'] = Variable<String>(Difference.value);
    }
    if (Quality.present) {
      map['quality'] = Variable<String>(Quality.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLinesCompanion(')
          ..write('id: $id, ')
          ..write('InventoryId: $InventoryId, ')
          ..write('ProductId: $ProductId, ')
          ..write('EmplacementId: $EmplacementId, ')
          ..write('ProductLotId: $ProductLotId, ')
          ..write('Quantity: $Quantity, ')
          ..write('QuantitySystem: $QuantitySystem, ')
          ..write('Difference: $Difference, ')
          ..write('Quality: $Quality')
          ..write(')'))
        .toString();
  }
}

class $InventoryLinesTable extends InventoryLines
    with TableInfo<$InventoryLinesTable, InventoryLine> {
  final GeneratedDatabase _db;
  final String _alias;
  $InventoryLinesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _InventoryIdMeta =
      const VerificationMeta('InventoryId');
  GeneratedTextColumn _InventoryId;
  @override
  GeneratedTextColumn get InventoryId =>
      _InventoryId ??= _constructInventoryId();
  GeneratedTextColumn _constructInventoryId() {
    return GeneratedTextColumn('inventory_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductIdMeta = const VerificationMeta('ProductId');
  GeneratedTextColumn _ProductId;
  @override
  GeneratedTextColumn get ProductId => _ProductId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _EmplacementIdMeta =
      const VerificationMeta('EmplacementId');
  GeneratedTextColumn _EmplacementId;
  @override
  GeneratedTextColumn get EmplacementId =>
      _EmplacementId ??= _constructEmplacementId();
  GeneratedTextColumn _constructEmplacementId() {
    return GeneratedTextColumn('emplacement_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _ProductLotIdMeta =
      const VerificationMeta('ProductLotId');
  GeneratedTextColumn _ProductLotId;
  @override
  GeneratedTextColumn get ProductLotId =>
      _ProductLotId ??= _constructProductLotId();
  GeneratedTextColumn _constructProductLotId() {
    return GeneratedTextColumn('product_lot_id', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _QuantityMeta = const VerificationMeta('Quantity');
  GeneratedTextColumn _Quantity;
  @override
  GeneratedTextColumn get Quantity => _Quantity ??= _constructQuantity();
  GeneratedTextColumn _constructQuantity() {
    return GeneratedTextColumn('quantity', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _QuantitySystemMeta =
      const VerificationMeta('QuantitySystem');
  GeneratedTextColumn _QuantitySystem;
  @override
  GeneratedTextColumn get QuantitySystem =>
      _QuantitySystem ??= _constructQuantitySystem();
  GeneratedTextColumn _constructQuantitySystem() {
    return GeneratedTextColumn('quantity_system', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _DifferenceMeta = const VerificationMeta('Difference');
  GeneratedTextColumn _Difference;
  @override
  GeneratedTextColumn get Difference => _Difference ??= _constructDifference();
  GeneratedTextColumn _constructDifference() {
    return GeneratedTextColumn('difference', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _QualityMeta = const VerificationMeta('Quality');
  GeneratedTextColumn _Quality;
  @override
  GeneratedTextColumn get Quality => _Quality ??= _constructQuality();
  GeneratedTextColumn _constructQuality() {
    return GeneratedTextColumn('quality', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        InventoryId,
        ProductId,
        EmplacementId,
        ProductLotId,
        Quantity,
        QuantitySystem,
        Difference,
        Quality
      ];
  @override
  $InventoryLinesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'inventory_lines';
  @override
  final String actualTableName = 'inventory_lines';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('inventory_id')) {
      context.handle(
          _InventoryIdMeta,
          InventoryId.isAcceptableOrUnknown(
              data['inventory_id'], _InventoryIdMeta));
    } else if (isInserting) {
      context.missing(_InventoryIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_ProductIdMeta,
          ProductId.isAcceptableOrUnknown(data['product_id'], _ProductIdMeta));
    } else if (isInserting) {
      context.missing(_ProductIdMeta);
    }
    if (data.containsKey('emplacement_id')) {
      context.handle(
          _EmplacementIdMeta,
          EmplacementId.isAcceptableOrUnknown(
              data['emplacement_id'], _EmplacementIdMeta));
    } else if (isInserting) {
      context.missing(_EmplacementIdMeta);
    }
    if (data.containsKey('product_lot_id')) {
      context.handle(
          _ProductLotIdMeta,
          ProductLotId.isAcceptableOrUnknown(
              data['product_lot_id'], _ProductLotIdMeta));
    } else if (isInserting) {
      context.missing(_ProductLotIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_QuantityMeta,
          Quantity.isAcceptableOrUnknown(data['quantity'], _QuantityMeta));
    } else if (isInserting) {
      context.missing(_QuantityMeta);
    }
    if (data.containsKey('quantity_system')) {
      context.handle(
          _QuantitySystemMeta,
          QuantitySystem.isAcceptableOrUnknown(
              data['quantity_system'], _QuantitySystemMeta));
    } else if (isInserting) {
      context.missing(_QuantitySystemMeta);
    }
    if (data.containsKey('difference')) {
      context.handle(
          _DifferenceMeta,
          Difference.isAcceptableOrUnknown(
              data['difference'], _DifferenceMeta));
    } else if (isInserting) {
      context.missing(_DifferenceMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(_QualityMeta,
          Quality.isAcceptableOrUnknown(data['quality'], _QualityMeta));
    } else if (isInserting) {
      context.missing(_QualityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryLine map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return InventoryLine.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $InventoryLinesTable createAlias(String alias) {
    return $InventoryLinesTable(_db, alias);
  }
}

abstract class _$FecomItDatabase extends GeneratedDatabase {
  _$FecomItDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SitesTable _sites;
  $SitesTable get sites => _sites ??= $SitesTable(this);
  $CompanysTable _companys;
  $CompanysTable get companys => _companys ??= $CompanysTable(this);
  $StockEntrepotsTable _stockEntrepots;
  $StockEntrepotsTable get stockEntrepots =>
      _stockEntrepots ??= $StockEntrepotsTable(this);
  $StockSystemsTable _stockSystems;
  $StockSystemsTable get stockSystems =>
      _stockSystems ??= $StockSystemsTable(this);
  $EmplacementsTable _emplacements;
  $EmplacementsTable get emplacements =>
      _emplacements ??= $EmplacementsTable(this);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $ProductCategorysTable _productCategorys;
  $ProductCategorysTable get productCategorys =>
      _productCategorys ??= $ProductCategorysTable(this);
  $ProductLotsTable _productLots;
  $ProductLotsTable get productLots => _productLots ??= $ProductLotsTable(this);
  $InventorysTable _inventorys;
  $InventorysTable get inventorys => _inventorys ??= $InventorysTable(this);
  $InventoryLinesTable _inventoryLines;
  $InventoryLinesTable get inventoryLines =>
      _inventoryLines ??= $InventoryLinesTable(this);
  SitesDao _sitesDao;
  SitesDao get sitesDao => _sitesDao ??= SitesDao(this as FecomItDatabase);
  CompanysDao _companysDao;
  CompanysDao get companysDao =>
      _companysDao ??= CompanysDao(this as FecomItDatabase);
  StockEntrepotsDao _stockEntrepotsDao;
  StockEntrepotsDao get stockEntrepotsDao =>
      _stockEntrepotsDao ??= StockEntrepotsDao(this as FecomItDatabase);
  StockSystemsDao _stockSystemsDao;
  StockSystemsDao get stockSystemsDao =>
      _stockSystemsDao ??= StockSystemsDao(this as FecomItDatabase);
  EmplacementsDao _emplacementsDao;
  EmplacementsDao get emplacementsDao =>
      _emplacementsDao ??= EmplacementsDao(this as FecomItDatabase);
  ProductsDao _productsDao;
  ProductsDao get productsDao =>
      _productsDao ??= ProductsDao(this as FecomItDatabase);
  ProductCategorysDao _productCategorysDao;
  ProductCategorysDao get productCategorysDao =>
      _productCategorysDao ??= ProductCategorysDao(this as FecomItDatabase);
  ProductLotsDao _productLotsDao;
  ProductLotsDao get productLotsDao =>
      _productLotsDao ??= ProductLotsDao(this as FecomItDatabase);
  InventorysDao _inventorysDao;
  InventorysDao get inventorysDao =>
      _inventorysDao ??= InventorysDao(this as FecomItDatabase);
  InventoryLinesDao _inventoryLinesDao;
  InventoryLinesDao get inventoryLinesDao =>
      _inventoryLinesDao ??= InventoryLinesDao(this as FecomItDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        sites,
        companys,
        stockEntrepots,
        stockSystems,
        emplacements,
        products,
        productCategorys,
        productLots,
        inventorys,
        inventoryLines
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SitesDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $SitesTable get sites => attachedDatabase.sites;
}
mixin _$CompanysDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $CompanysTable get companys => attachedDatabase.companys;
}
mixin _$StockEntrepotsDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $StockEntrepotsTable get stockEntrepots => attachedDatabase.stockEntrepots;
}
mixin _$StockSystemsDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $StockSystemsTable get stockSystems => attachedDatabase.stockSystems;
}
mixin _$EmplacementsDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $EmplacementsTable get emplacements => attachedDatabase.emplacements;
}
mixin _$ProductsDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $ProductsTable get products => attachedDatabase.products;
}
mixin _$ProductCategorysDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $ProductCategorysTable get productCategorys =>
      attachedDatabase.productCategorys;
}
mixin _$ProductLotsDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $ProductLotsTable get productLots => attachedDatabase.productLots;
}
mixin _$InventorysDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $InventorysTable get inventorys => attachedDatabase.inventorys;
}
mixin _$InventoryLinesDaoMixin on DatabaseAccessor<FecomItDatabase> {
  $InventoryLinesTable get inventoryLines => attachedDatabase.inventoryLines;
}
