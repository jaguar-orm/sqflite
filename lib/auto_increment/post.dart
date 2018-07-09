import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

part 'post.jorm.dart';

// The model
class Post {
  Post();

  Post.make(this.id, this.msg, this.stars, this.read, this.at);

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

  String toString() =>
      'Post(id: $id, message: $msg, stars: $stars, read: $read, at: $at)';

  static String get tableName => 'posts';
}

@GenBean()
class PostBean extends Bean<Post> with _PostBean {
  PostBean(Adapter adapter) : super(adapter);
}
