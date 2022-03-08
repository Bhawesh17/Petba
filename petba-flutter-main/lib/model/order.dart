class OrderData {
  OrderData({this.quantity, this.orderId, this.date, this.price, this.orderStatus, this.name, this.image});
  final String date, name, image;
  final int quantity, orderId, orderStatus;
  final double price;

  factory OrderData.fromJson(Map<String, dynamic> json, int orderStatus, date) {
    return OrderData(
      orderId: json['order_id'],
      date: date,
      quantity: json['quantity'],
      orderStatus: orderStatus,
      price: double.parse(json['total']),
      name: json['name'],
      image: json['product_image']['image'],
    );
  }
}
