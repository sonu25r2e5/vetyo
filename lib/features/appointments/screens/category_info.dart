import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CategoryInfoScreen extends StatefulWidget {
  final String? categoryName;
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const CategoryInfoScreen({
    super.key,
    this.categoryName,
    this.onContinue,
    this.onBack,
  });

  @override
  State<CategoryInfoScreen> createState() => _CategoryInfoScreenState();
}

class _CategoryInfoScreenState extends State<CategoryInfoScreen> {
  static const String _categoryFieldId = 'category';
  static const String _subCategoryFieldId = 'sub_category';

  static const Map<String, List<Map<String, String>>>
  _subCategoryOptionsByCategory = {
    'pet': [
      {'label': 'Cat', 'value': 'cat'},
      {'label': 'Dog', 'value': 'dog'},
      {'label': 'Rabbit', 'value': 'rabbit'},
      {'label': 'Bird', 'value': 'bird'},
      {'label': 'Hamster', 'value': 'hamster'},
    ],
    'livestock': [
      {'label': 'Cattle', 'value': 'cattle'},
      {'label': 'Sheep', 'value': 'sheep'},
      {'label': 'Goat', 'value': 'goat'},
      {'label': 'Horse', 'value': 'horse'},
      {'label': 'Pig', 'value': 'pig'},
      {'label': 'Buffalo', 'value': 'buffalo'},
      {'label': 'Camel', 'value': 'camel'},
      {'label': 'Donkey', 'value': 'donkey'},
      {'label': 'Rabbit', 'value': 'rabbit'},
      {'label': 'Yak', 'value': 'yak'},
    ],
    'poultry': [
      {'label': 'Chicken', 'value': 'chicken'},
      {'label': 'Duck', 'value': 'duck'},
      {'label': 'Turkey', 'value': 'turkey'},
      {'label': 'Geese', 'value': 'geese'},
      {'label': 'Quail', 'value': 'quail'},
      {'label': 'Guinea Fowl', 'value': 'guinea_fowl'},
      {'label': 'Pigeon', 'value': 'pigeon'},
      {'label': 'Ostrich', 'value': 'ostrich'},
    ],
    'aqua': [
      {'label': 'Freshwater Fish', 'value': 'freshwater_fish'},
      {'label': 'Marine Fish', 'value': 'marine_fish'},
      {'label': 'Shrimp & Crustaceans', 'value': 'shrimp_crustaceans'},
      {'label': 'Coral & Reef', 'value': 'coral_reef'},
      {'label': 'Amphibians', 'value': 'amphibians'},
      {'label': 'Aquatic Plants', 'value': 'aquatic_plants'},
    ],
    'agriculture': [
      {'label': 'Crop', 'value': 'crop'},
      {'label': 'Fruit', 'value': 'fruit'},
      {'label': 'Vegetable', 'value': 'vegetable'},
      {'label': 'Grain', 'value': 'grain'},
    ],
  };

  final _categoryFormKey = GlobalKey<FormState>();
  Map<String, dynamic> categoryFormData = {};
  List<CustomFormFieldConfig> categoryFormFields = [];

  String get _prefilledCategory => widget.categoryName?.trim() ?? '';

  String get _normalizedCategory => _prefilledCategory.toLowerCase();

  List<Map<String, String>> get _resolvedSubCategoryOptions {
    final options = _subCategoryOptionsByCategory[_normalizedCategory];
    if (options != null && options.isNotEmpty) {
      return options;
    }

    return _subCategoryOptionsByCategory.values
        .expand((items) => items)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _buildFormFields();
  }

  void _buildFormFields() {
    categoryFormFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: _categoryFieldId,
        label: 'Category',
        hintText: 'Category',
        enabled: _prefilledCategory.isEmpty,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: _subCategoryFieldId,
        label: 'Sub-Category',
        isRequired: true,
        options: _resolvedSubCategoryOptions,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Safe area spacing
              SizedBox(height: 24.h),

              // Title and Subtitle
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Category Information',
                    style: context.textBlackStyle().semiBold.large.withSatoshi,
                  ),
                  Text(
                    'Selected category and sub category',
                    style: context.textBlackStyle().medium.withSatoshi.slate500,
                  ),
                ],
              ),

              SizedBox(height: 24.h),
              CustomFormFieldGenerator(
                formKey: _categoryFormKey,
                updateData: {_categoryFieldId: _prefilledCategory},
                onFieldSubmitted: (data) {
                  categoryFormData = data;
                  setState(() {});
                  if (widget.onContinue != null) {
                    widget.onContinue!(categoryFormData);
                  }
                },
                formFields: categoryFormFields,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
