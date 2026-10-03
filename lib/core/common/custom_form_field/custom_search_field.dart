import 'package:flutter/material.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/form_field/decoration.dart';
import 'package:vetyo/core/utils/form_field/input_formatter.dart';
import 'package:vetyo/core/utils/form_field/keyboard_selector.dart';
import 'package:vetyo/core/utils/form_field/validators.dart';

class CustomSearchField extends StatefulWidget {
  final Function(dynamic)? onFieldSubmitted;
  final CustomFormFieldConfig config;
  const CustomSearchField({
    super.key,
    required this.config,
    this.onFieldSubmitted,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  bool isHidden = true;

  @override
  void initState() {
    isHidden = widget.config.isObscure ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style:
              context
                  .textStyle(palette: ColorPalete.slate, swatch: 700)
                  .large
                  .regular,
          textCapitalization:
              widget.config.enableCaps == true
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
          enabled: widget.config.enabled,
          onChanged: widget.config.onChanged ?? widget.config.onFieldSubmitted,
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!(value);
            }
            if (widget.config.onFieldSubmitted != null) {
              widget.config.onFieldSubmitted!(value);
            }
          },
          onSaved: widget.config.onSaved ?? widget.config.onFieldSubmitted,
          validator: (value) {
            return FormValidator.checkValidation(
              isLogIn: widget.config.isLogIn ?? false,
              isRequired: widget.config.isRequired ?? false,
              value: value ?? "",
              fieldType: widget.config.fieldType,
              label: widget.config.label,
            );
          },
          inputFormatters: InputFormatter.formFieldInputFormatters(
            widget.config.fieldType,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.config.controller!,
          // ..selection = TextSelection.fromPosition(
          //     TextPosition(offset: widget.config.controller!.text.length)),
          obscureText:
              widget.config.fieldType == FieldType.password ||
                      widget.config.fieldType == FieldType.confirmPassword
                  ? isHidden
                  : false,
          keyboardType: KeyboardSelector.keyboardType(widget.config.fieldType),
          readOnly: widget.config.fieldType == FieldType.country ? true : false,
          decoration: InputDecoration(
            counterText: "",
            suffixIcon:
                widget.config.fieldType == FieldType.password ||
                        widget.config.fieldType == FieldType.confirmPassword
                    ? IconButton(
                      icon: Icon(
                        color: ColorPalete.brand,
                        isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isHidden = isHidden ? false : true;
                        });
                      },
                    )
                    : widget.config.suffixIcon,
            focusedBorder: FormFieldDecoration.getFocusedBorder(context),
            border: FormFieldDecoration.getBoarder(),
            fillColor: AppColor.greyColor.withAlpha(20),
            filled: true,
            focusColor: widget.config.style == null ? null : Colors.white,
            prefixIcon: widget.config.prefixIcon,
            hintText: widget.config.hintText,
            labelText:
                "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
            labelStyle: context.textBlackStyle().medium.regular.copyWith(
              color: AppColor.greyColor.withAlpha(254),
            ),
          ),
        ),
      ],
    );
  }
}
