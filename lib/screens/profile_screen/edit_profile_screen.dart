import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/save_button.dart';

import '../../services/user_database.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildUserInfoTextField(
              textEditingController: nameController,
              labelText: "Username",
              maxLength: 20,
              hinText: "example: John",
            ),
            const SizedBox(height: 30),
            buildUserInfoTextField(
              textEditingController: emailController,
              labelText: "Email",
              hinText: "example: John@gmail.com",
            ),
            const SizedBox(height: 30),
            buildSaveButton(
              onTap: () async {
                await _saveUserInfo();
                if (mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  TextField buildUserInfoTextField({
    required TextEditingController textEditingController,
    required String labelText,
    int? maxLength,
    String? hinText,
  }) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        labelText: labelText,
        hintText: hinText,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          color: Colors.black54,
        ),
      ),
      maxLength: maxLength,
    );
  }

  Future<void> _saveUserInfo() async {
    final String newName = nameController.text;
    final String newEmail = emailController.text;

    final Map<String, String>? userInfo = await UserInfoDatabase.getUserInfo();

    final String name = newName.isNotEmpty ? newName : userInfo?['name'] ?? '';
    final String email =
        newEmail.isNotEmpty ? newEmail : userInfo?['email'] ?? '';

    await UserInfoDatabase.saveUserInfo(name, email);

    print('User Info Saved: $userInfo');
  }
}
