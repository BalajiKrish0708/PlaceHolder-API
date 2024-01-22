class Comments {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;
  Comments({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  static Comments fromMap(Map<dynamic, dynamic> map) => Comments(
        id: map['id'] as int,
        postId: map['postId'] as int,
        name: map['name'] as String,
        email: map['email'] as String,
        body: map['body'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'postId': postId,
        'name': name,
        'email': email,
        'body': body,
      };
}
