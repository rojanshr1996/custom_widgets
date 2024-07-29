part of '../../custom_widgets.dart';

class CustomButton extends StatelessWidget {
  /// Used for the name of the button
  final String title;

  /// Used for adding color to the button
  final Color? buttonColor;

  /// Describes how to format the button name text
  final TextStyle? textStyle;

  /// Specifies the height of the button. Defaults to 48.0
  final double? buttonHeight;

  /// Called when the button is pressed
  final VoidCallback? onPressed;

  /// Species the radii for each corner of the button
  final BorderRadiusGeometry? borderRadius;

  /// Species the radii for each corner of the splash behaviour when pressing the button
  final BorderRadius? splashBorderRadius;

  /// Used to add any icon in front of the text in the button
  final Widget? prefixIcon;

  /// Used to add any icon after the text in the button
  final Widget? suffixIcon;

  /// The [Widget] that loads when the [loader] is set to true when the button is pressed
  final Widget? loadingIndicator;

  /// Specifies the width of the button
  final double? buttonWidth;

  /// [bool] value which toggles in order to show the loading state when the button is pressed
  final bool? loader;

  // The color to paint the shadow below the material.

  // If null, [ThemeData.shadowColor] is used, which defaults to fully opaque black.
  final Color? shadowColor;

  /// {@template flutter.material.material.elevation}
  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material and the opacity
  /// of the elevation overlay color if it is applied.
  ///
  /// If this is non-zero, the contents of the material are clipped, because the
  /// widget conceptually defines an independent printed piece of material.
  ///
  /// Defaults to 0. Changing this value will cause the shadow and the elevation
  /// overlay to animate over [Material.animationDuration].
  ///
  /// The value is non-negative.
  ///
  /// See also:
  ///
  ///  * [ThemeData.applyElevationOverlayColor] which controls the whether
  ///    an overlay color will be applied to indicate elevation.
  ///  * [Material.color] which may have an elevation overlay applied.
  ///
  /// {@endtemplate}
  final double elevation;

  const CustomButton({
    super.key,
    required this.title,
    this.buttonColor,
    this.onPressed,
    this.textStyle = const TextStyle(color: CustomColor.cWhite),
    this.buttonHeight,
    this.borderRadius,
    this.prefixIcon,
    this.splashBorderRadius,
    this.buttonWidth,
    this.loader = false,
    this.suffixIcon,
    this.loadingIndicator,
    this.elevation = 2.0,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: buttonColor ?? ButtonTheme.of(context).colorScheme!.primary,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      child: InkWell(
        borderRadius: splashBorderRadius,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: SizedBox(
          width: buttonWidth ?? Utilities.screenWidth(context),
          height: buttonHeight ?? 47.5.w,
          child: loader!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 19.5.w,
                      width: 19.5.w,
                      child: Center(
                        child: loadingIndicator ??
                            const CircularProgressIndicator(
                                color: CustomColor.cWhite, strokeWidth: 4),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefixIcon == null
                        ? const SizedBox()
                        : Padding(
                            padding:
                                EdgeInsets.only(right: 11.5.w, left: 11.5.w),
                            child: prefixIcon,
                          ),
                    Expanded(
                      child: Text(
                        title,
                        style: textStyle,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    suffixIcon == null
                        ? const SizedBox()
                        : Padding(
                            padding:
                                EdgeInsets.only(right: 11.5.w, left: 11.5.w),
                            child: suffixIcon,
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
