import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'item.dart';
import 'post.dart';

part 'pivot.jorm.dart';

// The model
class Pivot {
  Pivot();

  @BelongsToMany(PostBean)
  int postId;

  @BelongsToMany(ItemBean)
  int itemId;

  static String tableName = 'pivot';
}

@GenBean()
class PivotBean extends Bean<Pivot> with _PivotBean {
  PivotBean(Adapter adapter) : super(adapter);

  final ItemBean itemBean;
  final PostBean postBean;
}
