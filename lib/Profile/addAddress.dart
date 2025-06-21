import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:thaaja/ConfirmOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool _isAutoDetectLocation = false;
  String _currentLocation = "Detecting please wait....";
  TextEditingController hNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nearbyLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isAutoDetectLocation = true;  // Set Auto Detect Location as the default
    _getCurrentLocation();  // Automatically fetch the current location when the page loads
    _loadAddressData(); // Load address data when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildLocationSelectionRadio(),
            const SizedBox(height: 20),
            if (!_isAutoDetectLocation) ...[
              _buildTextField(hintText: 'H.No', controller: hNoController),
              const SizedBox(height: 10),
              _buildTextField(hintText: 'Address', controller: addressController),
              const SizedBox(height: 10),
              _buildTextField(hintText: 'Area', controller: areaController),
              const SizedBox(height: 10),
              _buildTextField(hintText: 'City', controller: cityController),
              const SizedBox(height: 10),
              _buildTextField(hintText: 'Nearby location', controller: nearbyLocationController),
              const SizedBox(height: 20), // Added extra space before the button
            ],
            if (_isAutoDetectLocation)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Current Location: $_currentLocation',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: _saveAddress,
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Added padding at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSelectionRadio() {
    return Column(
      children: [
        RadioListTile<bool>(
          title: const Text(
            'Auto Detect Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: true,
          activeColor: Colors.green,
          groupValue: _isAutoDetectLocation,
          onChanged: (bool? value) {
            setState(() {
              _isAutoDetectLocation = true;
              _getCurrentLocation();
            });
          },
        ),
        RadioListTile<bool>(
          title: const Text(
            'Enter Address Manually',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: false,
          activeColor: Colors.green,
          groupValue: _isAutoDetectLocation,
          onChanged: (bool? value) {
            setState(() {
              _isAutoDetectLocation = false;
            });
          },
        ),
      ],
    );
  }


  Widget _buildTextField({required String hintText, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.green.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get location: $e";
      });
    }
  }

  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentLocation = "${place.name ?? 'Unnamed location'}, "
              "${place.subLocality ?? 'No Mandal'}, "
              "${place.locality ?? 'No City'}, "
              "${place.administrativeArea ?? 'No State'}, "
              "${place.postalCode ?? 'No PIN'}, "  // <-- Added PIN code
              "${place.country ?? 'No Country'}";
        });
      } else {
        setState(() {
          _currentLocation = "No address found";
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get address: $e";
      });
    }
  }

  Future<void> _saveAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User not authenticated!");
      return;
    }
    try {
      String documentId = user.phoneNumber ?? user.email!; // Use phone number or email as document ID
      DocumentReference customerRef = FirebaseFirestore.instance.collection('Customers').doc(documentId);
      DocumentSnapshot docSnapshot = await customerRef.get();

      // Prepare address data
      Map<String, dynamic> addressData = {};

      // Check which option the user selected (Manual or Auto Detect)
      if (_isAutoDetectLocation) {
        // Auto-detected location
        addressData['currentLocation'] = _currentLocation; // Auto-detected address
        addressData['autoDetectTimestamp'] = Timestamp.now(); // Store timestamp for auto-detect
      } else {
        // Manually entered address
        addressData['hNo'] = hNoController.text;
        addressData['address'] = addressController.text;
        addressData['area'] = areaController.text;
        addressData['city'] = cityController.text;
        addressData['nearbyLocation'] = nearbyLocationController.text;
        addressData['manualAddressTimestamp'] = Timestamp.now(); // Store timestamp for manual address
      }

      // Check if document exists to decide whether to add or update
      if (docSnapshot.exists) {
        var existingData = docSnapshot.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (existingData != null) {
          // If the address is manually entered, ensure only the manual fields are updated
          if (!_isAutoDetectLocation && existingData.containsKey('manualAddressTimestamp')) {
            // Manually entered address: prevent overwriting autoDetectTimestamp
            addressData['autoDetectTimestamp'] = existingData['autoDetectTimestamp'];
          }

          // If auto-detected address is selected, only update the auto-detect fields
          if (_isAutoDetectLocation && existingData.containsKey('autoDetectTimestamp')) {
            addressData['manualAddressTimestamp'] = existingData['manualAddressTimestamp'];
          }
        }
      } else {
        // Document does not exist, so set both fields if necessary (new user)
        if (_isAutoDetectLocation) {
          addressData['autoDetectTimestamp'] = Timestamp.now();
        } else {
          addressData['manualAddressTimestamp'] = Timestamp.now();
        }
      }

      // Update the Firestore document with the address and selected timestamps
      await customerRef.update({
        'address': addressData,
      });

      Get.snackbar("Success", "Address added successfully!");
      Get.to(() => ConfirmOrderPage()); // Navigate to the next page
    } catch (e) {
      Get.snackbar("Error", "Failed to save address: $e");
    }
  }

  // Load address data from Firestore
  Future<void> _loadAddressData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      String documentId = user.phoneNumber ?? user.email!; // Use phone number or email as document ID
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Customers').doc(documentId).get();
      if (snapshot.exists) {
        var addressData = snapshot['address'];
        if (addressData != null) {
          setState(() {
            hNoController.text = addressData['hNo'] ?? '';
            addressController.text = addressData['address'] ?? '';
            areaController.text = addressData['area'] ?? '';
            cityController.text = addressData['city'] ?? '';
            nearbyLocationController.text = addressData['nearbyLocation'] ?? '';
            if (addressData['currentLocation'] != null) {
              _currentLocation = addressData['currentLocation']; // Set the auto-detected location if available
            }
          });
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load address data: $e");
    }
  }
}
