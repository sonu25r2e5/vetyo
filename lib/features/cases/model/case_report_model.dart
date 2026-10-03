class   CaseReportModel {
  // Core
  final String id;
  final CaseStatus status;
  final DateTime createdAt;

  // Pet Info
  final String category;
  final String species;
  final String petName;
  final String breed;
  final int ageInMonths;

  // Evidence
  final List<EvidenceItem> evidences;

  // Doctor Questionnaire
  final bool hasMedicineAllergy;
  final bool isTakingOtherMedication;
  final bool hasHeartOrKidneyIssues;
  final bool hadVaccineReaction;
  final bool consumedHarmfulSubstance;

  // Consultation
  final ConsultationPriority consultationPriority;

  CaseReportModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.category,
    required this.species,
    required this.petName,
    required this.breed,
    required this.ageInMonths,
    required this.evidences,
    required this.hasMedicineAllergy,
    required this.isTakingOtherMedication,
    required this.hasHeartOrKidneyIssues,
    required this.hadVaccineReaction,
    required this.consumedHarmfulSubstance,
    required this.consultationPriority,
  });

  // ---------------- FROM JSON ----------------
  factory CaseReportModel.fromJson(Map<String, dynamic> json) {
    return CaseReportModel(
      id: json['id'],
      status: CaseStatusX.fromString(json['status']),
      createdAt: DateTime.parse(json['created_at']),

      category: json['category'],
      species: json['species'],
      petName: json['pet_name'],
      breed: json['breed'],
      ageInMonths: json['age_in_months'],

      evidences:
          (json['evidences'] as List<dynamic>)
              .map((e) => EvidenceItem.fromJson(e))
              .toList(),

      hasMedicineAllergy: json['has_medicine_allergy'],
      isTakingOtherMedication: json['is_taking_other_medication'],
      hasHeartOrKidneyIssues: json['has_heart_or_kidney_issues'],
      hadVaccineReaction: json['had_vaccine_reaction'],
      consumedHarmfulSubstance: json['consumed_harmful_substance'],

      consultationPriority: ConsultationPriorityX.fromString(
        json['consultation_priority'],
      ),
    );
  }

  // ---------------- TO JSON ----------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.value,
      'created_at': createdAt.toIso8601String(),

      'category': category,
      'species': species,
      'pet_name': petName,
      'breed': breed,
      'age_in_months': ageInMonths,

      'evidences': evidences.map((e) => e.toJson()).toList(),

      'has_medicine_allergy': hasMedicineAllergy,
      'is_taking_other_medication': isTakingOtherMedication,
      'has_heart_or_kidney_issues': hasHeartOrKidneyIssues,
      'had_vaccine_reaction': hadVaccineReaction,
      'consumed_harmful_substance': consumedHarmfulSubstance,

      'consultation_priority': consultationPriority.value,
    };
  }
}

class EvidenceItem {
  final String id;
  final EvidenceType type;
  final String url;

  EvidenceItem({required this.id, required this.type, required this.url});

  factory EvidenceItem.fromJson(Map<String, dynamic> json) {
    return EvidenceItem(
      id: json['id'],
      type: EvidenceTypeX.fromString(json['type']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type.value, 'url': url};
  }
}

enum CaseStatus { active, closed, cancelled }

extension CaseStatusX on CaseStatus {
  String get value => name;

  static CaseStatus fromString(String value) {
    return CaseStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CaseStatus.active,
    );
  }
}

enum EvidenceType { image, video, document }

extension EvidenceTypeX on EvidenceType {
  String get value => name;

  static EvidenceType fromString(String value) {
    return EvidenceType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EvidenceType.image,
    );
  }
}

enum ConsultationPriority { normal, high, emergency }

extension ConsultationPriorityX on ConsultationPriority {
  String get value => name;

  static ConsultationPriority fromString(String value) {
    return ConsultationPriority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ConsultationPriority.normal,
    );
  }
}
