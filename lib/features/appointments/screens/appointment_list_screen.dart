import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/features/appointments/widgets/appointment_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        'Appointments',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0A3128),
          fontFamily: "Satoshi",
        ),
      ),
      centerTitle: true,
      showBackButton: true,
      bodyColor: Colors.white,
      body: Column(
        children: [
          // Tab Bar Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                // Tab buttons
                Row(
                  children: [
                    Expanded(child: _buildTabButton('Upcoming', 0)),
                    Expanded(child: _buildTabButton('Past', 1)),
                  ],
                ),
                SizedBox(height: 4.h),
                // Separator with indicator
                Stack(
                  children: [
                    Container(
                      height: 3.h,
                      width: double.infinity,
                      color: const Color(0xFFF5F5F5),
                    ),
                    AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, child) {
                        return Positioned(
                          left:
                              _tabController.index == 0
                                  ? 0
                                  : MediaQuery.of(context).size.width / 2 -
                                      16.w,
                          child: Container(
                            height: 3.h,
                            width: MediaQuery.of(context).size.width / 2 - 16.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF34F4C6), Color(0xFF1DC7F2)],
                              ),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildUpcomingTab(), _buildPastTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color:
                isSelected ? const Color(0xFF34F4C6) : const Color(0xFF737373),
            fontFamily: "Satoshi",
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        AppointmentCard(
          dateTime: 'May 22, 2023 - 10.00 AM',
          doctorName: 'Dr. James Robinson',
          specialty: 'Orthopedic Surgery',
          location: 'Elite Ortho Clinic, USA',
          imageUrl:
              'https://www.figma.com/api/mcp/asset/6a489ee1-df51-44e8-8f67-7feb2933cf1e',
          onCancel: () {
            // Handle cancel
          },
          onReschedule: () {
            // Handle reschedule
            Navigator.pushNamed(
              context, //rescheduleAppointmentScreen);
              '/rescheduleAppointmentScreen',
            );
          },
        ),
        SizedBox(height: 16.h),
        AppointmentCard(
          dateTime: 'Jube 14, 2023 - 15.00pm',
          doctorName: 'Dr. Daniel Lee',
          specialty: 'Gastroenterologist',
          location: 'Digestive Institute, USA',
          imageUrl:
              'https://www.figma.com/api/mcp/asset/7e19a3cc-a99a-4b1d-a752-f0f148725001',
          onCancel: () {
            // Handle cancel
          },
          onReschedule: () {
            Navigator.pushNamed(
              context, //rescheduleAppointmentScreen);
              '/rescheduleAppointmentScreen',
            );
            // Handle reschedule
          },
        ),
        SizedBox(height: 16.h),
        AppointmentCard(
          dateTime: 'June 21, 2023 - 10.00 AM',
          doctorName: 'Dr. Nathan Harris',
          specialty: 'Cardiologist',
          location: 'Cardiology Center, USA',
          imageUrl:
              'https://www.figma.com/api/mcp/asset/99a7dc57-0657-4a3d-99f7-63c887625ded',
          onCancel: () {
            // Handle cancel
          },
          onReschedule: () {
            Navigator.pushNamed(
              context, //rescheduleAppointmentScreen);
              '/rescheduleAppointmentScreen',
            );
          },
        ),
      ],
    );
  }

  Widget _buildPastTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64.sp, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            'No Past Appointments',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: "Satoshi",
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your past appointments will appear here',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
              fontFamily: "Satoshi",
            ),
          ),
        ],
      ),
    );
  }
}
