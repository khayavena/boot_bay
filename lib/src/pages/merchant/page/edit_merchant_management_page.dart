import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/ResText.dart';
import '../../mediacontent/page/content_page.dart';

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
  TextEditingController phoneController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  @override
  void initState() {
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
          child: Consumer<MerchantRegistrationViewModel>(
            builder: (BuildContext context, MerchantRegistrationViewModel value,
                Widget? child) {
              if (value.status == Loader.busy) {
                return WidgetLoader();
              } else if (value.status == Loader.error) {
                return Center(child: Text(value.dataErrorMessage));
              } else if ((value.status == Loader.idl)) {
                return Center(child: _buildBody());
              } else {
                return Container(
                    child: ContentPage(
                        id: widget.merchant.id ?? '',
                        type: "merchant",
                        name: widget.merchant.name));
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    Provider.of<MerchantRegistrationViewModel>(
      context,
      listen: false,
    ).resetLoader();
    super.dispose();
  }

  void updateMerchant() async {
    var merchantRequest = Merchant.copy(
        userId: widget.merchant.userId,
        name: nameController.text,
        rating: 0,
        email: emailController.text,
        phone: phoneController.text,
        regNo: regNoController.text,
        taxNo: taxNoController.text);
    await Provider.of<MerchantRegistrationViewModel>(
      context,
      listen: false,
    ).register(merchantRequest);
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

  void initValues() {
    emailController.text = widget.merchant.email;
    nameController.text = widget.merchant.name;
    phoneController.text = widget.merchant.phone;
    taxNoController.text = widget.merchant.taxNo;
    regNoController.text = widget.merchant.regNo;
  }
}
