part of custom_widgets;

class CustomTwoButtons extends StatelessWidget {
  /// Used for the name of the left button
  final String leftButtonText;

  /// Used for the name of the right button
  final String? rightButtonText;

  /// Called when left side button is pressed
  final VoidCallback? leftButtonFunction;

  /// Called when right side button is pressed
  final VoidCallback? rightButtonFunction;

  /// Specifies the height of the button. Defaults to 48.0
  final double? buttonHeight;

  /// Used for adding color to the button
  final Color? buttonColor;

  /// Describes how to format the right side button name text
  final TextStyle? rightButtonTextStyle;

  /// Describes how to format the left side button name text
  final TextStyle? leftButtonTextStyle;

  /// [bool] value in order to toggle the decorations between the two bottons. Defaults to [false];
  final bool switchButtonDecoration;

  /// Species the radii for each corner of the button
  final BorderRadiusGeometry? borderRadius;

  /// Species the radii for each corner of the splash behaviour when pressing the button
  final BorderRadius? splashBorderRadius;

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

  /// Species the direction of the button. [Axis.horizontal] aligns the buttons is a row.
  /// [Axis.vertical] aligns the buttons in a column.
  /// Defaults to [Axis.horizontal]
  final Axis? buttonDirection;

  const CustomTwoButtons({
    Key? key,
    required this.leftButtonText,
    this.rightButtonText,
    this.leftButtonFunction,
    this.rightButtonFunction,
    this.buttonHeight = 48.0,
    this.buttonColor = CustomColor.cpurple,
    this.rightButtonTextStyle = const TextStyle(color: CustomColor.cpurple),
    this.leftButtonTextStyle = const TextStyle(color: CustomColor.cwhite),
    this.switchButtonDecoration = false,
    this.borderRadius,
    this.splashBorderRadius,
    this.elevation = 0.0,
    this.buttonDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttonDirection == Axis.vertical
        ? Column(
            children: <Widget>[
              Material(
                elevation: elevation,
                color: switchButtonDecoration ? Colors.transparent : buttonColor,
                borderRadius: borderRadius,
                child: InkWell(
                  borderRadius: splashBorderRadius,
                  highlightColor: Colors.transparent,
                  onTap: leftButtonFunction,
                  child: Container(
                    height: buttonHeight,
                    decoration: switchButtonDecoration
                        ? BoxDecoration(
                            border: Border.all(color: buttonColor ?? CustomColor.cpurple, width: 1.5),
                            borderRadius: splashBorderRadius)
                        : const BoxDecoration(),
                    child: Center(
                        child: Text(
                      leftButtonText,
                      style: switchButtonDecoration ? rightButtonTextStyle : leftButtonTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                ),
              ),
              SizedBox(height: rightButtonText == null ? 0 : 10),
              rightButtonText == null
                  ? Container()
                  : Material(
                      color: switchButtonDecoration ? buttonColor : Colors.transparent,
                      borderRadius: borderRadius,
                      child: InkWell(
                        borderRadius: splashBorderRadius,
                        highlightColor: Colors.transparent,
                        onTap: rightButtonFunction,
                        child: Container(
                          decoration: switchButtonDecoration
                              ? const BoxDecoration()
                              : BoxDecoration(
                                  border: Border.all(color: buttonColor ?? CustomColor.cpurple, width: 1),
                                  borderRadius: splashBorderRadius),
                          height: buttonHeight,
                          child: Center(
                              child: Text(
                            rightButtonText!,
                            style: switchButtonDecoration ? leftButtonTextStyle : rightButtonTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ),
                      ),
                    ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Material(
                    elevation: elevation,
                    color: switchButtonDecoration ? Colors.transparent : buttonColor,
                    borderRadius: borderRadius,
                    child: InkWell(
                      borderRadius: splashBorderRadius,
                      onTap: leftButtonFunction,
                      child: Container(
                        height: buttonHeight,
                        decoration: switchButtonDecoration
                            ? BoxDecoration(
                                border: Border.all(color: buttonColor ?? CustomColor.cpurple, width: 1.5),
                                borderRadius: splashBorderRadius)
                            : const BoxDecoration(),
                        child: Center(
                            child: Text(
                          leftButtonText,
                          style: switchButtonDecoration ? rightButtonTextStyle : leftButtonTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              rightButtonText == null
                  ? Container()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Material(
                          color: switchButtonDecoration ? buttonColor : Colors.transparent,
                          borderRadius: borderRadius,
                          child: InkWell(
                            borderRadius: splashBorderRadius,
                            onTap: rightButtonFunction,
                            child: Container(
                              decoration: switchButtonDecoration
                                  ? const BoxDecoration()
                                  : BoxDecoration(
                                      border: Border.all(color: buttonColor ?? CustomColor.cpurple, width: 1),
                                      borderRadius: splashBorderRadius),
                              height: buttonHeight,
                              child: Center(
                                  child: Text(
                                rightButtonText!,
                                style: switchButtonDecoration ? leftButtonTextStyle : rightButtonTextStyle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }
}
