import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/app_themes/text_style/font_weight_helper.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.hintStyle,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.required = false,
    this.needBorder = true,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.isCollapsed,
    this.labelText,
    this.labelStyle,
    this.fillColor,
    this.readOnly = false,
    this.autofocus = false,
    required this.textInputAction,
  });

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? isCollapsed;
  final bool required;
  final bool readOnly;
  final bool autofocus;
  final bool needBorder;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            label!,
            style: AppTextStyle.bodySm.copyWith(
              fontWeight: FontWeightHelper.medium,
              color: context.skin.textFieldLabel,
            ),
          ),
          const VerticalSpace(6),
          buildTextFormField(context),
        ],
      );
    }
    return buildTextFormField(context);
  }

  Widget buildTextFormField(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      autofocus: autofocus,
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: controller,
      style: AppTextStyle.style16Regular.copyWith(
        color: context.skin.textFieldText,
      ),
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      cursorColor: context.skin.textFieldCursor,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines ?? 1,
      onTapOutside: (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).unfocus();
        });
      },
      decoration: InputDecoration(
        hintText: required ? '$hint*' : hint,
        labelText: labelText,
        labelStyle:
            labelStyle ??
            AppTextStyle.style14Medium.copyWith(
              color: context.skin.textFieldLabel,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle:
            hintStyle ??
            AppTextStyle.style16Regular.copyWith(
              color: context.skin.textFieldHint,
            ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        isCollapsed: isCollapsed,
        isDense: true,
        filled: true,
        fillColor: fillColor ?? context.skin.textFieldFill,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderSide: needBorder
              ? BorderSide.none
              : BorderSide(color: context.skin.textFieldBorder),

          borderRadius: AppConstants.textFormBorderRadius,
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: needBorder
              ? BorderSide(color: context.skin.textFieldBorder)
              : BorderSide.none,
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: needBorder
              ? BorderSide(color: context.skin.textFieldFocusedBorder)
              : BorderSide.none,

          borderRadius: AppConstants.textFormBorderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.skin.textFieldBorder),
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.skin.textFieldErrorBorder),
          borderRadius: AppConstants.textFormBorderRadius,
        ),
        errorStyle: TextStyle(color: context.skin.error),
      ),
    );
  }
}
