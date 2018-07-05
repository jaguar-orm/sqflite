// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_example/main.dart' as sqflite_example;

void main() {
  testWidgets('Hello world smoke test', (WidgetTester tester) async {
    sqflite_example.main(); // builds the app and schedules a frame but doesn't trigger one
    await tester.pump(); // triggers a frame

    // expect(find.text('Hello, world!'), findsOneWidget);
  });
}
