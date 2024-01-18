// ignore_for_file: file_names, prefer_const_constructors

import 'package:admin_panel/utils/constant.dart';
import 'package:admin_panel/widgets/drawer-widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Admin Panel"),
      ),
      drawer: DrawerWidget(),
    );
  }
}
