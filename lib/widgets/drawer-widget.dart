// ignore_for_file: file_names, sort_child_properties_last, prefer_const_constructors, unused_local_variable, must_be_immutable, avoid_print, unnecessary_string_interpolations, deprecated_member_use, unused_element, unnecessary_null_comparison
import 'package:admin_panel/screens/all-users-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/all-orders-screen.dart';
import '../screens/all-products-screen.dart';
import '../screens/all_categories_screen.dart';
import '../screens/main-screen.dart';
import '../utils/constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final GoogleSignInController googleSignInController =
  //     Get.put(GoogleSignInController());

  String userName = 'User';
  String firstLetter = 'U';

  // Future<dynamic> getUserData() async {
  //   if (user != null) {
  //     final DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid.toString())
  //         .get();

  //     UserModel userModel =
  //         UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  //     userName = userModel.username;
  //     firstLetter = userModel.username[0];
  //     setState(() {});

  //     print(userName);
  //   } else {}
  // }

  @override
  void initState() {
    super.initState();

    // if (user != null) {
    //   getUserData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        )),
        child: Wrap(
          runSpacing: 10,
          children: [
            user != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        userName.toString(),
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      subtitle: Text(
                        AppConstant.appVersion,
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        radius: 22.0,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text(
                          firstLetter,
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Guest",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      subtitle: Text(
                        AppConstant.appVersion,
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        radius: 22.0,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text(
                          "G",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ),
                    ),
                  ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.offAll(() => MainScreen());
                },
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllUsersScreen());
                },
                title: Text(
                  'Users',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllOrdersScreen());
                },
                title: Text(
                  'Orders',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.back();
                  Get.to(() => AllProductsScreen());
                },
                title: Text(
                  'Products',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                onTap: () async {
                  Get.back();

                  Get.to(() => AllCategoriesScreen());
                },
                title: Text(
                  'Categories',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.category,
                  color: Colors.white,
                ),
              ),
            ),
            if (user != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  onTap: () {
                    // Get.back();
                    // Get.to(() => CustomerReviews());
                  },
                  title: Text(
                    'Customer Reviews',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.reviews_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  // Get.to(() => ContactScreen());
                },
                title: Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  // if (user != null) {
                  //   EasyLoading.show();
                  //   await FirebaseAuth.instance.signOut();
                  //   await _googleSignIn.signOut();
                  //   Get.offAll(() => MainScreen());
                  //   EasyLoading.dismiss();
                  // } else {
                  //   Get.back();
                  //   await googleSignInController.signInWithGoogle();
                  // }
                },
                title: Text(
                  user != null ? 'Logout' : 'Login',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  user != null ? Icons.logout : Icons.login,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        width: Get.width - 80.0,
        backgroundColor: AppConstant.appScendoryColor,
        // backgroundColor: Colors.grey.shade900,
      ),
    );
  }

  // send whatsapp message
  // static Future<void> sendMessage() async {
  //   final phoneNumber = AppConstant.whatsAppNumber;
  //   final message =
  //       "Hello *${AppConstant.appMainName}*"; // Replace with your message

  //   final url =
  //       'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
