import 'package:flutter/material.dart';

class HoverHandleBuilder extends StatefulWidget {
  final Function(bool hovering)? onHover;
  final Widget Function(BuildContext, bool) builder;

  const HoverHandleBuilder({
    Key? key,
    required this.builder,
    this.onHover,
  }) : super(key: key);

  @override
  _HoverHandleBuilderState createState() => _HoverHandleBuilderState();
}

class _HoverHandleBuilderState extends State<HoverHandleBuilder> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(
      "Only for web. There is not option to hover on devices",
    );
  }
}
