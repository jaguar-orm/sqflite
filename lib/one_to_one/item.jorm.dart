// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ItemBean implements Bean<Item> {
  String get tableName => Item.tableName;

  final IntField id = new IntField('id');

  final StrField msg = new StrField('msg');

  final IntField postId = new IntField('post_id');

  Item fromMap(Map map) {
    Item model = new Item();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.postId = adapter.parseValue(map['post_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Item model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(id.set(model.id));
    ret.add(msg.set(model.msg));
    ret.add(postId.set(model.postId));

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true);
    st.addStr(msg.name);
    st.addInt(postId.name, foreignTable: Post.tableName, foreignCol: 'id');
    return execCreateTable(st);
  }

  Future<dynamic> insert(Item model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return execInsert(insert);
  }

  Future<int> update(Item model) async {
    final Update update =
        updater.where(this.id.eq(model.id)).setMany(toSetColumns(model));
    return execUpdate(update);
  }

  Future<Item> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await execFindOne(find);
  }

  Future<List<Item>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> remove(int id) async {
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

  Future<Item> findByPost(int postId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.postId.eq(postId));
    return await execFindOne(find);
  }

  Future<int> removeByPost(int postId) async {
    final Remove rm = remover.where(this.postId.eq(postId));
    return await execRemove(rm);
  }

  Future<List<Item>> findByPostList(List<Post> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Post model in models) {
      find.or(this.postId.eq(model.id));
    }
    return await (await execFind(find)).toList();
  }

  void associatePost(Item child, Post parent) {
    child.postId = parent.id;
  }
}
