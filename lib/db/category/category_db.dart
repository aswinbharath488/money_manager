

import 'package:flutter/cupertino.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_flutter/screens/category/income_category_list.dart';

const CATGEORY_DB_NAME = "catgeory_database";

abstract class categorydbfunction {
  Future<List<categorymodel>> getcategories();
  Future<void> insertcategory(categorymodel value);
  Future<void> deletecategory(String categoryID);
}

class categoryDB implements categorydbfunction {
  categoryDB._internal();

  static categoryDB instance = categoryDB._internal();
  factory categoryDB() {
    return instance;
  }

  ValueNotifier<List<categorymodel>> incomecategorylistlistener =
      ValueNotifier([]);
  ValueNotifier<List<categorymodel>> expensecategorylistlistener =
      ValueNotifier([]);

  @override
  Future<void> insertcategory(categorymodel value) async {
    final _catgerorydb = await Hive.openBox<categorymodel>(CATGEORY_DB_NAME);
    await _catgerorydb.put(value.id, value);
    refershui();
  }

  @override
  Future<List<categorymodel>> getcategories() async {
    final _catgerorydb = await Hive.openBox<categorymodel>(CATGEORY_DB_NAME);
    return _catgerorydb.values.toList();
  }

  Future<void> refershui() async {
    final _allcategory = await getcategories();
    incomecategorylistlistener.value.clear();
    expensecategorylistlistener.value.clear();
    await Future.forEach(
      _allcategory,
      (categorymodel category) {
        if (category.type == categorytype.income) {
          incomecategorylistlistener.value.add(category);
        } else {
          expensecategorylistlistener.value.add(category);
        }
      },
    );

    incomecategorylistlistener.notifyListeners();
    expensecategorylistlistener.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final categoryDB = await Hive.openBox<categorymodel>(CATGEORY_DB_NAME);
    categoryDB.delete(categoryID);
    refershui();
  }
}
