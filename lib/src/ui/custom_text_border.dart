part of '../../custom_widgets.dart';

class CustomTextBorder extends StatelessWidget {
  final String text;

  /// The color to use when stroking or filling a shape.
  ///
  /// Defaults to [CustomColor.dark] i.e [Color(0xff212230)].
  final Color textBorderColor;

  /// If non-null, the style to use for this text.
  final TextStyle? textStyle;

  /// How wide to make edges drawn when [style] is set to [PaintingStyle.stroke]. The width is given in logical pixels measured in the direction orthogonal to the direction of the path.
  ///
  /// Defaults to 0.5.
  final double strokeWidth;
  const CustomTextBorder({
    super.key,
    required this.text,
    this.textBorderColor = CustomColor.dark,
    this.strokeWidth = 0.5,
    this.textStyle =
        const TextStyle(color: CustomColor.cWhite, fontWeight: FontWeight.w500),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(text,
            style: textStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: true),
        Text(text,
            style: textStyle?.copyWith(
              foreground: Paint()
                ..strokeWidth = strokeWidth
                ..color = textBorderColor
                ..style = PaintingStyle.stroke,
            )),
      ],
    );
  }
}
