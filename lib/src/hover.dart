import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:html' as html;

extension HoverWidget on Widget {
  static final appContainer =
      html.window.document.getElementById("app-container");

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) {
        appContainer?.style.cursor = "pointer";
      },
      onExit: (event) {
        appContainer?.style.cursor = "default";
      },
    );
  }
}

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
  bool _hovering = false;
  late StreamController<bool> _hoverController;

  @override
  void initState() {
    _hoverController = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    _hoverController.close();
    super.dispose();
  }

  _hover(bool state) {
    _hovering = state;
    if (widget.onHover != null) {
      widget.onHover!(_hovering);
    }
    _hoverController.sink.add(_hovering);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _hoverController.stream,
      initialData: false,
      builder: (context, snapshot) {
        return MouseRegion(
          onHover: (event) => _hover(true),
          onExit: (event) => _hover(false),
          child: widget.builder(
            context,
            snapshot.data ?? false,
          ),
        );
      },
    );
  }
}
