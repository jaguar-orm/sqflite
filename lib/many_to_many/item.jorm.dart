// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ItemBean implements Bean<Item> {
  final id = new IntField('id');
  final msg = new StrField('msg');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        msg.name: msg,
      };
  Item fromMap(Map map) {
    Item model = new Item();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);

    return model;
  }

  List<SetColumn> toSetColumns(Item model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(msg.set(model.msg));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(msg.name)) ret.add(msg.set(model.msg));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(msg.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Item model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
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

  Future<void> insertMany(List<Item> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      return adapter.insertMany(insert);
    }
  }

  Future<int> update(Item model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
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

  Future<void> updateMany(List<Item> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      return adapter.updateMany(update);
    }
  }

  Future<Item> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Item model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Item newModel = await find(id);
      await pivotBean.detachItem(newModel);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Item> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Item> preload(Item model, {bool cascade: false}) async {
    model.posts = await pivotBean.fetchByItem(model);
    return model;
  }

  Future<List<Item>> preloadAll(List<Item> models,
      {bool cascade: false}) async {
    for (Item model in models) {
      var temp = await pivotBean.fetchByItem(model);
      if (model.posts == null)
        model.posts = temp;
      else {
        model.posts.clear();
        model.posts.addAll(temp);
      }
    }
    return models;
  }

  PivotBean get pivotBean;

  PostBean get postBean;
}
