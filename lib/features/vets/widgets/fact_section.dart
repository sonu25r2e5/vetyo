import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';

const String _petImageUrl =
    "https://www.figma.com/api/mcp/asset/c7798115-cb6a-4c5e-accf-3039a671c03f";

class FactSection extends StatefulWidget {
  const FactSection({super.key});

  @override
  State<FactSection> createState() => _FactSectionState();
}

class _FactSectionState extends State<FactSection> {
  int _currentIndex = 0;

  final List<FactItem> facts = [
    FactItem(
      title: 'Less Active Than\nUsual?',
      description: 'A sudden drop in energy is never\n"just a lazy day."',
      fact:
          'If your pet is avoiding play, walks, or\nmovement, it could be an early sign of\npain, illness, or discomfort see more..',
    ),
    FactItem(
      title: 'Another Fact\nTitle',
      description: 'Description text for the second fact\nitem',
      fact:
          'Detailed explanation about the fact\nwith more information to help pet\nowners understand their pet better',
    ),
    FactItem(
      title: 'Third Fact\nTitle',
      description: 'Third description text\nfor demonstration',
      fact:
          'Third fact explanation with important\ninformation about pet health and\nwell-being indicators',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: Stack(
        children: [
          // Carousel with PageView
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: facts.length,
            itemBuilder: (context, index) {
              return _FactCarousel(fact: facts[index], imageUrl: _petImageUrl);
            },
          ),
          // Carousel Indicators
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  facts.length,
                  (index) => Container(
                    width: index == _currentIndex ? 30.w : 6.w,
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color:
                          index == _currentIndex
                              ? const Color(0xFFFAFAFA)
                              : const Color(0xFFE5E5E5).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FactItem {
  final String title;
  final String description;
  final String fact;

  FactItem({
    required this.title,
    required this.description,
    required this.fact,
  });
}

class _FactCarousel extends StatelessWidget {
  final FactItem fact;
  final String imageUrl;

  const _FactCarousel({required this.fact, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorPalete.brightSky[800] ?? const Color(0xFF0F677F),
            ColorPalete.brightSky[300] ?? const Color(0xFF68DEFE),
            ColorPalete.healingGreen[100] ?? const Color(0xFFBBFCEC),
            ColorPalete.healingGreen[800] ?? const Color(0xFF1A7B63),
          ],
          stops: const [0.0, 0.32, 0.625, 1.0],
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -125.w,
            bottom: 0,
            child: Transform.scale(
              scaleX: -1.0,
              child: Image.network(
                imageUrl,
                width: 400.w,
                height: 300.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      fact.title,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Baloo 2',
                        color: Colors.white,
                        height: 1.125,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Description
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                          color: const Color(0xFF0F172B),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: fact.description.split('"')[0]),
                          TextSpan(
                            text: '"${fact.description.split('"')[1]}"',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Satoshi',
                              color: const Color(0xFF0F172B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 199.h),
                // FACT Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FACT',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Satoshi',
                        color: const Color(0xFFECFDF5),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      fact.fact,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Satoshi',
                        color: Colors.white,
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
