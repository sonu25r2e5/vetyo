import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/features/notification/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    // Clear focus when leaving this screen
    FocusManager.instance.primaryFocus?.unfocus();
    super.deactivate();
  }

  // Sample notification data grouped by date
  final Map<String, List<Map<String, dynamic>>> notifications = {
    'Today': [
      {
        'title': 'Close case',
        'message':
            'Dr.Richa Karki has initiated to close case, agree if you want to close the case now.',
        'time': '1h',
        'icon': Icons.calendar_today,
        'iconBgColor': Color(0xFFD6FDF4),
        'iconColor': Color(0xFF078768),
        'isRead': false,
      },
      {
        'title': 'Appointment Cancelled',
        'message':
            'You have successfully cancelled your appointment with Dr. David Patel.',
        'time': '2h',
        'icon': Icons.event_busy,
        'iconBgColor': Color(0xFFFFE2E2),
        'iconColor': Color(0xFFDE1515),
        'isRead': false,
      },
      {
        'title': 'Scheduled Changed',
        'message':
            'You have successfully changes your appointment with Dr. Jesica Turner.',
        'time': '8h',
        'icon': Icons.edit_calendar,
        'iconBgColor': Color(0xFFF5F5F5),
        'iconColor': Color(0xFF737373),
        'isRead': true,
      },
    ],
    'Yesterday': [
      {
        'title': 'Appointment Success',
        'message':
            'You have successfully booked your appointment with Dr. Emily Walker.',
        'time': '1d',
        'icon': Icons.calendar_today,
        'iconBgColor': Color(0xFFD6FDF4),
        'iconColor': Color(0xFF078768),
        'isRead': true,
      },
    ],
  };

  void _markAllAsRead(String section) {
    setState(() {
      for (var notification in notifications[section]!) {
        notification['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Intercept back navigation
      onPopInvoked: (didPop) {
        // Handle back navigation manually to ensure proper focus clearing
        if (!didPop) {
          // Clear focus first, then navigate
          FocusManager.instance.primaryFocus?.unfocus();
          // Small delay to ensure focus is cleared before navigation
          Future.delayed(const Duration(milliseconds: 50), () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }
      },
      child: BasePage(
        showAppBar: false,
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button and title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Clear any active focus before navigating back
                        FocusManager.instance.primaryFocus?.unfocus();
                        // Small delay to ensure focus is cleared
                        Future.delayed(const Duration(milliseconds: 50), () {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 64.w),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Notification',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF404040),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 64.w),
                  ],
                ),
              ),

              // Notifications list
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children:
                      notifications.entries.map((entry) {
                        final section = entry.key;
                        final items = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date header with "Mark all as read"
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 8.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    section.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF737373),
                                      fontFamily: "Satoshi",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _markAllAsRead(section),
                                    child: Text(
                                      'Mark all as read',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0A3128),
                                        fontFamily: "Satoshi",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),

                            // Notification items
                            ...items.map((notification) {
                              return NotificationCard(
                                title: notification['title'],
                                message: notification['message'],
                                time: notification['time'],
                                icon: notification['icon'],
                                iconBgColor: notification['iconBgColor'],
                                iconColor: notification['iconColor'],
                                isRead: notification['isRead'],
                                onTap: () {
                                  // Handle notification tap
                                  setState(() {
                                    notification['isRead'] = true;
                                  });
                                },
                              );
                            }).toList(),

                            SizedBox(height: 16.h),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
