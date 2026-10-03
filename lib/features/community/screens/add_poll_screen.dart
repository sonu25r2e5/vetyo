import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class AddPollScreen extends StatefulWidget {
  const AddPollScreen({super.key});

  @override
  State<AddPollScreen> createState() => _AddPollScreenState();
}

class _AddPollScreenState extends State<AddPollScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];

  final List<String> _options = ['', ''];
  String _duration = '1 day';
  bool _anonymous = true;
  bool _allowMultiple = false;
  List<TextEditingController> _optionControllers = [];

  File? _pickedImage;
  File? _pickedVideo;

  final List<String> _durations = ['1 day', '3 days', '1 week'];

  @override
  void initState() {
    super.initState();
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.multiLine,
        id: 'question',
        label: 'Poll Question',
        hintText: 'Ask something to the community',
        showLabel: true,
        maxLines: 4,
        isRequired: true,
      ),
    ];
    // initialize controllers for options
    _optionControllers =
        _options.map((e) => TextEditingController(text: e)).toList();
  }

  // Future<void> _openCamera() async {
  //   final res = await ImageUtils.customCameraPicker();
  //   if (res is File) {
  //     setState(() {
  //       _pickedImage = res;
  //       _pickedVideo = null;
  //     });
  //   }
  // }

  // Future<void> _pickVideo() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.video,
  //   );
  //   if (result != null && result.files.single.path != null) {
  //     setState(() {
  //       _pickedVideo = File(result.files.single.path!);
  //       _pickedImage = null;
  //     });
  //   }
  // }

  void _removeMedia() {
    setState(() {
      _pickedImage = null;
      _pickedVideo = null;
    });
  }

  void _addOption() {
    setState(() {
      _options.add('');
      _optionControllers.add(TextEditingController(text: ''));
    });
  }

  void _removeOption(int index) {
    if (_options.length > 2) {
      setState(() {
        _options.removeAt(index);
        // dispose controller and remove
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onPublish() {
    final question = formData['question'] ?? '';
    final validOptions = _options.where((o) => o.trim().isNotEmpty).toList();
    if (question.toString().trim().isEmpty || validOptions.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a question and at least two options'),
        ),
      );
      return;
    }

    final payload = {
      'question': question,
      'options': validOptions,
      'duration': _duration,
      'anonymous': _anonymous,
      'allowMultiple': _allowMultiple,
      'image': _pickedImage?.path,
      'video': _pickedVideo?.path,
    };

    debugPrint('Publish poll: $payload');
    Navigator.pop(context, payload);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure controllers list matches number of options (handles hot reload state)
    if (_optionControllers.length < _options.length) {
      for (int i = _optionControllers.length; i < _options.length; i++) {
        _optionControllers.add(TextEditingController(text: _options[i]));
      }
    } else if (_optionControllers.length > _options.length) {
      for (int i = _optionControllers.length - 1; i >= _options.length; i--) {
        _optionControllers[i].dispose();
        _optionControllers.removeAt(i);
      }
    }
    return BasePage(
      title: Text('Create Poll', style: context.textBlackStyle().header4),
      centerTitle: false,
      showBackButton: true,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 16.h,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // SizedBox(height: 16.h),

                      // Question field using form generator
                      CustomFormFieldGenerator(
                        formKey: _formKey,
                        formFields: formFields,
                        onFieldSubmitted: (data) => formData = data ?? {},
                      ),

                      SizedBox(height: 12.h),

                      // Options list
                      Text(
                        'Options',
                        style: context
                            .textBlackStyle()
                            .medium
                            .semiBold
                            .copyWith(color: ColorPalete.brightSky[700]),
                      ),
                      SizedBox(height: 8.h),
                      ...List.generate(_options.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  config: CustomFormFieldConfig(
                                    id: 'option_$index',
                                    label: 'Option ${index + 1}',
                                    showLabel: false,
                                    fieldType: FieldType.text,
                                    controller: _optionControllers[index],
                                    prefixIcon: Icon(
                                      Icons.drag_indicator,
                                      color: ColorPalete.brightSky[950],
                                    ),
                                    hintText: 'Option ${index + 1}',
                                    isRequired: false,
                                    onChanged:
                                        (v) =>
                                            setState(() => _options[index] = v),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              if (_options.length > 2)
                                GestureDetector(
                                  onTap: () => _removeOption(index),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),

                      CustomDottedButton(
                        label: 'Add option',
                        labelColor: ColorPalete.brightSky[950],
                        onPressed: _addOption,
                        color: ColorPalete.brightSky[50],
                        isIconLeft: true,
                        height: 36.h,
                        width: double.infinity,
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: ColorPalete.brightSky[950],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Poll Settings (from Figma)
                      SizedBox(height: 8.h),
                      Text(
                        'Poll Settings',
                        style: context.textBlackStyle().large.semiBold,
                      ),
                      SizedBox(height: 16.h),

                      // Duration row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Poll Duration',
                                  style:
                                      context.textBlackStyle().medium.semiBold,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'How long the poll will remain\nactive',
                                  style: context
                                      .textBlackStyle()
                                      .small
                                      .regular
                                      .copyWith(color: ColorPalete.slate[500]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            height: 40.h,
                            width: 127.w,
                            decoration: BoxDecoration(
                              color: ColorPalete.slate[100],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _duration,
                                  isExpanded: true,
                                  items:
                                      _durations
                                          .map(
                                            (d) => DropdownMenuItem(
                                              value: d,
                                              child: Text(d),
                                            ),
                                          )
                                          .toList(),
                                  onChanged:
                                      (v) => setState(
                                        () => _duration = v ?? _duration,
                                      ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Allow multiple answers toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Allow multiple answers',
                                  style:
                                      context.textBlackStyle().medium.semiBold,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Users can select more than one option',
                                  style: context
                                      .textBlackStyle()
                                      .small
                                      .regular
                                      .copyWith(color: ColorPalete.slate[500]),
                                ),
                              ],
                            ),
                          ),
                          Switch.adaptive(
                            value: _allowMultiple,
                            activeColor: ColorPalete.brightSky[500],
                            onChanged:
                                (v) => setState(() => _allowMultiple = v),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Anonymous voting toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Anonymous voting',
                                  style:
                                      context.textBlackStyle().medium.semiBold,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Hide voter identities from results',
                                  style: context
                                      .textBlackStyle()
                                      .small
                                      .regular
                                      .copyWith(color: ColorPalete.slate[500]),
                                ),
                              ],
                            ),
                          ),
                          Switch.adaptive(
                            value: _anonymous,
                            activeColor: ColorPalete.brightSky[500],
                            onChanged: (v) => setState(() => _anonymous = v),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // Media preview
                      if (_pickedImage != null || _pickedVideo != null) ...[
                        SizedBox(height: 8.h),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.grey[200],
                              ),
                              child:
                                  _pickedImage != null
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        child: Image.file(
                                          _pickedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      : Center(
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          size: 48,
                                          color: Colors.black45,
                                        ),
                                      ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
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

                      // Controls: camera/photo/video + duration + anonymous
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: _openCamera,
                      //       icon: Icon(
                      //         Icons.camera_alt_outlined,
                      //         color: ColorPalete.brightSky[600],
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: _pickImage,
                      //       icon: Icon(
                      //         Icons.image_outlined,
                      //         color: ColorPalete.brightSky[600],
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: _pickVideo,
                      //       icon: Icon(
                      //         Icons.videocam_outlined,
                      //         color: ColorPalete.brightSky[600],
                      //       ),
                      //     ),
                      //     SizedBox(width: 12.w),
                      //     Expanded(
                      //       child: DropdownButtonFormField<String>(
                      //         value: _duration,
                      //         items:
                      //             _durations
                      //                 .map(
                      //                   (d) =>
                      //                       DropdownMenuItem(value: d, child: Text(d)),
                      //                 )
                      //                 .toList(),
                      //         onChanged:
                      //             (v) => setState(() => _duration = v ?? _duration),
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8.r),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 12.w),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           'Anonymous',
                      //           style: context.textBlackStyle().small.regular,
                      //         ),
                      //         Switch(
                      //           value: _anonymous,
                      //           onChanged: (v) => setState(() => _anonymous = v),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ]),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: CustomButton(
                          height: 48.h,
                          width: double.infinity,
                          color: AppColor.brightSkyMain,
                          labelStyle:
                              context.textBlackStyle().regular.extraLarge.white,
                          label: 'Post Poll to Community',
                          onPressed: _onPublish,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
