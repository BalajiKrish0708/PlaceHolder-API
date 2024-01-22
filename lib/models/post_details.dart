import 'dart:convert';

class PostDetails {
  PostDetails({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  //Converts the json object to seperate data
  factory PostDetails.fromJson(Map<String, dynamic> json) => PostDetails(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );
}

//reiterate our json object into a map of values
List<PostDetails> postFromJson(String str) => List<PostDetails>.from(
    json.decode(str).map((x) => PostDetails.fromJson(x)));
