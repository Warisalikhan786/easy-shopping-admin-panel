// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:admin_panel/screens/sign-in-screen.dart';
import 'package:admin_panel/utils/constant.dart';
import 'package:admin_panel/widgets/drawer-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/charts_controllers/chart_order_controller.dart';
import '../models/charts/chart_order_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAllOrdersChart getAllOrdersChart = Get.put(GetAllOrdersChart());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Admin Panel"),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => SignInScreen());
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
          children: [
            Obx(() {
              final monthlyData = getAllOrdersChart.monthlyOrderData;
              if (monthlyData.isEmpty) {
                return Container(
                  height: Get.height / 2,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else {
                return SizedBox(
                  height: Get.height / 2,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryXAxis: CategoryAxis(arrangeByIndex: true),
                    series: <LineSeries<ChartData, String>>[
                      LineSeries<ChartData, String>(
                        dataSource: monthlyData,
                        width: 2.5,
                        color: AppConstant.appMainColor,
                        xValueMapper: (ChartData data, _) => data.month,
                        yValueMapper: (ChartData data, _) => data.value,
                        name: "Monthly Orders",
                        markerSettings: MarkerSettings(isVisible: true),
                      )
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
