import 'package:flutter/material.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/helpers/dialogs.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class CloseAppointmentScreen extends StatefulWidget {
  const CloseAppointmentScreen({super.key});

  @override
  State<CloseAppointmentScreen> createState() => _CloseAppointmentScreenState();

  /// Shows a dialog to confirm appointment closure
  static Future<bool?> showCloseDialog({
    required BuildContext context,
    required String petName,
    required String breed,
    required String age,
    required String doctorName,
    required String timestamp,
  }) {
    return PlatformDialog.showDesignDialog(
      isIconRequired: true,
      iconWidget: Container(
        height: 56,
        width: 56,
        decoration: const BoxDecoration(
          color: Color(0xFFFEE2E2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Color(0xFFEF4444), size: 22),
      ),
      context: context,
      title: 'Requesting to close your appointment.',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dr. $doctorName has received your case and believes you\'re pet\'s condition has been addressed. Would you like to close this consultation.',
            textAlign: TextAlign.center,
            style:
                context
                    .textStyle(palette: ColorPalete.slate, swatch: 200)
                    .largeBody
                    .regular,
          ),
          const SizedBox(height: 16),
          // Case summary card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(AppImages.pet, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$petName · $breed · $age',
                          style:
                              context
                                  .textStyle(
                                    palette: ColorPalete.slate,
                                    swatch: 900,
                                  )
                                  .baseBody
                                  .fontWeightMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ColorPalete.healingGreen[50],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    'ACTIVE',
                    style:
                        context
                            .textStyle(
                              palette: ColorPalete.success,
                              swatch: 700,
                            )
                            .footNote
                            .semiBold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timestamp,
              style:
                  context
                      .textStyle(palette: ColorPalete.slate, swatch: 300)
                      .footNote
                      .regular,
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.whiteColor,
      confirmText: 'Accept & Close',
      cancelText: 'Decline',
      actions: [
        // Decline button (red outline)
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFEF4444), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Decline',
              style:
                  context
                      .textStyle(palette: ColorPalete.red, swatch: 500)
                      .largeBody
                      .fontWeightMedium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Accept & Close button (cyan/teal)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1DCDFE),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Accept & Close',
              style:
                  context
                      .textStyle(palette: ColorPalete.white)
                      .largeBody
                      .fontWeightMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _CloseAppointmentScreenState extends State<CloseAppointmentScreen> {
  final TextEditingController _noteController = TextEditingController();
  final List<String> _reasons = const [
    'Treatment completed',
    'Client requested closure',
    'Transferred to another clinic',
    'Other',
  ];
  String? _selectedReason;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.85;

    return SafeArea(
      top: false,
      child: Container(
        height: sheetHeight,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildDragHandle(),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    _buildCaseSummaryCard(context),
                    const SizedBox(height: 16),
                    _buildInputSection(context),
                    const SizedBox(height: 16),
                    _buildFooterActions(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        height: 4,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFADBEC4).withAlpha(128),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: const BoxDecoration(
            color: Color(0xFFFEE2E2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Color(0xFFEF4444), size: 22),
        ),
        const SizedBox(height: 16),
        Text(
          'Close Appointment?',
          textAlign: TextAlign.center,
          style:
              context
                  .textStyle(palette: ColorPalete.slate, swatch: 900)
                  .newheader4
                  .bold,
        ),
        const SizedBox(height: 8),
        Text(
          'This will send a close request to the pet\n'
          'owner. The case will only close once they\n'
          'confirm.',
          textAlign: TextAlign.center,
          style:
              context
                  .textStyle(palette: ColorPalete.slate, swatch: 200)
                  .largeBody
                  .fontWeightMedium,
        ),
      ],
    );
  }

  Widget _buildCaseSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(AppImages.pet, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rocky · Husky · 4 months',
                    style:
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 900)
                            .largeBody
                            .fontWeightMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Dr. Emma Watson requesting\nclosure',
                    style: context
                        .textStyle(palette: ColorPalete.slate, swatch: 200)
                        .baseBody
                        .regular
                        .copyWith(height: 1.1),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: ColorPalete.healingGreen[50],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              'ACTIVE',
              style:
                  context
                      .textStyle(palette: ColorPalete.success, swatch: 700)
                      .footNote
                      .semiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('REASON FOR CLOSING'),
        const SizedBox(height: 6),
        SizedBox(
          height: 42,
          child: DropdownButtonFormField<String>(
            value: _selectedReason,
            isExpanded: true,
            items:
                _reasons
                    .map(
                      (reason) => DropdownMenuItem<String>(
                        value: reason,
                        child: Text(reason),
                      ),
                    )
                    .toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF9AA6AC),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            style:
                context
                    .textStyle(palette: ColorPalete.slate, swatch: 700)
                    .largeBody
                    .regular,
            hint: Text(
              'Select a reason',
              style: context
                  .textStyle(palette: ColorPalete.slate, swatch: 500)
                  .largeBody
                  .regular
                  .copyWith(color: const Color(0xFF4B4C4C)),
            ),
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildLabel('ADD A NOTE ( OPTIONAL )'),
        const SizedBox(height: 6),
        SizedBox(
          height: 42,
          child: TextFormField(
            controller: _noteController,
            style:
                context
                    .textStyle(palette: ColorPalete.slate, swatch: 700)
                    .largeBody
                    .regular,
            decoration: InputDecoration(
              hintText: 'Add a note to the owner ( optional )',
              hintStyle: context
                  .textStyle(palette: ColorPalete.slate, swatch: 500)
                  .largeBody
                  .regular
                  .copyWith(color: const Color(0xFF4B4C4C)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2BCCA5),
              foregroundColor: ColorPalete.healingGreen[50],
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              CloseAppointmentScreen.showCloseDialog(
                context: context,
                petName: 'Rocky',
                breed: 'Husky',
                age: '4 months',
                doctorName: 'Emma Watson',
                timestamp: 'Today, 9:22 AM',
              );
            },
            child: Text(
              'Send Close Request',
              style:
                  context
                      .textStyle(palette: ColorPalete.healingGreen, swatch: 50)
                      .largeBody
                      .fontWeightMedium,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Cancel',
              style:
                  context
                      .textStyle(palette: ColorPalete.healingGreen, swatch: 950)
                      .largeBody
                      .fontWeightMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: context
          .textStyle(palette: ColorPalete.brightSky, swatch: 700)
          .labelCap
          .bold
          .copyWith(letterSpacing: 1),
    );
  }
}
