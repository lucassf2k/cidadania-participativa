class Post {
  late String id;
  late String title;
  late String description;
  late String userId;

  Post(this.id, this.title, this.description, this.userId);
  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    return data;
  }

  @override
  String toString() {
    return 'Post{_id: $id, title: $title, description: $description, userId: $userId}\n';
  }
}
