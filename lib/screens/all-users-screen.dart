// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:admin_panel/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get-all-user-length-controller.dart';
import '../models/user-model.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final GetUserLengthController _getUserLengthController =
      Get.put(GetUserLengthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
              'Users (${_getUserLengthController.userCollectionLength.toString()})');
        }),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdOn', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching category!'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No users found!'),
              ),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                UserModel userModel = UserModel(
                  uId: data['uId'],
                  username: data['username'],
                  email: data['email'],
                  phone: data['phone'],
                  userImg: data['userImg'],
                  userDeviceToken: data['userDeviceToken'],
                  country: data['country'],
                  userAddress: data['userAddress'],
                  street: data['street'],
                  isAdmin: data['isAdmin'],
                  isActive: data['isActive'],
                  createdOn: data['createdOn'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    // onTap: () => Get.to(
                    //   () => SpecificCustomerOrderScreen(
                    //       docId: snapshot.data!.docs[index]['uId'],
                    //       customerName: snapshot.data!.docs[index]
                    //           ['customerName']),
                    // ),

                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appScendoryColor,
                      backgroundImage: CachedNetworkImageProvider(
                        userModel.userImg,
                        errorListener: (err) {
                          // Handle the error here
                          print('Error loading image');
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(userModel.username),
                    subtitle: Text(userModel.email),
                    trailing: Icon(Icons.edit),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
