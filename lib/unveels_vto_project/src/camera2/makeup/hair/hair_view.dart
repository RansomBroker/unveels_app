import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class HairView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const HairView({super.key, this.webViewController});

  @override
  State<HairView> createState() => _HairViewState();
}

class _HairViewState extends State<HairView> {
  bool makeupOrAccessories = false;
  int? colorSelected = 0;
  int? hairSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  List<String> colorList = [
    "Yellow",
    "Black",
    "Silver",
    "Gold",
    "Rose Gold",
  ];
  List<String> hairList = [
    Assets.imagesImgHair1,
    Assets.imagesImgHair2,
    Assets.imagesImgHair3,
    Assets.imagesImgHair4,
    Assets.imagesImgHair5,
    Assets.imagesImgHair6,
    Assets.imagesImgHair7,
  ];
  List<Color> hairColorList = [
    const Color(0xFFFFFF00),
    Colors.black,
    const Color(0xFFC0C0C0),
    const Color(0xFFCA9C43),
    const Color(0xFFB76E79),
  ];
  List<Color> colorChoiceList = [
    const Color(0xFF740039),
    const Color(0xFF8D0046),
    const Color(0xFFB20058),
    const Color(0xFFB51F69),
    const Color(0xFFDF1050),
    const Color(0xFFE31B7B),
    const Color(0xFFFE3699),
    const Color(0xFFE861A4),
    const Color(0xFFE0467C),
  ];

  List<String> chipList = ['Gloss', 'Matt', 'Shimmer'];

  Widget lipstickChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 150,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            // if (index == 0)
            //   return InkWell(
            //     onTap: () async {},
            //     child: Icon(Icons.do_not_disturb_alt_sharp,
            //         color: Colors.white, size: 25),
            //   );
            return InkWell(
                onTap: () async {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 15, 10),
                      color: Colors.white,
                      width: 120,
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 9,
                              child: Image.asset(Assets.imagesImgLipstick)),
                          const Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 18,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Item name Tom Ford",
                      style: Constant.whiteBold16.copyWith(fontSize: 12),
                    ),
                    Text(
                      "Brand name",
                      style: Constant.whiteRegular12
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        Text("\$15", style: Constant.whiteRegular12),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: const Color(0xFFC89A44),
                          child: const Center(
                              child: Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                        )
                      ],
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                colorSelected = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: index == colorSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 8, backgroundColor: hairColorList[index]),
                  Constant.xSizedBox4,
                  Text(
                    colorList[index],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget hairChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: hairList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            // if (index == 0)
            //   return InkWell(
            //     onTap: () async {},
            //     child: Icon(Icons.do_not_disturb_alt_sharp,
            //         color: Colors.white, size: 25),
            //   );
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: index == hairSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                      hairSelected = index;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(hairList[index]),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  Widget chipChoice() {
    return SizedBox(
      height: 18,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: chipList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: index == 0 ? Colors.white : Colors.transparent),
            ),
            child: Text(
              colorList[index],
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          );
        },
      ),
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constant.xSizedBox8,
          colorChip(),
          Constant.xSizedBox8,
          hairChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          lipstickChoice(),
        ],
      ),
    );
  }
}
