// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ItemBean implements Bean<Item> {
  final id = new IntField('id');
  final msg = new StrField('msg');
  final postId = new IntField('post_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        msg.name: msg,
        postId.name: postId,
      };
  Item fromMap(Map map) {
    Item model = new Item();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.postId = adapter.parseValue(map['post_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Item model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(msg.set(model.msg));
      ret.add(postId.set(model.postId));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(msg.name)) ret.add(msg.set(model.msg));
      if (only.contains(postId.name)) ret.add(postId.set(model.postId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true);
    st.addStr(msg.name);
    st.addInt(postId.name, foreignTable: postBean.tableName, foreignCol: 'id');
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Item model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<int> update(Item model, {Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<Item> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
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

  Future<List<Item>> findByPost(int postId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.postId.eq(postId));
    return findMany(find);
  }

  Future<List<Item>> findByPostList(List<Post> models,
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

  void associatePost(Item child, Post parent) {
    child.postId = parent.id;
  }

  PostBean get postBean;
}
