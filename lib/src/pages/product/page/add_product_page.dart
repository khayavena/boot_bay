import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

final place = TextEditingController();
final item = TextEditingController();
final description = TextEditingController();
final price = TextEditingController();

DateTime now = DateTime.now();

class AddProductPage extends StatefulWidget {
  final Merchant merchant;
  final Category category;

  AddProductPage({Key key, this.merchant, this.category}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String _imageUrl;
  MediaContentViewModel _mediaContentViewModel;
  CategoryViewModel _categoryViewModel;
  MediaViewModel _mediaViewModel;
  ProductViewModel _productViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mediaContentViewModel = Provider.of<MediaContentViewModel>(
        context,
        listen: false,
      );
      _categoryViewModel = Provider.of<CategoryViewModel>(
        context,
        listen: false,
      );
      _mediaViewModel = Provider.of<MediaViewModel>(
        context,
        listen: false,
      );
      _productViewModel = Provider.of<ProductViewModel>(
        context,
        listen: false,
      );
      _categoryViewModel.getCategoriesById(widget.merchant.id);
    });
    super.initState();
  }

  uploadImage() async {
    _mediaViewModel.openGalleryForImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor().appBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: CustomColor.cta_blue),
        backgroundColor: CustomColor().appBackground,
        elevation: 0,
        title: Text(
          widget.merchant.name.toUpperCase(),
          style: TextStyle(fontFamily: 'Gotham', color: CustomColor().black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.cancel, color: CustomColor().black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: place,
              style: TextStyle(color: Colors.pink, fontFamily: 'Gotham'),
              decoration: new InputDecoration(
                enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
                hintStyle: TextStyle(
                  fontFamily: 'Gotham',
                  color: Colors.black54,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.pink),
                hintText: 'Pickup where?',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: item,
              style: TextStyle(color: Colors.pink, fontFamily: 'Gotham'),
              decoration: new InputDecoration(
                enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
                hintStyle: TextStyle(
                  fontFamily: 'Gotham',
                  color: Colors.black54,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.pink),
                hintText: 'Item(s)',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: description,
              style: TextStyle(color: Colors.pink, fontFamily: 'Gotham'),
              decoration: new InputDecoration(
                enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
                hintStyle: TextStyle(
                  fontFamily: 'Gotham',
                  color: Colors.black54,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.pink),
                hintText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: price,
              style: TextStyle(color: Colors.pink, fontFamily: 'Gotham'),
              decoration: new InputDecoration(
                enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
                hintStyle: TextStyle(
                  fontFamily: 'Gotham',
                  color: Colors.black54,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.pink),
                hintText: 'Price(USD)',
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Add an image".toUpperCase(),
                style: TextStyle(fontFamily: 'Gotham', color: Colors.pink, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: (_imageUrl != null) ? Image.network(_imageUrl) : Image.network('https://i.imgur.com/sUFH1Aq.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text(
                  "Upload".toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Gotham',
                  ),
                )),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: CustomColor().darkBlue)),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  color: CustomColor().pureWhite,
                  textColor: CustomColor().black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Submit".toUpperCase(),
                            style: TextStyle(fontFamily: 'Gotham', color: CustomColor().black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void clear() {
  place.clear();
  item.clear();
  description.clear();
  price.clear();
}
