import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/extensions.dart';

import 'index.dart';



class KSingleSelector<T> extends StatefulWidget {
  final String title;
  final BoxDecoration? btnDecoration, popupDecoration, errorDecoration;
  final List<MultiSelectorItem<T>> items;
  final Function(T?) onChanged;
  final T? value;
  final SelectorViewType? type;
  final String? Function(T? values)? validator;
  final String? error;
  final bool? showArrow;
  final bool? showAz;
  final bool isRequired;

  final TextStyle? titleStyle, hintStyle;
  final InputDecoration? textFieldDecoration;

  const KSingleSelector({
    Key? key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.showArrow,
    this.showAz,
    this.btnDecoration,
    this.errorDecoration,
    this.validator,
    this.value,
    this.error,
    this.titleStyle,
    this.textFieldDecoration,
    this.type = SelectorViewType.sheet,
    this.popupDecoration,
    this.hintStyle,  this.isRequired=false,
  }) : super(key: key);

  @override
  State<KSingleSelector<T>> createState() => _KSingleSelectorState<T>();
}

class _KSingleSelectorState<T> extends State<KSingleSelector<T>> {
  MultiSelectorItem<T>? _selectedItem;
  late List<MultiSelectorItem<T>> _items;
  late List<MultiSelectorItem<T>> _initItems;
  T? _value;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _initItems = widget.items;

    _value = widget.value;
    _items = widget.items;
    _selectedItem = _items.firstWhereOrNull((element) => element.value == widget.value);
    _selectedIndex = _selectedItem != null ? _items.indexOf(_selectedItem!) : -1;
  }

  @override
  void didUpdateWidget(KSingleSelector<T> oldWidget) {
    debugPrint('=================  didUpdateWidget : ${widget.title}');
    _items = widget.items;
    _initItems = widget.items;

    if (widget.value != oldWidget.value) {
      _value = widget.value;
      _selectedItem = _items.firstWhereOrNull((element) => element.value == widget.value);
      _selectedIndex = _selectedItem != null ? _items.indexOf(_selectedItem!) : -1;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    debugPrint('=================  didChangeDependencies : ${widget.title}');
    _items = widget.items;
    _initItems = widget.items;
    if (_selectedIndex != -1 && _items.isNotEmpty) {
      //_selectedItem = _items[_selectedIndex];
      _selectedItem = _initItems.where((element) => element.value == widget.value).firstOrNull;

      _value = _selectedItem?.value;
      // debugPrint('========= did Change Dependencies ==== _selectedValue ${widget.value == _selectedValue} ==== _selectedIndex $_selectedIndex ');
      // debugPrint('========= did Change Dependencies ==== _selectedValue ${widget.value} ==== _selectedIndex $_selectedIndex ');
    }
    super.didChangeDependencies();
  }

  void _onItemSelected(int index) {
    _selectedItem = _items[index];
    if (_selectedItem == null) return;
    final i = _initItems.indexOf(_selectedItem!);
    _selectedItem = _initItems[i];
    _value = _selectedItem?.value;
    _selectedIndex = i;

    debugPrint('================= $_value : ');

    widget.onChanged(_value);
    setState(() {});
    Navigator.pop(context);
  }

  bool get isAr => Directionality.of(context) == TextDirection.rtl;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWidget(title: widget.title, style: widget.titleStyle,isRequired: widget.isRequired,),
              if (widget.items.length > 4)
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    decoration: widget.textFieldDecoration ?? VM.of(context).textFieldDecoration,
                    onChanged: (p0) {
                      _items = widget.items.where((element) => element.searchValue.toString().toLowerCase().contains(p0.toLowerCase().replaceAll(' ', ''))).toList();
                      setSt.call(() {});
                    },
                  ),
                ),
              const SizedBox(height: 8),
              const Divider(thickness: 1, height: 1),
              (widget.showAz ?? false)
                  ? Expanded(
                      child: AzListView(
                        itemCount: _items.length,
                        data: _items.map((e) => _AZItem(e.searchValue ?? '#')).toList(),
                        indexBarData: getAllFirstChars(_items.map((e) => e.searchValue).toList()),
                        indexBarAlignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            onPressed: () {
                              _onItemSelected(index);
                              setSt.call(
                                () {},
                              );
                            },
                            child: ListTile(
                              visualDensity: VisualDensity.compact,
                              leading: _items[index].icon,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              title: _items[index].child,
                            ),
                          );
                        },
                      ),
                    )
                  : Flexible(
                      fit: FlexFit.tight,
                      child: ListView.builder(
                        itemCount: _items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            onPressed: () {
                              _onItemSelected(index);
                            },
                            child: ListTile(
                              visualDensity: VisualDensity.compact,
                              leading: _items[index].icon,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              title: _items[index].child,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FormField<T?>(
      validator: widget.validator,
      builder: (formState) {
        return InkWell(
          onTap: () async {
            if (_items.isNotEmpty) {
              if (widget.type == SelectorViewType.sheet) {
                await VM.of(context).showMultiSelectSheet(_buildListView);
              } else {
                await VM.of(context).showMultiSelectDialog(_buildListView);
              }
              formState
                ..didChange(_value)
                ..validate();
            }
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
                child: Row(
                  children: [
                    if (_selectedItem != null)
                      Expanded(
                        child: Row(
                          children: [
                            if (_selectedItem?.icon != null) ...[
                              SizedBox(width: 24, height: 24, child: _selectedItem!.icon!),
                              const SizedBox(width: 10),
                            ],
                            Expanded(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: width - 130), child: _selectedItem!.child)),
                          ],
                        ),
                      )
                    else
                      Expanded(child: Text(widget.title, style: widget.hintStyle ?? VM.of(context).hintStyle, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
              if (formState.hasError || (widget.error != null && widget.error!.isNotEmpty)) ...[
                const SizedBox(height: 5),
                MultiErrorWidget(error: formState.errorText ?? widget.error ?? ''),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _AZItem extends ISuspensionBean {
  final String title;

  _AZItem(this.title);

  String get tag => title.toString().split('').firstOrNull ?? '';

  @override
  String getSuspensionTag() => tag;
}

List<String> getAllFirstChars(List<String?> list) {
  final map = <String, String>{};
  for (var element in list) {
    if (element?.split("").firstOrNull != null) {
      map.addAll({element!.split("").firstOrNull!: element.split("").firstOrNull!});
    }
  }

  return map.entries.map((e) => e.value).toList();
}
