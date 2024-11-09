/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/catalog/layered_data.dart';
import 'package:test_new/unvells/models/catalog/layered_data_options.dart';
import 'package:test_new/unvells/screens/catalog/widget/checkbox_tile.dart';

import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet(this.filters, this.onFilter, this.selectedFilters,
      {Key? key, this.groupValue = "", this.selectedFiltersLabel})
      : super(key: key);
  final List<LayeredData>? filters;
  final VoidCallback onFilter;
  final List<Map<String, String>>? selectedFilters;
  List<String>? selectedFiltersLabel = [];
  String? groupValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          title: Text(
            Utils.getStringValue(context, AppStringConstant.filterBy)
                .toUpperCase(),
            style: KTextStyle.of(context).boldSixteen,
          ),
          automaticallyImplyLeading: false,
          // Uncomment this if you require a close button
          // leading: const CloseButton(),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: onFilter,
          //     child: Text(
          //       Utils.getStringValue(context, AppStringConstant.apply).toUpperCase(),
          //     ),
          //   )
          // ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedFilters?.isNotEmpty ?? false)
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
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20.0, 0, 10),
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
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20.0, 10, 10),
                              child: GestureDetector(
                                onTap: () {
                                  for (var element in filters ?? []) {
                                    element.options?.forEach((filter) {
                                      filter.selected = false;
                                    });
                                  }
                                  onFilter();
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
                              // physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedFilters?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8.0, 0, 8),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      selectedFiltersLabel?[index].toString() ??
                                          "",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, idx) {
                    return _listElement(
                      "${filters?.elementAt(idx).label}",
                      filters?.elementAt(idx),
                      context,
                    );
                  },
                  itemCount: filters?.length ?? 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _listElement(
    String title,
    LayeredData? layeredData,
    BuildContext context,
  ) {
    if (selectedFilters?.isNotEmpty ?? false) {
      selectedFilters?.forEach((element) {
        layeredData?.options?.forEach((optionElement) {
          if ((element["code"].toString() == layeredData.code.toString()) &&
              (element["value"].toString() == optionElement.id.toString()))
            optionElement.selected = true;
        });
      });
    }
    return Padding(
      padding: const EdgeInsets.only(left:AppSizes.spacingSmall,top: AppSizes.size6,bottom: AppSizes.size6,right: AppSizes.spacingGeneric),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.spacingSmall,bottom: AppSizes.size6),
            child: Text(
              title,
              style: KTextStyle.of(context).twelve,
            ),
          ),
          StatefulBuilder(
            builder: (ctx, setState) => ListView.builder(
              // padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => RadioListTile<String?>(

                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),

                dense: true,
                contentPadding: const EdgeInsets.all(0),
                // visualDensity: const VisualDensity(),
                value:
                    "${layeredData?.code}${layeredData?.options?.elementAt(index).id}",
                groupValue: groupValue,
                title: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    layeredData?.options?.elementAt(index).label ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    groupValue =
                        "${layeredData?.code}${layeredData?.options?.elementAt(index).id}";
                    layeredData?.options?.elementAt(index).selected = true;
                    onFilter();
                  });
                },
              ),
              //     CheckboxTile(layeredData?.options?.elementAt(index),
              //             () {
              //       setState(() {});
              //
              // }),
              itemCount: layeredData?.options?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }
}
