// ignore_for_file: avoid_unnecessary_containers

import 'package:admin_panel/controllers/edit_category_controller.dart';
import 'package:admin_panel/models/categories_model.dart';
import 'package:admin_panel/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'add_category_screen.dart';
import 'edit_category_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("All Categories"),
        actions: [
          InkWell(
            onTap: () => Get.to(() => const AddCategoriesScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('categories')
            // .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: const Center(
                child: Text('Error occurred while fetching category!'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: const Center(
                child: Text('No category found!'),
              ),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: data['categoryId'],
                  categoryName: data['categoryName'],
                  categoryImg: data['categoryImg'],
                  createdAt: data['createdAt'],
                  updatedAt: data['updatedAt'],
                );

                return SwipeActionCell(
                  key: ObjectKey(categoriesModel.categoryId),

                  /// this key is necessary
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        title: "Delete",
                        onTap: (CompletionHandler handler) async {
                          await Get.defaultDialog(
                            title: "Delete Product",
                            content: const Text(
                                "Are you sure you want to delete this product?"),
                            textCancel: "Cancel",
                            textConfirm: "Delete",
                            contentPadding: const EdgeInsets.all(10.0),
                            confirmTextColor: Colors.white,
                            onCancel: () {},
                            onConfirm: () async {
                              Get.back(); // Close the dialog
                              EasyLoading.show(status: 'Please wait..');
                              EditCategoryController editCategoryController =
                                  Get.put(EditCategoryController(
                                      categoriesModel: categoriesModel));

                              await editCategoryController
                                  .deleteImagesFromStorage(
                                      categoriesModel.categoryImg);

                              await editCategoryController
                                  .deleteWholeCategoryFromFireStore(
                                      categoriesModel.categoryId);
                              EasyLoading.dismiss();
                            },
                            buttonColor: Colors.red,
                            cancelTextColor: Colors.black,
                          );
                        },
                        color: Colors.red),
                  ],
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appScendoryColor,
                        backgroundImage: CachedNetworkImageProvider(
                          categoriesModel.categoryImg.toString(),
                          errorListener: (err) {
                            // Handle the error here
                            print('Error loading image');
                            const Icon(Icons.error);
                          },
                        ),
                      ),
                      title: Text(categoriesModel.categoryName),
                      subtitle: Text(categoriesModel.categoryId),
                      trailing: GestureDetector(
                          onTap: () => Get.to(
                                () => EditCategoryScreen(
                                    categoriesModel: categoriesModel),
                              ),
                          child: const Icon(Icons.edit)),
                    ),
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
