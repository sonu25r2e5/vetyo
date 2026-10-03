import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentedCarouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const SegmentedCarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = index <= currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 32.w,
          height: 4.h,
          decoration: BoxDecoration(
            color:
                isActive
                    ? const Color(0xFF56F6CF) // green
                    : const Color(0xFFE0E0E0), // grey
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      }),
    );
  }
}
