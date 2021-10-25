import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Merchant Registration'),
        ),
        body: Consumer<MerchantRegistrationViewModel>(
          builder: (BuildContext context, MerchantRegistrationViewModel value, Widget child) {
            switch (value.loader) {
              case Loader.idl:
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Search your address"),
                                    content: MapBoxPlaceSearchWidget(
                                      popOnSelect: true,
                                      apiKey: moduleLocator<EnvConfig>().mapBoxKey,
                                      searchHint: 'Your Hint here',
                                      onSelected: (place) {
                                        if (place != null) {
                                          var p = place;
                                        }
                                      },
                                      context: context,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text("Address")),
                        buildEditText(emailController, "Email'"),
                        buildEditText(nameController, "Name'"),
                        buildEditText(locationController, "Location Name'"),
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
              case Loader.error:
                return Center(child: Text(value?.dataErrorMessage ?? 'Something is wrong'));
                break;
              case Loader.busy:
                return Center(child: ColorLoader5());
                break;
              case Loader.complete:
                _merchantViewModel?.resetLoader();
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 43,
                    decoration: BoxDecoration(
                      color: Color(0xff2783a9),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x7f103747),
                          offset: Offset(2, 2),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                );
                break;
            }
            return Container();
          },
        ));
  }

  void registerNow() async {
    var userId = userViewModel.getUser.id;
    var merchantRequest = Merchant(
        userId: userId,
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
    _merchantViewModel.register(merchantRequest);
  }

  Widget buildEditText(TextEditingController controller, String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}
