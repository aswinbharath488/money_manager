import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/screens/category/_expense_category_list.dart';
import 'package:money_manager_flutter/screens/category/income_category_list.dart';

class screencategory extends StatefulWidget {
  const screencategory({Key? key}) : super(key: key);

  @override
  State<screencategory> createState() => _screencategoryState();
}

class _screencategoryState extends State<screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categoryDB().refershui();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          tabs: [
            Tab(
              text: "INCOME",
            ),
            Tab(
              text: "EXPENSE",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              incomecategorylist(),
              expensecategorylist(),
            ],
          ),
        )
      ],
    );
  }
}
