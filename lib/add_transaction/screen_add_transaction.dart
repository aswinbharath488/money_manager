import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_model.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

class screenaddtransaction extends StatefulWidget {
  static const routname = "add-transaction";
  const screenaddtransaction({Key? key}) : super(key: key);

  @override
  State<screenaddtransaction> createState() => _screenaddtransactionState();
}

class _screenaddtransactionState extends State<screenaddtransaction> {
  DateTime? _selecteddate;
  categorytype? _selectedcategorytype;
  categorymodel? _selectedcategorymodel;
  String? _categoryID;

  final _purposetexteditingcontroller = TextEditingController();
  final _amounttexteditingcontroller = TextEditingController();

  @override
  void initState() {
    _selectedcategorytype = categorytype.income;
    super.initState();
  }

  /*
  purpose
  date
  amount
  income/expense
  categorytype
    */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //purpose
            TextFormField(
              controller: _purposetexteditingcontroller,
              decoration: InputDecoration(
                hintText: "purpose",
              ),
            ),
            //amount
            TextFormField(
              controller: _amounttexteditingcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "amount",
              ),
            ),
            //calender

            TextButton.icon(
              onPressed: () async {
                final _selecteddatetemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selecteddatetemp == null)
                  return;
                else {
                  print(_selecteddatetemp.toString());
                  setState(() {
                    _selecteddate = _selecteddatetemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selecteddate == null
                  ? "select date"
                  : _selecteddate.toString()),
            ),

            //category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: categorytype.income,
                      groupValue: _selectedcategorytype,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedcategorytype = categorytype.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text("income"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: categorytype.expense,
                      groupValue: _selectedcategorytype,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedcategorytype = categorytype.expense;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text("expense"),
                  ],
                ),
              ],
            ),
            //category type
            DropdownButton<String>(
              value: _categoryID,
              hint: const Text("select category"),
              items: (_selectedcategorytype == categorytype.income
                      ? categoryDB().incomecategorylistlistener
                      : categoryDB().expensecategorylistlistener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedcategorymodel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedvalue) {
                print(selectedvalue);
                setState(() {
                  _categoryID = selectedvalue;
                });
              },
            ),
            //submit
            ElevatedButton(
              onPressed: () {
                addtransction();
              },
              child: Text("submit"),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addtransction() async {
    final _purposetext = _purposetexteditingcontroller.text;
    final _amounttext = _amounttexteditingcontroller.text;
    if (_purposetext.isEmpty) {
      return;
    }
    if (_amounttext.isEmpty) {
      return;
    }
    // if (_categoryID == null) {
    //   return;
    // }
    if (_selecteddate == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }
    final _parseamount = double.tryParse(_amounttext);
    if (_parseamount == null) {
      return;
    }

    // _selecteddate
    // _selectedcategorytype
    // _categoryID

    final _model = transactionmodel(
      purpose: _purposetext,
      amount: _parseamount,
      date: _selecteddate!,
      type: _selectedcategorytype!,
      category: _selectedcategorymodel!,
    );                      

    await transactiondb.instance.addtransaction(_model);
    Navigator.of(context).pop();
    transactiondb.instance.refresh();
  }
}
