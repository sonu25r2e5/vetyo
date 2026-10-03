import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/app_single_child_scroll_view/app_single_child_scroll_view.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';
import 'package:vetyo/core/helpers/bottom_dialogs.dart';
import 'package:vetyo/core/common/custom_listview/custom_list_tile.dart';

class EditDoctorProfileScreen extends StatefulWidget {
  const EditDoctorProfileScreen({super.key});

  @override
  State<EditDoctorProfileScreen> createState() =>
      _EditDoctorProfileScreenState();
}

class _EditDoctorProfileScreenState extends State<EditDoctorProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formValues = {};

  // Awards section key for custom widget
  final GlobalKey<DynamicAwardsSectionState> _awardsKey =
      GlobalKey<DynamicAwardsSectionState>();

  // Profile picture management
  File? _profileImage;

  late List<CustomFormFieldConfig> _formFields;

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initializeFormFields() {
    _formFields = [
      CustomFormFieldConfig(
        id: 'fullName',
        label: 'Full Name',
        // hintText: 'Enter Your Name',
        fieldType: FieldType.text,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'qualification',
        label: 'Your Qualification',
        // hintText: 'Enter Your Academic Qualification',
        fieldType: FieldType.text,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'registrationNumber',
        label: 'Registration Number',
        // hintText: 'Enter Registration Number',
        fieldType: FieldType.text,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'experience',
        label: 'Experience',
        // hintText: 'Enter Your Working Experience',
        fieldType: FieldType.text,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'averagePatients',
        label: 'Average Patients',
        // hintText: 'Enter the number of average patients till now',
        fieldType: FieldType.number,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'aboutMe',
        label: 'About Me',
        hintText: 'Write about yourself',
        fieldType: FieldType.multiLine,
        maxLines: 3,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        id: 'expertise',
        label: 'Area Of Expertise',
        // hintText: 'Select',
        fieldType: FieldType.dropDown,
        options: [
         'Small Animal Specialist',
          'Large Animal Specialist',
          'Exotic Animal Specialist',
          'Emergency Veterinarian',
          'Surgery Specialist',
        ],
        isRequired: true,
      ),
    ];
  }

  void _onFormFieldsUpdated(dynamic values) {
    setState(() {
      formValues = values as Map<String, dynamic>;
    });
  }

  // Profile image picker methods
  Future<void> _showProfileImagePicker() async {
    BottomDialog.showBottomDialog(
      context: context,
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Profile Picture',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Satoshi",
              ),
            ),
            SizedBox(height: 20.h),
            _buildImagePickerOption(
              icon: Icons.photo_library,
              label: 'Gallery',
              onTap: () => _pickFromGallery(),
            ),
            SizedBox(height: 12.h),
            _buildImagePickerOption(
              icon: Icons.camera_alt,
              label: 'Camera',
              onTap: () => _pickFromCamera(),
            ),
            if (_profileImage != null) ...[
              SizedBox(height: 12.h),
              _buildImagePickerOption(
                icon: Icons.delete,
                label: 'Remove',
                onTap: () => _removeProfileImage(),
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: CustomListTile(
        onPress: onTap,
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Satoshi",
          ),
        ),
        leading: Icon(icon, size: 24.sp),
      ),
    );
  }

  Future<void> _pickFromGallery() async {
    Navigator.pop(context);
    final result = await ImageUtils.customImagePicker();
    if (result != null && result != '') {
      setState(() {
        _profileImage = result is File ? result : File(result);
      });
      showSnackBar(context, 'Profile picture updated successfully!');
    }
  }

  Future<void> _pickFromCamera() async {
    Navigator.pop(context);
    final result = await ImageUtils.customCameraPicker();
    if (result != null && result != '') {
      setState(() {
        _profileImage = result is File ? result : File(result);
      });
      showSnackBar(context, 'Profile picture updated successfully!');
    }
  }

  void _removeProfileImage() {
    Navigator.pop(context);
    setState(() {
      _profileImage = null;
    });
    showSuccessSnackBar(context, 'Profile picture removed!');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        "Edit Profile",
        style: context.textBlackStyle().semiBold.header4,
      ),
      centerTitle: true,
      bodyColor: Colors.white,
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: AppSingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Profile Picture Section
                  _ProfilePictureWidget(
                    profileImage: _profileImage,
                    onTap: _showProfileImagePicker,
                  ),
                  // Form Fields using CustomFormFieldGenerator
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        CustomFormFieldGenerator(
                          formKey: _formKey,
                          formFields: _formFields,
                          onFieldSubmitted: _onFormFieldsUpdated,
                        ),
                        DynamicAwardsSection(key: _awardsKey),
                        _CustomSaveButton(onPressed: _saveChanges),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    // Get awards data from custom widget
    List<Map<String, String>> awardData = [];
    if (_awardsKey.currentState != null) {
      awardData = _awardsKey.currentState!.getAwardsData();
    }

    // Implement save functionality with award data
    print('Form Values: $formValues');
    print('Awards Data: $awardData');

    showSuccessSnackBar(
      context,
      'Profile updated successfully with ${awardData.length} award(s)!',
    );
  }
}

// Custom Widget for Dynamic Awards Section
class DynamicAwardsSection extends StatefulWidget {
  const DynamicAwardsSection({super.key});

  @override
  State<DynamicAwardsSection> createState() => DynamicAwardsSectionState();
}

class DynamicAwardsSectionState extends State<DynamicAwardsSection> {
  List<AwardItem> awards = [AwardItem()]; // Start with one award item

  @override
  void dispose() {
    // Dispose all award controllers
    for (var award in awards) {
      award.titleController.dispose();
    }
    super.dispose();
  }

  // Add new award item
  void _addAward() {
    setState(() {
      awards.add(AwardItem());
    });
  }

  // Remove award item
  void _removeAward(int index) {
    if (awards.length > 1) {
      // Keep at least one award
      setState(() {
        awards[index].titleController.dispose();
        awards.removeAt(index);
      });
    }
  }

  // Get all awards data
  List<Map<String, String>> getAwardsData() {
    List<Map<String, String>> awardData = [];
    for (int i = 0; i < awards.length; i++) {
      awardData.add({
        'title': awards[i].titleController.text,
        'image': awards[i].selectedImage ?? '',
      });
    }
    return awardData;
  }

  void _selectImage(int index) {
    BottomDialog.showBottomDialog(
      context: context,
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Award Image ${index + 1}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Satoshi",
              ),
            ),
            SizedBox(height: 20.h),
            _buildImagePickerOption(
              icon: Icons.photo_library,
              label: 'Gallery',
              onTap: () => _pickAwardImage(index, ImageSource.gallery),
            ),
            SizedBox(height: 12.h),
            _buildImagePickerOption(
              icon: Icons.camera_alt,
              label: 'Camera',
              onTap: () => _pickAwardImage(index, ImageSource.camera),
            ),
            if (awards[index].selectedImageFile != null) ...[
              SizedBox(height: 12.h),
              _buildImagePickerOption(
                icon: Icons.delete,
                label: 'Remove',
                onTap: () => _removeAwardImage(index),
              ),
            ],
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: CustomListTile(
        onPress: onTap,
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Satoshi",
          ),
        ),
        leading: Icon(icon, size: 24.sp),
      ),
    );
  }

  Future<void> _pickAwardImage(int index, ImageSource source) async {
    Navigator.pop(context);
    try {
      final result =
          source == ImageSource.camera
              ? await ImageUtils.customCameraPicker()
              : await ImageUtils.customImagePicker();

      if (result != null && result != '') {
        setState(() {
          awards[index].selectedImageFile =
              result is File ? result : File(result);
          awards[index].selectedImage = awards[index].selectedImageFile!.path;
        });

        showSnackBar(context, 'Award image ${index + 1} updated successfully!');
      }
    } catch (e) {
      showErrorSnackBar(context, 'Failed to pick image. Please try again.');
    }
  }

  void _removeAwardImage(int index) {
    Navigator.pop(context);
    setState(() {
      awards[index].selectedImageFile = null;
      awards[index].selectedImage = null;
    });
    showSnackBar(context, 'Award image ${index + 1} removed!');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and plus icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Award & Certifications',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: "Satoshi",
              ),
            ),

            GestureDetector(
              onTap: _addAward, // Call the add award function
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34F5C6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 20.sp,
                  color: const Color(0xFF0A3128),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Dynamic list of awards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: awards.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            return _buildAwardItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildAwardItem(int index) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Award header with remove button (only show if more than 1 award)
          if (awards.length > 1)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Award ${index + 1}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0A3128),
                    fontFamily: "Satoshi",
                  ),
                ),
                GestureDetector(
                  onTap: () => _removeAward(index),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF4444),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),

          if (awards.length > 1) SizedBox(height: 12.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image upload box
              GestureDetector(
                onTap: () => _selectImage(index),
                child: Container(
                  width: 104.w,
                  height: 68.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF0A3128),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    color:
                        awards[index].selectedImageFile != null
                            ? Colors.grey[200]
                            : Colors.white,
                  ),
                  child:
                      awards[index].selectedImageFile != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.file(
                              awards[index].selectedImageFile!,
                              fit: BoxFit.cover,
                              width: 104.w,
                              height: 68.h,
                            ),
                          )
                          : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 20.sp,
                                  color: const Color(0xFF0A3128),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF0A3128),
                                    fontFamily: "Satoshi",
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
              ),

              SizedBox(height: 12.h),

              // Award title field
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979797)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: awards[index].titleController,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF2F2F2F),
                    fontFamily: "Satoshi",
                  ),
                  decoration: InputDecoration(
                    hintText: 'Award title',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF979797),
                      fontFamily: "Satoshi",
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(11.w),
                  ),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper class to manage individual award items
class AwardItem {
  final TextEditingController titleController = TextEditingController();
  String? selectedImage;
  File? selectedImageFile;

  AwardItem();
}

// Custom Widgets

class _ProfilePictureWidget extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onTap;

  const _ProfilePictureWidget({
    required this.profileImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 109.w,
        height: 109.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.18371, 0.80506],
            colors: [const Color(0x4D34F5C6), const Color(0x4D1DCDFE)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(11.w),
          child: Stack(
            children: [
              Container(
                width: 87.w,
                height: 87.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD9D9D9),
                  image:
                      profileImage != null
                          ? DecorationImage(
                            image: FileImage(profileImage!),
                            fit: BoxFit.cover,
                          )
                          : DecorationImage(
                            image: AssetImage(AppImages.avatarImage),
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18.sp,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CustomSaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF34F5C6),
          foregroundColor: const Color(0xFF0A3128),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Satoshi",
          ),
        ),
      ),
    );
  }
}
