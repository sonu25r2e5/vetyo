import 'case_report_model.dart';

// ============================================================================
// ACTIVE CASES
// ============================================================================

/// Active case with high priority - emergency consultation
final CaseReportModel mockActiveCaseHighPriority = CaseReportModel(
  id: 'case-active-001-high',
  status: CaseStatus.active,
  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  category: 'Pet',
  species: 'Dog',
  petName: 'Buddy',
  breed: 'German Shepherd',
  ageInMonths: 48, // 4 years
  evidences: [
    EvidenceItem(
      id: 'ev-a1',
      type: EvidenceType.image,
      url: 'https://example.com/buddy-injury1.jpg',
    ),
    EvidenceItem(
      id: 'ev-a2',
      type: EvidenceType.image,
      url: 'https://example.com/buddy-injury2.jpg',
    ),
    EvidenceItem(
      id: 'ev-a3',
      type: EvidenceType.video,
      url: 'https://example.com/buddy-video.mp4',
    ),
  ],
  hasMedicineAllergy: true,
  isTakingOtherMedication: false,
  hasHeartOrKidneyIssues: false,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: true,
  consultationPriority: ConsultationPriority.high,
);

/// Active case with normal priority
final CaseReportModel mockActiveCaseNormalPriority = CaseReportModel(
  id: 'case-active-002-normal',
  status: CaseStatus.active,
  createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
  category: 'Pet',
  species: 'Cat',
  petName: 'Whiskers',
  breed: 'Siamese',
  ageInMonths: 24, // 2 years
  evidences: [
    EvidenceItem(
      id: 'ev-a4',
      type: EvidenceType.image,
      url: 'https://example.com/whiskers-checkup.jpg',
    ),
  ],
  hasMedicineAllergy: false,
  isTakingOtherMedication: true,
  hasHeartOrKidneyIssues: false,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: false,
  consultationPriority: ConsultationPriority.normal,
);

/// Active case with emergency priority
final CaseReportModel mockActiveCaseEmergency = CaseReportModel(
  id: 'case-active-003-emergency',
  status: CaseStatus.active,
  createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
  category: 'Pet',
  species: 'Dog',
  petName: 'Rocky',
  breed: 'Labrador',
  ageInMonths: 60, // 5 years
  evidences: [
    EvidenceItem(
      id: 'ev-a5',
      type: EvidenceType.video,
      url: 'https://example.com/rocky-emergency.mp4',
    ),
    EvidenceItem(
      id: 'ev-a6',
      type: EvidenceType.image,
      url: 'https://example.com/rocky-xray.jpg',
    ),
    EvidenceItem(
      id: 'ev-a7',
      type: EvidenceType.document,
      url: 'https://example.com/rocky-records.pdf',
    ),
  ],
  hasMedicineAllergy: true,
  isTakingOtherMedication: true,
  hasHeartOrKidneyIssues: true,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: true,
  consultationPriority: ConsultationPriority.emergency,
);

/// Active case for a bird
final CaseReportModel mockActiveCaseBird = CaseReportModel(
  id: 'case-active-004-bird',
  status: CaseStatus.active,
  createdAt: DateTime.now().subtract(const Duration(hours: 8)),
  category: 'Pet',
  species: 'Bird',
  petName: 'Tweety',
  breed: 'Cockatiel',
  ageInMonths: 12, // 1 year
  evidences: [
    EvidenceItem(
      id: 'ev-a8',
      type: EvidenceType.image,
      url: 'https://example.com/tweety-feathers.jpg',
    ),
  ],
  hasMedicineAllergy: false,
  isTakingOtherMedication: false,
  hasHeartOrKidneyIssues: false,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: false,
  consultationPriority: ConsultationPriority.normal,
);

// ============================================================================
// CLOSED CASES
// ============================================================================

final CaseReportModel mockClosedCaseWithConcerns = CaseReportModel(
  id: 'case-12345-abcdef-67890',
  status: CaseStatus.closed,
  createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
  category: 'Pet',
  species: 'Dog',
  petName: 'Max',
  breed: 'Golden Retriever',
  ageInMonths: 36, // 3 years
  evidences: [
    EvidenceItem(
      id: 'ev1',
      type: EvidenceType.image,
      url: 'https://example.com/image1.jpg',
    ),
    EvidenceItem(
      id: 'ev2',
      type: EvidenceType.image,
      url: 'https://example.com/image2.jpg',
    ),
    EvidenceItem(
      id: 'ev3',
      type: EvidenceType.video,
      url: 'https://example.com/video1.mp4',
    ),
  ],
  hasMedicineAllergy: true,
  isTakingOtherMedication: true,
  hasHeartOrKidneyIssues: true,
  hadVaccineReaction: true,
  consumedHarmfulSubstance: true,
  consultationPriority: ConsultationPriority.high,
);

/// Closed case with no health concerns
/// This represents a normal consultation with no complications
final CaseReportModel mockClosedCaseNoConcerns = CaseReportModel(
  id: 'case-98765-zyxwvu-43210',
  status: CaseStatus.closed,
  createdAt: DateTime.now().subtract(const Duration(days: 7, hours: 2)),
  category: 'Pet',
  species: 'Cat',
  petName: 'Luna',
  breed: 'Persian',
  ageInMonths: 18, // 1 year 6 months
  evidences: [
    EvidenceItem(
      id: 'ev4',
      type: EvidenceType.image,
      url: 'https://example.com/cat-image1.jpg',
    ),
    EvidenceItem(
      id: 'ev5',
      type: EvidenceType.document,
      url: 'https://example.com/document1.pdf',
    ),
  ],
  hasMedicineAllergy: false,
  isTakingOtherMedication: false,
  hasHeartOrKidneyIssues: false,
  hadVaccineReaction: false,
  consumedHarmfulSubstance: false,
  consultationPriority: ConsultationPriority.normal,
);

// ============================================================================
// COMBINED LISTS
// ============================================================================

/// List of all active cases
final List<CaseReportModel> mockActiveCases = [
  mockActiveCaseEmergency,
  mockActiveCaseHighPriority,
  mockActiveCaseNormalPriority,
  mockActiveCaseBird,
];

/// List of all closed cases
final List<CaseReportModel> mockClosedCases = [
  mockClosedCaseWithConcerns,
  mockClosedCaseNoConcerns,
];

/// List of all cases (active + closed)
final List<CaseReportModel> mockAllCases = [
  ...mockActiveCases,
  ...mockClosedCases,
];
