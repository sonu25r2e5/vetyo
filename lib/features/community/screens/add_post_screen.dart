import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/utils/image_utils.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController customTagController = TextEditingController();

  File? _pickedImage;
  File? _pickedVideo;
  bool _showPoll = false;
  List<String> _pollOptions = ['Yes', 'No'];
  int _selectedCategoryIndex = -1;
  List<String> _customTags = [];

  final List<String> _categories = [
    '#dogs',
    '#healthtip',
    '#cattle',
    'General',
    '#Poultry',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    customTagController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final res = await ImageUtils.customImagePicker();
    if (res is File) {
      setState(() {
        _pickedImage = res;
        _pickedVideo = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedVideo = File(result.files.single.path!);
        _pickedImage = null;
      });
    }
  }

  Future<void> _openCamera() async {
    final res = await ImageUtils.customCameraPicker();
    if (res is File) {
      setState(() {
        _pickedImage = res;
        _pickedVideo = null;
      });
    }
  }

  void _removeMedia() {
    setState(() {
      _pickedImage = null;
      _pickedVideo = null;
    });
  }

  void _addCustomTag() {
    final tag = customTagController.text.trim();
    if (tag.isNotEmpty && !_customTags.contains(tag)) {
      setState(() {
        _customTags.add(tag);
        customTagController.clear();
      });
    }
  }

  void _removeCustomTag(String tag) {
    setState(() {
      _customTags.remove(tag);
    });
  }

  void _onPublish() {
    final title = titleController.text.trim();
    final body = descriptionController.text.trim();
    final payload = {
      'title': title,
      'body': body,
      'category':
          _selectedCategoryIndex >= 0
              ? _categories[_selectedCategoryIndex]
              : null,
      'customTags': _customTags,
      'image': _pickedImage?.path,
      'video': _pickedVideo?.path,
      'poll': _showPoll ? _pollOptions : null,
    };

    // For now, just print and pop. Replace with real submit logic.
    debugPrint('Publish payload: $payload');
    Navigator.pop(context, payload);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Text('Create Post', style: context.textBlackStyle().header4),
      showBackButton: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 21.r,
                    backgroundImage: const AssetImage(AppImages.avatarImage),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Posting to ',
                          style: context
                              .textBlackStyle()
                              .small
                              .regular
                              .copyWith(color: ColorPalete.oceanTeal[400]),
                        ),
                        Text(
                          'Vetyo Community',
                          style: context
                              .textBlackStyle()
                              .bold
                              .large
                              .withSatoshi
                              .copyWith(color: ColorPalete.oceanTeal[500]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Name Field
                    TextFormField(
                      style: context
                          .textBlackStyle()
                          .xlarge
                          .bold
                          .withSatoshi
                          .copyWith(color: ColorPalete.oceanTeal.shade200),
                      controller: titleController,

                      decoration: InputDecoration(
                        hintText: "Give a title to your post.",
                        hintStyle: context
                            .textBlackStyle()
                            .xlarge
                            .bold
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade200),

                        filled: true,
                        fillColor: Colors.white,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 16.h,
                        ),

                        /// Remove all borders
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                    Text(
                      "What's on your mind?",
                      style: context.textBlackStyle().medium.regular.copyWith(
                        color: ColorPalete.oceanTeal[400],
                      ),
                    ),
                    TextFormField(
                      style: context
                          .textBlackStyle()
                          .medium
                          .bold
                          .withSatoshi
                          .copyWith(color: ColorPalete.oceanTeal.shade200),
                      controller: descriptionController,
                      maxLines: 20,
                      decoration: InputDecoration(
                        hintText: "Give a title to your post.",
                        hintStyle: context
                            .textBlackStyle()
                            .medium
                            .bold
                            .withSatoshi
                            .copyWith(color: ColorPalete.oceanTeal.shade200),

                        filled: true,
                        fillColor: Colors.white,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 4.h,
                        ),

                        /// Remove all borders
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      child: Text(
                        'SELECT TAGS',
                        style: context
                            .textBlackStyle()
                            .small
                            .bold
                            .withSatoshi
                            .copyWith(
                              color: ColorPalete.oceanTeal.shade700,
                              letterSpacing: 1,
                            ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    SizedBox(
                      height: 38.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          return _buildTagChip(
                            label: _categories[index],
                            selected: index == _selectedCategoryIndex,
                            showClose: index == 0,
                            onTap: () {
                              setState(() {
                                _selectedCategoryIndex =
                                    _selectedCategoryIndex == index
                                        ? -1
                                        : index;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Expanded(child: _buildCustomTagInput()),
                        SizedBox(width: 8.w),

                        // GestureDetector(
                        //   onTap: _addCustomTag,
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 16.w,
                        //       vertical: 12.h,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: ColorPalete.brightSky[400],
                        //       borderRadius: BorderRadius.circular(20.r),
                        //     ),
                        //     child: Icon(
                        //       Icons.add,
                        //       color: Colors.white,
                        //       size: 20.sp,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    if (_customTags.isNotEmpty) ...[
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children:
                            _customTags
                                .map(
                                  (tag) => GestureDetector(
                                    onTap: () => _removeCustomTag(tag),
                                    child: _buildCustomTagChip(label: tag),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              Container(
                height: 1,
                width: double.infinity,
                color: ColorPalete.clinicCloud[200],
              ),

              SizedBox(height: 16.h),

              // Media preview
              if (_pickedImage != null || _pickedVideo != null) ...[
                SizedBox(height: 8.h),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey[200],
                      ),
                      child:
                          _pickedImage != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.file(
                                  _pickedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.videocam,
                                      size: 40.sp,
                                      color: ColorPalete.clinicCloud[400],
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Video selected',
                                      style:
                                          context
                                              .textBlackStyle()
                                              .medium
                                              .regular,
                                    ),
                                  ],
                                ),
                              ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: GestureDetector(
                        onTap: _removeMedia,
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 12.h),

              SizedBox(height: 32.h),

              Row(
                children: [
                  _buildFooterAction(
                    icon: Icons.videocam_outlined,
                    onTap: _pickVideo,
                  ),
                  SizedBox(width: 21.w),
                  _buildFooterAction(
                    icon: Icons.photo_camera_outlined,
                    onTap: _openCamera,
                  ),
                  SizedBox(width: 21.w),
                  _buildFooterAction(
                    icon: Icons.image_outlined,
                    onTap: _pickImage,
                  ),
                  SizedBox(width: 21.w),
                  _buildFooterAction(
                    icon: Icons.bar_chart_outlined,
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.addPollScreen);
                    },
                  ),
                  const Spacer(),

                  CustomButton(
                    height: 42.h,
                    width: 80.w,
                    color: ColorPalete.brightSky[50],
                    label: 'Post',
                    labelStyle: context.textBlackStyle().large.bold.copyWith(
                      color: ColorPalete.brightSky[300],
                    ),
                    onPressed: _onPublish,
                  ),
                ],
              ),

              if (_showPoll) ...[SizedBox(height: 12.h), _buildPollBuilder()],

              SizedBox(height: 13.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    bool showClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color:
              selected
                  ? ColorPalete.brightSky[400]
                  : ColorPalete.clinicCloud[300],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                selected
                    ? ColorPalete.brightSky[600]!
                    : ColorPalete.clinicCloud[400]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.textBlackStyle().medium.regular.copyWith(
                color: selected ? Colors.white : ColorPalete.oceanTeal.shade500,
              ),
            ),
            if (showClose) ...[
              SizedBox(width: 8.w),
              Icon(
                selected ? Icons.check_box : Icons.close,
                size: 18.sp,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTagChip({required String label}) {
    return DottedBorder(
      color: ColorPalete.brightSky[700]!,
      strokeWidth: 2,
      borderType: BorderType.RRect,
      radius: Radius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorPalete.brightSky[50],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.textBlackStyle().medium.regular.copyWith(
                color: ColorPalete.oceanTeal.shade200,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: ColorPalete.brightSky[400],
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(Icons.check, size: 16.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildCustomTagInput() {
  return DottedBorder(
    color: ColorPalete.brightSky[700]!,
    strokeWidth: 1.2,
    borderType: BorderType.RRect,
    radius: Radius.circular(20.r),
    child: Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorPalete.brightSky[50],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: TextFormField(
          controller: customTagController,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,

          style: context.textBlackStyle().medium.regular.copyWith(
            color: ColorPalete.oceanTeal.shade200,
          ),

          onFieldSubmitted: (_) => _addCustomTag(),

          decoration: InputDecoration(
            isDense: true,

            hintText: '# Type your tag',

            hintStyle: context.textBlackStyle().medium.regular.copyWith(
              color: ColorPalete.oceanTeal[400],
            ),

            suffixIcon: Align(
              alignment: Alignment.center,
              widthFactor: 1,
              heightFactor: 1,
              child: IconButton(
                onPressed: _addCustomTag,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.check_box,
                  size: 22.sp,
                  color: Colors.white,
                ),
              ),
            ),

            suffixIconConstraints: BoxConstraints(
              minHeight: 22.h,
              minWidth: 22.w,
            ),

            filled: true,
            fillColor: Colors.transparent,

            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}

  Widget _buildFooterAction({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
      icon: Icon(icon, color: ColorPalete.brightSky[600], size: 24.sp),
    );
  }

  Widget _buildPollBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create a poll', style: context.textBlackStyle().large.semiBold),
        SizedBox(height: 8.h),
        ...List.generate(_pollOptions.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _pollOptions[index],
                    onChanged:
                        (val) => setState(() => _pollOptions[index] = val),
                    decoration: InputDecoration(
                      hintText: 'Option ${index + 1}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                if (_pollOptions.length > 2)
                  GestureDetector(
                    onTap: () => setState(() => _pollOptions.removeAt(index)),
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
              ],
            ),
          );
        }),
        Row(
          children: [
            CustomButton(
              height: 42.h,
              onPressed: () => setState(() => _pollOptions.add('')),
              label: 'Add option',
              color: ColorPalete.brightSky[400],
              labelStyle: context.textBlackStyle().medium.regular.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
