// ignore_for_file: file_names, must_be_immutable

import 'package:admin_panel/utils/constant.dart';
import 'package:flutter/material.dart';

class SpecificCustomerOrderScreen extends StatelessWidget {
  String docId;
  String customerName;
  SpecificCustomerOrderScreen({
    super.key,
    required this.docId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(customerName),
      ),
    );
  }
}
