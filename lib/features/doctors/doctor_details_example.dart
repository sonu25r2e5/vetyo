import 'package:flutter/material.dart';
import 'package:vetyo/features/doctors/vet_details_screen.dart';

/// Example of how to use the VetDetailsScreen with custom doctor data
class DoctorDetailsExample {
  /// Navigate to doctor details with sample data
  static void navigateToSampleDoctor(BuildContext context) {
    final sampleDoctor = DoctorModel(
      id: '123',
      name: 'Dr. Sarah Johnson',
      specialty: 'Veterinary Surgeon',
      location: 'Animal Care Center',
      imageUrl: 'assets/images/profile_avatar.jpg',
      patients: 3500,
      experience: 15,
      rating: 4.9,
      reviews: 2847,
      about:
          '''Dr. Sarah Johnson is a highly experienced veterinary surgeon with over 15 years of dedicated service in animal healthcare. She specializes in complex surgical procedures and has performed over 5,000 successful operations. Dr. Johnson graduated from the prestigious Veterinary School of Medicine with honors and has since contributed to numerous veterinary research publications. She is known for her compassionate approach to animal care and her commitment to using the latest medical technologies to ensure the best outcomes for her patients.''',
      workingHours: 'Monday-Saturday, 09:00 AM-17:00 PM',
      reviewsList: [
        ReviewModel(
          userName: 'Maria Garcia',
          userImage: 'assets/images/profile_avatar.jpg',
          rating: 5.0,
          comment:
              'Dr. Johnson saved my cat\'s life with her expertise in emergency surgery. Forever grateful!',
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
        ReviewModel(
          userName: 'David Thompson',
          userImage: 'assets/images/profile_avatar.jpg',
          rating: 4.8,
          comment:
              'Professional and caring. My dog felt comfortable throughout the entire treatment.',
          date: DateTime.now().subtract(const Duration(days: 8)),
        ),
        ReviewModel(
          userName: 'Lisa Chen',
          userImage: 'assets/images/profile_avatar.jpg',
          rating: 5.0,
          comment:
              'Excellent communication and follow-up care. Highly recommended for any pet owner.',
          date: DateTime.now().subtract(const Duration(days: 15)),
        ),
      ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VetDetailsScreen(doctor: sampleDoctor),
      ),
    );
  }

  /// Navigate to doctor details with minimal data (will use defaults)
  static void navigateToDefaultDoctor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VetDetailsScreen()),
    );
  }

  /// Create a doctor model from API response
  static DoctorModel fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown Doctor',
      specialty: json['specialty'] ?? 'General Practice',
      location: json['location'] ?? 'Unknown Location',
      imageUrl: json['image_url'] ?? 'assets/images/profile_avatar.jpg',
      patients: json['patients'] ?? 0,
      experience: json['experience'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviews: json['reviews'] ?? 0,
      about: json['about'] ?? 'No information available.',
      workingHours: json['working_hours'] ?? 'Contact for availability',
      reviewsList:
          (json['reviews_list'] as List<dynamic>?)
              ?.map((review) => ReviewModelJson.fromJson(review))
              .toList() ??
          [],
    );
  }
}

/// Helper class for ReviewModel JSON conversion
class ReviewModelJson {
  static ReviewModel fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['user_name'] ?? 'Anonymous',
      userImage: json['user_image'] ?? 'assets/images/profile_avatar.jpg',
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}
