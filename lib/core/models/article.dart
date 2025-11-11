class ArticleModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final bool visible;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? publishedAt;
  final DateTime? updatedAt;
  final String? genre;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    this.visible = false,
    this.imageUrl,
    this.createdAt,
    this.publishedAt,
    this.updatedAt,
    this.genre,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["_id"],
        title: json["title"] ?? "",
        content: json["content"] ?? "",
        author: json["author"] ?? "",
        visible: json["visible"] ?? false,
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
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "author": author,
        "visible": visible,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "genre": genre,
      };
}
