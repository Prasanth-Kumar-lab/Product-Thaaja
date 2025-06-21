import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/home_screen/SubscriptionProducts/Subscription_model.dart';
import 'package:intl/intl.dart';
class SubscriptionProductController extends GetxController {
  var quantity = 1.obs;
  var repeatOption = 'Daily'.obs;
  var startDate = DateTime.now().obs;
  var deliveryOption = 'Select Deliveries'.obs;
  var selectedDeliveryType = 'Delivery Once'.obs;
  var selectedDays = <String>[].obs;
  var subscribedProducts = <ProductModel, double>{}.obs; // product and total price
  void confirmSubscription(ProductModel product) {
    subscribedProducts[product] = product.price * quantity.value;
  }



  double get totalSubscriptionPrice =>
      subscribedProducts.values.fold(0, (sum, price) => sum + price);

  void updateQuantity(int value) => quantity.value = value;
  void updateRepeat(String value) => repeatOption.value = value;
  void updateDeliveryOption(String value) => deliveryOption.value = value;
  void selectDeliveryType(String type) => selectedDeliveryType.value = type;

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }

  String get formattedDate => DateFormat('yyyy-MM-dd').format(startDate.value);
}

class SubscriptionProduct extends StatelessWidget {
  final ProductModel product;

  const SubscriptionProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionProductController());
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image, Name and Price
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(product.imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(thickness: 1, height: 20,),
            // Quantity Section with - and +
            _buildSection(
              title: 'Qty',
              content: Obx(() => Row(
                children: [
                  const Text('Per Day'),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(color: Colors.green.shade100,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.green),
                          onPressed: () {
                            if (controller.quantity.value > 1) {
                              controller.updateQuantity(controller.quantity.value - 1);
                            }
                          },
                        ),
                        Text(
                          controller.quantity.value.toString(),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            controller.updateQuantity(controller.quantity.value + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
            // Quantity Section
            /*_buildSection(
              title: 'Qty',
              content: Obx(() => Row(
                children: [
                  const Text('Per Day'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PopupMenuButton<int>(
                      onSelected: (value) {
                        controller.updateQuantity(value);
                      },
                      itemBuilder: (context) => [1, 2, 3, 4, 5].map((value) {
                        return PopupMenuItem(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.quantity.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),*/
            // Repeat Section
            _buildSection(
              title: 'Repeat',
              content: Column(
                children: [
                  Obx(() => DropdownButtonFormField<String>(
                    value: controller.repeatOption.value,
                    items: ['Daily', 'Weekly', 'Monthly']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) controller.updateRepeat(value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )),
                  const SizedBox(height: 8),
                  Obx(() => controller.repeatOption.value == 'Weekly'
                      ? SizedBox(
                    height: 70, // Increased height to accommodate the text
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: weekdays.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final day = weekdays[index];
                        return Obx(() => GestureDetector(
                          onTap: () => controller.toggleDay(day),
                          child: Container(
                            width: 52, // Fixed width for consistency
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 20, // Slightly larger to fit text
                                  backgroundColor: controller.selectedDays.contains(day)
                                      ? Colors.green
                                      : Colors.grey[200],
                                  child: Text(
                                    day,
                                    style: TextStyle(
                                      fontSize: 12, // Smaller font size
                                      color: controller.selectedDays.contains(day)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                    ),
                  )
                      : const SizedBox.shrink()),
                ],
              ),
            ),

            // Start From Section
            _buildSection(
              title: 'Start From',
              content: Obx(() => TextFormField(
                readOnly: true,
                onTap: () => controller.pickDate(context),
                controller: TextEditingController(text: controller.formattedDate),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              )),
            ),

            // Select Deliveries Section
            _buildSection(
              title: 'Select Deliveries',
              content: Obx(() => DropdownButtonFormField<String>(
                value: controller.deliveryOption.value == 'Select Deliveries' ? null : controller.deliveryOption.value,
                items: ['Morning', 'Evening', 'Both']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) controller.updateDeliveryOption(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Deliveries',
                ),
              )),
            ),
            const Divider(thickness: 1, height: 24),

            // Delivery Type Selection
            Obx(() => Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Delivery Once'),
                  value: 'Delivery Once',
                  groupValue: controller.selectedDeliveryType.value,
                  onChanged: (value) => controller.selectDeliveryType(value!),
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile<String>(
                  title: const Text('SubscriptionProducts'),
                  value: 'SubscriptionProducts',
                  groupValue: controller.selectedDeliveryType.value,
                  onChanged: (value) => controller.selectDeliveryType(value!),
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ],
            )),
            const SizedBox(height: 6),
            // Total Price
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Obx(() => Text(
                    ' \$${(product.price * controller.quantity.value).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  controller.confirmSubscription(product); // Save subscription
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Subscribed to ${product.name}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          content,
        ],
      ),
    );
  }
}