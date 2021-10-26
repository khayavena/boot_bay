import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/entityaddress/viewmodel/entity_address_view_model.dart';
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Merchant Registration'),
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
      }
    });
  }

  Widget buildEditText(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
        decoration: new InputDecoration(
          enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54)),
          hintStyle: TextStyle(
            fontFamily: 'Gotham',
            color: Colors.black54,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          labelStyle: TextStyle(fontFamily: 'Gotham', color: Colors.black),
          hintText: text,
        ),
      ),
    );
  }

  void showAddress() {
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
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: locationController,
              style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
              onTap: () {
                showAddress();
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
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
            buildEditText(emailController, "Email'"),
            buildEditText(nameController, "Name'"),
            buildEditText(phoneController, "Phone No"),
            buildEditText(taxNoController, "Tax No"),
            buildEditText(regNoController, 'Registration No'),
            ElevatedButton(
              child: Text('Add Merchant'),
              onPressed: () {
                registerNow();
              },
            ),
          ],
        ));
  }
}
