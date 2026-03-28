import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../domain/entity/address_model.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.translate("shipping_address")),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                AuthTextField(
                  hint: locale.translate("name"),
                  controller: nameController,
                ),
                AuthTextField(
                  hint: locale.translate("address"),
                  controller: addressController,
                ),
                AuthTextField(
                  hint: locale.translate("city"),
                  controller: cityController,
                ),
                AuthTextField(
                  hint: locale.translate("country"),
                  controller: countryController,
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 60,
                  child: AuthButton(
                    text: locale.translate("save_address"),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        AddressModel(
                          name: nameController.text,
                          address: addressController.text,
                          city: cityController.text,
                          country: countryController.text,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
