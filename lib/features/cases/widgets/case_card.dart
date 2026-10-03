import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CaseCard extends StatelessWidget {
  final String doctorName;
  final String experience;
  final String date;
  final String status; // 'active', 'pending', 'closed'
  final String imageUrl;
  final VoidCallback onViewCase;
  final VoidCallback? onReschedule;
  final VoidCallback onChat;

  const CaseCard({
    super.key,
    required this.doctorName,
    required this.experience,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.onViewCase,

    required this.onChat,
    this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChat,
      child: Container(
        height: 88.h,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Stack(
          children: [
            // Doctor Image
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 53.w,
                height: 51.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  image: DecorationImage(
                    image:
                        imageUrl.startsWith('http')
                            ? NetworkImage(imageUrl) as ImageProvider
                            : AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Doctor Info
            Positioned(
              left: 67.w,
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF232323),
                      fontFamily: "Satoshi",
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    experience,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF232323).withOpacity(0.7),
                      fontFamily: "Satoshi",
                    ),
                  ),
                ],
              ),
            ),

            // Status Badge
            Positioned(right: 5.w, top: 3.h, child: _buildStatusBadge()),

            // Date
            Positioned(
              right: 23.w,
              top: 24.h,
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF44403B),
                  fontFamily: "Satoshi",
                ),
              ),
            ),

            // Buttons
            Positioned(left: 65.w, bottom: 8.h, child: _buildActionButtons()),

            // Bottom Divider
            Positioned(
              left: 65.w,
              bottom: 0,
              right: 0,
              child: Container(height: 1.h, color: const Color(0xFFE5E5E5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = const Color(0xFFD6FDF4);
        textColor = const Color(0xFF08AC84);
        statusText = 'Active';
        icon = Icons.notifications_active;
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFEF3C6);
        textColor = const Color(0xFFBB4D00);
        statusText = 'Pending';
        icon = Icons.notifications_active;
        break;
      case 'closed':
        backgroundColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFC10007);
        statusText = 'Closed';
        icon = Icons.cloud_done_outlined;
        break;
      default:
        backgroundColor = const Color(0xFFD6FDF4);
        textColor = const Color(0xFF08AC84);
        statusText = 'Active';
        icon = Icons.notifications_active;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            statusText,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
              fontFamily: "Satoshi",
            ),
          ),
          SizedBox(width: 4.w),
          Icon(icon, size: 12.sp, color: textColor),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (status.toLowerCase() == 'closed' && onReschedule != null) {
      return Row(
        children: [
          GestureDetector(
            onTap: onReschedule,
            child: Container(
              width: 90.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF033D2F), width: 1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Reschedule',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF033D2F),
                  fontFamily: "Satoshi",
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onViewCase,
            child: Container(
              width: 90.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF08AC84),
                borderRadius: BorderRadius.circular(18.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'View Case',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: "Satoshi",
                ),
              ),
            ),
          ),
        ],
      );
    } else if (status.toLowerCase() == 'active') {
      return GestureDetector(
        onTap: onViewCase,
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF08AC84),
            borderRadius: BorderRadius.circular(18.r),
          ),
          alignment: Alignment.center,
          child: Text(
            'View Case',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: "Satoshi",
            ),
          ),
        ),
      );
    } else {
      // Pending status - no buttons
      return const SizedBox.shrink();
    }
  }
}

class UpdatedUserCaseCard extends StatelessWidget {
  final String doctorName;
  final String role; // e.g., 'Veterinarian'
  final String date;
  final String status;
  final String imageUrl;
  final VoidCallback onPrimaryAction; // view case
  final VoidCallback? onSecondaryAction; // reschedule
  final VoidCallback? onChat;

  const UpdatedUserCaseCard({
    super.key,
    required this.doctorName,
    required this.role,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.onPrimaryAction,
    this.onSecondaryAction,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChat,
      child: Container(
        // height: 100.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: context.applyAppColor(
            palette: ColorPalete.clinicCloud,
            swatch: 50,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.applyAppColor(
              palette: ColorPalete.brightSky,
              swatch: 200,
            ),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child:
                          imageUrl.isEmpty
                              ? Container(
                                width: 53.w,
                                height: 51.h,
                                color: context.applyAppColor(
                                  palette: ColorPalete.neutral,
                                  swatch: 100,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 26.sp,
                                  color: context.applyAppColor(
                                    palette: ColorPalete.neutral,
                                    swatch: 400,
                                  ),
                                ),
                              )
                              : Image(
                                image:
                                    imageUrl.startsWith('http')
                                        ? NetworkImage(imageUrl)
                                            as ImageProvider
                                        : AssetImage(imageUrl),
                                width: 53.w,
                                height: 51.h,
                                fit: BoxFit.cover,
                              ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: context.textBlackStyle().large.semiBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            role,
                            style:
                                context
                                    .textStyle(
                                      palette: ColorPalete.neutral,
                                      swatch: 400,
                                    )
                                    .small
                                    .regular,
                          ),
                          SizedBox(height: 8.h),

                          Row(
                            children: [
                              _SolidButton(
                                label: 'View Case',
                                onTap: onPrimaryAction,
                                backgroundColor: context.applyAppColor(
                                  palette: ColorPalete.white,
                                ),
                                borderColor: context.applyAppColor(
                                  palette: ColorPalete.brightSky,
                                  swatch: 200,
                                ),
                                textColor: Colors.black,
                              ),
                              SizedBox(width: 4.w),
                              _SolidButton(
                                label: "Reschedule",
                                onTap: () {},
                                borderColor: context.applyAppColor(
                                  palette: ColorPalete.brightSky,
                                  swatch: 200,
                                ),
                                backgroundColor: context.applyAppColor(
                                  palette: ColorPalete.brightSky,
                                  swatch: 200,
                                ),
                                textColor: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        _StatusBadge(status: status),
                        SizedBox(height: 8.h),

                        Text(
                          date,
                          style:
                              context
                                  .textStyle(
                                    palette: ColorPalete.neutral,
                                    swatch: 400,
                                  )
                                  .small
                                  .regular,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Positioned(right: 0, top: 2.h, child: ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final normalized = status.toLowerCase();
    Color bg;
    Color fg;

    switch (normalized) {
      case 'pending':
        bg = context.applyAppColor(palette: ColorPalete.warning, swatch: 200);
        fg = context.applyAppColor(palette: ColorPalete.warning, swatch: 900);
        break;
      case 'active':
        bg = context.applyAppColor(
          palette: ColorPalete.healingGreen,
          swatch: 100,
        );
        fg = context.applyAppColor(
          palette: ColorPalete.healingGreen,
          swatch: 900,
        );
        break;
      case 'closed':
        bg = context.applyAppColor(palette: ColorPalete.error, swatch: 100);
        fg = context.applyAppColor(palette: ColorPalete.error, swatch: 900);
        break;
      default:
        bg = context.applyAppColor(palette: ColorPalete.neutral, swatch: 100);
        fg = context.applyAppColor(palette: ColorPalete.neutral, swatch: 900);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Text(
        status,
        style: context
            .textStyle(palette: ColorPalete.neutral, swatch: 900)
            .small
            .bold
            .copyWith(color: fg),
      ),
    );
  }
}

class _SolidButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  // final double? width;

  const _SolidButton({
    required this.label,
    required this.onTap,
    // required this.width,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: width ?? 90.w,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.2),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Text(
          label,
          style: context.textBlackStyle().small.semiBold.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
