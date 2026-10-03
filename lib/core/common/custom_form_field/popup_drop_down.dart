import 'package:flutter/material.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/form_field/decoration.dart';
import 'package:vetyo/core/utils/form_field/validators.dart';

class CustomDropDownFormField extends StatefulWidget {
  final CustomFormFieldConfig config;
  final Function(dynamic)? onFieldSubmitted;

  const CustomDropDownFormField({
    super.key,
    required this.config,
    this.onFieldSubmitted,
  });

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  List<Map<String, dynamic>> sourceOptions = [];
  List<Map<String, dynamic>> allOptions = [];

  @override
  void initState() {
    super.initState();
    _syncOptions();
  }

  @override
  void didUpdateWidget(covariant CustomDropDownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.options != widget.config.options) {
      _syncOptions();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Map<String, dynamic>> _normalizeOptions(List? options) {
    return (options ?? [])
        .map<Map<String, dynamic>>((option) {
          if (option is Map) {
            final label = (option['label'] ?? option['value'] ?? '').toString();
            final value = option['value'] ?? label;
            return {'label': label, 'value': value};
          }

          final value = option?.toString() ?? '';
          return {'label': value, 'value': value};
        })
        .where((item) => (item['label'] as String).isNotEmpty)
        .toList();
  }

  void _syncOptions() {
    sourceOptions = _normalizeOptions(widget.config.options);
    allOptions = List<Map<String, dynamic>>.from(sourceOptions);
  }

  @override
  Widget build(BuildContext context) {
    return buildDropDownForm();
  }

  buildDropDownForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.config.label,
            style: context.textBlackStyle().bold.medium.copyWith(
              color: AppColor.brightSkyMain,
            ),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          style:
              context
                  .textStyle(palette: ColorPalete.slate, swatch: 700)
                  .large
                  .regular,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.config.onChanged ?? widget.config.onFieldSubmitted,
          onSaved: widget.config.onSaved ?? widget.config.onFieldSubmitted,
          readOnly: true,
          enabled: widget.config.enabled,
          validator: ((value) {
            return FormValidator.checkValidation(
              isLogIn: widget.config.isLogIn ?? false,
              isRequired: widget.config.isRequired ?? false,
              value: value ?? "",
              fieldType: widget.config.fieldType,
              label: widget.config.label,
            );
          }),
          controller: widget.config.controller,
          decoration: InputDecoration(
            // focusedBorder: FormFieldDecoration.getFocusedBorder(context),
            border: FormFieldDecoration.getBoarder(),
            fillColor: Colors.grey.shade100,
            filled: true,
            labelText:
                "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
            labelStyle: context.textBlackStyle().medium.semiBold.copyWith(
              color: const Color(0xFF7C7C7C),
            ),
            suffixIcon:
                widget.config.controller!.text.isEmpty
                    ? const Icon(Icons.arrow_drop_down)
                    : widget.config.enabled == true
                    ? GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.config.controller?.clear();

                          widget.config.onFieldSubmitted!.call("");
                        });
                      },
                      child: const Icon(Icons.close, size: 18),
                    )
                    : null,
            hintText: widget.config.hintText,
          ),
          onTap: () {
            onTabFunction();
          },
        ),
      ],
    );
  }

  onTabFunction() {
    setState(() {
      _syncOptions();
    });

    if (allOptions.isEmpty) return;

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<Map<String, dynamic>>(
      context: context,
      position: position,
      items:
          allOptions
              .map(
                (option) => PopupMenuItem<Map<String, dynamic>>(
                  value: option,
                  child: Text(
                    (option['label'] ?? '').toString(),
                    style:
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 700)
                            .medium
                            .semiBold,
                  ),
                ),
              )
              .toList(),
    ).then((selected) {
      if (selected == null) return;

      if (!mounted) return;
      setState(() {
        widget.config.controller!.text = (selected['label'] ?? '').toString();
      });

      widget.config.onFieldSubmitted?.call(selected['value']);
      widget.onFieldSubmitted?.call(selected['value']);

      if (widget.config.nextFocusNode != null) {
        FocusScope.of(context).requestFocus(widget.config.nextFocusNode);
      }
    });
  }

  // void filterSearchResults(String query) {
  //   setState(() {
  //     allOptions = widget.config.options!
  //         .where((e) =>
  //             e["label"].toLowerCase().replaceAll(' ', '').contains(query))
  //         .toList();
  //   });
  // }
}
