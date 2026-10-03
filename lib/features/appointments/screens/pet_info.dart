import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class PetsInfo extends StatefulWidget {
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const PetsInfo({super.key, this.onContinue, this.onBack});

  @override
  State<PetsInfo> createState() => _PetsInfoState();
}

class _PetsInfoState extends State<PetsInfo> {
  final _petFormKey = GlobalKey<FormState>();
  Map<String, dynamic> petFormData = {};
  List<CustomFormFieldConfig> petsFormFields = [];

  String selectedGender = '';

  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    petsFormFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "pet_name",
        label: "PET'S NAME",
        hintText: "Enter pet's name",
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "pet_type",
        label: "PET TYPE",
        hintText: "Enter your pet's type",
        options: [
          {"label": "Dog", "value": "Dog"},
          {"label": "Cat", "value": "Cat"},
          {"label": "Bird", "value": "Bird"},
          {"label": "Rabbit", "value": "Rabbit"},
          {"label": "Other", "value": "Other"},
        ],
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "breed",
        label: "BREED",
        hintText: "Enter your pet's breed",
        isRequired: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),
            // Title and Subtitle
            SizedBox(
              width: 331.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tell us about your Pet',
                    style: context.textBlackStyle().semiBold.large.withSatoshi,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Help us personalize care and reminders for your furry  friend.',
                    style: context.textBlackStyle().medium.withSatoshi.slate500,
                  ),
                ],
              ),
            ),

            CustomFormFieldGenerator(
              formKey: _petFormKey,
              onFieldSubmitted: (data) {
                print('📝 PetsInfo form data submitted: $data');
                petFormData = data;
                setState(() {});
                // Call parent callback with form data
                if (widget.onContinue != null) {
                  print('📤 PetsInfo calling onContinue callback');
                  widget.onContinue!(petFormData);
                } else {
                  print('⚠️ PetsInfo onContinue is null');
                }
              },
              formFields: petsFormFields,
            ),

            // Gender Selection

            // Progress Bar
            // _buildProgressBar(),
            SizedBox(height: 12.h),

            GenderRadioGroup(),

            // Continue Button
            // GestureDetector(
            //   onTap: () {
            //     // Validate and continue

            //     if (_petFormKey.currentState!.validate()) {
            //       // Map<String, dynamic> request = {
            //       //   "email": formData['email'],
            //       //   "password": password,
            //       // };
            //       // // Navigator.pushNamed(
            //       // //     context, RoutePaths.oTPVerificationScreen,
            //       // //     arguments: {"email": formData['email']});
            //       // _loadingOverlay.show(context);
            //       // BlocProvider.of<SignupBloc>(
            //       //   context,
            //       // ).add(SignupWithPassword(formData: request));
            //     }
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: 48.h,
            //     decoration: BoxDecoration(
            //       color: const Color(0xFF1DC7F2),
            //       borderRadius: BorderRadius.circular(20.r),
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       'Continue',
            //       style: TextStyle(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.white,
            //         fontFamily: "Satoshi",
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
          ],
        ),
      ),
    );
  }
}

enum Gender { male, female }

class SimpleRadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SimpleRadioOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child:
                  selected
                      ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderRadioGroup extends StatefulWidget {
  const GenderRadioGroup({super.key});

  @override
  State<GenderRadioGroup> createState() => _GenderRadioGroupState();
}

class _GenderRadioGroupState extends State<GenderRadioGroup> {
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        SimpleRadioOption(
          label: "Male",
          selected: selectedGender == Gender.male,
          onTap: () {
            setState(() => selectedGender = Gender.male);
          },
        ),

        SimpleRadioOption(
          label: "Female",
          selected: selectedGender == Gender.female,
          onTap: () {
            setState(() => selectedGender = Gender.female);
          },
        ),
      ],
    );
  }
}
