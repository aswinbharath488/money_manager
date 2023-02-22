import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_flutter/db/transactions/transaction_model.dart';

final TRANSACTION_DB_NAME = 'transaction-db';

abstract class transactiondbfunction {
  Future<void> addtransaction(transactionmodel obj);
  Future<List<transactionmodel>> getalltransaction();
  Future<void> deletetransaction(String id);
}

class transactiondb implements transactiondbfunction {
  transactiondb._internal();
  static transactiondb instance = transactiondb._internal();

  factory transactiondb() {
    return instance;
  }
  ValueNotifier<List<transactionmodel>> transactionlistnotifier =
      ValueNotifier([]);

  @override
  Future<void> addtransaction(transactionmodel obj) async {
    final _db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getalltransaction();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistnotifier.value.clear();
    transactionlistnotifier.value.addAll(_list);
    transactionlistnotifier.notifyListeners();
  }

  @override
  Future<List<transactionmodel>> getalltransaction() async {
    final _db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deletetransaction(String id) async {
    final _db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
