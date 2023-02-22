import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_flutter/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_model.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';

Future<void> main() async {
  final obj1 = categoryDB();
  final obj2 = categoryDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }

  if (!Hive.isAdapterRegistered(categorymodelAdapter().typeId)) {
    Hive.registerAdapter(categorymodelAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionmodelAdapter().typeId)) {
    Hive.registerAdapter(transactionmodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: screenhome(),
      routes: {
        screenaddtransaction.routname: (ctx) => const screenaddtransaction(),
      },
    );
  }
}
