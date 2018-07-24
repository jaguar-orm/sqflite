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

  @PrimaryKey(autoIncrement: true)
  int id;

  @Column(nullable: true)
  String msg;

  @Column(nullable: true)
  bool read;

  @Column(nullable: true)
  double stars;

  @Column(nullable: true)
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
