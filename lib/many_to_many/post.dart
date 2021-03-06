import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'item.dart';
import 'pivot.dart';

part 'post.jorm.dart';

// The model
class Post {
  Post();

  Post.make(this.id, this.msg, this.stars, this.read, this.at, this.items);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: true)
  String msg;

  @Column(isNullable: true)
  bool read;

  @Column(isNullable: true)
  double stars;

  @Column(isNullable: true)
  DateTime at;

  @ManyToMany(PivotBean, ItemBean)
  List<Item> items;

  String toString() =>
      'Post(id: $id, message: $msg, stars: $stars, read: $read, at: $at, items: $items)';
}

@GenBean()
class PostBean extends Bean<Post> with _PostBean {
  PostBean(Adapter adapter)
      : itemBean = ItemBean(adapter),
        pivotBean = PivotBean(adapter),
        super(adapter);

  final ItemBean itemBean;
  final PivotBean pivotBean;

  Future<int> updateReadField(int id, bool read) async {
    Update st = updater.where(this.id.eq(id)).set(this.read, read);
    return adapter.update(st);
  }

  final String tableName = "posts";
}
