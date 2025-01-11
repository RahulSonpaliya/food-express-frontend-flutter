class Category {
  num id;
  String name;
  String image;
  String description;
  String status;
  String createdAt;
  String updatedAt;
  bool isSelected = false;
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson(Category obj) {
    return <String, dynamic>{
      'id': obj.id,
      'name': obj.name,
      'image': obj.image,
      'description': obj.description,
      'status': obj.status,
      'created_at': obj.createdAt,
      'updated_at': obj.updatedAt,
    };
  }

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
      id: parsedJson['id'],
      name: parsedJson['name'],
      image: parsedJson['image'],
      description: parsedJson['description'],
      status: parsedJson['status'],
      createdAt: parsedJson['createdAt'],
      updatedAt: parsedJson['updatedAt'],
    );
  }

  static Category ALL = Category(
      id: -1,
      name: 'All',
      image: '',
      description: '',
      status: '',
      createdAt: '',
      updatedAt: '');
}
