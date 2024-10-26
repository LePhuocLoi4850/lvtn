class Company {
  final String? id;
  final String name;
  final String imageUrl;
  final String address;
  final String description;

  const Company({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.description,
    bool isFavorite = false,
  });

  Company copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? address,
    String? description,
    bool? isFavorite,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      description: address ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'address': address,
      'description': description,
    };
  }

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      address: json['address'],
      description: json['description'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
