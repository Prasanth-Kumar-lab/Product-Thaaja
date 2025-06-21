class OrderModel {
  final String orderId;
  final double totalAmount;
  final String timestamp;

  OrderModel({
    required this.orderId,
    required this.totalAmount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'totalAmount': totalAmount,
    'timestamp': timestamp,
  };

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
    orderId: map['orderId'],
    totalAmount: map['totalAmount'],
    timestamp: map['timestamp'],
  );
}
