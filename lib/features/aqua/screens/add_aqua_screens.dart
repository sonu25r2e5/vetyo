import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';

class AddAquaScreen extends StatefulWidget {
  const AddAquaScreen({super.key});

  @override
  State<AddAquaScreen> createState() => _AddAquaScreenState();
}

class _AddAquaScreenState extends State<AddAquaScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  late List<CustomFormFieldConfig> formFields;

  // Image state variables
  File? _profileImage;
  final List<File> _attachmentImages = [];

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  }

  void _initializeFormFields() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "fish_type",
        label: "Fish Type",
        hintText: "Enter fish type",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "fish_count",
        label: "Fish Count",
        hintText: "Enter the number of fish",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "batch_number",
        label: "Batch Number",
        hintText: "Enter batch number",
        isRequired: true,
      ),
    ];
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

  // Pick attachment images
  Future<void> _pickAttachmentImages() async {
    try {
      final pickedFiles = await ImageUtils.customMultipleImagePicker();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _attachmentImages.addAll(pickedFiles);
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error picking images: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _removeAttachmentImage(int index) {
    setState(() {
      _attachmentImages.removeAt(index);
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with submission
      Map<String, dynamic> aquaData = Map.from(formData);
      aquaData['profileImage'] = _profileImage?.path;
      aquaData['attachmentImages'] =
          _attachmentImages.map((file) => file.path).toList();

      print("Aqua Data: $aquaData");
      print("Profile Image: ${_profileImage?.path}");
      print(
        "Attachment Images: ${_attachmentImages.map((f) => f.path).toList()}",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Aqua profile created successfully!'),
          backgroundColor: ColorPalete.healingGreen[500],
        ),
      );

      // Navigate back
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showBackButton: true,
      showAppBar: true,
      title: Text(
        'Create Profile',
        style: context.textBlackStyle().newheader1.withBaloo2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Center(child: _buildProfilePictureSection()),
                SizedBox(height: 48.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: CustomFormFieldGenerator(
                    formKey: _formKey,
                    formFields: formFields,
                    onFieldSubmitted: (data) {
                      formData = data;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: _buildAttachmentSection(),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: CustomButton(
                    label: "Done",
                    labelStyle: context
                        .textBlackStyle()
                        .xlarge
                        .semiBold
                        .copyWith(color: Colors.white),
                    onPressed: _handleSubmit,
                    color: ColorPalete.brightSky[500],
                  ),
                ),
                SizedBox(height: 24.h),
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
        width: 110.w,
        height: 110.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55.w),
          gradient:
              _profileImage == null
                  ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(52, 245, 198, 0.3),
                      Color.fromRGBO(29, 205, 254, 0.3),
                    ],
                    stops: const [0.18371, 0.80506],
                  )
                  : null,
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
            // Center text when no image
            if (_profileImage == null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Profile",
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF062933),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Picture",
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF062933),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            // Camera button overlay
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: ColorPalete.brightSky[500],
                  borderRadius: BorderRadius.circular(22.w),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Icon(Icons.camera_alt, size: 20.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          "ATTACHMENT",
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: ColorPalete.brightSky[700],
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            // Add Image Button
            GestureDetector(
              onTap: _pickAttachmentImages,
              child: Container(
                width: 104.w,
                height: 68.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorPalete.brightSky[500]!,
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 24.sp,
                    color: ColorPalete.brightSky[500],
                  ),
                ),
              ),
            ),
            // Display selected images
            ..._attachmentImages.asMap().entries.map(
              (entry) => _buildAttachmentImageCard(entry.key, entry.value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachmentImageCard(int index, File imageFile) {
    return Stack(
      children: [
        Container(
          width: 104.w,
          height: 68.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: ColorPalete.brightSky[500]!, width: 0.5),
            image: DecorationImage(
              image: FileImage(imageFile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: () => _removeAttachmentImage(index),
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.close, size: 12.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
