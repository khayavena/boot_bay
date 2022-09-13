import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../helpers/ResText.dart';
import '../../../model/entity_address.dart';
import '../viewmodel/entity_address_view_model.dart';
import '../widget/address_picker_widget.dart';

class EntityAddressPage extends StatefulWidget {
  final String id;
  final String type;
  final String name;

  EntityAddressPage(
      {Key? key, required this.id, required this.type, required this.name})
      : super(key: key);

  @override
  _EntityAddressPageState createState() => _EntityAddressPageState();
}

class _EntityAddressPageState extends State<EntityAddressPage> {
  late EntityAddressViewModel _addressViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _addressViewModel = Provider.of<EntityAddressViewModel>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  void onSelected(final EntityAddress saveAddress) {
    _addressViewModel.setAddress(saveAddress);
  }

  uploadEntityAddress() async {
    _addressViewModel.saveAddress(_addressViewModel.entityAddress);
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
          "${widget.name}'s Address",
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
      body: Consumer<EntityAddressViewModel>(builder:
          (BuildContext context, EntityAddressViewModel value, Widget? child) {
        switch (value.status) {
          case Loader.error:
            return Center(child: Text(value.dataErrorMessage));
          case Loader.busy:
            return WidgetLoader();
          case Loader.complete:
            return Center(
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  "Done".toUpperCase(),
                  style: TextStyle(
                    fontFamily: fontStyle(),
                  ),
                ),
              ),
            );
          case Loader.idl:
            return Column(
              children: [
                AddressPickerWidget(
                  onSelected: onSelected,
                  parentId: widget.id,
                ),
                ElevatedButton(
                    onPressed: () {
                      uploadEntityAddress();
                    },
                    child: Text(
                      "Save Address".toUpperCase(),
                      style: TextStyle(
                        fontFamily: fontStyle(),
                      ),
                    ))
              ],
            );
        }
      }),
    );
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  void clear() {
    _addressViewModel.clear();
  }
}
