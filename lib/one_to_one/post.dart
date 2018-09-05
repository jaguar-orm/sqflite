import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'item.dart';

part 'post.jorm.dart';

// The model
class Post {
  Post();

  Post.make(this.id, this.msg, this.stars, this.read, this.at, this.item);

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

  @HasOne(ItemBean)
  Item item;

  //@HasMany(ItemBean)
  //List<Item> items;

  String toString() =>
      'Post(id: $id, message: $msg, stars: $stars, read: $read, at: $at, item: $item)';

  static String get tableName => 'posts';
}

@GenBean()
class PostBean extends Bean<Post> with _PostBean {
  PostBean(Adapter adapter)
      : itemBean = ItemBean(adapter),
        super(adapter);

  final ItemBean itemBean;

  Future<int> updateReadField(int id, bool read) async {
    Update st = updater.where(this.id.eq(id)).set(this.read, read);
    return adapter.update(st);
  }

  final String tableName = 'posts';
}
