import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'Constants.dart';

class MongoDatabase{
static connect() async {
  var db = await Db.create(Url);
  await db.open();
  inspect(db);

  var status = db.serverStatus();
  print(status);

  var collection = db.collection(collecitionName);

  print(await collection.find().toList());
}

}