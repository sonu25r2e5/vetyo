import 'package:flutter/material.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/extention/color_extention.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool pushNotifications = false;
  bool emailNotifications = false;
  bool autoplayVideos = false;
  bool dataSaver = false;

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: context.textBlackStyle().small.copyWith(
          color: AppColor.supporting2Main, // subtle label
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _card({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0x80CED8DB),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(children: children),
    );
  }

  Widget _row({
    required Widget leading,
    required Widget title,
    Widget? trailing,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        subtitle,
                        style: context.textBlackStyle().small.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _iconCircle(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Color(0x80CED8DB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(icon, color: ColorPalete.oceanTeal.shade300, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const Text('Settings'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('PREFERENCES'),
              _card(
                children: [
                  _row(
                    leading: _iconCircle(Icons.language),
                    title: Text(
                      'Language',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'English',
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.languageScreen);
                    },
                  ),
                  const Divider(),
                  _row(
                    leading: _iconCircle(Icons.notifications_none),
                    title: Text(
                      'Push Notifications',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: Switch(
                      value: pushNotifications,
                      onChanged: (v) => setState(() => pushNotifications = v),
                    ),
                  ),
                  const Divider(),
                  _row(
                    leading: _iconCircle(Icons.email_outlined),
                    title: Text(
                      'Email Notifications',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: Switch(
                      value: emailNotifications,
                      onChanged: (v) => setState(() => emailNotifications = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              _sectionLabel('PRIVACY & SECURITY'),
              _card(
                children: [
                  _row(
                    leading: _iconCircle(Icons.lock_outline),
                    title: Text(
                      'Change Password',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.black38,
                    ),
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          RoutePaths.resetPasswordScreen,
                        ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              _sectionLabel('CONTENT'),
              _card(
                children: [
                  _row(
                    leading: _iconCircle(Icons.play_circle_outline),
                    title: Text(
                      'Autoplay Videos',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: Switch(
                      value: autoplayVideos,
                      onChanged: (v) => setState(() => autoplayVideos = v),
                    ),
                  ),
                  const Divider(),
                  _row(
                    leading: _iconCircle(Icons.favorite_border),
                    title: Text(
                      'Data Saver',
                      style: context.textBlackStyle().medium,
                    ),
                    subtitle: 'Lowers video quality to save mobile data',
                    trailing: Switch(
                      value: dataSaver,
                      onChanged: (v) => setState(() => dataSaver = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              _sectionLabel('ACCOUNT ACTIONS'),
              _card(
                children: [
                  _row(
                    leading: _iconCircle(Icons.info_outline),
                    title: Text(
                      'App Version',
                      style: context.textBlackStyle().medium,
                    ),
                    trailing: const Text(
                      'v1.0.1',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Divider(),
                  _row(
                    leading: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    title: Text(
                      'Delete Account',
                      style: context.textBlackStyle().medium.copyWith(
                        color: Colors.red,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.black38,
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
