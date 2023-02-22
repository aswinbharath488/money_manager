import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

ValueNotifier<categorytype> selectedcategorNotifier =
    ValueNotifier(categorytype.income);
Future<void> showcategoryaddpopup(BuildContext context) async {
  final _nameditingcontroller = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: Text("add category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameditingcontroller,
              decoration: InputDecoration(
                hintText: "category name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                radiobutton(
                  title: "income",
                  type: categorytype.income,
                ),
                radiobutton(
                  title: "expense",
                  type: categorytype.expense,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameditingcontroller.text;
                if (_name.isEmpty) {
                  return;
                } else {
                  final _type = selectedcategorNotifier.value;
                  final _category = categorymodel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type,
                  );

                  categoryDB().insertcategory(_category);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text("add"),
            ),
          )
        ],
      );
    },
  );
}

class radiobutton extends StatelessWidget {
  final String title;
  final categorytype type;

  const radiobutton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcategorNotifier,
            builder:
                (BuildContext context, categorytype newcategory, Widget? _) {
              return Radio<categorytype>(
                value: type,
                groupValue: newcategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedcategorNotifier.value = value;
                  selectedcategorNotifier.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}
