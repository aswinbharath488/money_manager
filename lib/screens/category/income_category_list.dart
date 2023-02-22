import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

class incomecategorylist extends StatelessWidget {
  const incomecategorylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categoryDB().incomecategorylistlistener,
      builder: (BuildContext ctx, List<categorymodel> newlist, Widget? _) {
        return ListView.separated(
          itemBuilder: ((context, index) {
            final Category = newlist[index];
            return Card(
              child: ListTile(
                  title: Text(Category.name),
                  trailing: IconButton(
                    onPressed: () {
                      categoryDB.instance.deletecategory(Category.id);
                    },
                    icon: Icon(Icons.delete),
                  )),
            );
          }),
          separatorBuilder: ((context, index) {
            return const SizedBox(
              height: 10,
            );
          }),
          itemCount: newlist.length,
        );
      },
    );
  }
}
