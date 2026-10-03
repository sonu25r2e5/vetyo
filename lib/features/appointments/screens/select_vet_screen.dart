import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_fonts.dart';
import 'package:vetyo/constants/font_size.dart';
import 'package:vetyo/constants/font_weight.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/appointments/widgets/appointment_vet_card.dart';
import 'package:vetyo/features/vets/screens/all_vets_screen.dart';

class SelectVetScreen extends StatefulWidget {
  final Function(Vet?)? onVetSelected;
  const SelectVetScreen({super.key, this.onVetSelected});

  @override
  State<SelectVetScreen> createState() => _SelectVetScreenState();
}

class _SelectVetScreenState extends State<SelectVetScreen> {
  Vet? _selectedVet;
  late List<Vet> _filteredVets;

  @override
  void initState() {
    super.initState();
    _filteredVets = vets;
  }

  void _updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredVets = vets;
      } else {
        _filteredVets =
            vets
                .where(
                  (vet) =>
                      vet.name.toLowerCase().contains(query.toLowerCase()) ||
                      vet.specialty.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      vet.location.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  void _selectVet(Vet vet) {
    setState(() {
      _selectedVet = vet;
    });
    // Notify parent widget about selection
    widget.onVetSelected?.call(vet);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// App Bar

        /// Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorPalete.clinicCloud[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: ColorPalete.neutral[400],
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      onChanged: _updateSearch,
                      decoration: InputDecoration(
                        hintText: context.l10n.searchVets,
                        hintStyle:
                            context
                                .textStyle(
                                  palette: ColorPalete.neutral,
                                  swatch: 400,
                                )
                                .largeBody
                                .regular
                                .withSatoshi,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Space
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

        /// Found Count and Sort
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.vetsFound(_filteredVets.length),
                  style:
                      context
                          .textBlackStyle()
                          .header5
                          .bold
                          .withSatoshi
                          .healingGreen900,
                ),
                Row(
                  children: [
                    Text(
                      context.l10n.defaultSort,
                      style: TextStyle(
                        fontSize: FontSize.largeBody,
                        fontWeight: AppFontWeight.bold,
                        color: ColorPalete.neutral[500],
                        fontFamily: AppFonts.satoshi,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.swap_vert,
                      size: 14.sp,
                      color: ColorPalete.neutral[500],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// Space
        SliverToBoxAdapter(child: SizedBox(height: 8.h)),

        /// Vets List
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final vet = _filteredVets[index];
            final isSelected = _selectedVet?.name == vet.name;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: SelectableVetCard(
                vet: vet,
                isSelected: isSelected,
                onTap: () => _selectVet(vet),
              ),
            );
          }, childCount: _filteredVets.length),
        ),

        /// Bottom Padding
        SliverToBoxAdapter(child: SizedBox(height: 40.h)),
      ],
    );
  }
}

/// Custom widget that adds selection state to VetCard
class SelectableVetCard extends StatelessWidget {
  final Vet vet;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableVetCard({
    super.key,
    required this.vet,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF1DC7F2) : const Color(0xFFF5F5F5),
            width: isSelected ? 2 : 0.5,
          ),
        ),
        child: AppointmentVetCard(
          // onPressed: ,
          name: vet.name,
          specialty: vet.specialty,
          distance: vet.location,
          imageUrl: vet.imageUrl,
          rating: vet.rating,
          reviewsNo: vet.reviews,
          onTap: onTap,
        ),
      ),
    );
  }
}
