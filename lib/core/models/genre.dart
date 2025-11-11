class GenreModel {
  final String id;
  final String name;
  final String? description;
  final bool visible;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? publishedAt;
  final DateTime? updatedAt;

  GenreModel({
    required this.id,
    required this.name,
    this.description,
    this.visible = true,
    this.imageUrl,
    this.createdAt,
    this.publishedAt,
    this.updatedAt,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["_id"],
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        visible: json["visible"] ?? true,
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        publishedAt: json["publishedAt"] != null
            ? DateTime.tryParse(json["publishedAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "visible": visible,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
