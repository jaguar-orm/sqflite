// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'item.dart';
import 'post.dart';

/// The adapter
SqfliteAdapter _adapter;

void main() async {
  await Sqflite.devSetDebugModeOn(true);
  var sb = StringBuffer();
  sb.writeln("Jaguar ORM showcase:");

  sb.writeln('--------------');
  sb.write('Connecting ...');
  var dbPath = await getDatabasesPath();
  _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));

  try {
    await _adapter.connect();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    final bean = PostBean(_adapter);
    final itemBean = ItemBean(_adapter);

    await bean.drop();
    await itemBean.drop();

    sb.write('Creating table ...');
    await bean.createTable();
    await itemBean.createTable();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Delete all
    sb.write('Removing old rows (if any) ...');
    await bean.removeAll();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Insert some posts
    sb.writeln('Inserting sample rows ...');
    var post = new Post.make(
        1, 'Coffee?', 4.5, false, DateTime.now(), new Item.make(2, 'test'));
    int id1 = await bean.insert(post, cascade: true);
    sb.writeln(
        'Inserted successfully row with id: $id1 and one to one relation!');
    int id2 = await bean
        .insert(new Post.make(2, 'Sure!', 5.0, true, DateTime.now(), null));
    sb.writeln('Inserted successfully row with id: $id2!');
    /*
  int id3 =
      await bean.insert(new Post.make(3, null, 5.0, true, DateTime.now()));
  sb.writeln('Inserted successfully row with id: $id3!');
  */
    sb.writeln('--------------');

    // Find one post
    sb.writeln('Reading row with id $id1 with one to one relation...');
    Post post1 = await bean.find(id1, preload: true);
    sb.writeln(post1);
    sb.writeln('--------------');

    // Find all posts
    sb.writeln('Reading all rows ...');
    List<Post> posts = await bean.getAll();
    await bean.preloadAll(posts);
    posts.forEach((p) => sb.writeln(p));
    sb.writeln('--------------');

    // Update a post
    sb.write('Updating a column in row with id $id1 ...');
    await bean.updateReadField(id1, true);
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Find one post
    sb.writeln('Reading row with $id1 to check the update ...');
    post1 = await bean.find(id1, preload: true);
    sb.writeln(post1);
    sb.writeln('--------------');

    sb.writeln('Removing row with id $id1 ...');
    await bean.remove(id1);
    sb.writeln('--------------');

    // Find all posts
    sb.writeln('Reading all rows ...');
    posts = await bean.getAll();
    await bean.preloadAll(posts);
    posts.forEach((p) => sb.writeln(p));
    sb.writeln('--------------');

    sb.writeln('Removing all rows ...');
    await bean.removeAll();
    sb.writeln('--------------');

    sb.write('Closing the connection ...');
    await _adapter.close();
    sb.writeln(' successful!');
    sb.writeln('--------------');
  } finally {
    print(sb.toString());
  }

  runApp(SingleChildScrollView(
      child: Text(sb.toString(), textDirection: TextDirection.ltr)));
}
