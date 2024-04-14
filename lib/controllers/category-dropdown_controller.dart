// ignore_for_file: file_names, unnecessary_overrides, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDropDownController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<Map<String, dynamic>> categoriesList = [];

      querySnapshot.docs
          .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        categoriesList.add({
          'categoryId': document.id,
          'categoryName': document['categoryName'],
          'categoryImg': document['categoryImg'],
        });
      });

      categories.value = categoriesList;
      print(categories);
      update();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

//set selected category
  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print('selectedCategoryId $selectedCategoryId');
    update();
  }

  // Method to fetch category name based on category ID
  Future<String?> getCategoryName(String? categoryId) async {
    try {
      // Access Firestore collection and document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('categories')
          .doc(categoryId)
          .get();

      // Extract category name from snapshot
      if (snapshot.exists) {
        return snapshot.data()?['categoryName'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching category name: $e");
      return null;
    }
  }

  // set categoryName
  void setSelectedCategoryName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    print('selectedCategoryName $selectedCategoryName');
    update();
  }

  // set old value
  void setOldValue(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print('selectedCategoryId $selectedCategoryId');
    update();
  }
}
