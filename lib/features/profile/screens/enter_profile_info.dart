import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';
import 'package:vetyo/features/profile/data/districts_data.dart';
import 'package:vetyo/features/profile/data/local_bodies_data.dart';

class EnterProfileInfoScreen extends StatefulWidget {
  const EnterProfileInfoScreen({super.key});

  @override
  State<EnterProfileInfoScreen> createState() => _EnterProfileInfoScreenState();
}

class _EnterProfileInfoScreenState extends State<EnterProfileInfoScreen> {
  final _basicFormKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();

  Map<String, dynamic> basicFormData = {};
  Map<String, dynamic> locationFormData = {};
  List<CustomFormFieldConfig> basicFormFields = [];
  List<CustomFormFieldConfig> locationFormFields = [];

  String? selectedProvince;
  String? selectedDistrict;
  int? selectedDistrictId;
  File? _profileImage;

  Key get _locationFormGeneratorKey =>
      ValueKey('location_${selectedProvince ?? ''}_${selectedDistrict ?? ''}');

  @override
  void initState() {
    super.initState();
  }

  // Pick profile image
  Future<void> _pickProfileImage() async {
    try {
      final pickedFile = await ImageUtils.customImagePicker();
      if (pickedFile != null && pickedFile is File) {
        setState(() {
          _profileImage = pickedFile;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error picking image: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // Helper method to convert string list to option list
  List<Map<String, String>> _convertToOptions(List<String> items) {
    return items.map((item) => {"label": item, "value": item}).toList();
  }

  // Get districts for a province
  List<String> _districtOptions(String? province) {
    if (province == null || province.isEmpty) return [];
    return (districtsByProvince[province] ?? [])
        .map((district) => district['name'] as String)
        .toList();
  }

  // Get district ID for a district name and province
  int? _getDistrictId(String? province, String? district) {
    if (province == null || district == null) return null;
    final districts = districtsByProvince[province] ?? [];
    final found = districts.firstWhere(
      (d) => d['name'] == district,
      orElse: () => {},
    );
    return found['id'] as int?;
  }

  // Get local bodies for a district
  List<String> _localBodyOptions(int? districtId) {
    if (districtId == null) return [];
    final bodies = localBodiesByDistrictId[districtId] ?? [];
    return bodies.map((body) => body['name'] as String).toList();
  }

  void _onProvinceChanged(dynamic value) {
    final selected = value?.toString();
    if (selected == null || selected == selectedProvince) return;

    setState(() {
      selectedProvince = selected;
      selectedDistrict = null;
      selectedDistrictId = null;
      locationFormData['province'] = selected;
      locationFormData['district'] = null;
      locationFormData['local_body'] = null;
    });
  }

  void _onDistrictChanged(dynamic value) {
    final selected = value?.toString();
    if (selected == null || selected == selectedDistrict) return;

    setState(() {
      selectedDistrict = selected;
      selectedDistrictId = _getDistrictId(selectedProvince, selected);
      locationFormData['district'] = selected;
      locationFormData['local_body'] = null;
    });
  }

  void _buildFormFields() {
    basicFormFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "fullName",
        label: "Full Name",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.phone,
        id: "phone",
        label: "Phone Number",
        isRequired: true,
      ),
    ];

    locationFormFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "province",
        label: "Province",
        isRequired: true,
        options: _convertToOptions(provinces),
        onFieldSubmitted: _onProvinceChanged,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "district",
        label: "District",
        isRequired: true,
        options: _convertToOptions(_districtOptions(selectedProvince)),
        enabled: selectedProvince != null,
        hintText:
            selectedProvince == null
                ? "Select Province first"
                : "Select District",
        onFieldSubmitted: _onDistrictChanged,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "local_body",
        label: "Local Body (Municipality/Rural Municipality)",
        isRequired: true,
        options: _convertToOptions(_localBodyOptions(selectedDistrictId)),
        enabled: selectedDistrictId != null,
        hintText:
            selectedDistrictId == null
                ? "Select District first"
                : "Select Local Body",
        onFieldSubmitted: (value) {
          locationFormData['local_body'] = value;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild form fields to update cascading options
    _buildFormFields();

    return BasePage(
      showAppBar: false,

      // title: Text(
      //   'Edit Profile',
      //   style: context.textBlackStyle().header6.bold.withBaloo2.copyWith(
      //     color: ColorPalete.oceanTeal.shade900,
      //   ),
      // ),
      // trailing: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 16.0),
      //     child: TextButton(
      //       onPressed: () {},
      //       child: Text(
      //         "Save Changes",
      //         style: context
      //             .textBlackStyle()
      //             .medium
      //             .bold
      //             .withSatoshi
      //             .brightSky700
      //             .copyWith(height: 1.2),
      //       ),
      //     ),
      //   ),
      // ],
      bodyColor: AppColor.pageBodyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildProfilePictureSection(),
                  ),
                ),

                /// Basic Information Section
                Text(
                  'Basic Information',
                  style: context
                      .textBlackStyle()
                      .medium
                      .bold
                      .withSatoshi
                      .copyWith(
                        color: ColorPalete.oceanTeal.shade200,
                        height: 1.2,
                      ),
                ),
                SizedBox(height: 12.h),

                CustomFormFieldGenerator(
                  formKey: _basicFormKey,
                  formFields: basicFormFields,
                  onFieldSubmitted: (data) {
                    basicFormData = data;
                    setState(() {});
                  },
                ),
                SizedBox(height: 16.h),

                /// Location Section
                Text(
                  'Your Location',
                  style: context
                      .textBlackStyle()
                      .medium
                      .bold
                      .withSatoshi
                      .copyWith(
                        color: ColorPalete.oceanTeal.shade200,
                        height: 1.2,
                      ),
                ),
                SizedBox(height: 12.h),
                CustomFormFieldGenerator(
                  key: _locationFormGeneratorKey,
                  formKey: _locationFormKey,
                  formFields: locationFormFields,
                  updateData: locationFormData,
                  onFieldSubmitted: (data) {
                    final incomingProvince = data['province']?.toString();
                    final incomingDistrict = data['district']?.toString();

                    setState(() {
                      locationFormData = {...locationFormData, ...data};

                      if (incomingProvince != null &&
                          incomingProvince.isNotEmpty &&
                          incomingProvince != selectedProvince) {
                        selectedProvince = incomingProvince;
                        selectedDistrict = null;
                        selectedDistrictId = null;
                        locationFormData['district'] = null;
                        locationFormData['local_body'] = null;
                        return;
                      }

                      if (incomingDistrict != null &&
                          incomingDistrict.isNotEmpty &&
                          incomingDistrict != selectedDistrict) {
                        selectedDistrict = incomingDistrict;
                        selectedDistrictId = _getDistrictId(
                          selectedProvince,
                          incomingDistrict,
                        );
                        locationFormData['local_body'] = null;
                      }
                    });
                  },
                ),
                SizedBox(height: 32.h),

                /// Continue Button with Gradient
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: Container(
        width: 92.w,
        height: 92.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(46.w),
          color: ColorPalete.brightSky[100],
          image:
              _profileImage != null
                  ? DecorationImage(
                    image: FileImage(_profileImage!),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child: Stack(
          children: [
            // Show placeholder icon when no image
            if (_profileImage == null)
              Center(
                child: Icon(
                  Icons.person,
                  size: 44.sp,
                  color: ColorPalete.brightSky[500],
                ),
              ),
            // Camera button overlay
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: ColorPalete.brightSky[500],
                  borderRadius: BorderRadius.circular(17.w),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.camera_alt, size: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
