import 'package:flutter/material.dart';
import 'package:test_new/unveels_vto_project/common/helper/constant.dart';
import 'package:test_new/unveels_vto_project/generated/assets.dart';
import 'package:test_new/unveels_vto_project/utils/vto_types.dart';

class VtoTypeSelector extends StatefulWidget {
  const VtoTypeSelector({
    super.key,
    required this.menu,
    required this.onSubTypeChange,
  });
  final MenuVto menu;
  final Function(String type) onSubTypeChange;

  @override
  State<VtoTypeSelector> createState() => _VtoTypeSelectorState();
}

class _VtoTypeSelectorState extends State<VtoTypeSelector> {
  VtoType? vtoType;

  Widget itemType(String pathImage, pathImageOn, VtoType type) {
    String path = vtoType == type ? pathImageOn : pathImage;
    double height = switch (type) {
      VtoType.handAcc ||
      VtoType.headAcc ||
      VtoType.nailsAcc ||
      VtoType.neckAcc =>
        70,
      _ => 56
    };
    return InkWell(
      onTap: () {
        setState(() {
          vtoType = type;
        });
      },
      child: Image.asset(path, height: height),
    );
  }

  Widget selectorItem(String type) {
    return GestureDetector(
      onTap: () => widget.onSubTypeChange(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget itemSubType() {
    List<String> typeList = VtoSubTypes.getSubTypes(vtoType, widget.menu);
    return typeList.isEmpty
        ? const SizedBox()
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              height: 30,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: typeList.length,
                separatorBuilder: (_, __) => Constant.xSizedBox8,
                itemBuilder: (context, index) {
                  return selectorItem(typeList[index]);
                },
              ),
            ),
          );
  }

  Widget sheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.menu == MenuVto.makeup
                ? [
                    itemType(
                      Assets.iconsIcLips,
                      Assets.iconsIcLipsOn,
                      VtoType.lips,
                    ),
                    itemType(
                      Assets.iconsIcEyes,
                      Assets.iconsIcEyesOn,
                      VtoType.eyes,
                    ),
                    itemType(
                      Assets.iconsIcFace,
                      Assets.iconsIcFaceOn,
                      VtoType.face,
                    ),
                    itemType(
                      Assets.iconsIcNails,
                      Assets.iconsIcNailsOn,
                      VtoType.nails,
                    ),
                    itemType(
                      Assets.iconsIcHair,
                      Assets.iconsIcHairOn,
                      VtoType.hair,
                    ),
                  ]
                : [
                    itemType(
                      Assets.iconsIcHead,
                      Assets.iconsIcHeadOn,
                      VtoType.headAcc,
                    ),
                    itemType(
                      Assets.iconsIcNeck,
                      Assets.iconsIcNeckOn,
                      VtoType.neckAcc,
                    ),
                    itemType(
                      Assets.iconsIcHand,
                      Assets.iconsIcHandOn,
                      VtoType.handAcc,
                    ),
                    itemType(
                      Assets.iconsIcNailsAcc,
                      Assets.iconsIcNailsAccOn,
                      VtoType.nailsAcc,
                    ),
                  ],
          ),
          Constant.xSizedBox8,
          Constant.xSizedBox8,
          itemSubType(),
          Constant.xSizedBox12,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: sheet(),
    );
  }
}
