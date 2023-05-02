class LikeModule {
  final String like_id;
  final String post_id;
  final String user_id;

  const LikeModule({
    required this.like_id,
    required this.post_id,
    required this.user_id,
  });

  factory LikeModule.fromJson(Map<String, dynamic> json) {
    return LikeModule(
      like_id: json['like_id'],
      post_id: json['post_id'],
      user_id: json['user_id'],
    );
  }
}
