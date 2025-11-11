// class UserModel {
//   final String id;
//   final String name;
//   final String alias;
//   final String? bio;
//   final bool visible;
//   final String? imageUrl;
//   final DateTime? createdAt;
//   final DateTime? joinedAt;
//   final DateTime? updatedAt;
//   final String? genres;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     this.alias = "",
//     this.bio,
//     this.visible = true,
//     this.imageUrl,
//     this.createdAt,
//     this.joinedAt,
//     this.updatedAt,
//     this.genres,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["_id"],
//         name: json["name"] ?? "",
//         alias: json["alias"] ?? "",
//         bio: json["bio"],
//         visible: json["visible"] ?? true,
//         imageUrl: json["imageUrl"],
//         createdAt: json["createdAt"] != null
//             ? DateTime.tryParse(json["createdAt"])
//             : null,
//         joinedAt: json["joinedAt"] != null
//             ? DateTime.tryParse(json["joinedAt"])
//             : null,
//         updatedAt: json["updatedAt"] != null
//             ? DateTime.tryParse(json["updatedAt"])
//             : null,
//         genres: json["genres"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "alias": alias,
//         "bio": bio,
//         "visible": visible,
//         "imageUrl": imageUrl,
//         "createdAt": createdAt?.toIso8601String(),
//         "joinedAt": joinedAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "genres": genres,
//       };
// }

class UserModel {
  final String id;
  final String name;
  final String alias;
  final String? bio;
  final bool visible;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? joinedAt;
  final DateTime? updatedAt;
  final String? genres;
  final bool isAuthor;

  UserModel({
    required this.id,
    required this.name,
    this.alias = "",
    this.bio,
    this.visible = true,
    this.imageUrl,
    this.createdAt,
    this.joinedAt,
    this.updatedAt,
    this.genres,
    this.isAuthor = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        alias: json["alias"] ?? "",
        bio: json["bio"],
        visible: json["visible"] ?? true,
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        joinedAt: json["joinedAt"] != null
            ? DateTime.tryParse(json["joinedAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
        genres: json["genres"],
        isAuthor: json["author"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alias": alias,
        "bio": bio,
        "visible": visible,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "joinedAt": joinedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "genres": genres,
        "author": isAuthor,
      };
}
