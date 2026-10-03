import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';

class QuestionaireScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const QuestionaireScreen({super.key, this.onContinue, this.onBack});

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  // Store answers for questions
  String? allergicToMedicines;
  String? takingMedicines;
  String? existingHealthCondition;
  String? petBehavior;

  final TextEditingController _existingConditionController =
      TextEditingController();

  final GlobalKey<FormState> _radioFormKey = GlobalKey<FormState>();
  late List<CustomFormFieldConfig> radioFormFields;

  /// Get all questionnaire answers as a map
  Map<String, dynamic> getAnswers() {
    return {
      'allergic_to_medicines': allergicToMedicines,
      'taking_medicines': takingMedicines,
      'existing_health_condition': existingHealthCondition,
      'pet_behavior': petBehavior,
    };
  }

  @override
  void initState() {
    super.initState();
    _initializeRadioFields();
  }

  void _initializeRadioFields() {
    radioFormFields = [
      CustomFormFieldConfig(
        id: 'pet_behavior',
        label: 'How is your pet\'s behavior?',
        fieldType: FieldType.radio,
        isRequired: true,
        options: const [
          {'label': 'Normal', 'value': 'normal'},
          {'label': 'Slightly lethargic', 'value': 'slightly_lethargic'},
          {'label': 'Very lethargic', 'value': 'very_lethargic'},
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _existingConditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status bar spacing
        SizedBox(height: MediaQuery.of(context).padding.top),

        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // Header Section
                  SizedBox(
                    width: 331.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pet Health Information',
                          style:
                              context
                                  .textBlackStyle()
                                  .semiBold
                                  .large
                                  .withSatoshi,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Provide a few details about your pet and its health so the expert can better understand the problem.',
                          style:
                              context
                                  .textBlackStyle()
                                  .medium
                                  .withSatoshi
                                  .slate500,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Q1: Allergic to medicines
                  _QuestionCard(
                    title: 'Is your pet allergic to any medicines?',
                    subtitle:
                        'Let the expert know if your pet has reacted badly to any medication before.',
                    child: Row(
                      children: [
                        _OptionPill(
                          label: 'Yes',
                          selected: allergicToMedicines == 'yes',
                          onTap: () {
                            setState(() {
                              allergicToMedicines = 'yes';
                            });
                          },
                        ),
                        SizedBox(width: 12.w),
                        _OptionPill(
                          label: 'No',
                          selected: allergicToMedicines == 'no',
                          onTap: () {
                            setState(() {
                              allergicToMedicines = 'no';
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Q2: Taking any medicines
                  _QuestionCard(
                    title: 'Is your pet currently taking any medicines?',
                    subtitle:
                        'Share if your pet is on any medication so the expert can avoid conflicts.',
                    child: Row(
                      children: [
                        _OptionPill(
                          label: 'Yes',
                          selected: takingMedicines == 'yes',
                          onTap: () {
                            setState(() {
                              takingMedicines = 'yes';
                            });
                          },
                        ),
                        SizedBox(width: 12.w),
                        _OptionPill(
                          label: 'No',
                          selected: takingMedicines == 'no',
                          onTap: () {
                            setState(() {
                              takingMedicines = 'no';
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Q3: Existing health conditions
                  _QuestionCard(
                    title: 'Existing health conditions (optional)',
                    subtitle:
                        'Mention any long-term issues like diabetes, heart problems, allergies, etc.',
                    child: TextField(
                      controller: _existingConditionController,
                      maxLines: 4,
                      onChanged: (value) {
                        setState(() {
                          existingHealthCondition = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Describe any ongoing health conditions...',
                        hintStyle:
                            context
                                .textBlackStyle()
                                .medium
                                .withSatoshi
                                .slate400,
                        filled: true,
                        fillColor: const Color(0xFFFAFAFA),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF56F6CF),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Q4: Pet Behavior (using CustomFormFieldGenerator with radio button)
                  CustomFormFieldGenerator(
                    formKey: _radioFormKey,
                    formFields: radioFormFields,
                    onFieldSubmitted: (data) {
                      print(
                        '📝 QuestionaireScreen radio data submitted: $data',
                      );
                      setState(() {
                        petBehavior = data['pet_behavior'];
                      });
                      // Call parent callback with all answers
                      if (widget.onContinue != null) {
                        final answers = getAnswers();
                        print(
                          '📤 QuestionaireScreen calling onContinue with: $answers',
                        );
                        widget.onContinue!(answers);
                      } else {
                        print('⚠️ QuestionaireScreen onContinue is null');
                      }
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 24.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _QuestionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textBlackStyle().medium.semiBold.withSatoshi,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: context.textBlackStyle().medium.withSatoshi.slate500,
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

class _OptionPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OptionPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFB4EEFF) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? const Color(0xFF56F6CF) : const Color(0xFFCED4DA),
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Satoshi',
            color: selected ? const Color(0xFF0F172B) : const Color(0xFF4B4C4C),
          ),
        ),
      ),
    );
  }
}
