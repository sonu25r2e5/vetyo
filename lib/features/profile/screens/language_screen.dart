import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/language/cubit/language_cubit.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  void _onSelect(String isoCode) {
    context.read<LanguageCubit>().changeLanguage(isoCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to $isoCode'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _languageTile({
    required String isoCode,
    required String label,
    required String flag,
    required String currentIso,
  }) {
    final bool selected = currentIso == isoCode;
    return InkWell(
      onTap: () => _onSelect(isoCode),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFF3F4F6)),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 20.sp)),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: const Color(0xFF1DC7F2))
            else
              Icon(Icons.circle_outlined, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, state) {
            final current = state.languageCode;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _languageTile(
                  isoCode: 'en',
                  label: 'English',
                  flag: '🇺🇸',
                  currentIso: current,
                ),
                SizedBox(height: 12.h),
                _languageTile(
                  isoCode: 'ne',
                  label: 'नेपाली',
                  flag: '🇳🇵',
                  currentIso: current,
                ),
                const Spacer(),
                Text(
                  'App language affects UI strings only.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
