import 'package:flutter/material.dart';
import 'package:thaaja/payment/OrderModel.dart';
import 'package:thaaja/payment/orderDatabaseHelper.dart';
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage> {
  bool isOngoing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isOngoing = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                "Ongoing",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isOngoing ? Colors.green : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isOngoing = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                "History",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isOngoing ? Colors.green : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      alignment: isOngoing ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 32, // Adjusted for padding
                        height: 3,
                        margin: const EdgeInsets.only(top: 44),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isOngoing ? OngoingOrders() : OrderHistory(),
          ),

        ],
      ),
    );
  }
}
class OngoingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.calendar_today, color: Colors.green),
          title: Text("March 5, 2019", style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text("6:30 pm", style: TextStyle(color: Colors.green)),
        ),
        OrderStep("We are packing your items...", Icons.local_shipping, true),
        OrderStep("Your order is delivering to your location...", Icons.delivery_dining, true),
        OrderStep("Your order is received.", Icons.done, false),
      ],
    );
  }
}
class OrderStep extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  const OrderStep(this.text, this.icon, this.isActive);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Icon(icon, color: Colors.green),
              Container(
                height: 60,
                width: 2,
                color: Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}
class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    final fetchedOrders = await OrderDatabaseHelper().getAllOrders();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderItemWidget(
          order: OrderItem(
            order.orderId,
            "Delivered",
            order.timestamp,
            order.totalAmount.toInt(),
            true,
          ),
        );
      },
    );
  }
}

class OrderItem {
  final String orderNumber;
  final String status;
  final String date;
  final int amount;
  final bool isDelivered;
  OrderItem(this.orderNumber, this.status, this.date, this.amount, this.isDelivered);
}
class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  const OrderItemWidget({required this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.shopping_bag, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.orderNumber,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  order.status,
                  style: TextStyle(
                    color: order.isDelivered ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(order.date, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            "\$${order.amount}",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
