import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/tone_tab_parsing.dart';
import '../../skin_tone_model.dart';
import '../../skin_tone_product_model.dart';
import '../../tone_type_model.dart';
import 'stf_product_item_widget.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

final List<String> _matchedTones = [
  "Cooler",
  "Lighter",
  "Perfect Fit",
  "Warner",
  "Darker",
];

Map<String, String> hexColorTone = {
  "cooler": "A37772",
  "lighter": "DF9F86",
  "perfect fit": "B7775E",
  "warmer": "CB8B5E",
  "darker": "8F4F36"
};

Map<String, String> hexOtherTone = {
  "Fair": "ffdfc4",
  "Medium": "f0c08c",
  "Light": "FAD4B4",
  "Olive": "c68642",
  "Tan": "a57243",
  "Brown": "8d5524",
  "Deep": "4b2e1f",
};
final List<String> _skinTones = [
  "Light tones",
  "Medium tones",
  "Dark Tones",
];

String selectedHexa = "";

class STFShadesWidget extends StatefulWidget {
  final Function()? onViewAll;
  final String? resultData;
  final SkinToneModel? skinToneModel;
  final ToneTypeModel? toneTypeModel;

  const STFShadesWidget(
      {super.key,
      this.onViewAll,
      this.resultData,
      this.skinToneModel,
      this.toneTypeModel});

  @override
  State<STFShadesWidget> createState() => _STFShadesWidgetState();
}

class _STFShadesWidgetState extends State<STFShadesWidget> {
  ToneTab? _selectedToneTab;
  String _selectedSkinTone = "perfect fit";
  String _selectedOtherTone = "Fair";
  // String? _selectedMatchedTone;

  SkinToneProductModel skinToneProductModel = SkinToneProductModel();
  SkinToneProductModel otherToneProductModel = SkinToneProductModel();
  bool isLoadingProductt = true;
  bool isLoadingProductOther = true;
  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedToneTab = ToneTab.values.first;

    _selectedSkinTone = "perfect fit";

    // _selectedMatchedTone = _matchedTones.first;
    getProduct(
        widget.skinToneModel!.options!
                .where((e) =>
                    e.label.toString().toLowerCase() ==
                    jsonDecode(widget.resultData!)["skinType"]
                        .toString()
                        .split(' ')[0]
                        .toLowerCase())
                .first
                .value ??
            '',
        widget.toneTypeModel!.options
                ?.where((e) =>
                    e.label?.toLowerCase() == _selectedSkinTone.toLowerCase())
                .first
                .value ??
            '');

    getProductBySkinTone(widget.skinToneModel?.options
            ?.where((e) => e.label == _selectedOtherTone)
            .first
            .value ??
        '-');
  }

  Color hexToColor(String hexString) {
    // Ensure the string is properly formatted
    hexString = hexString.toUpperCase().replaceAll('#', '');

    // If the hex code is only 6 characters (RRGGBB), add the 'FF' prefix for full opacity
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    // Parse the hex string to an integer and return the color
    return Color(int.parse(hexString, radix: 16));
  }

  getProduct(String skinId, String toneTypeId) async {
    try {
      setState(() {
        isLoadingProductt = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=451&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=skin_tone&searchCriteria[filter_groups][2][filters][0][value]=$skinId&searchCriteria[filter_groups][2][filters][0][condition_type]=eq&searchCriteria[filter_groups][3][filters][0][field]=tone_type&searchCriteria[filter_groups][3][filters][0][value]=$toneTypeId&searchCriteria[filter_groups][3][filters][0][condition_type]=finset');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          skinToneProductModel =
              SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingProductt = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingProductt = false;
      });
    }
  }

  getProductBySkinTone(String skinId) async {
    try {
      setState(() {
        isLoadingProductOther = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=451&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=skin_tone&searchCriteria[filter_groups][2][filters][0][value]=$skinId&searchCriteria[filter_groups][2][filters][0][condition_type]=eq');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          otherToneProductModel =
              SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingProductOther = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingProductOther = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final macthedToneItemWidth = (context.width * 0.9) / _matchedTones.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ToneTabItemWidget(
                      tab: ToneTab.values.first,
                      isSelected: _selectedToneTab == ToneTab.values.first,
                      onTap: (value) {
                        if (value != _selectedToneTab) {
                          setState(() {
                            _selectedToneTab = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: _ToneTabItemWidget(
                      tab: ToneTab.values.last,
                      isSelected: _selectedToneTab == ToneTab.values.last,
                      onTap: (value) {
                        if (value != _selectedToneTab) {
                          setState(() {
                            _selectedToneTab = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (_selectedToneTab == ToneTab.other) ...[
          SizedBox(
            height: 35,
            child: ListView.separated(
              itemCount: widget.skinToneModel?.options?.length ?? 0,
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (context, index) {
                final skinTone = widget.skinToneModel?.options?[index].label;
                final isSelected = skinTone == _selectedOtherTone;
                final isFirst = index == 0;
                final isEnd =
                    index == (widget.skinToneModel?.options?.length ?? 0) - 1;
                // get opacity from index, example: 1 => 0.1
                // final opacity = (1 - index / 10);

                if (widget.skinToneModel?.options?[index].label == ' ') {
                  return Container();
                }

                return Padding(
                  padding: EdgeInsets.only(
                    left: isFirst ? SizeConfig.horizontalPadding : 0,
                    right: isEnd ? SizeConfig.horizontalPadding : 0,
                  ),
                  child: _SkinToneItemWidget(
                    title:
                        '${widget.skinToneModel?.options?[index].label ?? ''} Skin',
                    color: hexToColor(hexOtherTone[
                            (widget.skinToneModel?.options?[index].label ??
                                '-')] ??
                        '#FFFFFF'),
                    isSelected: isSelected,
                    onTap: (value) {
                      if (value != _selectedOtherTone) {
                        setState(() {
                          _selectedOtherTone = value.split(' ')[0];
                          getProductBySkinTone(widget.skinToneModel?.options
                                  ?.where((e) => e.label == _selectedOtherTone)
                                  .first
                                  .value ??
                              '-');
                          selectedHexa = "";
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          isLoadingProductOther
              ? const SizedBox()
              : otherToneProductModel.items == null
                  ? const SizedBox()
                  : otherToneProductModel.items!.isEmpty
                      ? const SizedBox()
                      : Container(
                          height: 35,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.horizontalPadding),
                          alignment: Alignment.centerLeft,
                          child: ListView.separated(
                            itemCount:
                                (otherToneProductModel.items?.length ?? 0) + 1,
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              // final isFirst = index == 0;
                              // final isEnd = index ==
                              //     (otherToneProductModel.items?.length ?? 0) -
                              //         1;
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedHexa = "";
                                    });
                                  },
                                  child: Container(
                                      height: selectedHexa == "" ? 35 : 25,
                                      width: selectedHexa == "" ? 35 : 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          color: Colors.transparent),
                                      child: Icon(Icons.not_interested_rounded,
                                          color: Colors.white,
                                          size: selectedHexa == "" ? 35 : 25)),
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedHexa = otherToneProductModel
                                        .items![index - 1].customAttributes
                                        .where((e) =>
                                            e.attributeCode == "hexacode")
                                        .first
                                        .value;
                                  });
                                },
                                child: Container(
                                    height: selectedHexa ==
                                            otherToneProductModel
                                                .items![index - 1]
                                                .customAttributes
                                                .where((e) =>
                                                    e.attributeCode ==
                                                    "hexacode")
                                                .first
                                                .value
                                        ? 35
                                        : 25,
                                    width:
                                        selectedHexa == otherToneProductModel.items![index - 1].customAttributes.where((e) => e.attributeCode == "hexacode").first.value
                                            ? 35
                                            : 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: selectedHexa ==
                                                otherToneProductModel
                                                    .items![index - 1]
                                                    .customAttributes
                                                    .where(
                                                        (e) => e.attributeCode == "hexacode")
                                                    .first
                                                    .value
                                            ? Border.all(color: Colors.white)
                                            : Border.all(color: Colors.transparent),
                                        color: hexToColor(otherToneProductModel.items![index - 1].customAttributes.where((e) => e.attributeCode == "hexacode").first.value))),
                              );
                            },
                          ),
                        ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onViewAll,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: isLoadingProductOther
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : otherToneProductModel.items == null
                    ? const Center(
                        child: Text('No Product!'),
                      )
                    : otherToneProductModel.items!.isEmpty
                        ? const Center(
                            child: Text('No Product!'),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: ListView.separated(
                              itemCount:
                                  otherToneProductModel.items?.length ?? 0,
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                final isFirst = index == 0;
                                final isEnd = index ==
                                    (otherToneProductModel.items?.length ?? 0) -
                                        1;

                                if (selectedHexa == "") {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: isFirst
                                          ? SizeConfig.horizontalPadding
                                          : 0,
                                      right: isEnd
                                          ? SizeConfig.horizontalPadding
                                          : 0,
                                    ),
                                    child: STFProductItemWidget(
                                      data: otherToneProductModel.items?[index],
                                    ),
                                  );
                                } else if (selectedHexa != "" &&
                                    selectedHexa ==
                                        otherToneProductModel
                                            .items![index].customAttributes
                                            .where((e) =>
                                                e.attributeCode == "hexacode")
                                            .first
                                            .value) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: isFirst
                                          ? SizeConfig.horizontalPadding
                                          : 0,
                                      right: isEnd
                                          ? SizeConfig.horizontalPadding
                                          : 0,
                                    ),
                                    child: STFProductItemWidget(
                                      data: otherToneProductModel.items?[index],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
          ),
        ],
        if (_selectedToneTab == ToneTab.matched) ...[
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.horizontalPadding),
            child: _SkinToneItemWidget(
              title: '${jsonDecode(widget.resultData!)["skinType"]}',
              color: hexToColor(
                  jsonDecode(widget.resultData!)["hexColor"] ?? '#FFFFFF'),
              isSelected: true,
              onTap: (value) {
                if (value != _selectedSkinTone) {
                  setState(() {
                    _selectedSkinTone = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: widget.toneTypeModel!.options!.map((e) {
                if ((hexColorTone[(e.label ?? '-').toLowerCase()] ??
                        '#FFFFFF') ==
                    '#FFFFFF') {
                  return const SizedBox();
                }
                return _MatchedToneItemWidget(
                  title: e.label ?? '',
                  color: hexToColor(
                      hexColorTone[(e.label ?? '-').toLowerCase()] ??
                          '#FFFFFF'),
                  isSelected:
                      _selectedSkinTone.toLowerCase() == e.label!.toLowerCase(),
                  width: macthedToneItemWidth,
                  onTap: (value) {
                    setState(() {
                      _selectedSkinTone = e.label!;
                      getProduct(
                          widget.skinToneModel!.options!
                                  .where((e) =>
                                      e.label.toString().toLowerCase() ==
                                      jsonDecode(widget.resultData!)["skinType"]
                                          .toString()
                                          .split(' ')[0]
                                          .toLowerCase())
                                  .first
                                  .value ??
                              '',
                          widget.toneTypeModel!.options
                                  ?.where((e) =>
                                      e.label?.toLowerCase() ==
                                      _selectedSkinTone.toLowerCase())
                                  .first
                                  .value ??
                              '');
                    });
                  },
                );
              }).toList()

              // _matchedTones.map((matchedTone) {
              //   final isSelected = matchedTone == _selectedMatchedTone;
              //   // get opacity from index, example: 1 => 0.9
              //   final opacity = (1 - _matchedTones.indexOf(matchedTone) / 10);

              //   return _MatchedToneItemWidget(
              //     title: matchedTone,
              //     color: const Color(0xFFCB8B5E).withOpacity(
              //       opacity,
              //     ),
              //     isSelected: isSelected,
              //     width: macthedToneItemWidth,
              //     onTap: (value) {
              //       if (value != _selectedMatchedTone) {
              //         setState(() {
              //           _selectedMatchedTone = value;
              //         });
              //       }
              //     },
              //   );
              // }).toList(),
              ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onViewAll,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: isLoadingProductt
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : skinToneProductModel.items!.isEmpty
                    ? const Center(
                        child: Text('No Product!'),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: ListView.separated(
                          itemCount: skinToneProductModel.items?.length ?? 0,
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            final isFirst = index == 0;
                            final isEnd = index == 10 - 1;

                            return Padding(
                              padding: EdgeInsets.only(
                                left:
                                    isFirst ? SizeConfig.horizontalPadding : 0,
                                right: isEnd ? SizeConfig.horizontalPadding : 0,
                              ),
                              child: STFProductItemWidget(
                                data: skinToneProductModel.items?[index],
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ]
      ],
    );
  }
}

class _ToneTabItemWidget extends StatelessWidget {
  final ToneTab tab;
  final bool isSelected;
  final Function(ToneTab value) onTap;

  const _ToneTabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(tab);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: Center(
          child: Text(
            tab.title,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkinToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;

  const _SkinToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchedToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;
  final double width;

  const _MatchedToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        height: isSelected ? 40 : 26,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
