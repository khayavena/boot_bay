import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/pages/user/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../config/app_routing.dart';
import '../../../helpers/ResText.dart';

class MerchantRegistrationPage extends StatefulWidget {
  MerchantRegistrationPage();

  @override
  _MerchantRegistrationPageState createState() =>
      _MerchantRegistrationPageState();
}

class _MerchantRegistrationPageState extends State<MerchantRegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  late MerchantRegistrationViewModel _merchantViewModel;
  late UserViewModel userViewModel;

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

  void dispose() {
    _merchantViewModel.resetLoader();
    super.dispose();
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
            builder: (BuildContext context, MerchantRegistrationViewModel value,
                Widget? child) {
              if (value.status == Loader.busy) {
                return WidgetLoader();
              } else if (value.status == Loader.error) {
                return Center(child: Text(value.dataErrorMessage));
              } else if (value.status == Loader.idl) {
                return _buildBody();
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      ElevatedButton(
                          child: Text("Skip Image"),
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                                AppRouting.addAddressPage,
                                arguments: {
                                  "id": value.getMerchant.id,
                                  "type": "merchant",
                                  "name": value.getMerchant.name
                                });
                          }),
                      SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRouting.addImagePage, arguments: {
                              "id": value.getMerchant.id,
                              "type": "merchant",
                              "name": value.getMerchant.name
                            });
                          },
                          child: Text("Add Image")),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  void registerNow() async {
    final user = await userViewModel.getCurrentUser();
    final merchantRequest = Merchant.copy(
        userId: user.id ?? '',
        name: nameController.text,
        location: locationController.text,
        rating: 0,
        email: emailController.text,
        phone: phoneController.text,
        regNo: regNoController.text,
        taxNo: taxNoController.text);
    _merchantViewModel.register(merchantRequest);
  }

  Widget buildEditText(
      TextEditingController controller, String text, Icon suffixIcon) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontFamily: fontStyle()),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            fontFamily: fontStyle(),
            color: Colors.black54,
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),
          labelStyle: TextStyle(fontFamily: fontStyle(), color: Colors.black),
          hintText: text,
        ),
      ),
    );
  }

  Widget _buildBody() {
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
}
