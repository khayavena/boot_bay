import 'package:bootbay/src/model/entity_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

import '../../../config/EnvConfig.dart';
import '../../../di/boot_bay_module_locator.dart';
import '../../../helpers/ResText.dart';
import '../../../helpers/custom_color.dart';

class AddressPickerWidget extends StatefulWidget {
  final void Function(EntityAddress saveAddress) onSelected;
  final String parentId;
  final String type;

  AddressPickerWidget(
      {required this.onSelected, required this.parentId, required this.type});

  @override
  State<AddressPickerWidget> createState() => _AddressPickerWidgetState();
}

class _AddressPickerWidgetState extends State<AddressPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return buildSheet(context);
  }

  final _startPointController = TextEditingController();
  final addressText = TextEditingController();

  Widget buildSheet(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          CustomTextField(
            hintText: "Enter address",
            textController: _startPointController,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapBoxAutoCompleteWidget(
                    apiKey: moduleLocator<EnvConfig>().mapBoxKey,
                    hint: "Select starting point",
                    onSelect: (place) {
                      final address = EntityAddress.copy(
                          parentId: widget.parentId,
                          type: widget.type,
                          address: place.placeName ?? '',
                          latitude: place.geometry?.coordinates?.first ?? 0,
                          longitude: place.geometry?.coordinates?.last ?? 0);
                      widget.onSelected.call(address);
                      setState(() {
                        addressText.text = address.address;
                      });
                    },
                    limit: 10,
                  ),
                ),
              );
            },
            enabled: true,
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Selected Address",
              style: TextStyle(
                fontFamily: fontStyle(),
                color: CustomColor().black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 16),
          CustomTextField(
            hintText: "Enter address",
            maxLines: 10,
            textController: addressText,
            onTap: () {},
            enabled: true,
          )
        ],
      ),
    );
  }
}
