import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/features/cases/widgets/user_cases_card.dart';
import 'package:vetyo/features/cases/widgets/user_cases_filter_widget.dart';

class UserCasesScreen extends StatefulWidget {
  const UserCasesScreen({super.key});

  @override
  State<UserCasesScreen> createState() => _UserCasesScreenState();
}

class _UserCasesScreenState extends State<UserCasesScreen> {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  List<CustomFormFieldConfig> formFields = [];
  int selectedIndex = 3; // Favourites tab selected by default

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initializeFormFields(context);
    super.didChangeDependencies();
  }

  void _initializeFormFields(BuildContext context) {
    formFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: 'search_cases',
        label: context.l10n.searchCases,
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (formFields.isEmpty) {
      _initializeFormFields(context);
    }

    // Favourite cases data - these are marked as favorites by the user
    final allCases = [
      // Active cases
      {
        'doctorName': 'Dr. Sia',
        'specialty': 'Heart Health',
        'date': '28 May',
        'status': 'Active',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'You sent a photo...',
        'petName': 'Burno',
        'petBreed': 'Golden Retriever',
        'petAge': 3,
        'petGender': 'Male',
        'petImage': 'assets/images/avatar.png',
      },
      {
        'doctorName': 'Dr. Sharma',
        'specialty': 'General Health',
        'date': '27 May',
        'status': 'Active',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Awaiting your response...',
        'petName': 'Rocky',
        'petBreed': 'German Shepherd',
        'petAge': 5,
        'petGender': 'Male',
        'petImage': 'assets/images/avatar.png',
      },
      // Pending cases
      {
        'doctorName': 'Dr. Patel',
        'specialty': 'Orthopedics',
        'date': '26 May',
        'status': 'Pending',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Waiting for diagnosis...',
        'petName': 'Max',
        'petBreed': 'Labrador',
        'petAge': 2,
        'petGender': 'Female',
        'petImage': 'assets/images/avatar.png',
      },
      {
        'doctorName': 'Dr. Kumar',
        'specialty': 'Nutrition',
        'date': '25 May',
        'status': 'Pending',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Diet plan under review...',
        'petName': 'Luna',
        'petBreed': 'Beagle',
        'petAge': 1,
        'petGender': 'Female',
        'petImage': 'assets/images/avatar.png',
      },
      // Closed cases
      {
        'doctorName': 'Dr. Willson',
        'specialty': 'Skin Health',
        'date': '29 Dec',
        'status': 'Closed',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Case closed successfully...',
        'petName': 'Charlie',
        'petBreed': 'German Shepherd',
        'petAge': 4,
        'petGender': 'Male',
        'petImage': 'assets/images/avatar.png',
      },
      {
        'doctorName': 'Dr. Willson',
        'specialty': 'Skin Health',
        'date': '20 Dec',
        'status': 'Closed',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Treatment completed...',
        'petName': 'Bella',
        'petBreed': 'Poodle',
        'petAge': 5,
        'petGender': 'Female',
        'petImage': 'assets/images/avatar.png',
      },
      {
        'doctorName': 'Dr. Singh',
        'specialty': 'Dental Care',
        'date': '15 Dec',
        'status': 'Closed',
        'image': 'assets/images/avatar.png',
        'messagePreview': 'Checkup done...',
        'petName': 'Daisy',
        'petBreed': 'Cocker Spaniel',
        'petAge': 2,
        'petGender': 'Female',
        'petImage': 'assets/images/avatar.png',
      },
    ];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header with title
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: 8.h,
            ),
            child: Text(
              context.l10n.cases,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF272828),
                fontFamily: 'Baloo2',
              ),
            ),
          ),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomFormFieldGenerator(
              onFieldSubmitted: (data) {
                formData = data ?? {};
                setState(() {});
              },
              formKey: _formKey,
              formFields: formFields,
            ),
          ),

          // Filter chips - including All, Active, Favourites, Closed
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
            child: _buildFilterChips(),
          ),

          // Favourite cases list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: _getFilteredCases(allCases).length,
              itemBuilder: (context, index) {
                final caseData = _getFilteredCases(allCases)[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: UserCaseCard(
                    doctorName: caseData['doctorName'] as String,
                    specialty: caseData['specialty'] as String,
                    date: caseData['date'] as String,
                    status: caseData['status'] as String,
                    imageUrl: caseData['image'] as String,
                    petName: caseData['petName'] as String,
                    petBreed: caseData['petBreed'] as String,
                    petAge: caseData['petAge'] as int?,
                    petGender: caseData['petGender'] as String?,
                    petImageUrl: caseData['petImage'] as String?,
                    messagePreview:
                        caseData['messagePreview'] as String? ??
                        'You sent a photo...',
                    onChat: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.caseDetailsChatScreen,
                      );
                    },
                    onViewCase: () {
                      _onViewCase(context, caseData);
                    },
                    onFollowUp:
                        (caseData['status'] as String).toLowerCase() == 'closed'
                            ? () {
                              _onFollowUp(context, caseData);
                            }
                            : null,
                    onReport: () {
                      _onReport(context, caseData);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases(
    List<Map<String, dynamic>> allCases,
  ) {
    switch (selectedIndex) {
      case 0: // All
        return allCases;
      case 1: // Active
        return allCases
            .where(
              (case_) => (case_['status'] as String).toLowerCase() == 'active',
            )
            .toList();
      case 2: // Pending
        return allCases
            .where(
              (case_) => (case_['status'] as String).toLowerCase() == 'pending',
            )
            .toList();
      case 3: // Closed
        return allCases
            .where(
              (case_) => (case_['status'] as String).toLowerCase() == 'closed',
            )
            .toList();

      default:
        return allCases;
    }
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Filter icon
          IconButton(
            onPressed: () {
              _showFilterBottomSheet(context);
            },
            icon: Icon(
              Icons.filter_list,
              size: 20.sp,
              color: const Color(0xFF6F7070),
            ),
          ),
          SizedBox(width: 12.w),
          // Chips - matching design exactly
          _buildChip(context.l10n.all, 0),
          SizedBox(width: 8.w),
          _buildChip(context.l10n.active, 1),
          SizedBox(width: 8.w),
          _buildChip("Pending", 2),
          SizedBox(width: 8.w),
          _buildChip(context.l10n.closed, 3),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _buildChip(String label, int index) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 28.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB4EEFF) : Colors.transparent,
          border:
              isSelected
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: const Color(0xFF939393), width: 0.8.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.76.sp,
              fontWeight: FontWeight.w500,
              color:
                  isSelected
                      ? const Color(0xFF4B4C4C)
                      : const Color(0xFF6F7070),
              fontFamily: 'Satoshi',
            ),
          ),
        ),
      ),
    );
  }

  void _onViewCase(BuildContext context, Map<String, dynamic> caseData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('View case: ${caseData['doctorName']}')),
    );
    // Navigate to case details based on status
    final status = (caseData['status'] as String).toLowerCase();
    if (status == 'closed') {
      Navigator.pushNamed(
        context,
        '/closedCaseDetailsScreen',
        arguments: caseData,
      );
    } else {
      Navigator.pushNamed(
        context,
        '/activeCaseDetailsScreen',
        arguments: caseData,
      );
    }
  }

  void _onFollowUp(BuildContext context, Map<String, dynamic> caseData) {
    showSnackBar(context, "follow up pressed");
    Navigator.pushNamed(context, RoutePaths.followUpscreen);
  }

  void _onReport(BuildContext context, Map<String, dynamic> caseData) {
    showSnackBar(context, "Report submitted for ${caseData['doctorName']}");
    // Add report navigation or action here
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return UserCasesFilterWidget(
          onSave: () {
            Navigator.pop(context);
            setState(() {});
          },
        );
      },
    );
  }
}
