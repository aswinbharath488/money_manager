import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager_flutter/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:money_manager_flutter/screens/category/category_add_popup.dart';
import 'package:money_manager_flutter/screens/category/screen_category.dart';
import 'package:money_manager_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_flutter/screens/transactions/screen_transaction.dart';

class screenhome extends StatelessWidget {
  screenhome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);
  final _pages = [
    screentransaction(),
    screencategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("MONEY MANAGER"),
        centerTitle: true,
      ),
      bottomNavigationBar: const moneymanagerbottamnavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexnotifier,
          builder: (BuildContext context, int updatedindex, _) {
            return _pages[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedindexnotifier.value == 0) {
            print("add transactions");

            Navigator.of(context).pushNamed(screenaddtransaction.routname);
          } else {
            showcategoryaddpopup(context);

            print("add category");
            // final _sample = categorymodel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: "travel",
            //   type: categorytype.expense,
            // );

            // categoryDB().insertcategory(_sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
