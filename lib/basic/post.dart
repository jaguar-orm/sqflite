import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
// import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

part 'post.jorm.dart';

// The model
class Post {
  Post();

  Post.make(this.id, this.msg, this.stars, this.read, this.at);

  @PrimaryKey()
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

  Future<int> updateReadField(int id, bool read) async {
    Update st = updater.where(this.id.eq(id)).set(this.read, read);
    return execUpdate(st);
  }

  /// Finds all posts
  Future<List<Post>> findAll() async => (await execFind(finder)).toList();
}