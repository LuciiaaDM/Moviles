class Post {
  final String title;
  final String type; // general, educational, lifestyle
  final String country;
  final String city;
  final String text;
  final List<String> images; // Lista de URLs de imágenes
  final String university; // Solo necesario para posts de tipo educational
  final String campus; // Solo necesario para posts de tipo educational

  Post({
    required this.title,
    required this.type,
    required this.country,
    required this.city,
    required this.text,
    required this.images,
    this.university = '', // Valor predeterminado para evitar errores si no es un post educativo
    this.campus = '', // Valor predeterminado para evitar errores si no es un post educativo
  });
}
