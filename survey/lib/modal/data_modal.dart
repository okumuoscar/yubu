class Post {
  final String name;
  final String email;
  final String phone;
  final String message;

  Post(
      {required this.name,
      required this.email,
      required this.phone,
      required this.message});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      message: json['message']);
}
