import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/appointments/screens/add_evidence_screen.dart';
import 'package:vetyo/features/appointments/screens/category_info.dart';
import 'package:vetyo/features/appointments/screens/category_specific_info_screen.dart';
import 'package:vetyo/features/appointments/screens/pet_info.dart';
import 'package:vetyo/features/appointments/screens/priority_screen.dart';
import 'package:vetyo/features/appointments/screens/questionaire_screen.dart';
import 'package:vetyo/features/appointments/screens/select_vet_screen.dart';
import 'package:vetyo/features/appointments/widgets/segmented_caraousel.dart';
import 'package:vetyo/features/vets/screens/all_vets_screen.dart';

class BookAppointmentFlow extends StatefulWidget {
  final String? categoryName;

  final int initialPage;
  const BookAppointmentFlow({
    super.key,
    this.initialPage = 0,
    this.categoryName,
  });

  @override
  State<BookAppointmentFlow> createState() => _BookAppointmentFlowState();
}

class _BookAppointmentFlowState extends State<BookAppointmentFlow> {
  static const String _categoryKey = 'category';
  static const String _petKey = 'pet';
  static const String _questionnaireKey = 'questionnaire';
  static const String _evidenceKey = 'evidence';
  static const String _priorityKey = 'priority';
  static const String _selectedVetKey = 'selected_vet';

  static const String _farmDetailsKey = 'farm_details';
  static const String _poultryDetailsKey = 'poultry_details';
  static const String _aquaDetailsKey = 'aqua_details';

  late final PageController _controller;
  late int _currentIndex;
  Vet? _selectedVet;

  final Map<String, dynamic> _appointmentData = {};

  late final Map<String, List<_AppointmentStep>> _categoryFlowConfig;

  @override
  void initState() {
    super.initState();
    _categoryFlowConfig = _buildCategoryFlowConfig();
    _currentIndex = _clampIndex(
      widget.initialPage,
      _categoryFlowConfig['default']!.length,
    );
    _controller = PageController(initialPage: _currentIndex);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFFAFAFA),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isEmptyValue(dynamic value) {
    if (value == null) return true;
    if (value is String) return value.trim().isEmpty;
    if (value is Iterable) return value.isEmpty;
    if (value is Map) return value.isEmpty;
    return false;
  }

  String get _selectedCategoryCode {
    final rawCategory = _appointmentData[_categoryKey];
    if (rawCategory is Map) {
      return (rawCategory['category'] ?? '').toString().toLowerCase();
    }
    return rawCategory?.toString().toLowerCase() ?? '';
  }

  List<_AppointmentStep> get _activeSteps {
    final category = _selectedCategoryCode;
    if (category.isEmpty) {
      return _categoryFlowConfig['default']!;
    }
    return _categoryFlowConfig[category] ?? _categoryFlowConfig['default']!;
  }

  int get _totalPages => _activeSteps.length;

  bool _validateStep(int index) {
    if (index < 0 || index >= _activeSteps.length) return false;
    return _activeSteps[index].validator(_appointmentData, _selectedVet);
  }

  String _stepValidationMessage(int index) {
    if (index < 0 || index >= _activeSteps.length) {
      return 'Please complete this step to continue.';
    }
    return _activeSteps[index].validationMessage;
  }

  Map<String, dynamic> _buildFinalData() {
    return {
      ..._appointmentData,
      _selectedVetKey:
          _selectedVet != null
              ? {
                'name': _selectedVet!.name,
                'specialty': _selectedVet!.specialty,
                'location': _selectedVet!.location,
                'rating': _selectedVet!.rating,
                'reviews': _selectedVet!.reviews,
              }
              : null,
    };
  }

  int _clampIndex(int index, int totalSteps) {
    if (totalSteps <= 0) return 0;
    final maxIndex = totalSteps - 1;
    return index.clamp(0, maxIndex);
  }

  void _syncIndexToActiveSteps() {
    final clamped = _clampIndex(_currentIndex, _activeSteps.length);
    if (clamped == _currentIndex) return;

    _currentIndex = clamped;
    if (_controller.hasClients) {
      _controller.jumpToPage(clamped);
    }
  }

  void _saveStepData(String key, dynamic value) {
    setState(() {
      _appointmentData[key] = value;
      if (key == _categoryKey) {
        _syncIndexToActiveSteps();
      }
    });
  }

  List<_AppointmentStep> _defaultSteps() {
    return [
      _AppointmentStep(
        id: 'category',
        validationMessage: 'Please complete category details to continue.',
        validator: (data, vet) => !_isEmptyValue(data[_categoryKey]),
        builder:
            () => CategoryInfoScreen(
              categoryName: widget.categoryName,
              onContinue: (data) {
                _saveStepData(_categoryKey, data);
              },
            ),
      ),
      _AppointmentStep(
        id: 'pet',
        validationMessage: 'Please complete pet details to continue.',
        validator: (data, vet) => !_isEmptyValue(data[_petKey]),
        builder:
            () => PetsInfo(
              onContinue: (data) {
                _saveStepData(_petKey, data);
              },
            ),
      ),
      _AppointmentStep(
        id: 'questionnaire',
        validationMessage: 'Please complete questionnaire details to continue.',
        validator: (data, vet) => !_isEmptyValue(data[_questionnaireKey]),
        builder:
            () => QuestionaireScreen(
              onContinue: (data) {
                _saveStepData(_questionnaireKey, data);
              },
            ),
      ),
      _AppointmentStep(
        id: 'evidence',
        validationMessage: 'Please add evidence to continue.',
        validator: (data, vet) => !_isEmptyValue(data[_evidenceKey]),
        builder:
            () => AddEvidenceScreen(
              onContinue: (data) {
                _saveStepData(_evidenceKey, data);
              },
            ),
      ),
      _AppointmentStep(
        id: 'priority',
        validationMessage: 'Please select priority to continue.',
        validator: (data, vet) => !_isEmptyValue(data[_priorityKey]),
        builder:
            () => PriorityScreen(
              onContinue: (data) {
                _saveStepData(_priorityKey, data);
              },
            ),
      ),
      _AppointmentStep(
        id: 'vet',
        validationMessage: 'Please select a vet to continue.',
        validator: (data, vet) => vet != null,
        builder:
            () => SelectVetScreen(
              onVetSelected: (vet) {
                setState(() {
                  _selectedVet = vet;
                });
              },
            ),
      ),
    ];
  }

  Map<String, List<_AppointmentStep>> _buildCategoryFlowConfig() {
    final defaultFlow = _defaultSteps();
    final farmDetailsStep = _AppointmentStep(
      id: 'farm_details',
      validationMessage: 'Please complete farm details to continue.',
      validator: (data, vet) => !_isEmptyValue(data[_farmDetailsKey]),
      builder:
          () => CategorySpecificInfoScreen(
            title: 'Farm Information',
            subtitle:
                'Provide basic farm context so the expert can guide accurately.',
            fields: [
              const CustomFormFieldConfig(
                fieldType: FieldType.number,
                id: 'total_animals',
                label: 'Total Animals',
                hintText: 'Enter count',
                isRequired: true,
              ),
              const CustomFormFieldConfig(
                fieldType: FieldType.text,
                id: 'primary_issue',
                label: 'Primary Issue',
                hintText: 'Describe the farm issue',
                isRequired: true,
              ),
            ],
            onContinue: (data) {
              _saveStepData(_farmDetailsKey, data);
            },
          ),
    );

    final poultryDetailsStep = _AppointmentStep(
      id: 'poultry_details',
      validationMessage: 'Please complete poultry details to continue.',
      validator: (data, vet) => !_isEmptyValue(data[_poultryDetailsKey]),
      builder:
          () => CategorySpecificInfoScreen(
            title: 'Poultry Information',
            subtitle:
                'Add flock details to help assess risks and treatment priority.',
            fields: [
              const CustomFormFieldConfig(
                fieldType: FieldType.number,
                id: 'flock_size',
                label: 'Flock Size',
                hintText: 'Enter number of birds',
                isRequired: true,
              ),
              const CustomFormFieldConfig(
                fieldType: FieldType.text,
                id: 'symptoms_duration',
                label: 'Symptoms Duration',
                hintText: 'e.g. 2 days',
                isRequired: true,
              ),
            ],
            onContinue: (data) {
              _saveStepData(_poultryDetailsKey, data);
            },
          ),
    );

    final aquaDetailsStep = _AppointmentStep(
      id: 'aqua_details',
      validationMessage: 'Please complete aqua details to continue.',
      validator: (data, vet) => !_isEmptyValue(data[_aquaDetailsKey]),
      builder:
          () => CategorySpecificInfoScreen(
            title: 'Aqua Information',
            subtitle:
                'Share pond and water details for a more precise recommendation.',
            fields: [
              const CustomFormFieldConfig(
                fieldType: FieldType.text,
                id: 'water_source',
                label: 'Water Source',
                hintText: 'Pond / River / Borewell',
                isRequired: true,
              ),
              const CustomFormFieldConfig(
                fieldType: FieldType.text,
                id: 'water_quality_notes',
                label: 'Water Quality Notes',
                hintText: 'Color, smell, recent changes, etc.',
                isRequired: true,
              ),
            ],
            onContinue: (data) {
              _saveStepData(_aquaDetailsKey, data);
            },
          ),
    );

    final nonPetFlow = [
      defaultFlow[0],
      farmDetailsStep,
      defaultFlow[2],
      defaultFlow[3],
      defaultFlow[4],
      defaultFlow[5],
    ];

    return {
      'default': defaultFlow,
      'pet': defaultFlow,
      'farm': nonPetFlow,
      'poultry': [
        defaultFlow[0],
        poultryDetailsStep,
        defaultFlow[2],
        defaultFlow[3],
        defaultFlow[4],
        defaultFlow[5],
      ],
      'aqua': [
        defaultFlow[0],
        aquaDetailsStep,
        defaultFlow[2],
        defaultFlow[3],
        defaultFlow[4],
        defaultFlow[5],
      ],
    };
  }

  void _handleContinue() {
    FocusScope.of(context).unfocus();
    if (!_validateStep(_currentIndex)) {
      showSnackBar(context, _stepValidationMessage(_currentIndex));
      return;
    }

    final bool isLastStep = _currentIndex == _totalPages - 1;

    if (!isLastStep) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      RoutePaths.bookAppointment,
      arguments: _buildFinalData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    color: AppColor.brightSkyMain,
                  ),
                ),
                Text(
                  "Book Appointment",
                  style: context.textBlackStyle().header6.semiBold.withSatoshi,
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  final int previousIndex = _currentIndex;

                  // Restrict forward navigation if current step is incomplete.
                  if (index > previousIndex && !_validateStep(previousIndex)) {
                    showSnackBar(
                      context,
                      _stepValidationMessage(previousIndex),
                    );
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _controller.animateToPage(
                        previousIndex,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                      );
                    });
                    return;
                  }

                  setState(() => _currentIndex = index);
                },
                children: _activeSteps.map((step) => step.builder()).toList(),
              ),
            ),
            SegmentedCarouselIndicator(
              currentIndex: _currentIndex,
              itemCount: _totalPages,
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                label: "Continue",
                onPressed: _handleContinue,
                // width: 327.w,
                height: 40.h,
                color: const Color(0xFF1DC7F2),
                labelStyle:
                    context.textBlackStyle().large.semiBold.white.withSatoshi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef _StepValidator =
    bool Function(Map<String, dynamic> data, Vet? selectedVet);
typedef _StepBuilder = Widget Function();

class _AppointmentStep {
  final String id;
  final String validationMessage;
  final _StepValidator validator;
  final _StepBuilder builder;

  const _AppointmentStep({
    required this.id,
    required this.validationMessage,
    required this.validator,
    required this.builder,
  });
}
