import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/image_utils.dart';

class AddEvidenceScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const AddEvidenceScreen({super.key, this.onContinue, this.onBack});

  @override
  State<AddEvidenceScreen> createState() => _AddEvidenceScreenState();
}

class _AddEvidenceScreenState extends State<AddEvidenceScreen> {
  List<File> selectedImages = [];
  bool isLoading = false;
  static const int maxImages = 10; // Maximum number of images allowed

  Future<void> _pickImage() async {
    // Check if we can add more images
    if (selectedImages.length >= maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum $maxImages images allowed',
            style: TextStyle(fontFamily: "Satoshi"),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print("📱 Picking single image from gallery...");
      final result = await ImageUtils.customImagePicker();
      print("📱 Image picker result: $result (type: ${result.runtimeType})");

      if (result != null && result is File) {
        print("📱 Adding image to selectedImages: ${result.path}");
        setState(() {
          selectedImages.add(result);
        });
        print("📱 Total images now: ${selectedImages.length}");
        _notifyEvidenceUpdate(); // Notify parent of changes
      } else {
        print("📱 No image selected or invalid result");
      }
    } catch (e) {
      print("📱 Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to pick image: ${e.toString()}',
              style: TextStyle(fontFamily: "Satoshi"),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickMultipleImages() async {
    // Check if we can add more images
    if (selectedImages.length >= maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum $maxImages images allowed',
            style: TextStyle(fontFamily: "Satoshi"),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print("📱 Picking multiple images from gallery...");
      final List<File> results = await ImageUtils.customMultipleImagePicker();
      print("📱 Multiple image picker results: ${results.length} images");

      if (results.isNotEmpty) {
        // Check how many images we can actually add
        int remainingSlots = maxImages - selectedImages.length;
        List<File> imagesToAdd = results.take(remainingSlots).toList();

        setState(() {
          selectedImages.addAll(imagesToAdd);
        });

        print(
          "📱 Added ${imagesToAdd.length} images. Total images now: ${selectedImages.length}",
        );
        _notifyEvidenceUpdate(); // Notify parent of changes

        if (mounted) {
          String message =
              'Added ${imagesToAdd.length} image${imagesToAdd.length > 1 ? 's' : ''}';
          if (results.length > imagesToAdd.length) {
            message +=
                ' (${results.length - imagesToAdd.length} skipped - limit reached)';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message, style: TextStyle(fontFamily: "Satoshi")),
              backgroundColor:
                  imagesToAdd.length == results.length
                      ? Colors.green
                      : Colors.orange,
            ),
          );
        }
      } else {
        print("📱 No images selected");
      }
    } catch (e) {
      print("📱 Error picking multiple images: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to pick images: ${e.toString()}',
              style: TextStyle(fontFamily: "Satoshi"),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _captureImage() async {
    // Check if we can add more images
    if (selectedImages.length >= maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum $maxImages images allowed',
            style: TextStyle(fontFamily: "Satoshi"),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print("📸 Capturing image with camera...");
      final result = await ImageUtils.customCameraPicker();
      print("📸 Camera result: $result (type: ${result.runtimeType})");

      if (result != null && result is File) {
        print("📸 Adding captured image to selectedImages: ${result.path}");
        setState(() {
          selectedImages.add(result);
        });
        print("📸 Total images now: ${selectedImages.length}");
        _notifyEvidenceUpdate(); // Notify parent of changes
      } else {
        print("📸 No image captured or invalid result");
      }
    } catch (e) {
      print("📸 Error capturing image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to capture image: ${e.toString()}',
              style: TextStyle(fontFamily: "Satoshi"),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    _notifyEvidenceUpdate();
  }

  /// Notify parent about evidence updates
  void _notifyEvidenceUpdate() {
    final evidenceData = {
      'images': selectedImages.map((file) => file.path).toList(),
      'image_count': selectedImages.length,
    };

    if (widget.onContinue != null) {
      widget.onContinue!(evidenceData);
    }
  }

  /// Gather evidence data and notify parent
  void gatherAndNotifyEvidence() {
    _notifyEvidenceUpdate();
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library, color: Color(0xFF1DC7F2)),
                  title: Text(
                    'Select Single Image',
                    style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
                Divider(height: 1.h),
                ListTile(
                  leading: Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF1DC7F2),
                  ),
                  title: Text(
                    'Select Multiple Images',
                    style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickMultipleImages();
                  },
                ),
                Divider(height: 1.h),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Color(0xFF1DC7F2)),
                  title: Text(
                    'Take Photo',
                    style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _captureImage();
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // Title and Subtitle
                  SizedBox(
                    width: 327.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Add Evidence',
                          style:
                              context
                                  .textBlackStyle()
                                  .semiBold
                                  .large
                                  .withSatoshi,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Upload photos of your pet that show\nabout his condition or anything\nthat is important for the\ndoctor to see.\n\nYou can select up to $maxImages images.',
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

                  SizedBox(height: 88.h),

                  // Image Upload Box
                  Center(
                    child: GestureDetector(
                      onTap: isLoading ? null : _showImagePickerOptions,
                      child: Container(
                        width: 189.w,
                        height: 160.h,
                        decoration: BoxDecoration(
                          color:
                              isLoading
                                  ? const Color(0xFFE0E0E0)
                                  : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child:
                              isLoading
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFF1DC7F2),
                                            ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Loading...',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xFF666666),
                                          fontFamily: "Satoshi",
                                        ),
                                      ),
                                    ],
                                  )
                                  : Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 48.w,
                                    color: const Color(0xFFB0B0B0),
                                  ),
                        ),
                      ),
                    ),
                  ),

                  // Display Selected Images
                  if (selectedImages.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    Text(
                      'Selected Images (${selectedImages.length}/$maxImages)',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0A0A0A),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.file(
                                  selectedImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    print("❌ Error loading image: $error");
                                    return Container(
                                      color: Color(0xFFF0F0F0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.broken_image,
                                            color: Color(0xFF999999),
                                            size: 24.w,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'Error',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Color(0xFF999999),
                                              fontFamily: "Satoshi",
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4.h,
                              right: 4.w,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],

                  SizedBox(height: 295.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
