class Comment {
  final String comment_id;
  final String post_id;
  final String content;
  final String created_at;
  final String user_id;
  final String username;
  final String singup_date;
  final String picture;

  const Comment({
    required this.comment_id,
    required this.post_id,
    required this.content,
    required this.created_at,
    required this.user_id,
    required this.username,
    required this.singup_date,
    required this.picture,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment_id: json['comment_id'],
      post_id: json['post_id'],
      content: json['content'],
      created_at: json['created_at'],
      user_id: json['user_id'],
      username: json['username'],
      singup_date: json['singup_date'],
      picture: json['picture'],
    );
  }
}
