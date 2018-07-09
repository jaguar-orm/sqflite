import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'pivot.dart';
import 'post.dart';

part 'item.jorm.dart';

// The model
class Item {
  Item();

  Item.make(this.id, this.msg);

  @PrimaryKey()
  int id;

  @Column(nullable: true)
  String msg;

  @ManyToMany(PivotBean, PostBean)
  List<Post> posts;

  String toString() => 'Item(id: $id, message: $msg)';

  static String get tableName => 'items';
}

@GenBean()
class ItemBean extends Bean<Item> with _ItemBean {
  ItemBean(Adapter adapter) : super(adapter);

  PivotBean _pivotBean;
  PostBean _postBean;

  PostBean get postBean {
    _postBean ??= new PostBean(adapter);
    return _postBean;
  }

  PivotBean get pivotBean {
    _pivotBean ??= new PivotBean(adapter);
    return _pivotBean;
  }

  /// Finds all items
  Future<List<Item>> findAll() async => (await execFind(finder)).toList();
}
