import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_page2.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project//utils/utils.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class EyeshadowView extends StatefulWidget {
  const EyeshadowView({super.key});

  @override
  State<EyeshadowView> createState() => _EyeshadowViewState();
}

class _EyeshadowViewState extends State<EyeshadowView> {
  late CameraController controller;
  Completer<String?> cameraSetupCompleter = Completer();
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  double sliderValue = 0;
  bool onOffVisibel = false;
  int? eyebrowSelected = 0;
  int? colorSelected = 0;
  int? colorTextSelected = 0;
  int? typeSelected = 0;
  int? typeComboSelected = 0;

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    print("Fetching data");
    try {
      // print("Trying to fetch");
      // List<String>? textures =
      //     getTextureByLabel([chipList[typeColorSelected!]]);
      List<String>? productTypes =
          getProductTypesByLabels("eye_makeup_product_type", [
        "Eyeshadows",
      ]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: "eye_makeup_product_type",
          productTypes: productTypes?.join(","));
      setState(() {
        products = dataResponse;
      });
    } catch (e) {
      print("err");
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Color> colorMainList = [
    const Color(0xffFE3699),
    const Color(0xffE1E1A3),
    const Color(0xff3D0B0B),
    const Color(0xffFF0000),
    Colors.white,
  ];

  List<String> colorMainListString = [
    'Pink',
    'Beige',
    'Brown',
    'Red',
    'White',
  ];
  List<Color> colorList = [
    const Color(0xff3D2B1F),
    const Color(0xff5C4033),
    const Color(0xff6A4B3A),
    const Color(0xff8B4513),
    const Color(0xff7B3F00),
    const Color(0xff4F300D),
    const Color(0xff483C32),
    const Color(0xff342112),
    const Color(0xff4A2912),
  ];

  List<String> type1List = [
    'Sheer',
    'Matt',
    'Gloss',
  ];

  List<String> typeComboList = [
    'One',
    'Dual',
    'Tri',
    'Quadra',
    'Penta',
  ];

  List<Widget> typeEyeShadow = [
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      DeviceInfoPlugin().androidInfo.then((value) {
        if (value.version.sdkInt >= 32) {
          permissions = [
            Permission.camera,
            Permission.microphone,
          ];
        } else {
          permissions = [
            Permission.camera,
            Permission.microphone,
            // Permission.storage
          ];
        }
      }).then((value) {
        // _initCamera();
        checkPermissionStatuses().then((allclear) {
          if (allclear) {
            _initCamera();
          } else {
            permissions.request().then((value) {
              checkPermissionStatuses().then((allclear) {
                if (allclear) {
                  _initCamera();
                } else {
                  Utils.showToast(
                      'Mohon izinkan untuk mengakses Kamera dan Mikrofon');
                  Navigator.of(context).pop();
                }
              });
            });
          }
        });
      });
    } else {
      _initCamera();
      // permissions = [
      //   Permission.camera,
      //   Permission.microphone,
      //   // Permission.storage
      // ];
      // checkPermissionStatuses().then((allclear) {
      //   if (allclear) {
      //     _initCamera();
      //   } else {
      //     permissions.request().then((value) {
      //       checkPermissionStatuses().then((allclear) {
      //         if (allclear) {
      //           _initCamera();
      //         } else {
      //           Utils.showToast(
      //               'Mohon izinkan untuk mengakses Kamera dan Mikrofon');
      //           Navigator.of(context).pop();
      //         }
      //       });
      //     });
      //   }
      // });
    }
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    if (cameraSetupCompleter.isCompleted) {
      controller.dispose();
    }
  }

  Future<bool> checkPermissionStatuses() async {
    for (var permission in permissions) {
      if (await permission.status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<void> _initCamera({CameraDescription? camera}) async {
    Future<void> selectCamera(CameraDescription camera) async {
      controller = CameraController(camera, ResolutionPreset.high,
          imageFormatGroup: ImageFormatGroup.jpeg);
      await controller.initialize();
      cameraSetupCompleter.complete();
    }

    if (camera != null) {
      selectCamera(camera);
    } else {
      await availableCameras().then((value) async {
        isFlipCameraSupported = value.indexWhere((element) =>
                element.lensDirection == CameraLensDirection.front) !=
            -1;

        for (var camera in value) {
          if (camera.lensDirection == CameraLensDirection.back) {
            await selectCamera(camera);
            return;
          }
        }

        cameraSetupCompleter
            .complete("Tidak dapat menemukan kamera yang cocok.");
      });
    }
  }

  Widget pictureTaken() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Constant.xSizedBox24,
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffCA9C43),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Share',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Constant.xSizedBox16,
                    Icon(Icons.share_outlined, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget colorChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: colorMainList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  colorTextSelected = index;
                });
                fetchData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: index == colorTextSelected
                          ? Colors.white
                          : Colors.transparent),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 8, backgroundColor: colorMainList[index]),
                    Constant.xSizedBox4,
                    Text(
                      colorMainListString[index],
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget colorChoice() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () async {
                setState(() {
                  onOffVisibel = true;
                });
                fetchData();
              },
              child: const Icon(Icons.do_not_disturb_alt_sharp,
                  color: Colors.white, size: 25),
            );
          }
          return InkWell(
              onTap: () async {
                setState(() {
                  colorSelected = index;
                  onOffVisibel = false;
                });
                fetchData();
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: index == colorSelected && onOffVisibel == false
                            ? Colors.white
                            : Colors.transparent),
                  ),
                  child: CircleAvatar(
                      radius: 12, backgroundColor: colorList[index])));
        },
      ),
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget typeChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: type1List.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                setState(() {
                  typeSelected = index;
                });
                fetchData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: index == typeSelected
                          ? Colors.white
                          : Colors.transparent),
                ),
                child: Center(
                  child: Text(
                    type1List[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget typeComboChip() {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeComboList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                typeComboSelected = index;
              });
              fetchData();
            },
            child: Center(
              child: Text(
                typeComboList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    shadows: index == typeComboSelected
                        ? [
                            const BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.white,
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ]
                        : null),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget typeEyeShadowChip() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeEyeShadow.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                eyebrowSelected = index;
              });
              fetchData();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: index == eyebrowSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: typeEyeShadow[index],
            ),
          );
        },
      ),
    );
  }

  Widget lipstickChoice() {
    if (_isLoading) {
      return SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(color: Colors.white, width: 150, height: 80),
            ],
          ));
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products?.length ?? 0,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            // if (index == 0)
            //   return InkWell(
            //     onTap: () async {},
            //     child: Icon(Icons.do_not_disturb_alt_sharp,
            //         color: Colors.white, size: 25),
            //   );
            var product = products?[index];
            if (product != null) {
              return VtoProductItem(product: product);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget slider() {
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Slider(
            thumbColor: const Color(0xffCA9C43),
            activeColor: const Color(0xffCA9C43),
            value: sliderValue,
            max: 10,
            min: 0,
            onChanged: (v) {
              setState(() {
                sliderValue = v;
              });
              fetchData();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Light',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
                Text('Dark',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constant.xSizedBox8,
          colorChip(),
          Constant.xSizedBox8,
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          typeChip(),
          Constant.xSizedBox4,
          separator(),
          Constant.xSizedBox4,
          typeComboChip(),
          Constant.xSizedBox4,
          separator(),
          Constant.xSizedBox4,
          typeEyeShadowChip(),
          separator(),
          Constant.xSizedBox4,
          lipstickChoice(),
        ],
      ),
    );
  }

  Widget cameraPreview(double scale) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: CameraPreview(controller),
      ),
    );
  }

  Widget iconSidebar(GestureTapCallback? onTap, String path) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        path,
        width: 24,
        height: 24,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        // toolbarHeight: 0,
        leadingWidth: 84,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            CusNav.nPop(context);
            CusNav.nPushReplace(context, OcrCameraPage2(makeUpOn: true));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            // padding: EdgeInsets.all(8),
            // width: 64,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black26),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              // padding: EdgeInsets.only(right: 16, left: 16),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black26),
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<String?>(
        future: cameraSetupCompleter.future,
        builder: (context, snapshot) {
          final isLoading = snapshot.connectionState != ConnectionState.done;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.data != null) {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Setup Camera Failed'),
                Text(
                  snapshot.data!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ));
          } else {
            return LayoutBuilder(
              builder: (p0, p1) {
                final width = p1.maxWidth;
                final height = p1.maxHeight;

                late double scale;

                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  final screenRatio = width / height;
                  final cameraRatio = controller.value.aspectRatio;
                  scale = 1 / (cameraRatio * screenRatio);
                } else {
                  final screenRatio = (height) / width;
                  final cameraRatio = controller.value.aspectRatio;
                  scale = 1 / (cameraRatio * screenRatio);
                }

                return Stack(
                  children: [
                    cameraPreview(scale),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // margin: xHEdgeInsets12
                        //     .add(const EdgeInsets.only(bottom: 12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    iconSidebar(() async {
                                      CusNav.nPush(
                                          context, const CameraVideoPage());
                                    }, Assets.iconsIcCamera),
                                    Constant.xSizedBox12,
                                    iconSidebar(() async {
                                      ///[Flip Camera]
                                      if (isFlippingCamera == null ||
                                          isFlippingCamera!.isCompleted) {
                                        isFlippingCamera = Completer();
                                        isFlippingCamera!.complete(
                                            await availableCameras()
                                                .then((value) async {
                                          for (var camera in value) {
                                            if (camera.lensDirection ==
                                                (controller.description
                                                            .lensDirection ==
                                                        CameraLensDirection
                                                            .front
                                                    ? CameraLensDirection.back
                                                    : CameraLensDirection
                                                        .front)) {
                                              await controller.dispose();
                                              cameraSetupCompleter =
                                                  Completer();

                                              await _initCamera(camera: camera);
                                              setState(() {});
                                              break;
                                            }
                                          }

                                          await Future.delayed(const Duration(
                                              seconds: 1, milliseconds: 500));
                                        }));
                                      } else {
                                        print('Not completed!');
                                      }
                                    }, Assets.iconsIcFlipCamera),
                                    Constant.xSizedBox12,
                                    iconSidebar(
                                        () async {}, Assets.iconsIcScale),
                                    Constant.xSizedBox12,
                                    iconSidebar(() async {
                                      setState(() {
                                        // makeupOrAccessories = true;
                                      });
                                    }, Assets.iconsIcCompare),
                                    Constant.xSizedBox12,
                                    iconSidebar(
                                        () async {}, Assets.iconsIcReset),
                                    Constant.xSizedBox12,
                                    iconSidebar(
                                        () async {}, Assets.iconsIcChoose),
                                    Constant.xSizedBox12,
                                    iconSidebar(
                                        () async {}, Assets.iconsIcShare),
                                  ],
                                ),
                              ),
                            ),
                            Constant.xSizedBox16,
                            sheet(),
                            // file != null ? pictureTaken() : noPictureTaken(),
                            // pictureTaken(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
