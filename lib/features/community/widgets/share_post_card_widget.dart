import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class SharePostCardWidget extends StatefulWidget {
  const SharePostCardWidget({super.key});

  @override
  State<SharePostCardWidget> createState() => _SharePostCardWidgetState();
}

class _SharePostCardWidgetState extends State<SharePostCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalete.slate[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Share Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Share', style: context.textBlackStyle().header4.medium),
                  SizedBox(height: 8.h),
                  Divider(
                    color: ColorPalete.slate[200],
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // Share Options List
              Column(
                children: [
                  // Copy Link Option
                  _buildShareOption(
                    context,
                    icon: Icons.content_copy,
                    label: 'Copy Link',
                    onTap: () {
                      // Copy link to clipboard
                      showSnackBar(context, "Copied to clipboard");
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Share to Contacts
                  _buildShareOption(
                    context,
                    icon: Icons.person_add,
                    label: 'Share to Contacts',
                    onTap: () {
                      // Share to contacts
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Share via WhatsApp
                  _buildShareOption(
                    
                    context,
                    // isDestructive: true,
                    icon: Icons.share,
                    label: 'Share via WhatsApp',
                    onTap: () {
                      // Share via WhatsApp
                      Navigator.pop(context);
                    },
                  ),

                  // Share via Email
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorPalete.slate[200]!),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              // Icon Circle Background
              // Container(
              //   width: 56.w,
              //   height: 56.h,
              //   decoration: BoxDecoration(
              //     color:
              //         isDestructive
              //             ? ColorPalete.warning[50]
              //             : ColorPalete.white ,
              //     borderRadius: BorderRadius.circular(12.r),
              //   ),
              //   child:
              CircleAvatar(
                  radius: 24.r,
                
                backgroundColor: AppColor.greyColor,
                child: Center(
                    child: Icon(
                      icon,
                      size: 24.sp,
                      color:
                          isDestructive
                              ? ColorPalete.warning[600]
                              : ColorPalete.white,
                    ),
                  ),
              ),
              // ),
              
              SizedBox(width: 16.w),

              // Label
              Expanded(
                child: Text(
                  label,
                  style: context.textBlackStyle().extraLarge.medium.copyWith(
                    color:
                        isDestructive
                            ? ColorPalete.warning[600]
                            : ColorPalete.slate[900],
                  ),
                ),
              ),

              // Arrow Icon
            ],
          ),
        ),
      ),
    );
  }
}
