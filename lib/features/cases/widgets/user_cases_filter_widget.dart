import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';

class UserCasesFilterWidget extends StatefulWidget {
  final VoidCallback onSave;

  const UserCasesFilterWidget({super.key, required this.onSave});

  @override
  State<UserCasesFilterWidget> createState() => _UserCasesFilterWidgetState();
}

class _UserCasesFilterWidgetState extends State<UserCasesFilterWidget> {
  // Filters state
  int selectedCaseFilter =
      0; // 0: Favourites, 1: Closed, 2: All, 3: General, 4: Active
  int selectedTimeFilter = 1; // 0: 3 months, 1: 1 month, 2: Week

  List<String> get caseFilters => [
    context.l10n.all,
    context.l10n.newCase,
    context.l10n.active,
    context.l10n.pending,
    context.l10n.closed,
  ];
  List<String> get timeFilters => [
    context.l10n.threeMonths,
    context.l10n.twoMonths,
    context.l10n.oneMonth,
    context.l10n.oneWeekAgo,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 24.h),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (centered) with close button on the right
                SizedBox(
                  height: 36.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          context.l10n.filterYourCases,
                          textAlign: TextAlign.center,
                          style: context.textBlackStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context))
                              Navigator.of(context).pop();
                          },
                          child: Iconoir.Xmark(
                            width: 20.w,
                            height: 20.h,
                            color: ColorPalete.neutral[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Case Status Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.caseStatus,
                      style: context
                          .textStyle(
                            palette: ColorPalete.supporting2,
                            swatch: 500,
                          )
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 14.h),

                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 2.2,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: caseFilters.length,
                      itemBuilder:
                          (context, index) => _FilterChip(
                            label: caseFilters[index],
                            isSelected: selectedCaseFilter == index,
                            onTap: () {
                              setState(() {
                                selectedCaseFilter = index;
                              });
                            },
                          ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Time Period Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.timePeriod,
                      style: context
                          .textStyle(
                            palette: ColorPalete.supporting2,
                            swatch: 500,
                          )
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 14.h),

                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 2.2,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: timeFilters.length,
                      itemBuilder:
                          (context, index) => _FilterChip(
                            label: timeFilters[index],
                            isSelected: selectedTimeFilter == index,
                            onTap: () {
                              setState(() {
                                selectedTimeFilter = index;
                              });
                            },
                          ),
                    ),
                    // Wrap(
                    //   spacing: 10.w,
                    //   runSpacing: 10.h,
                    //   children: List.generate(
                    //     timeFilters.length,
                    //     (index) => _FilterChip(
                    //       label: timeFilters[index],
                    //       isSelected: selectedTimeFilter == index,
                    //       onTap: () {
                    //         setState(() {
                    //           selectedTimeFilter = index;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              height: 42.h,
              label: context.l10n.save,
              onPressed: widget.onSave,
              color: context.applyAppColor(
                palette: ColorPalete.healingGreen,
                swatch: 600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ColorPalete.brightSky.shade500
                  : ColorPalete.oceanTeal[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.textBlackStyle().copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color:
                  isSelected ? Colors.white : ColorPalete.clinicCloud.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
