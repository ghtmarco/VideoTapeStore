import 'package:flutter/foundation.dart';

class VideoTape {
  final String id;
  final String title;
  final double price;
  final String description;
  final String genreId;
  final String genreName;
  final int level;
  final List<String> imageUrls;
  final DateTime releasedDate;
  final int stockQuantity;
  final double rating;
  final int totalReviews;

  const VideoTape({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.genreId,
    required this.genreName,
    required this.level,
    required this.imageUrls,
    required this.releasedDate,
    required this.stockQuantity,
    this.rating = 0.0,
    this.totalReviews = 0,
  });

  // Fungsi untuk mengubah Map menjadi VideoTape object (dari JSON)
  factory VideoTape.fromJson(Map<String, dynamic> json) {
    return VideoTape(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      genreId: json['genreId'] as String,
      genreName: json['genreName'] as String,
      level: json['level'] as int,
      imageUrls: List<String>.from(json['imageUrls'] as List),
      releasedDate: DateTime.parse(json['releasedDate'] as String),
      stockQuantity: json['stockQuantity'] as int,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['totalReviews'] as int? ?? 0,
    );
  }

  // Fungsi untuk mengubah VideoTape object menjadi Map (ke JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'genreId': genreId,
      'genreName': genreName,
      'level': level,
      'imageUrls': imageUrls,
      'releasedDate': releasedDate.toIso8601String(),
      'stockQuantity': stockQuantity,
      'rating': rating,
      'totalReviews': totalReviews,
    };
  }

  // Fungsi untuk membuat salinan object dengan perubahan tertentu
  VideoTape copyWith({
    String? id,
    String? title,
    double? price,
    String? description,
    String? genreId,
    String? genreName,
    int? level,
    List<String>? imageUrls,
    DateTime? releasedDate,
    int? stockQuantity,
    double? rating,
    int? totalReviews,
  }) {
    return VideoTape(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      genreId: genreId ?? this.genreId,
      genreName: genreName ?? this.genreName,
      level: level ?? this.level,
      imageUrls: imageUrls ?? this.imageUrls,
      releasedDate: releasedDate ?? this.releasedDate,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoTape && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Enum untuk genre film
enum VideoGenre {
  action('Action'),
  comedy('Comedy'),
  drama('Drama'),
  horror('Horror'),
  sciFi('Sci-Fi'),
  thriller('Thriller'),
  romance('Romance'),
  documentary('Documentary');

  final String displayName;
  const VideoGenre(this.displayName);
}

// Enum untuk level film
enum VideoLevel {
  beginner(1, 'Beginner'),
  intermediate(2, 'Intermediate'),
  advanced(3, 'Advanced'),
  expert(4, 'Expert');

  final int value;
  final String displayName;
  const VideoLevel(this.value, this.displayName);
}