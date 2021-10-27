import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/entityaddress/viewmodel/entity_address_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/pages/user/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:provider/provider.dart';

class MerchantRegistrationPage extends StatefulWidget {
  MerchantRegistrationPage();

  @override
  _MerchantRegistrationPageState createState() => _MerchantRegistrationPageState();
}

class _MerchantRegistrationPageState extends State<MerchantRegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  MerchantRegistrationViewModel _merchantViewModel;
  UserViewModel userViewModel;
  EntityAddressViewModel _entityAddressViewModel;
  ImageProviderViewModel _imageProviderViewModel;
  MediaContentViewModel _mediaContentViewModel;
  MapBoxPlace _mapBoxPlace;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _merchantViewModel = Provider.of<MerchantRegistrationViewModel>(
        context,
        listen: false,
      );
      userViewModel = Provider.of<UserViewModel>(
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
      _mediaContentViewModel = Provider.of<MediaContentViewModel>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor().appBackground,

        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: CustomColor().appBackground,
          title: Text(
            'Merchant Registration',
            style: TextStyle(
              color: CustomColor().black,
              fontSize: 15,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Container(
          child: Consumer<MerchantRegistrationViewModel>(
            builder: (BuildContext context, MerchantRegistrationViewModel value, Widget child) {
              switch (value.loader) {
                case Loader.idl:
                  return _buildBody();
                case Loader.error:
                  return Center(child: Text(value?.dataErrorMessage ?? 'Something is wrong'));
                  break;
                case Loader.busy:
                  return Center(child: ColorLoader5());
                  break;
                case Loader.complete:
                  _merchantViewModel?.resetLoader();
                  return _buildBody();
                  break;
              }
              return _buildBody();
            },
          ),
        ));
  }

  void registerNow() async {
    var user = await userViewModel.getCurrentUser();
    var merchantRequest = Merchant(
        userId: user.id,
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
        _entityAddressViewModel.updateSelectedAddress(value.id, _mapBoxPlace);
        await _entityAddressViewModel.saveAddress(_entityAddressViewModel.entityAddress);
        if (_imageProviderViewModel.isValidImage) {
          await _mediaContentViewModel.saveMerchantILogo(_imageProviderViewModel.path, value.id);
        }
      }
    });
  }

  Widget buildEditText(TextEditingController controller, String text, Icon suffixIcon) {
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

  void showActionDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // repository must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Search your address"),
          content: MapBoxPlaceSearchWidget(
            height: 600,
            popOnSelect: true,
            apiKey: moduleLocator<EnvConfig>().mapBoxKey,
            searchHint: 'Your Hint here',
            onSelected: (place) {
              if (place != null) {
                locationController.text = place.placeName;
                _mapBoxPlace = place;
              }
            },
            context: context,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            buildEditText(nameController, "Merchant Name", Icon(Icons.business_outlined)),
            buildEditText(emailController, "Email", Icon(Icons.email_outlined)),
            buildEditText(phoneController, "Contact no", Icon(Icons.phone)),
            buildEditText(taxNoController, "Tax reference(optional)", Icon(Icons.money_off_sharp)),
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
                  labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.black),
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
                child: Text('Add Merchant'),
                onPressed: () {
                  registerNow();
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child:
          Consumer<ImageProviderViewModel>(builder: (BuildContext context, ImageProviderViewModel value, Widget child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: value.proverFileImageView(),
        );
      }),
    );
  }

  void uploadImage() async {
    _imageProviderViewModel.openGalleryForImage();
  }
}
