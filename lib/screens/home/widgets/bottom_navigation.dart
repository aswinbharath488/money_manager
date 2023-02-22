// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';

class moneymanagerbottamnavigation extends StatelessWidget {
  const moneymanagerbottamnavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenhome.selectedindexnotifier,
      builder: (BuildContext ctx, int updatedindex, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedindex,
          onTap: (newindex) {
            screenhome.selectedindexnotifier.value = newindex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "transactions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "catagory"),
          ],
        );
      },
    );
  }
}
