import 'package:flutter/material.dart';

import '../../../config/app_routing.dart';
import '../../../helpers/ResText.dart';
import '../viewmodel/product_view_model.dart';

class ProductSuccessWidget extends StatelessWidget {
  final ProductViewModel vm;

  const ProductSuccessWidget({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Successful added ${vm.getProduct.name}".toUpperCase(),
            style: TextStyle(
                fontFamily: fontStyle(), color: Colors.teal, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              vm.reset();
            },
            child: Text(
              "Add Product".toUpperCase(),
              style: TextStyle(
                  fontFamily: fontStyle(), color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRouting.addImagePage, arguments: {
                "id": vm.getProduct.id,
                "type": "product",
                "name": vm.getProduct.name,
              });
            },
            child: Text(
              "Add an image".toUpperCase(),
              style: TextStyle(
                  fontFamily: fontStyle(), color: Colors.amber, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
