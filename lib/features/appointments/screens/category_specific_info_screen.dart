import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CategorySpecificInfoScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<CustomFormFieldConfig> fields;
  final Function(Map<String, dynamic>)? onContinue;

  const CategorySpecificInfoScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    this.onContinue,
  });

  @override
  State<CategorySpecificInfoScreen> createState() =>
      _CategorySpecificInfoScreenState();
}

class _CategorySpecificInfoScreenState
    extends State<CategorySpecificInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              widget.title,
              style: context.textBlackStyle().semiBold.large.withSatoshi,
            ),
            SizedBox(height: 4.h),
            Text(
              widget.subtitle,
              style: context.textBlackStyle().medium.withSatoshi.slate500,
            ),
            SizedBox(height: 16.h),
            CustomFormFieldGenerator(
              formKey: _formKey,
              formFields: widget.fields,
              onFieldSubmitted: (data) {
                _formData = data;
                setState(() {});
                widget.onContinue?.call(_formData);
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
          ],
        ),
      ),
    );
  }
}
