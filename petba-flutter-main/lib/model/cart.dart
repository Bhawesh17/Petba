class Cart {
  final int id, productId, quantity;
  final double price, weight;
  final String image, name, category, weightClass;

  Cart({
    this.id,
    this.productId,
    this.quantity,
    this.image,
    this.price,
    this.name,
    this.category,
    this.weight,
    this.weightClass,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    double price = double.parse(json['product']['price']);

    final option = json['option'] as List;
    option.forEach((element) {
      if (element['price_prefix'] == '+') {
        price += double.parse(element['price']);
      } else {
        price -= double.parse(element['price']);
      }
    });

    price *= json['quantity'];

    return Cart(
      id: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      image: json['product']['image'],
      price: price, // double.parse(json['product']['price']),
      name: json['product_description']['name'],
      category: 'N/A',
      weight: double.parse(json['product']['weight']),
      weightClass: json['product']['weight_class_id']['unit'],
    );
  }
}
