class Post {
  final String author; // Author of the post
  final String title; // Title of the post
  final String type; // Type of the post (general, educational, lifestyle)
  final String country; // Country associated with the post
  final String city; // City associated with the post
  final String text; // Text content of the post
  final String university; // University associated with the post
  final String campus; // Campus associated with the post

  Post({
    required this.author,
    required this.title,
    required this.type,
    required this.country,
    required this.city,
    required this.text,
    required this.university,
    required this.campus,
  });
}
