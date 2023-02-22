import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_model.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

class screentransaction extends StatelessWidget {
  const screentransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactiondb.instance.refresh();

    categoryDB.instance.refershui();
    return ValueListenableBuilder(
      valueListenable: transactiondb.instance.transactionlistnotifier,
      builder: (BuildContext ctx, List<transactionmodel> newlist, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          //values
          itemBuilder: ((context, index) {
            final _value = newlist[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      transactiondb.instance.deletetransaction(_value.id!);
                    },
                    icon: Icons.delete,
                  )
                ],
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      parsedate(_value.date),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: _value.type == categorytype.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text("RS ${_value.amount}"),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return const SizedBox(height: 10);
          }),
          itemCount: newlist.length,
        );
      },
    );
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteddate = _date.split(' ');
    return '${_spliteddate.last}\n${_spliteddate.first}';

    // return '${date.day}\n${date.month}';
  }
}
