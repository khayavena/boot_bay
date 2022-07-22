import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/entityaddress/viewmodel/entity_address_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:provider/provider.dart';

class EditMerchantManagementPage extends StatefulWidget {
  final Merchant merchant;

  EditMerchantManagementPage({required this.merchant});

  @override
  _EditMerchantManagementPageState createState() =>
      _EditMerchantManagementPageState();
}

class _EditMerchantManagementPageState
    extends State<EditMerchantManagementPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  late MerchantRegistrationViewModel _merchantViewModel;

  MapBoxPlace? _mapBoxPlace;

  late EntityAddressViewModel _entityAddressViewModel;

  late ImageProviderViewModel _imageProviderViewModel;

  late MediaViewModel _mediaViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _merchantViewModel = Provider.of<MerchantRegistrationViewModel>(
        context,
        listen: false,
      );
      _entityAddressViewModel = Provider.of<EntityAddressViewModel>(
        context,
        listen: false,
      );
      _imageProviderViewModel = Provider.of<ImageProviderViewModel>(
        context,
        listen: false,
      );
      _mediaViewModel = Provider.of<MediaViewModel>(
        context,
        listen: false,
      );
      _entityAddressViewModel.getAll(widget.merchant.id);
    });

    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor().pureWhite,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          iconTheme: IconThemeData(color: CustomColor().black),
          backgroundColor: CustomColor().pureWhite,
          title: Text(
            'Update Merchant',
            style: TextStyle(
              color: CustomColor().black,
              fontSize: 15,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Container(
          child: Consumer3<MerchantRegistrationViewModel, MediaViewModel,
              EntityAddressViewModel>(
            builder: (BuildContext context,
                MerchantRegistrationViewModel value,
                MediaViewModel value1,
                EntityAddressViewModel value2,
                Widget? child) {
              if (value.status == Loader.busy ||
                  value1.status == Loader.busy ||
                  value2.status == Loader.busy) {
                return WidgetLoader();
              } else if (value.status == Loader.error ||
                  value1.status == Loader.error ||
                  value2.status == Loader.error) {
                return Center(child: Text(value.dataErrorMessage));
              } else {
                updateAddressField(value2.entityAddress.address);
                return _buildBody(value2);
              }
            },
          ),
        ));
  }

  void updateMerchant() async {
    var merchantRequest = Merchant(
        id: widget.merchant.id,
        userId: widget.merchant.userId,
        name: nameController.text,
        location: locationController.text,
        rating: 0,
        logoUrl: "",
        email: emailController.text,
        phone: phoneController.text,
        lastUpdate: DateTime.now().toString(),
        createDate: DateTime.now().toString(),
        regNo: regNoController.text,
        taxNo: taxNoController.text);
    await _merchantViewModel.register(merchantRequest).then((value) async {
      if (_mapBoxPlace != null) {
        _entityAddressViewModel.updateSelectedAddress(
            value.id,
            _mapBoxPlace?.placeName ?? "",
            _mapBoxPlace?.geometry?.coordinates![0] ?? 0,
            _mapBoxPlace?.geometry?.coordinates![1] ?? 0,
            'merchant');
        await _entityAddressViewModel
            .saveAddress(_entityAddressViewModel.entityAddress);
        if (_imageProviderViewModel.isValidImage) {
          await _mediaViewModel.saveMerchantILogo(
              _imageProviderViewModel.path, value.id);
        }
      }
    });
  }

  Widget _buildBody(EntityAddressViewModel addressViewModel) {
    locationController.text = addressViewModel.entityAddress.address;
    return Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            buildEditText(
                nameController, "Merchant Name", Icon(Icons.business_outlined)),
            buildEditText(emailController, "Email", Icon(Icons.email_outlined)),
            buildEditText(phoneController, "Contact no", Icon(Icons.phone)),
            buildEditText(taxNoController, "Tax reference(optional)",
                Icon(Icons.money_off_sharp)),
            buildEditText(
              regNoController,
              'Reg no(optional)',
              Icon(Icons.copyright_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: TextFormField(
                controller: locationController,
                style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
                onTap: () {
                  showActionDialog();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on_outlined),
                  hintStyle: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                  ),
                  labelStyle:
                      TextStyle(fontFamily: 'Gotham', color: Colors.black),
                  hintText: "Merchant address",
                ),
              ),
            ),
            _buildImage(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ElevatedButton(
                child: Text('Update Merchant'),
                onPressed: () {
                  updateMerchant();
                },
              ),
            ),
          ],
        ));
  }

  Widget buildEditText(
      TextEditingController controller, String text, Icon suffixIcon) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            fontFamily: 'Gotham',
            color: Colors.black54,
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),
          labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.black),
          hintText: text,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Consumer<ImageProviderViewModel>(builder:
          (BuildContext context, ImageProviderViewModel value, Widget? child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: value.proverFileImageView(
              imageUrl: getImageUri(widget.merchant.id)),
        );
      }),
    );
  }

  void uploadImage() async {
    _imageProviderViewModel.openGalleryForImage();
  }

  void showActionDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // repository must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Search your address"),
          content: MapBoxAutoCompleteWidget(
            closeOnSelect: true,
            apiKey: moduleLocator<EnvConfig>().mapBoxKey,
            hint: 'Enter your address',
            onSelect: (place) {
              locationController.text = place.placeName!;
              _mapBoxPlace = place;
            },
          ),
        );
      },
    );
  }

  updateAddressField(String value) {
    locationController.text = value;
  }

  void initValues() {
    emailController.text = widget.merchant.email;
    nameController.text = widget.merchant.name;
    locationController.text = widget.merchant.location;
    phoneController.text = widget.merchant.phone;
    taxNoController.text = widget.merchant.taxNo;
    regNoController.text = widget.merchant.regNo;
  }
}
