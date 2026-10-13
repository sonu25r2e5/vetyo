import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/vets/screens/all_vets_screen.dart'
    show Vet, vets;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  static const List<String> _categories = [
    'All',
    'General',
    'Poultry',
    'Cattle',
    'Agriculture',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text('Favorites', style: context.textBlackStyle().header6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 38.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category == _selectedCategory;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedCategory = category);
                          }
                        },
                        labelStyle: TextStyle(
                          color:
                              isSelected
                                  ? Colors.white
                                  : const Color(0xFF475569),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        selectedColor: const Color(0xFF0F677F),
                        backgroundColor: const Color(0xFFF1F5F9),
                        side: BorderSide.none,
                        showCheckmark: false,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Veterinarians',
                  style: context.textBlackStyle().large.semiBold,
                ),
                SizedBox(height: 12.h),
                _buildVeterinarianGallery(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 22.sp, color: const Color(0xFF62748E)),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search vets',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
              icon: Icon(Icons.close, size: 18.sp),
              color: const Color(0xFF62748E),
              visualDensity: VisualDensity.compact,
              tooltip: 'Clear search',
            ),
        ],
      ),
    );
  }

  Widget _buildVeterinarianGallery() {
    final query = _searchController.text.trim().toLowerCase();
    final visibleVets =
        vets.where((vet) {
          final matchesCategory =
              _selectedCategory == 'All' ||
              _categoryForVet(vet) == _selectedCategory;
          final matchesSearch =
              query.isEmpty ||
              vet.name.toLowerCase().contains(query) ||
              vet.specialty.toLowerCase().contains(query) ||
              vet.location.toLowerCase().contains(query);
          return matchesCategory && matchesSearch;
        }).toList();

    if (visibleVets.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: Text(
            'No veterinarians found in this category',
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xFF62748E), fontSize: 14.sp),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visibleVets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: MediaQuery.of(context).size.height * 0.175,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final vet = visibleVets[index];
        return _VeterinarianCard(key: ValueKey(vet.name), vet: vet);
      },
    );
  }

  String _categoryForVet(Vet vet) {
    final specialty = vet.specialty.toLowerCase();
    if (specialty.contains('livestock') || specialty.contains('large animal')) {
      return 'Cattle';
    }
    return 'General';
  }
}

class _VeterinarianCard extends StatefulWidget {
  final Vet vet;

  const _VeterinarianCard({super.key, required this.vet});

  @override
  State<_VeterinarianCard> createState() => _VeterinarianCardState();
}

class _VeterinarianCardState extends State<_VeterinarianCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    final vet = widget.vet;
    final initials =
        vet.name
            .split(' ')
            .where((part) => part.isNotEmpty)
            .take(2)
            .map((part) => part[0])
            .join()
            .toUpperCase();

    return SingleChildScrollView(
      padding: EdgeInsets.all(2),
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x140F172A),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // otor image
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(AppImages.avatarImage),
                ),
                // const Spacer(),
                // Vetname lies here
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      vet.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      vet.specialty,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: const Color(0xFF62748E),
                        ),
                        // SizedBox(height: 2),
                        Text('Cardiology Center, NEPAL'),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: const Color(0xFF62748E),
                        ),
                        Text('5 | '),
                        SizedBox(width: 1),
                        Text('1872\tReviews'),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _isFavorite = !_isFavorite);
                  },
                  tooltip:
                      _isFavorite
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.redAccent : Colors.grey,
                    size: 21.sp,
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
