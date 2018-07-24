// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PostBean implements Bean<Post> {
  final id = new IntField('id');
  final msg = new StrField('msg');
  final read = new BoolField('read');
  final stars = new DoubleField('stars');
  final at = new DateTimeField('at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        msg.name: msg,
        read.name: read,
        stars.name: stars,
        at.name: at,
      };
  Post fromMap(Map map) {
    Post model = new Post();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.read = adapter.parseValue(map['read']);
    model.stars = adapter.parseValue(map['stars']);
    model.at = adapter.parseValue(map['at']);

    return model;
  }

  List<SetColumn> toSetColumns(Post model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(msg.set(model.msg));
      ret.add(read.set(model.read));
      ret.add(stars.set(model.stars));
      ret.add(at.set(model.at));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(msg.name)) ret.add(msg.set(model.msg));
      if (only.contains(read.name)) ret.add(read.set(model.read));
      if (only.contains(stars.name)) ret.add(stars.set(model.stars));
      if (only.contains(at.name)) ret.add(at.set(model.at));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true);
    st.addStr(msg.name);
    st.addBool(read.name);
    st.addInt(stars.name);
    st.addDateTime(at.name);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Post model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model))..id(id.name);
    final ret = await adapter.insert(insert);
    if (cascade) {
      Post newModel;
      if (model.items != null) {
        newModel ??= await find(ret);
        for (final child in model.items) {
          await itemBean.insert(child);
          await pivotBean.attach(model, child);
        }
      }
    }
    return ret;
  }

  Future<int> update(Post model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Post newModel;
      if (model.items != null) {
        for (final child in model.items) {
          await await itemBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<Post> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Post model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Post newModel = await find(id);
      await pivotBean.detachPost(newModel);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Post> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<void> preload(Post model, {bool cascade: false}) async {
    model.items = await pivotBean.fetchByPost(model);
  }

  Future<void> preloadAll(List<Post> models, {bool cascade: false}) async {
    for (Post model in models) {
      var temp = await pivotBean.fetchByPost(model);
      if (model.items == null)
        model.items = temp;
      else {
        model.items.clear();
        model.items.addAll(temp);
      }
    }
  }

  PivotBean get pivotBean;

  ItemBean get itemBean;
}
