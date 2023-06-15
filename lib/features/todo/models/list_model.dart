class ListModel {
  final String id;
  final String title;
  final String icon;
  final String color;
  final int createdAt;

  ListModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.createdAt,
  });

  ListModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        title = json['title'],
        color = json['color'],
        icon = json['icon'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'icon': icon,
      'createdAt': createdAt,
    };
  }
}
