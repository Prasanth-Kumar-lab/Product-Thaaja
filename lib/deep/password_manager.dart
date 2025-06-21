import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thaaja/deep/controller/password_controller.dart';

class passwordpage extends StatelessWidget {
  passwordpage({super.key});

  final PasswordController controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  'Password Manger',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: _buildPasswordField(
                        'Old Password', controller.oldPassword)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: _buildPasswordField(
                          'New Password', controller.newPassword)),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                // Changed to 50 for top padding
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: _buildPasswordField(
                      'Confirm Password', controller.confirmPassword),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 350, left: 10),
                  child: SizedBox(
                    width: 370,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: controller.changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Optional rounded corners
                        ),
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildPasswordField(String label, RxString password) {
  return Obx(
    () => SizedBox(
      width: 370,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.grey.shade300, // Add border color
          ),
        ),
        child: TextField(
          obscureText: password.isNotEmpty,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            // Removes the default border from TextField
            prefixIcon: Icon(CupertinoIcons.lock_fill,color: Colors.green,),
            suffixIcon: IconButton(
              icon: Icon(
                  password.isEmpty
                      ? Icons.visibility_outlined
                      : Icons.visibility_off,
                  color: Colors.green),
              onPressed: () {
                password.value = password.value.isEmpty ? 'visible' : '';
              },
            ),
          ),
          onChanged: (value) => password.value = value,
        ),
      ),
    ),
  );
}
