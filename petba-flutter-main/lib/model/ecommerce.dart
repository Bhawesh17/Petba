import '../constants.dart';

class Ecommerce {
  final String name, description, category, weightClass;
  final int id, stock;
  final double price, weight, rating;
  List<String> images = [];
  bool wishlist;

  Ecommerce({
    this.id,
    this.images,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.weight,
    this.weightClass,
    this.wishlist,
    this.rating,
  });

  factory Ecommerce.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    images.add(imgBaseUrl + json['image']);

    final imagesProducts = json['product_image'] as List;
    imagesProducts.forEach((element) {
      images.add(imgBaseUrl + element['image']);
    });
    return Ecommerce(
      id: json['product_id'],
      name: json['product_description']['name'],
      description: json['product_description']['description'],
      price: double.parse(json['price']),
      stock: json['quantity'],
      category: 'N/A',
      weight: double.parse(json['weight']),
      weightClass: json['weight_class_id']['unit'],
      images: images,
      wishlist: json['wishlist'],
      rating: 3.5,
    );
  }
}

class Category {
  final String title;
  final int optionId;
  final List<int> optionValueId;
  List<String> optionName;
  List<double> prices;
  List pricePrefix;
  List<bool> isSelected;

  Category({
    this.title,
    this.optionId,
    this.optionValueId,
    this.optionName,
    this.prices,
    this.pricePrefix,
    this.isSelected,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<double> prices = [];
    List<String> option = [];
    List pricePrefix = [];
    List<int> optionValueId = [];
    List<bool> isSelected = [];

    final perOption = json['product_options'] as List;
    perOption.forEach((element) {
      prices.add(double.parse(element['price']));
      pricePrefix.add(element['price_prefix']);
      option.add(element['option_value']['name']);
      optionValueId.add(element['product_option_value_id']);
      isSelected.add(false);
    });
    return Category(
      title: json['product_category_name']['name'],
      optionId: json['product_option_id'],
      optionValueId: optionValueId,
      optionName: option,
      prices: prices,
      pricePrefix: pricePrefix,
      isSelected: isSelected,
    );
  }
}
