// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PivotBean implements Bean<Pivot> {
  String get tableName => Pivot.tableName;

  final IntField postId = new IntField('post_id');

  final IntField itemId = new IntField('item_id');

  Pivot fromMap(Map map) {
    Pivot model = new Pivot();

    model.postId = adapter.parseValue(map['post_id']);
    model.itemId = adapter.parseValue(map['item_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Pivot model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(postId.set(model.postId));
    ret.add(itemId.set(model.itemId));

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addInt(postId.name, foreignTable: Post.tableName, foreignCol: 'id');
    st.addInt(itemId.name, foreignTable: Item.tableName, foreignCol: 'id');
    return execCreateTable(st);
  }

  Future<dynamic> insert(Pivot model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return execInsert(insert);
  }

  Future<List<Pivot>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> removeWhere(Expression exp) async {
    return execRemove(remover.where(exp));
  }

  Future<List<Pivot>> findByPost(int postId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.postId.eq(postId));
    return await (await execFind(find)).toList();
  }

  Future<List<Pivot>> findByItem(int itemId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.itemId.eq(itemId));
    return await (await execFind(find)).toList();
  }

  Future<int> removeByPost(int postId) async {
    final Remove rm = remover.where(this.postId.eq(postId));
    return await execRemove(rm);
  }

  Future<int> removeByItem(int itemId) async {
    final Remove rm = remover.where(this.itemId.eq(itemId));
    return await execRemove(rm);
  }

  Future<List<Pivot>> findByPostList(List<Post> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Post model in models) {
      find.or(this.postId.eq(model.id));
    }
    return await (await execFind(find)).toList();
  }

  Future<List<Pivot>> findByItemList(List<Item> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Item model in models) {
      find.or(this.itemId.eq(model.id));
    }
    return await (await execFind(find)).toList();
  }

  void associatePost(Pivot child, Post parent) {
    child.postId = parent.id;
  }

  void associateItem(Pivot child, Item parent) {
    child.itemId = parent.id;
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

  Future<int> detachItem(Item model) async {
    final dels = await findByItem(model.id);
    await removeByItem(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(postBean.id.eq(t.postId));
    }
    return await postBean.removeWhere(exp);
  }

  Future<List<Item>> fetchByPost(Post model) async {
    final pivots = await findByPost(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(itemBean.id.eq(t.itemId));
    }
    return await itemBean.findWhere(exp);
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
