// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PostBean implements Bean<Post> {
  String get tableName => Post.tableName;

  final IntField id = new IntField('id');

  final StrField msg = new StrField('msg');

  final BoolField read = new BoolField('read');

  final DoubleField stars = new DoubleField('stars');

  final DateTimeField at = new DateTimeField('at');

  Post fromMap(Map map) {
    Post model = new Post();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.read = adapter.parseValue(map['read']);
    model.stars = adapter.parseValue(map['stars']);
    model.at = adapter.parseValue(map['at']);

    return model;
  }

  List<SetColumn> toSetColumns(Post model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(id.set(model.id));
    ret.add(msg.set(model.msg));
    ret.add(read.set(model.read));
    ret.add(stars.set(model.stars));
    ret.add(at.set(model.at));

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true);
    st.addStr(msg.name);
    st.addBool(read.name);
    st.addInt(stars.name);
    st.addDateTime(at.name);
    return execCreateTable(st);
  }

  Future<dynamic> insert(Post model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await execInsert(insert);
    if (cascade) {
      Post newModel;
      if (model.items != null) {
        newModel ??= await find(retId);
        model.items.forEach((x) => itemBean.associatePost(x, newModel));
        for (final child in model.items) {
          await itemBean.insert(child);
        }
      }
    }
    return retId;
  }

  Future<int> update(Post model,
      {bool cascade: false, bool associate: false}) async {
    final Update update =
        updater.where(this.id.eq(model.id)).setMany(toSetColumns(model));
    final ret = execUpdate(update);
    if (cascade) {
      Post newModel;
      if (model.items != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.items.forEach((x) => itemBean.associatePost(x, newModel));
        }
        for (final child in model.items) {
          await itemBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<Post> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Post model = await execFindOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<List<Post>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Post newModel = await find(id);
      await itemBean.removeByPost(newModel.id);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<Post> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future<int> removeWhere(Expression exp) async {
    return execRemove(remover.where(exp));
  }

  Future preload(Post model, {bool cascade: false}) async {
    model.items =
        await itemBean.findByPost(model.id, preload: cascade, cascade: cascade);
  }

  Future preloadAll(List<Post> models, {bool cascade: false}) async {
    models.forEach((Post model) => model.items ??= []);
    await PreloadHelper.preload<Post, Item>(
        models,
        (Post model) => [model.id],
        itemBean.findByPostList,
        (Item model) => [model.postId],
        (Post model, Item child) => model.items.add(child),
        cascade: cascade);
  }

  ItemBean get itemBean;
}
