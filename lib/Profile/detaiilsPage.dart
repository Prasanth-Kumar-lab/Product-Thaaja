import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart'as p;
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var dob = ''.obs;
  var phoneNumber = ''.obs;
  var gender = ''.obs;
  var profileImage = ''.obs;
  var isEditing = false.obs;
  var isLoading = true.obs;
  var isGoogleUser = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  File? _image;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();
  @override
  void onInit() {
    super.onInit();
    _checkLoginMethod();
  }
  Future<void> _checkLoginMethod() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Check if user logged in with Google
      isGoogleUser.value = user.providerData.any((userInfo) => userInfo.providerId == 'google.com');
      await _getUserData();
    }
  }
  Future<void> _getUserData() async {
    isLoading(true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      String documentId = isGoogleUser.value ? user.email! : user.phoneNumber!;

      if (isGoogleUser.value) {
        nameController.text = user.displayName ?? '';
        emailController.text = user.email ?? '';
        profileImage.value = user.photoURL ?? '';
      } else {
        phoneController.text = user.phoneNumber ?? '';
      }

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(documentId)
          .get();

      if (snapshot.exists) {
        name.value = snapshot['name'] ?? nameController.text;
        email.value = snapshot['email'] ?? emailController.text;
        dob.value = snapshot['dob'] ?? '';
        gender.value = snapshot['gender'] ?? '';
        phoneNumber.value = snapshot['phone'] ?? phoneController.text;

        // Save profile image URL and fetch/download locally
        String? firestoreImage = snapshot['profile_image'];
        if (firestoreImage != null && firestoreImage.isNotEmpty) {
          await _saveImageLocally(firestoreImage);
        }

        nameController.text = name.value;
        emailController.text = email.value;
        dobController.text = dob.value;
        phoneController.text = phoneNumber.value;
      }

      // Try to get local image
      String? localPath = await LocalDBHelper.getImagePath();
      if (localPath != null && File(localPath).existsSync()) {
        _image = File(localPath);
      }

    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> _saveImageLocally(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final documentDir = await getApplicationDocumentsDirectory();
      final filePath = p.join(documentDir.path, 'profile_image.jpg');
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      await LocalDBHelper.saveImagePath(filePath);
    } catch (e) {
      print("Error saving image locally: $e");
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _uploadedImageUrl = null;
    }
  }
  Future<void> uploadImage() async {
    if (_image != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      String fileName = isGoogleUser.value ? user.email! : user.phoneNumber!;
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/$fileName.jpg');
      UploadTask uploadTask = storageReference.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      _uploadedImageUrl = await taskSnapshot.ref.getDownloadURL();
    }
  }
  Future<void> updateProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      await uploadImage();
      String documentId = isGoogleUser.value ? user.email! : user.phoneNumber!;
      Map<String, dynamic> updateData = {
        'name': nameController.text,
        'dob': dobController.text,
        'gender': gender.value,
        'login_method': isGoogleUser.value ? 'google' : 'phone',
      };

      // For phone users - add phone number (non-editable)
      if (!isGoogleUser.value) {
        updateData['phone'] = phoneController.text;
      } else {
        // For Google users - add phone number if provided (editable)
        if (phoneController.text.isNotEmpty) {
          updateData['phone'] = phoneController.text;
        }
      }

      // For Google users - add email (non-editable)
      if (isGoogleUser.value) {
        updateData['email'] = user.email;
      } else {
        // For phone users - add email if provided (editable)
        if (emailController.text.isNotEmpty) {
          updateData['email'] = emailController.text;
        }
      }

      // Add profile image if uploaded
      if (_uploadedImageUrl != null) {
        updateData['profile_image'] = _uploadedImageUrl;
      }

      await FirebaseFirestore.instance
          .collection('Customers')
          .doc(documentId)
          .set(updateData, SetOptions(merge: true));

      _getUserData(); // Reload data
      isEditing.value = false;
      Get.snackbar("Success", "Profile updated successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e");
    }
  }
}

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (profileController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: profileController._image != null
                          ? FileImage(profileController._image!) as ImageProvider
                          : AssetImage('assets/Profile.jpg'),
                    ),

                    if (profileController.isEditing.value)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: profileController.pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.edit, size: 15, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Name Field (always editable)
              ProfileTextField(
                  "Name",
                  "Enter Your Name",
                  Icons.person_outline,
                  profileController.nameController,
                  profileController.isEditing.value
              ),

              // Phone Number Field
              ProfileTextField(
                  "Phone Number",
                  "Enter Your Phone Number",
                  Icons.call_outlined,
                  profileController.phoneController,
                  profileController.isEditing.value && profileController.isGoogleUser.value
              ),

              // Email Field
              ProfileTextField(
                  "Email",
                  "Enter Your Email",
                  Icons.email_outlined,
                  profileController.emailController,
                  profileController.isEditing.value && !profileController.isGoogleUser.value
              ),

              // DOB Field (always editable)
              ProfileTextField(
                  "DOB",
                  "DD/MM/YY",
                  Icons.calendar_today,
                  profileController.dobController,
                  profileController.isEditing.value
              ),

              // Gender Dropdown (always editable when in edit mode)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: profileController.gender.value.isEmpty
                              ? null
                              : profileController.gender.value,
                          hint: Text("Select Gender", style: TextStyle(color: Colors.grey)),
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          isExpanded: true,
                          onChanged: profileController.isEditing.value
                              ? (String? newValue) {
                            profileController.gender.value = newValue!;
                          }
                              : null,
                          items: ["Male", "Female", "Not to specify"]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(value: value, child: Text(value)),
                          )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              if (profileController.isEditing.value)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: profileController.updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Update Profile",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

              SizedBox(height: 20),
              if (!profileController.isEditing.value)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      profileController.isEditing.value = true;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icons;
  final TextEditingController controller;
  final bool isEditing;

  ProfileTextField(this.label, this.hint, this.icons, this.controller, this.isEditing);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: isEditing,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(icons, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
              filled: true,
              fillColor: Colors.green.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}


class LocalDBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = p.join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            localImagePath TEXT
          )
        ''');
      },
    );
  }

  static Future<void> saveImagePath(String path) async {
    final db = await database;
    await db.delete('profile'); // Ensure single record
    await db.insert('profile', {'localImagePath': path});
  }

  static Future<String?> getImagePath() async {
    final db = await database;
    final result = await db.query('profile', limit: 1);
    return result.isNotEmpty ? result.first['localImagePath'] as String : null;
  }
}


