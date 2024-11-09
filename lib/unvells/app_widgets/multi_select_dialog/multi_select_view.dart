import 'index.dart';
import 'package:flutter/material.dart';

class KMultiSelector<T> extends StatefulWidget {
  final String title;
  final BoxDecoration? btnDecoration, popupDecoration, errorDecoration;
  final List<MultiSelectorItem<T>> items;
  final SelectorViewType? type;
  final void Function(List<T> values) onChanged;
  final String? Function(List<T>? values)? validator;
  final String? error;
  final List<T>? initSelection;
  final bool? showArrow;
  final bool? showAz;

  final String? confirmText;
  final TextStyle? confirmStyle;
  final TextStyle? titleStyle, hintStyle;
  final InputDecoration? textFieldDecoration;

  const KMultiSelector({
    Key? key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.showArrow,
    this.showAz,
    this.btnDecoration,
    this.validator,
    this.type = SelectorViewType.sheet,
    this.error,
    this.confirmStyle,
    this.initSelection,
    this.confirmText,
    this.titleStyle,
    this.textFieldDecoration,
    this.popupDecoration,
    this.errorDecoration,
    this.hintStyle,
  }) : super(key: key);

  @override
  State<KMultiSelector<T>> createState() => _KMultiSelectorState<T>();
}

class _KMultiSelectorState<T> extends State<KMultiSelector<T>> {
  late List<MultiSelectorItem<T>> _items;
  List<MultiSelectorItem<T>> _selectedItems = [];
  List<T> selectedValues = [];

  @override
  void initState() {
    _items = widget.items;
    selectedValues = widget.initSelection ?? [];
    _selectedItems = widget.items.where((element) => selectedValues.contains(element.value)).toList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _items = widget.items;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant KMultiSelector<T> oldWidget) {
    _items = widget.items;

    super.didUpdateWidget(oldWidget);
  }

  void _onItemSelect(MultiSelectorItem<T> item) {
    if (selectedValues.contains(item.value)) {
      _selectedItems.removeAt(selectedValues.indexOf(item.value));
      selectedValues.remove(item.value);
    } else {
      _selectedItems.add(item);
      selectedValues.add(item.value);
    }
    setState(() {});
  }

  void _removerItem(MultiSelectorItem<T> e) {
    _selectedItems.remove(e);
    selectedValues.remove(e.value);
    setState(() {});
  }

  onDeleted(MultiSelectorItem<T> e, FormFieldState<List<T>> formState) {
    _removerItem(e);
    widget.onChanged(selectedValues);
    formState
      ..didChange(selectedValues)
      ..validate();
  }

  void clear(Function(void Function()) setSt) {
    selectedValues.clear();
    _selectedItems.clear();
    setSt(() {});
  }

  void selectAll(Function(void Function()) setSt) {
    selectedValues = widget.items.map((e) => e.value).toList();
    _selectedItems = widget.items.map((e) => e).toList();
    setSt(() {});
  }

  Widget get _buildListView {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final mh = widget.items.length > (height * .6 / 48)
        ? height * .8
        : ((widget.items.length * 48.0) + 110) < height
            ? ((widget.items.length * 48.0) + 110)
            : height * .8;
    return Container(
      decoration: widget.popupDecoration ?? VM.of(context).elevatedBox,
      constraints: BoxConstraints(maxHeight: mh),
      width: width,
      child: StatefulBuilder(
        builder: (context, setSt) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWidget(title: widget.title, style: widget.titleStyle),
              if (widget.items.length > 4)
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    onChanged: (p0) {
                      _items = widget.items
                          .where((element) => element.searchValue.toString().toLowerCase().contains(p0.toLowerCase().replaceAll(' ', '')))
                          .toList();
                      setSt.call(() {});
                    },
                    decoration: widget.textFieldDecoration ?? VM.of(context).textFieldDecoration,
                  ),
                ),
              const SizedBox(height: 5),
              const Divider(thickness: 1, height: 1),
              Flexible(
                fit: FlexFit.tight,
                child: ListView.builder(
                  itemCount: _items.length,
                 
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: selectedValues.contains(_items[index].value),
                      checkColor: Colors.white,
                      visualDensity: VisualDensity.compact,
                      activeColor: Theme.of(context).colorScheme.primary,
                      title: _items[index].child,
                      secondary: _items[index].icon,
                      onChanged: (value) {
                        _onItemSelect(_items[index]);
                        widget.onChanged(selectedValues);
                        setSt.call(() {});
                      },
                    );
                  },
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => clear(setSt),
                    child: const Icon(Icons.clear_all_rounded, color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.done_all_rounded, color: Colors.green),
                  ),
                  TextButton(
                    onPressed: () => selectAll(setSt),
                    child: const Icon(Icons.select_all_rounded),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      validator: widget.validator,
      builder: (formState) {
        return InkWell(
          onTap: () async {
            if (_items.isEmpty) return;
            if (widget.type == SelectorViewType.sheet) {
              await VM.of(context).showMultiSelectSheet(_buildListView);
            } else {
              await VM.of(context).showMultiSelectDialog(_buildListView);
            }
            _items = widget.items;

            formState
              ..didChange(selectedValues)
              ..validate();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HintContainer(
                btnDecoration: widget.btnDecoration,
                errorDecoration: widget.errorDecoration,
                hasError: formState.hasError,
                titleStyle: widget.hintStyle,
                showArrow: widget.showArrow ?? true,
                selectedValues: _selectedItems
                    .map(
                      (e) => Chip(
                        label: e.child,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        avatar: e.icon != null ? SizedBox(height: 18, width: 18, child: e.icon) : null,
                        onDeleted: () => onDeleted(e, formState),
                      ),
                    )
                    .toList(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    widget.title,
                    style: widget.hintStyle ?? VM.of(context).hintStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (formState.hasError || widget.error != null) ...[
                const SizedBox(height: 5),
                MultiErrorWidget(error: formState.errorText ?? widget.error ?? ''),
              ]
            ],
          ),
        );
      },
    );
  }
}
