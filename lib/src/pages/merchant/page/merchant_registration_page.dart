import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class MerchantRegistrationPage extends StatefulWidget {
  final String userId;

  MerchantRegistrationPage({@required this.userId});

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

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _merchantViewModel = Provider.of<MerchantRegistrationViewModel>(
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
                        buildEditText(emailController, "Email'"),
                        buildEditText(nameController, "Name'"),
                        buildEditText(locationController, "Location Name'"),
                        buildEditText(phoneController, "Phone No"),
                        buildEditText(taxNoController, "Tax No"),
                        buildEditText(regNoController, 'Registration No'),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Add Merchant'),
                              onPressed: () {
                                registerNow();
                              },
                            )),
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
                  onTap: () {
                  },
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
    var merchantRequest = Merchant(
        userId: widget.userId,
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
