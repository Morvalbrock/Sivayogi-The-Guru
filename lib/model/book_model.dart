class BookModel {
  final String image;
  final String name_english;
  final String name_tamil;
  final String price;

  BookModel(this.image, this.name_english, this.name_tamil, this.price);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      json['image'],
      json['name_english'],
      json['name_tamil'],
      json['price'],
    );
  }
}
