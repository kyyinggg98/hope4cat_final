class Book {
  String cat_id;
  String fee;
  String description;
  String latitude;
  String longitude;
  String publisher;
  String gender;
  String image;

  Book(
    String cat_id,
    String fee,
    String description,
    String latitude,
    String longitude,
    String publisher,
    String gender,
    String image,
  ) {
    this.cat_id = cat_id;
    this.fee = fee;
    this.description = description;
    this.latitude = latitude;
    this.longitude = longitude;
    this.publisher = publisher;
    this.gender = gender;
    this.image = image;
  }
}
