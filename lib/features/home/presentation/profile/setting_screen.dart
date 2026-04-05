import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },icon: const Icon(Icons.arrow_back, )),
                  const Icon(Icons.search, ),
                ],
              ),

              const SizedBox(height: 20),

              /// Title
              Text("Settings", style: AppTextStyles.headline),

              const SizedBox(height: 15),

              /// Personal Information
              Text("Personal Information", style: AppTextStyles.headline3),

              const SizedBox(height: 30),

              AuthTextField(hint: "Full name", controller: nameController),

              const SizedBox(height: 15),

              AuthTextField(hint: "Date Of Birth", controller: dateController),

              const SizedBox(height: 30),

              /// Password Section
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.forgetPassword);
                },
                child: Text(
                  "Password Change",
                  style: TextStyle( fontSize: 16),
                ),
              ),

              const SizedBox(height: 15),


              const SizedBox(height: 30),

              /// Notifications
              Row(
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle( fontSize: 16),
                  ),
                  Spacer(),
                  _buildSwitch(true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch(bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Switch(
        value: value,
        onChanged: (v) {},
        activeThumbColor: Colors.green,
        inactiveThumbColor: Colors.grey,
      ),
    );
  }
}
