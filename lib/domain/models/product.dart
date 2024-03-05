class Product{
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;
  dynamic rate;
  dynamic count;


  Product({required this.id, required this.title, required this.price, required this.description, required this.category, required this.image, required this.rate, required this.count});


  factory Product.fromJson(Map<String, dynamic> map){
    return Product(id: map['id'], title: map['title'], price: map['price'], description: map['description'], category: map['category'], image: map['image'], rate: map['rating']['rate'], count: map['rating']['count']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rate": rate,
      "count": count
    };
  }

}