part of '../../custom_widgets.dart';

class RemoveFocus extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const RemoveFocus({super.key, this.onTap, required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
