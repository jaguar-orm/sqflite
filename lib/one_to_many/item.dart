import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

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

  @BelongsTo(PostBean)
  int postId;

  String toString() => 'Item(id: $id, message: $msg)';
}

@GenBean()
class ItemBean extends Bean<Item> with _ItemBean {
  PostBean _postBean;

  PostBean get postBean => _postBean ??= new PostBean(adapter);

  ItemBean(Adapter adapter) : super(adapter);

  final String tableName = 'items';
}
