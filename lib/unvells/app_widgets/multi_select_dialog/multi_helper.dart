import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/extensions.dart';

abstract class SelectorViewType {
  const SelectorViewType();

  static const SelectorViewType dialog = _KSelectorViewDialog();
  static const SelectorViewType sheet = _KSelectorViewSheet();
}

class _KSelectorViewDialog extends SelectorViewType {
  const _KSelectorViewDialog();
}

class _KSelectorViewSheet extends SelectorViewType {
  const _KSelectorViewSheet();
}

class MultiSelectorItem<T> {
  final T value;
  final String? searchValue;
  final Widget child;
  final Widget? icon;

  MultiSelectorItem(
      {required this.value,
      this.searchValue = '',
      required this.child,
      this.icon});

  @override
  bool operator ==(covariant MultiSelectorItem<T> other) {
    if (identical(this, other)) return true;

    return other.value == value &&
        other.searchValue == searchValue &&
        other.child == child &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        searchValue.hashCode ^
        child.hashCode ^
        icon.hashCode;
  }
}

class VM {
  static BuildContext? _context;
  static VM? _instance;

  VM._internal() {
    _instance = this;
  }

  static VM of(BuildContext context) {
    _context = context;
    return _instance ?? VM._internal();
  }

  static const double radius = 8.0;

  TextStyle get titleStyle => TextStyle(
        color: Theme.of(_context!).brightness == Brightness.light
            ? Colors.black
            : Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get hintStyle => TextStyle(
      color: Theme.of(_context!).brightness == Brightness.light
          ? Colors.black
          : Colors.grey,
      fontSize: 12);

  TextStyle get confirmStyle => TextStyle(
      color: Theme.of(_context!).brightness == Brightness.light
          ? Colors.black
          : Colors.white);

  BoxDecoration get outlineBorder {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: Theme.of(_context!).colorScheme.outline.withOpacity(.6),
      ),
    );
  }

  BoxDecoration get outlineErrorBorder {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: Theme.of(_context!).colorScheme.error,
      ),
    );
  }

  BoxDecoration get elevatedBox {
    return BoxDecoration(
      color: Theme.of(_context!).colorScheme.background,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
            blurRadius: 6.0,
            offset: const Offset(0, 3),
            color: Theme.of(_context!).colorScheme.shadow.withOpacity(.5)),
      ],
    );
  }

  InputDecoration get textFieldDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        isDense: false,
        prefixIcon: Icon(Icons.search,
            color: Theme.of(_context!).colorScheme.secondary),
      );

  Future<void> showMultiSelectDialog(Widget widget) async {
    await showDialog(
      context: _context!,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(15), child: widget),
          ],
        ),
      ),
    );
  }

  Future<void> showMultiSelectSheet(Widget widget) async {
    await showModalBottomSheet(
      context: _context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 30),
        child: widget,
      ),
    );
  }

  Future<T?> showCustomBottomSheet<T>(Widget child) async {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      isScrollControlled: true,
      context: _context!,
      backgroundColor: Colors.transparent,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: DecoratedBox(
                    decoration: of(_context!).elevatedBox,
                    child: const SizedBox(height: 8, width: 80)),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class MultiErrorWidget extends StatelessWidget {
  const MultiErrorWidget({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: Text(error,
              style: const TextStyle(color: Colors.red),
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        ),
      ],
    );
  }
}

class HintContainer extends StatelessWidget {
  const HintContainer({
    Key? key,
    this.child,
    this.title,
    this.titleStyle,
    required this.showArrow,
    required this.btnDecoration,
    required this.errorDecoration,
    required this.hasError,

    // ignore: unused_element
    this.selectedValues,
  })  : assert(child != null || title != null),
        super(key: key);

  final TextStyle? titleStyle;
  final Widget? child;
  final List<Widget>? selectedValues;
  final String? title;
  final BoxDecoration? btnDecoration;
  final BoxDecoration? errorDecoration;
  final bool hasError;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final bd = (btnDecoration ?? _VM.of(context).outlineBorder);

    return Container(
      decoration: (btnDecoration ?? VM.of(context).outlineBorder).copyWith(
        border: hasError
            ? Border.all(color: Theme.of(context).colorScheme.error)
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      constraints: const BoxConstraints(minHeight: 45),
      width: width,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: child ??
                    Text(title ?? '',
                        style: titleStyle ?? VM.of(context).hintStyle,
                        overflow: TextOverflow.ellipsis),
              ),
              if (showArrow) const Icon(Icons.arrow_drop_down),
            ],
          ),
          if ((selectedValues ?? []).isNotEmpty) ...[
            const Divider(height: 2, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: selectedValues!,
              ),
            )
          ]
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(
      {Key? key, required this.title, this.style, this.isRequired = false})
      : super(key: key);

  final String title;
  final TextStyle? style;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Text(title.capitalized,
                  style: style ?? VM.of(context).titleStyle,
                  overflow: TextOverflow.ellipsis),
              if (isRequired)
                const Text(" *", style: TextStyle(color: Colors.red)),
            ],
          )),
          GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 20,
              ),
              onTap: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
