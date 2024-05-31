class JellyBean {
  final int beanId;
  final List<String> groupName;
  final List<String> ingredients;
  final String flavorName;
  final String description;
  final String colorGroup;
  final String backgroundColor;
  final String imageUrl;
  final bool glutenFree;
  final bool sugarFree;
  final bool seasonal;
  final bool kosher;

  JellyBean({
    required this.beanId,
    required this.groupName,
    required this.ingredients,
    required this.flavorName,
    required this.description,
    required this.colorGroup,
    required this.backgroundColor,
    required this.imageUrl,
    required this.glutenFree,
    required this.sugarFree,
    required this.seasonal,
    required this.kosher,
  });

  factory JellyBean.fromJson(Map<String, dynamic> json) {
    return JellyBean(
      beanId: json['beanId'],
      groupName: List<String>.from(json['groupName']),
      ingredients: List<String>.from(json['ingredients']),
      flavorName: json['flavorName'],
      description: json['description'],
      colorGroup: json['colorGroup'],
      backgroundColor: json['backgroundColor'],
      imageUrl: json['imageUrl'],
      glutenFree: json['glutenFree'],
      sugarFree: json['sugarFree'],
      seasonal: json['seasonal'],
      kosher: json['kosher'],
    );
  }
}
