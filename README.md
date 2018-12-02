# sqflite Jaguar ORM example

Showcases how to use Jaguar ORM, Jaguar Query and sqflite in your Flutter
apps.

Run the individual examples as follows:

    $ flutter run lib/basic/main.dart

    $ flutter run lib/one_to_one/main.dart

    $ flutter run lib/auto_increment/main.dart

    $ flutter run lib/one_to_many/main.dart

    $ flutter run lib/many_to_many/main.dart

Running the [basic example](https://github.com/jaguar-orm/sqflite/blob/master/lib/basic/main.dart) should show the following result:

```
I/flutter ( 5464): Jaguar ORM showcase:
I/flutter ( 5464): --------------
I/flutter ( 5464): Connecting ... successful!
I/flutter ( 5464): --------------
I/flutter ( 5464): Creating table ... successful!
I/flutter ( 5464): --------------
I/flutter ( 5464): Removing old rows (if any) ... successful!
I/flutter ( 5464): --------------
I/flutter ( 5464): Inserting sample rows ...
I/flutter ( 5464): Inserted successfully row with id: 1!
I/flutter ( 5464): Inserted successfully row with id: 2!
I/flutter ( 5464): --------------
I/flutter ( 5464): Reading row with id 1 ...
I/flutter ( 5464): Post(id: 1, message: Coffee? read: false, at: 2018-07-05 19:05:35.845037)
I/flutter ( 5464): --------------
I/flutter ( 5464): Reading all rows ...
I/flutter ( 5464): Post(id: 1, message: Coffee? read: false, at: 2018-07-05 19:05:35.845037)
I/flutter ( 5464): Post(id: 2, message: Sure! read: true, at: 2018-07-05 19:05:35.882620)
I/flutter ( 5464): --------------
I/flutter ( 5464): Updating a column in row with id 1 ... successful!
I/flutter ( 5464): --------------
I/flutter ( 5464): Reading row with 1 to check the update ...
I/flutter ( 5464): Post(id: 1, message: Coffee? read: true, at: 2018-07-05 19:05:35.845037)
I/flutter ( 5464): --------------
I/flutter ( 5464): Removing row with id 1 ...
I/flutter ( 5464): --------------
I/flutter ( 5464): Reading all rows ...
I/flutter ( 5464): Post(id: 2, message: Sure! read: true, at: 2018-07-05 19:05:35.882620)
I/flutter ( 5464): --------------
I/flutter ( 5464): Removing all rows ...
I/flutter ( 5464): --------------
I/flutter ( 5464): Closing the connection ... successful!
I/flutter ( 5464): ------
```