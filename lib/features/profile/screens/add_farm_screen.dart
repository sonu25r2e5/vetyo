import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> farmData = {};
  late List<CustomFormFieldConfig> formFields;

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  }

  void _initializeFormFields() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "farmName",
        label: "Farm Name",
        hintText: "Enter farm/business name",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "farmSize",
        label: "Farm Size",
        hintText: "eg: small, medium, large",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "location",
        label: "Location",
        hintText: "Enter location",
        isRequired: true,
      ),
    ];
  }

  void _handleSaveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {});

      // TODO: Implement save logic with farmData
      showSuccessSnackBar(
        context,
        'Farm Details Saved:\n'
        'Name: ${farmData['farmName']}\n'
        'Size: ${farmData['farmSize']}\n'
        'Location: ${farmData['location']}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        'Enter Farm Details',
        style: context.textBlackStyle().newheader2.copyWith(
          color: const Color(0xFF1D293D),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with back button
              SizedBox(height: 16.h),
              // Form fields using CustomFormFieldGenerator
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomFormFieldGenerator(
                  formKey: _formKey,
                  formFields: formFields,
                  onFieldSubmitted: (data) {
                    farmData = data;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 333.h),
              // Save button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: CustomButton(
                  height: 40.h,
                  gradient: LinearGradient(
                    colors: [
                      ColorPalete.brightSky.shade500,
                      ColorPalete.healingGreen.shade500,
                    ],
                  ),
                  label: 'Save Changes',
                  onPressed: _handleSaveChanges,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
