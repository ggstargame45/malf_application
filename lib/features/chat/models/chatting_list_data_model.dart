class ChattingListModel {
  final int post_id;
  final List<String> picture;
  final String title;
  final String personnel;

  ChattingListModel(
      {required this.post_id,
      required this.picture,
      required this.title,
      required this.personnel});

  // Factory method to create a Post instance from a Map (usually from JSON)
  factory ChattingListModel.fromJson(Map<String, dynamic> json) {
    return ChattingListModel(
      post_id: json['post_id'],
      picture: List<String>.from(json['picture']),
      title: json['title'],
      personnel: json['personnel'],
    );
  }

  // Method to convert a Post instance into a Map (usually for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'picture': picture,
      'title': title,
      'personnel': personnel,
    };
  }
}
