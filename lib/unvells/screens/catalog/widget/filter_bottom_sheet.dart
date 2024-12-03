import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/catalog/layered_data.dart';
import 'package:test_new/unvells/models/catalog/layered_data_options.dart';

import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet(this.filters, this.onFilter, this.selectedFilters,
      {Key? key, this.selectedFiltersLabel})
      : super(key: key);

  final List<LayeredData>? filters;
  final VoidCallback onFilter;
  final List<Map<String, String>>? selectedFilters;
  List<String>? selectedFiltersLabel = [];

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Map<String, int> selectedCounts =
      {}; // Track count of selected options per category

  @override
  void initState() {
    super.initState();
    _initializeSelectedCounts();
  }

  void _initializeSelectedCounts() {
    for (var filter in widget.filters ?? []) {
      selectedCounts[filter.label] = filter.options
              ?.where((LayeredDataOptions opt) => opt.selected == true)
              .length ??
          0;
    }
  }

  void _updateSelectedCount(String category, LayeredData? layeredData) {
    setState(() {
      selectedCounts[category] =
          layeredData?.options?.where((opt) => opt.selected ?? false).length ??
              0;
    });
  }

  void _clearFilters() {
    setState(() {
      for (var filter in widget.filters ?? []) {
        filter.options?.forEach((option) {
          option.selected = false;
        });
        selectedCounts[filter.label] = 0; // Reset selected count
      }
    });
    _initializeSelectedCounts(); // Reset counts
    widget.onFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text(
            Utils.getStringValue(context, AppStringConstant.filterBy)
                .toUpperCase(),
            style: KTextStyle.of(context).boldSixteen,
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _clearFilters(); // C
                Navigator.pop(context); // Close bottom sheet
                // lear filters
              },
              child: Text(
                Utils.getStringValue(context, AppStringConstant.clear)
                    .toUpperCase(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     widget.onFilter(); // Apply filters
            //     Navigator.pop(context); // Close bottom sheet
            //   },
            //   child: Text(
            //     Utils.getStringValue(context, AppStringConstant.apply)
            //         .toUpperCase(),
            //   ),
            // ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.selectedFilters?.isNotEmpty ?? false)
                      Container(
                        color: Theme.of(context).cardColor,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 20.0, 0, 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        Utils.getStringValue(context,
                                            AppStringConstant.currentFilter),
                                        style:
                                        Theme.of(context).textTheme.titleLarge,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20.0, 10, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      for (var element in widget.filters ?? []) {
                                        element.options?.forEach((filter) {
                                          filter.selected = false;
                                        });
                                      }
                                      _initializeSelectedCounts(); // Reset counts
                                      setState(() {}); // Update UI
                                      widget.onFilter(); // Reapply filters
                                      Navigator.pop(context); // Set filters
                                    },
                                    child: Text(
                                      Utils.getStringValue(
                                          context, AppStringConstant.delete),
                                      style: TextStyle(
                                          color: Theme.of(context).iconTheme.color,
                                          fontSize: AppSizes.textSizeSmall,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.selectedFilters?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 8.0, 0, 8),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        widget.selectedFiltersLabel?[index] ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        // padding: EdgeInsets.only(bottom: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, idx) {
                          var layeredData = widget.filters?.elementAt(idx);
                          return _listElement(
                            layeredData?.label ?? "",
                            layeredData,
                            context,
                          );
                        },
                        itemCount: widget.filters?.length ?? 0,
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    // width: AppSizes.deviceWidth*.8,
                    title: Utils.getStringValue(context, AppStringConstant.apply)
                        .toUpperCase(),
                    onPressed: () {
                      widget.onFilter(); // Apply filters
                      Navigator.pop(context);
                      // Your button action here
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _listElement(
      String title, LayeredData? layeredData, BuildContext context) {
    if (widget.selectedFilters?.isNotEmpty ?? false) {
      widget.selectedFilters?.forEach((element) {
        layeredData?.options?.forEach((optionElement) {
          if ((element["code"].toString() == layeredData?.code.toString()) &&
              (element["value"].toString() == optionElement.id.toString())) {
            optionElement.selected = true;
          }
        });
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Row(
              children: [
                Expanded(
                    child:
                        Text(title, style: KTextStyle.of(context).boldSixteen)),
                if (selectedCounts[title]! > 0)
                  CircleAvatar(
                    backgroundColor: AppColors.gold,
                    radius: 12,
                    child: Text(
                      selectedCounts[title]!.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            children: [
              StatefulBuilder(
                builder: (ctx, setState) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var option = layeredData?.options?.elementAt(index);
                    return CheckboxListTile(
                      dense: true,
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 2),
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // fillColor: WidgetStateProperty<Color?>.new(),
                      contentPadding: const EdgeInsets.all(0),
                      value: option?.selected ?? false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Text(
                          option?.label ?? "",
                          style: KTextStyle.of(context).sixteen,
                        ),
                      ),
                      onChanged: (isSelected) {
                        setState(() {
                          option?.selected = isSelected ?? false;
                          _updateSelectedCount(
                              title, layeredData); // Update count
                        });
                      },
                    );
                  },
                  itemCount: layeredData?.options?.length ?? 0,

                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
