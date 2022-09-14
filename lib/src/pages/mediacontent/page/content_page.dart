import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../config/app_routing.dart';
import '../../../helpers/ResText.dart';

final name = TextEditingController();
final description = TextEditingController();
final price = TextEditingController();

DateTime now = DateTime.now();

class ContentPage extends StatefulWidget {
  final String id;
  final String type;
  final String name;

  ContentPage(
      {Key? key, required this.id, required this.type, required this.name})
      : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late MediaViewModel _mediaContentViewModel;
  late ImageProviderViewModel _mediaViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mediaContentViewModel = Provider.of<MediaViewModel>(
        context,
        listen: false,
      );

      _mediaViewModel = Provider.of<ImageProviderViewModel>(
        context,
        listen: false,
      );
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
      backgroundColor: CustomColor().pureWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: CustomColor().black),
        backgroundColor: CustomColor().pureWhite,
        elevation: 0,
        title: Text(
          " Upload  ${widget.name}'s image",
          style: TextStyle(fontFamily: fontStyle(), color: CustomColor().black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.cancel, color: CustomColor().black),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Consumer2<MediaViewModel, ProductViewModel>(builder:
          (BuildContext context, MediaViewModel value,
              ProductViewModel productViewModel, Widget? child) {
        if (value.status == Loader.busy ||
            productViewModel.loader == Loader.busy) {
          return WidgetLoader();
        }
        return _buildBody();
      }),
    );
  }

  @override
  void dispose() {
    _mediaViewModel.clear();
    clear();
    super.dispose();
  }

  Widget _buildBody() {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Add an image".toUpperCase(),
              style: TextStyle(
                  fontFamily: fontStyle(), color: Colors.teal, fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<ImageProviderViewModel>(builder:
              (BuildContext context, ImageProviderViewModel value,
                  Widget? child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: value.proverFileImageView(),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: Text(
                "Upload".toUpperCase(),
                style: TextStyle(
                  fontFamily: fontStyle(),
                ),
              )),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () async {
              _mediaContentViewModel.saveImage(
                  _mediaViewModel.path, widget.id, widget.type);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Submit".toUpperCase(),
                      style: TextStyle(
                          fontFamily: fontStyle(), color: CustomColor().black)),
                ),
              ],
            ),
          ),
        ),
        buildAddressButton(),
      ],
    );
  }

  Widget buildAddressButton() {
    return widget.type == "product"
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () async {
                _mediaContentViewModel.saveImage(
                    _mediaViewModel.path, widget.id, widget.type);
                Navigator.of(context).pushNamed(AppRouting.addAddressPage,
                    arguments: {
                      "id": widget.id,
                      "type": widget.type,
                      "name": widget.name
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Add address".toUpperCase(),
                        style: TextStyle(
                            fontFamily: fontStyle(),
                            color: CustomColor().black)),
                  ),
                ],
              ),
            ),
          );
  }
}

void clear() {
  name.clear();
  description.clear();
  price.clear();
}
