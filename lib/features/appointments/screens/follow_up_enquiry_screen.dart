import 'package:flutter/material.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class FollowUpScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const FollowUpScreen({super.key, this.onContinue, this.onBack});

  @override
  State<FollowUpScreen> createState() => _FollowUpScreenState();
}

class _FollowUpScreenState extends State<FollowUpScreen> {
  final _followUpEnquiry = GlobalKey<FormState>();
  Map<String, dynamic> followUpEnqueryData = {};
  List<CustomFormFieldConfig> followUpEnqueryFields = [];

  String selectedGender = '';

  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    followUpEnqueryFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "follow_reason",
        label: "What is the reason for this follow up?",
        hintText: "Enter the reason for follow up",
        isRequired: true,
        maxLines: 5,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "changes_noticed",
        label: "What changes have you noticed?",
        hintText:
            "Describe any changes in symptoms, behavior, or condition since the last appointment",

        isRequired: true,
        maxLines: 5,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Help us understand what’s happening now",
              style: context.textBlackStyle().large.bold,
            ),
            SizedBox(height: 20.0),
            CustomFormFieldGenerator(
              formKey: _followUpEnquiry,
              onFieldSubmitted: (data) {
                print('📝 FollowUpScreen form data submitted: $data');
                followUpEnqueryData = data;
                setState(() {});
                // Call parent callback with form data
                if (widget.onContinue != null) {
                  print('📤 FollowUpScreen calling onContinue callback');
                  widget.onContinue!(followUpEnqueryData);
                } else {
                  print('⚠️ FollowUpScreen onContinue is null');
                }
              },
              formFields: followUpEnqueryFields,
            ),
          ],
        ),
      ),
    );
  }
}
