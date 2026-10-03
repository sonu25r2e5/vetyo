import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/features/cases/widgets/user_cases_filter_widget.dart';
import 'package:vetyo/features/doctors/doctor_case/widgets/doctor_case_card.dart';

class DoctorCasesScreen extends StatefulWidget {
  const DoctorCasesScreen({super.key});

  @override
  State<DoctorCasesScreen> createState() => _DoctorCasesScreenState();
}

class _DoctorCasesScreenState extends State<DoctorCasesScreen> {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  List<CustomFormFieldConfig> formFields = [];
  int selectedIndex = 3; // Favourites tab selected by default

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  }

  void _initializeFormFields() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: 'search_cases',
        label: 'Search cases',
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (formFields.isEmpty) {
      _initializeFormFields();
    }

    // Favourite cases data - these are marked as favorites by the user
    final allCases = [
      {
        'caseId': 'C-1001',
        'patientName': 'Charlie',
        'patientAge': '2 years · Male',
        'assignedDoctorName': 'Dr. Sia',
        'userType': 'Farm Owner',
        'assignedDoctorImage': 'assets/images/avatar.png',
        'caseDate': DateTime.now().subtract(const Duration(days: 2)),
        'status': 'Active',
        'patientImage': 'assets/images/pet.png',
      },
      {
        'caseId': 'C-1002',
        'patientName': 'Milo',
        'patientAge': '1 year · Female',
        'assignedDoctorName': 'Dr. Sia',
        'userType': 'Farm Owner',
        'assignedDoctorImage': 'assets/images/avatar.png',
        'caseDate': DateTime.now().subtract(const Duration(days: 10)),
        'status': 'Pending',
        'patientImage': 'assets/images/pet_cat.png',
      },
      {
        'caseId': 'C-1003',
        'patientName': 'Bella',
        'patientAge': '3 years · Female',
        'assignedDoctorName': 'Dr. Willson',
        'userType': 'Personal User',
        'assignedDoctorImage': 'assets/images/avatar.png',
        'caseDate': DateTime.now().subtract(const Duration(days: 30)),
        'status': 'Closed',
        'patientImage': 'assets/images/pet_cat.png',
      },
      {
        'caseId': 'C-1004',
        'patientName': 'Oscar',
        'patientAge': '4 years · Male',
        'assignedDoctorName': 'Dr. Willson',
        'userType': 'Farm Owner',
        'assignedDoctorImage': 'assets/images/avatar.png',
        'caseDate': DateTime.now().subtract(const Duration(days: 60)),
        'status': 'Closed',
        'patientImage': 'assets/images/pet.png',
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
              'Cases',
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                  child: DoctorCaseCard(
                    patientName: caseData['patientName'] as String? ?? '',
                    userType: caseData['userType'] as String? ?? '',
                    date: _formatCaseDate(caseData['caseDate']),
                    status: caseData['status'] as String? ?? '',
                    imageUrl: caseData['assignedDoctorImage'] as String? ?? '',

                    onViewCase: () {
                      _onViewCase(context, caseData);
                    },
                    onFollowUp:
                        (caseData['status'] as String).toLowerCase() == 'closed'
                            ? () {
                              _onFollowUp(context, caseData);
                            }
                            : null,
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
      case 2: // Closed
        return allCases
            .where(
              (case_) => (case_['status'] as String).toLowerCase() == 'closed',
            )
            .toList();
      case 3: // Favourites (show all by default)
        return allCases;

      default:
        return allCases;
    }
  }

  String _formatCaseDate(dynamic date) {
    if (date == null) return '';
    if (date is String) return date;
    if (date is DateTime) {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]}';
    }
    return date.toString();
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Filter icon
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: IconButton(
              onPressed: () {
                _showFilterBottomSheet(context);
              },
              icon: Icon(
                Icons.filter_list,
                size: 18.sp,
                color: const Color(0xFF6F7070),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Chips - matching design exactly
          _buildChip('All', 0),
          SizedBox(width: 8.w),
          _buildChip('Active', 1),
          SizedBox(width: 8.w),
          _buildChip('Closed', 2),
          SizedBox(width: 8.w),

          _buildChip('Favourites', 3),
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


