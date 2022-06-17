import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_field.dart';

class CustomFieldSuggestion extends StatefulWidget {
  const CustomFieldSuggestion({
    Key? key,
    required this.suggestions,
    required this.onChanged,
    this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.textInputType,
    this.enabled,
    required this.controller, 
    this.onSubmitted, 
    this.textInputAction = TextInputAction.next, 
    this.focusNode, 
    this.readOnly = false, 
    this.contentPadding, 
    this.style, 
    this.onTap, 
    this.baseList,
  }) : super(key: key);
  final TextEditingController controller;
  final List<String>? baseList;
  final List<String> suggestions;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final Function()? onSubmitted;
  final Function(int)? onTap;
  final bool? enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;

  @override
  State<CustomFieldSuggestion> createState() => _CustomFieldSuggestionState();
}

class _CustomFieldSuggestionState extends State<CustomFieldSuggestion> {
  OverlayEntry? entry;
  GlobalKey globalKey = GlobalKey();
  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   globalKey;
    //   return showOverlay();
    // });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: CustomTextField(
        focusNode: focusNode,
        controller: widget.controller,
        obscure: widget.obscure,
        textInputType: widget.textInputType,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        contentPadding: widget.contentPadding,
        style: widget.style,
        hint: widget.hint,
        onSubmitted: widget.onSubmitted,
        prefix: widget.prefix,
        suffix: widget.suffix,
        textInputAction: widget.textInputAction,
      ),
    );
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;

    //calculate the offsset to top and to bottom

    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    double offsetTop;
    double space = 5.0;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double boxHeight;

    if (widget.suggestions.length >= 5) {
        boxHeight = 240.0;
      } else {
        boxHeight = 48.0 * widget.suggestions.length;
    }

    if (offset.dy > mediaQueryHeight * 0.38) {
      offsetTop = offset.dy - size.height;
      space = - boxHeight - 48.0;
    } else {
      offsetTop = offset.dy + size.height;
    }

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: offsetTop,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + space),
          child: buildOverlay(context, boxHeight)
        )
      ),
    );

    overlay.insert(entry!);
  }

  Widget buildOverlay(BuildContext context, double height) {
    return Material(
      elevation: 8,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: SingleChildScrollView(
          child: Column(          
            children: List.generate(
              widget.suggestions.length,
              (index) => ListTile(
                dense: true,
                title: AutoSizeText(
                  widget.suggestions[index],
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14
                  ),
                ),
                onTap: () {
                  widget.controller.text = widget.suggestions[index];
                  if (widget.baseList != null) {
                    final int indexInBaseList = widget.baseList!.indexOf(widget.suggestions[index]);
                    widget.onTap?.call(indexInBaseList);
                  }
                  widget.onChanged(widget.suggestions[index]);
                  focusNode.unfocus();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hideOverlay() {
    entry!.remove();
    entry = null;
  }
}