import 'package:flutter/material.dart';

class ModesToolbar extends StatelessWidget {
  List<Widget> children;

  ModesToolbar({this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: this.children,
      ),
    );
  }
}

class ModeIconButton extends ElevatedButton {
  ModeIconButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    FocusNode focusNode,
    bool autofocus,
    Clip clipBehavior,
    @required Widget icon,
  })  : assert(icon != null),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(side: BorderSide()),
              minimumSize: Size.square(48.0)),
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: ModeButtonIconChild(icon: icon),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      // const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
      const EdgeInsetsDirectional.fromSTEB(30, 0, 32, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding));
  }
}

class ModeButtonIconChild extends StatelessWidget {
  ModeButtonIconChild({Key key, @required this.icon}) : super(key: key);

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon],
    );
  }
}
