// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ThemeModeModel extends _ThemeModeModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ThemeModeModel(
    String themeModeName,
  ) {
    RealmObjectBase.set(this, 'themeModeName', themeModeName);
  }

  ThemeModeModel._();

  @override
  String get themeModeName =>
      RealmObjectBase.get<String>(this, 'themeModeName') as String;
  @override
  set themeModeName(String value) =>
      RealmObjectBase.set(this, 'themeModeName', value);

  @override
  Stream<RealmObjectChanges<ThemeModeModel>> get changes =>
      RealmObjectBase.getChanges<ThemeModeModel>(this);

  @override
  ThemeModeModel freeze() => RealmObjectBase.freezeObject<ThemeModeModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ThemeModeModel._);
    return const SchemaObject(
        ObjectType.realmObject, ThemeModeModel, 'ThemeModeModel', [
      SchemaProperty('themeModeName', RealmPropertyType.string),
    ]);
  }
}
