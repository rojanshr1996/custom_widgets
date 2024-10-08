part of '../../custom_widgets.dart';

class CustomSimpleCircularLoader extends StatelessWidget {
  /// Species the color of the circular loader
  final Color? color;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// Creates a circular progress indicator.
  final Color? backgroundColor;

  final double? buttonSize;

  const CustomSimpleCircularLoader(
      {super.key,
      this.color = CustomColor.cSkyBlue,
      this.strokeWidth = 6.0,
      this.padding,
      this.backgroundColor,
      this.buttonSize});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(4.w),
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: CircularProgressIndicator(
            color: color,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor),
      ),
    );
  }
}
