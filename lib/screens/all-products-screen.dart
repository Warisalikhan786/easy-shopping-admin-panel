// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:admin_panel/models/product-model.dart';
import 'package:admin_panel/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add-products-screen.dart';
import 'product-detail-screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => AddProductScreen()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
        backgroundColor: AppConstant.appMainColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching products!'),
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
                child: Text('No products found!'),
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

                ProductModel productModel = ProductModel(
                  productId: data['productId'],
                  categoryId: data['categoryId'],
                  productName: data['productName'],
                  categoryName: data['categoryName'],
                  salePrice: data['salePrice'],
                  fullPrice: data['fullPrice'],
                  productImages: data['productImages'],
                  deliveryTime: data['deliveryTime'],
                  isSale: data['isSale'],
                  productDescription: data['productDescription'],
                  createdAt: data['createdAt'],
                  updatedAt: data['updatedAt'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Get.to(() => SingleProductDetailScreen(
                          productModel: productModel));
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appScendoryColor,
                      backgroundImage: CachedNetworkImageProvider(
                        productModel.productImages[0],
                        errorListener: (err) {
                          // Handle the error here
                          print('Error loading image');
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(productModel.productName),
                    subtitle: Text(productModel.productId),
                    trailing: Icon(Icons.arrow_forward_ios),
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
