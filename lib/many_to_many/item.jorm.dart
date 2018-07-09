// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ItemBean implements Bean<Item> {
  String get tableName => Item.tableName;

  final IntField id = new IntField('id');

  final StrField msg = new StrField('msg');

  Item fromMap(Map map) {
    Item model = new Item();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);

    return model;
  }

  List<SetColumn> toSetColumns(Item model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(id.set(model.id));
    ret.add(msg.set(model.msg));

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true);
    st.addStr(msg.name);
    return execCreateTable(st);
  }

  Future<dynamic> insert(Item model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await execInsert(insert);
    if (cascade) {
      Item newModel;
      if (model.posts != null) {
        newModel ??= await find(model.id);
        for (final child in model.posts) {
          await postBean.insert(child);
          await pivotBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<int> update(Item model,
      {bool cascade: false, bool associate: false}) async {
    final Update update =
        updater.where(this.id.eq(model.id)).setMany(toSetColumns(model));
    final ret = execUpdate(update);
    if (cascade) {
      Item newModel;
      if (model.posts != null) {
        for (final child in model.posts) {
          await await postBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<Item> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Item model = await execFindOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<List<Item>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Item newModel = await find(id);
      await pivotBean.detachItem(newModel);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<Item> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future<int> removeWhere(Expression exp) async {
    return execRemove(remover.where(exp));
  }

  Future preload(Item model, {bool cascade: false}) async {
    model.posts = await pivotBean.fetchByItem(model);
  }

  Future preloadAll(List<Item> models, {bool cascade: false}) async {}
  PivotBean get pivotBean;

  PostBean get postBean;
}
