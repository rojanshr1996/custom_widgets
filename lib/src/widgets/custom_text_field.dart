part of custom_widgets;

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFormSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final bool? enabled;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final int? maxLength;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final TextCapitalization textCapitalization;
  final Widget? label;
  final AutovalidateMode? autovalidateMode;
  final bool? showCursor;

  const CustomTextField({
    Key? key,
    this.textEditingController,
    this.hintText,
    this.textInputType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.maxLines = 1,
    this.prefixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.onTap,
    this.contentPadding,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onFormSubmitted,
    this.textInputAction,
    this.maxLength,
    this.filled = false,
    this.fillColor,
    this.hintStyle = const TextStyle(color: CustomColor.cgrey),
    this.style,
    this.textCapitalization = TextCapitalization.none,
    this.errorStyle = const TextStyle(color: CustomColor.cred),
    this.label,
    this.autovalidateMode,
    this.showCursor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: showCursor,
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      maxLength: maxLength,
      onChanged: onChanged,
      obscureText: obscureText,
      controller: textEditingController,
      autofocus: autofocus,
      autocorrect: false,
      validator: validator,
      enableSuggestions: false,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onTap: onTap,
      onFieldSubmitted: onFormSubmitted,
      textCapitalization: textCapitalization,
      style: style,
      decoration: InputDecoration(
        label: label,
        fillColor: fillColor,
        filled: filled,
        contentPadding: contentPadding ?? EdgeInsets.all(11.w),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        errorStyle: errorStyle,
        focusedBorder:
            focusedBorder ?? const OutlineInputBorder(borderSide: BorderSide(color: CustomColor.cpurple, width: 1.5)),
        enabledBorder:
            enabledBorder ?? const OutlineInputBorder(borderSide: BorderSide(color: CustomColor.cpurple, width: 1)),
        disabledBorder:
            disabledBorder ?? const OutlineInputBorder(borderSide: BorderSide(color: CustomColor.cgrey, width: 1)),
        errorBorder:
            errorBorder ?? const OutlineInputBorder(borderSide: BorderSide(color: CustomColor.cred, width: 1.5)),
        errorMaxLines: 2,
        focusedErrorBorder:
            focusedErrorBorder ?? const OutlineInputBorder(borderSide: BorderSide(color: CustomColor.cred, width: 1.5)),
        hintStyle: hintStyle,
      ),
    );
  }
}
