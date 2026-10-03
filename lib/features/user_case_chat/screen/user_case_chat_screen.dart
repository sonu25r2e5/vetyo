import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/features/doctor_chat_case/widgets/chat_message_bubble.dart';
import 'package:vetyo/features/doctor_chat_case/widgets/chat_options_menu.dart';
import 'package:vetyo/features/doctor_chat_case/widgets/consultation_info_card.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/font_weight.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;

class UserCaseChatScreen extends StatefulWidget {
  const UserCaseChatScreen({super.key});

  @override
  State<UserCaseChatScreen> createState() => _UserCaseChatScreenState();
}

class _UserCaseChatScreenState extends State<UserCaseChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  // State for attachments
  List<File> _selectedImages = [];
  List<PlatformFile> _selectedFiles = [];
  bool _isUploading = false;

  // Sample chat messages
  final List<Map<String, dynamic>> messages = [
    {
      'message':
          'I\'m looking at your intake form—you mentioned Max has a total loss of appetite and the situation feels urgent. How long has it been since he last ate, and is he acting \'painful\' or \'distressed\'?',
      'isSentByDoctor': true,
    },
    {
      'message':
          'It\'s been 24 hours since he touched food.He\'s usually obsessed with his meals.He\'s pacing around, whining, and he keeps looking at his stomach. He looks miserable.',
      'isSentByDoctor': false,
    },
    {
      'message':
          'I need you to feel his stomach very gently. Is it hard like a basketball, or soft? And does he try to snap or yelp when you touch it?',
      'isSentByDoctor': true,
    },
    {
      'message':
          'It\'s been 24 hours since he touched food.He\'s usually obsessed with his meals.He\'s pacing around, whining, and he keeps looking at his stomach. He looks miserable.',
      'isSentByDoctor': false,
    },
    {
      'message':
          'Based on the abdominal rigidity and his pacing, we cannot rule out a gastric obstruction or GDV (bloat). Is he drooling excessively or trying to vomit without anything coming up?',
      'isSentByDoctor': true,
    },
    {
      'message': 'These are usually the pictures when he is happy',
      'isSentByDoctor': false,
    },
    {
      'message':
          'Here is the pescription I have added so follow the pescription for better result.',
      'isSentByDoctor': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {}); // Rebuild to update send button color
    });
  }

  // Media selection methods
  Future<void> _showMediaSelectionBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _MediaSelectionBottomSheet(
            onCameraTap: _captureImageFromCamera,
            onGalleryTap: _selectImagesFromGallery,
            onFileTap: _selectFiles,
            onDocumentTap: _selectDocuments,
          ),
    );
  }

  Future<void> _captureImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
        _sendMediaMessage([File(image.path)], []);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture image: ${e.toString()}');
    }
  }

  Future<void> _selectImagesFromGallery() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        final List<File> imageFiles =
            images.map((image) => File(image.path)).toList();
        setState(() {
          _selectedImages.addAll(imageFiles);
        });
        _sendMediaMessage(imageFiles, []);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to select images: ${e.toString()}');
    }
  }

  Future<void> _selectFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(result.files);
        });
        _sendMediaMessage([], result.files);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to select files: ${e.toString()}');
    }
  }

  Future<void> _selectDocuments() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'rtf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(result.files);
        });
        _sendMediaMessage([], result.files);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to select documents: ${e.toString()}');
    }
  }

  void _sendMediaMessage(List<File> images, List<PlatformFile> files) {
    setState(() {
      _isUploading = true;
    });

    // Simulate upload process
    Future.delayed(const Duration(seconds: 1), () {
      final String messageText = _buildMediaMessageText(images, files);

      setState(() {
        messages.add({
          'message': messageText,
          'isSentByDoctor': true,
          'images': images.map((f) => f.path).toList(),
          'files': files.map((f) => f.name).toList(),
          'timestamp': DateTime.now(),
        });
        _isUploading = false;
        _selectedImages.clear();
        _selectedFiles.clear();
      });

      _scrollToBottom();
    });
  }

  String _buildMediaMessageText(List<File> images, List<PlatformFile> files) {
    final List<String> parts = [];

    if (images.isNotEmpty) {
      parts.add('${images.length} image${images.length > 1 ? 's' : ''}');
    }

    if (files.isNotEmpty) {
      parts.add('${files.length} file${files.length > 1 ? 's' : ''}');
    }

    return 'Sent ${parts.join(' and ')}';
  }

  void _sendTextMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'message': _messageController.text.trim(),
          'isSentByDoctor': true,
          'timestamp': DateTime.now(),
        });
      });

      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorPalete.error[500],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32.w,
            height: 30.79.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile_avatar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dr.Richa Karki',
                  style: context
                      .textBlackStyle()
                      .medium
                      .fontWeightMedium
                      .withSatoshi
                      .copyWith(color: ColorPalete.oceanTeal[900]),
                ),
                Text(
                  'Last seen 9:30 am',
                  style: context.textBlackStyle().smallBody.withSatoshi,
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: [
        Padding(
          padding: EdgeInsets.only(right: 12.sp),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.activeCaseDetailsScreen,
                  );
                },
                icon: Icon(Icons.file_copy, color: Colors.black, size: 20.sp),
              ),
              IconButton(
                onPressed: () {
                  _showOptionsMenu(context);
                },
                icon: Icon(Icons.more_vert, color: Colors.black, size: 28.sp),
              ),
            ],
          ),
        ),
      ],
      body: Stack(
        children: [
          // Background from Figma-inspired ellipse asset
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  AppImages.caseChatBackground,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  children: [
                    // Consultation Info Card
                    ConsultationInfoCard(
                      patientType: 'Dog',
                      breed: 'Poodle',
                      age: '6 months',
                      priorityLevel: 'High-priority consultation',
                    ),

                    // Chat messages
                    ...messages.map(
                      (msg) => ChatMessageBubble(
                        message: msg['message'],
                        isSentByDoctor: msg['isSentByDoctor'],
                        doctorImageUrl:
                            msg['isSentByDoctor']
                                ? 'assets/images/profile_avatar.jpg'
                                : null,
                      ),
                    ),

                    // Image attachments (for the "happy pictures" message)
                    Padding(
                      padding: EdgeInsets.only(left: 155.w, bottom: 16.h),
                      child: Row(
                        children: [
                          // Main large image
                          Container(
                            width: 110.w,
                            height: 104.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r),
                              ),
                            ),
                            child: Icon(
                              Icons.pets,
                              size: 40.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 2.w),
                          // Two smaller images stacked
                          Column(
                            children: [
                              Container(
                                width: 59.w,
                                height: 51.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Icon(
                                  Icons.pets,
                                  size: 20.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                width: 59.w,
                                height: 51.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Icon(
                                  Icons.pets,
                                  size: 20.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Prescription image
                    Padding(
                      padding: EdgeInsets.only(left: 35.w, bottom: 16.h),
                      child: Container(
                        width: 144.w,
                        height: 122.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(
                            color: const Color(0xFF21ABA5),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.description_outlined,
                          size: 40.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Message input area
              Container(
                color: const Color(0xFFEAE6E6),
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                child: Column(
                  children: [
                    // Upload progress indicator
                    if (_isUploading)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: ColorPalete.brightSky[50],
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: ColorPalete.brightSky[200]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16.w,
                              height: 16.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorPalete.brightSky[500]!,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Uploading media...',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorPalete.brightSky[700],
                                fontWeight: AppFontWeight.medium,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Input row
                    Row(
                      children: [
                        // Add button
                        GestureDetector(
                          onTap: _showMediaSelectionBottomSheet,
                          child: Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF22A487).withOpacity(0.3),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),

                        // Image button
                        GestureDetector(
                          onTap: _selectImagesFromGallery,
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color:
                                  _isUploading
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                            ),
                            child: Icon(
                              Icons.image_outlined,
                              color:
                                  _isUploading
                                      ? Colors.grey[600]
                                      : const Color(0xFF5E5E5E),
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),

                        // Camera button
                        GestureDetector(
                          onTap: _captureImageFromCamera,
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color:
                                  _isUploading
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color:
                                  _isUploading
                                      ? Colors.grey[600]
                                      : const Color(0xFF5E5E5E),
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Message input field
                        Expanded(
                          child: Container(
                            height: 36.h,
                            padding: EdgeInsets.symmetric(horizontal: 9.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6DDDD),
                              border: Border.all(
                                color: const Color(0xFF22A487),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Row(
                              children: [
                                // Emoji button
                                GestureDetector(
                                  onTap: () {
                                    // Handle emoji picker
                                  },
                                  child: Icon(
                                    Icons.emoji_emotions_outlined,
                                    color: const Color(0xFF5E5E5E),
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),

                                // Text input
                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF757575),
                                      fontFamily: "Satoshi",
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Message...',
                                      hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF757575),
                                        fontFamily: "Satoshi",
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 6.h,
                                      ),
                                    ),
                                  ),
                                ),

                                // Send button
                                GestureDetector(
                                  onTap: _sendTextMessage,
                                  child: Container(
                                    padding: EdgeInsets.all(2.w),
                                    child: Icon(
                                      Icons.send,
                                      color:
                                          _messageController.text.isNotEmpty
                                              ? const Color(0xFF1B836C)
                                              : Colors.grey[400],
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 16.w, // Right side
        kToolbarHeight +
            MediaQuery.of(context).padding.top +
            16.h, // Below header
        16.w, // Right padding
        0,
      ),
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 8,
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: const ChatOptionsMenu(),
        ),
      ],
    );
  }
}

// Custom Media Selection Bottom Sheet Widget
class _MediaSelectionBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onFileTap;
  final VoidCallback onDocumentTap;

  const _MediaSelectionBottomSheet({
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onFileTap,
    required this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Select Media',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: AppFontWeight.semiBold,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Media options
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Camera and Gallery row
                Row(
                  children: [
                    Expanded(
                      child: _MediaOptionTile(
                        icon: Icons.camera_alt_outlined,
                        title: 'Camera',
                        subtitle: 'Take a photo',
                        color: ColorPalete.brightSky[500]!,
                        onTap: () {
                          Navigator.pop(context);
                          onCameraTap();
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _MediaOptionTile(
                        icon: Icons.image_outlined,
                        title: 'Gallery',
                        subtitle: 'Choose photos',
                        color: ColorPalete.healingGreen[500]!,
                        onTap: () {
                          Navigator.pop(context);
                          onGalleryTap();
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Files and Documents row
                Row(
                  children: [
                    Expanded(
                      child: _MediaOptionTile(
                        icon: Icons.attach_file_outlined,
                        title: 'Files',
                        subtitle: 'Any file type',
                        color: ColorPalete.supporting2[400]!,
                        onTap: () {
                          Navigator.pop(context);
                          onFileTap();
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _MediaOptionTile(
                        icon: Icons.description_outlined,
                        title: 'Documents',
                        subtitle: 'PDF, DOC, TXT',
                        color: ColorPalete.supporting2[500]!,
                        onTap: () {
                          Navigator.pop(context);
                          onDocumentTap();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// Custom Media Option Tile Widget
class _MediaOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MediaOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: AppFontWeight.medium,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
