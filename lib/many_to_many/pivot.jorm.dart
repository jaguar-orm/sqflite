// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PivotBean implements Bean<Pivot> {
  final postId = new IntField('post_id');
  final itemId = new IntField('item_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        postId.name: postId,
        itemId.name: itemId,
      };
  Pivot fromMap(Map map) {
    Pivot model = new Pivot();

    model.postId = adapter.parseValue(map['post_id']);
    model.itemId = adapter.parseValue(map['item_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Pivot model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(postId.set(model.postId));
      ret.add(itemId.set(model.itemId));
    } else {
      if (only.contains(postId.name)) ret.add(postId.set(model.postId));
      if (only.contains(itemId.name)) ret.add(itemId.set(model.itemId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(postId.name,
        foreignTable: postBean.tableName, foreignCol: 'id', isNullable: false);
    st.addInt(itemId.name,
        foreignTable: itemBean.tableName, foreignCol: 'id', isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Pivot model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Pivot> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    return adapter.insertMany(insert);
  }

  Future<void> updateMany(List<Pivot> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    return adapter.updateMany(update);
  }

  Future<List<Pivot>> findByPost(int postId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.postId.eq(postId));
    return findMany(find);
  }

  Future<List<Pivot>> findByPostList(List<Post> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Post model in models) {
      find.or(this.postId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByPost(int postId) async {
    final Remove rm = remover.where(this.postId.eq(postId));
    return await adapter.remove(rm);
  }

  void associatePost(Pivot child, Post parent) {
    child.postId = parent.id;
  }

  Future<int> detachPost(Post model) async {
    final dels = await findByPost(model.id);
    await removeByPost(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(itemBean.id.eq(t.itemId));
    }
    return await itemBean.removeWhere(exp);
  }

  Future<List<Item>> fetchByPost(Post model) async {
    final pivots = await findByPost(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(itemBean.id.eq(t.itemId));
    }
    return await itemBean.findWhere(exp);
  }

  Future<List<Pivot>> findByItem(int itemId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.itemId.eq(itemId));
    return findMany(find);
  }

  Future<List<Pivot>> findByItemList(List<Item> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Item model in models) {
      find.or(this.itemId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByItem(int itemId) async {
    final Remove rm = remover.where(this.itemId.eq(itemId));
    return await adapter.remove(rm);
  }

  void associateItem(Pivot child, Item parent) {
    child.itemId = parent.id;
  }

  Future<int> detachItem(Item model) async {
    final dels = await findByItem(model.id);
    await removeByItem(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(postBean.id.eq(t.postId));
    }
    return await postBean.removeWhere(exp);
  }

  Future<List<Post>> fetchByItem(Item model) async {
    final pivots = await findByItem(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(postBean.id.eq(t.postId));
    }
    return await postBean.findWhere(exp);
  }

  Future<dynamic> attach(Post one, Item two) async {
    final ret = new Pivot();
    ret.postId = one.id;
    ret.itemId = two.id;
    return insert(ret);
  }

  PostBean get postBean;
  ItemBean get itemBean;
}
