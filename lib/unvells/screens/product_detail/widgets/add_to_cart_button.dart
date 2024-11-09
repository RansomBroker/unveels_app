/*
 *


 *
 * /
 */

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/logic/get_product_details/get_product_details_bloc.dart';
import 'package:test_new/logic/get_product_details/get_product_details_bloc.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/helper/skeleton_widget.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../../logic/get_product_details/get_product_details_state.dart';
import '../../../app_widgets/app_outlined_button.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../bloc/product_detail_screen_bloc.dart';
import '../bloc/product_detail_screen_events.dart';
import '../bloc/product_detail_screen_state.dart';

class AddToCartButtonView extends StatefulWidget {
  ProductDetailScreenBloc? productPageBloc;
  ProductDetailPageModel? _productDetailPageModel;
  int counter;
  List downloadLinks = [];
  List<dynamic> groupedParams = [];
  List<dynamic> bundleParams = [];
  List<dynamic> customOptionSelection = [];
  final ValueChanged<bool>? callback;

  AddToCartButtonView(
      this.productPageBloc,
      this._productDetailPageModel,
      this.counter,
      this.downloadLinks,
      this.groupedParams,
      this.bundleParams,
      this.customOptionSelection,
      {Key? key,
      this.callback});

  @override
  State<AddToCartButtonView> createState() => _AddToCartButtonViewState();
}

class _AddToCartButtonViewState extends State<AddToCartButtonView> {
  AppLocalizations? _localizations;

  List<dynamic> relatedProducts = [];

  Map<String, dynamic> mProductParamsJSON = new Map();

  @override
  void initState() {
    // GetProductDetailsNewBloc.of(context).get(sku: widget._productDetailPageModel?.sku??'');
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    final getGiftDataBloc = GetProductDetailsNewBloc.of(context);
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 29.0, left: 25, right: 25, top: 17),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomButton(
                onPressed: () {
                  if (widget._productDetailPageModel?.typeId ==
                      'bss_giftcard') {
                    giftBottomModelSheet(
                        context: context,
                        addToCart: () {
                          debugPrint(
                              widget._productDetailPageModel?.sku.toString());

                          widget.productPageBloc?.add(AddGiftToCartEvent(
                            sku: widget._productDetailPageModel?.sku ?? '',
                            productParamsJSON: {
                              "bss_giftcard_amount": "custom",
                              "bss_giftcard_amount_dynamic":
                                  getGiftDataBloc.selectedAMount?.price,
                              "bss_giftcard_recipient_email": getGiftDataBloc
                                  .emailOfAddresseeController.text,
                              "bss_giftcard_recipient_name": getGiftDataBloc
                                  .nameOfAddresseeController.text,
                              "bss_giftcard_sender_email":
                                  getGiftDataBloc.emailController.text,
                              "bss_giftcard_sender_name":
                                  getGiftDataBloc.nameController.text,
                              "bss_giftcard_selected_image":
                                  getGiftDataBloc.selectedImage?.id,
                              "bss_giftcard_template":
                                  getGiftDataBloc.selectedTemplate?.templateId,
                              "bss_giftcard_message_email":
                                  getGiftDataBloc.messageController.text,
                              "bss_giftcard_timezone":
                                  getGiftDataBloc.selectedTimeZone?.value,
                              "bss_giftcard_delivery_date":
                                  getGiftDataBloc.dateController.text
                            },
                          ));
                        },
                        bloc: GetProductDetailsNewBloc.of(context),
                        detailsBloc: widget.productPageBloc!);
                  } else if (collectAllOptionData(true, context)) {
                    print(
                        "TEST_LOG ===> mProductParamsJSON ==> $mProductParamsJSON");
                    widget.productPageBloc?.add(AddtoCartEvent(
                      false,
                      widget._productDetailPageModel?.id?.toString() ?? "",
                      widget.counter,
                      mProductParamsJSON,
                      relatedProducts,
                    ));
                  }
                },
                title:
                    Utils.getStringValue(context, AppStringConstant.addToCart)
                        .toUpperCase(),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            BlocBuilder<GetProductDetailsNewBloc, GetProductDetailsState>(
              builder: (context, state) {
                return state.when(
                  loading: () => const Expanded(
                      child: Skeleton(
                    height: 54,
                    cornerRadius: 10,
                  )),
                  success: (model) {
                    final bool isTryOn =
                        model?.items?.firstOrNull?.isProductTryOn == 1;
                    final bool? is_product_skin_try =
                        model?.items?.firstOrNull?.is_product_skin_try == 1;

                    return is_product_skin_try == true
                        ? Expanded(
                            flex: 1,
                            child: CustomButton(
                              onPressed: () {},
                              kFillColor: Colors.white,
                              borderColor: AppColors.gold,
                              textColor: AppColors.gold,
                              iconPath: "assets/icons/Tryon icon.png",
                              title: "SKIN IMPROVEMENTS".toUpperCase(),
                            ))
                        : isTryOn == true
                            ? Expanded(
                                flex: 1,
                                child: CustomButton(
                                  onPressed: () {},
                                  kFillColor: Colors.white,
                                  borderColor: AppColors.gold,
                                  textColor: AppColors.gold,
                                  iconPath: "assets/icons/Tryon icon.png",
                                  title: Utils.getStringValue(context, AppStringConstant.tryOn),
                                ))
                            : Expanded(
                                flex: 1,
                                child: CustomButton(
                                  onPressed: () {
                                    if (collectAllOptionData(true, context)) {
                                      print(
                                          "TEST_LOG ===> mProductParamsJSON ==> $mProductParamsJSON");
                                      widget.productPageBloc?.add(
                                          AddtoCartEvent(
                                              true,
                                              widget._productDetailPageModel?.id
                                                      ?.toString() ??
                                                  "",
                                              widget.counter,
                                              mProductParamsJSON,
                                              relatedProducts));
                                    }
                                  },
                                  kFillColor: Colors.white,
                                  borderColor: AppColors.gold,
                                  textColor: AppColors.gold,
                                  title: Utils.getStringValue(
                                              context, AppStringConstant.buyNow)
                                          .toUpperCase() ??
                                      '',
                                ));
                  },
                  error: (e) => Text(e),
                  initial: () => const CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool collectAllOptionData(bool isChecksEnabled, BuildContext context) {
    bool isAllRequiredOptionFilled = true;

    try {
      print(
          "TEST_LOG ===> Available ${widget._productDetailPageModel?.isAvailable}");

      if (widget._productDetailPageModel?.isAvailable ?? true) {
        switch (widget._productDetailPageModel?.typeId) {
          case "configurable":
            {
              List<dynamic> configurableOptnList = [];
              widget._productDetailPageModel?.configurableData?.attributes
                  ?.forEach((attributeElement) {
                Map<String, String> configurableOptnObj = new Map();
                if (attributeElement.swatchType == "visual" ||
                    attributeElement.swatchType == "text") {
                  var selectedItemId = "";
                  attributeElement.options?.forEach((element) {
                    if (element.swatchData?.isSelected ?? false) {
                      selectedItemId = element.swatchData?.id.toString() ?? "";
                    }
                  });

                  if (isChecksEnabled && selectedItemId.isEmpty) {
                    widget.productPageBloc?.emit(ProductDetailScreenErrorAlert(
                        Utils.getStringValue(context,
                            AppStringConstant.selectConfigurableOptionsMsg)));
                    isAllRequiredOptionFilled = false;
                  } else {
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    configurableOptnObj["id"] =
                        attributeElement.id?.toString() ?? "";
                    configurableOptnObj["value"] = selectedItemId;
                  }
                  configurableOptnList.add(configurableOptnObj);
                } else {
                  var selectedItemId = "";
                  attributeElement.options?.forEach((element) {
                    if (element.swatchData?.isSelected ?? false) {
                      selectedItemId = element.swatchData?.id.toString() ?? "";
                    }
                  });

                  print("TEST_LOG ===> selectedItemId $selectedItemId");

                  if (isChecksEnabled && selectedItemId.isEmpty) {
                    widget.productPageBloc?.emit(ProductDetailScreenErrorAlert(
                        Utils.getStringValue(context,
                            AppStringConstant.selectConfigurableOptionsMsg)));
                    isAllRequiredOptionFilled = false;
                  } else {
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    configurableOptnObj["id"] =
                        attributeElement.id?.toString() ?? "";
                    configurableOptnObj["value"] = selectedItemId;
                  }
                  configurableOptnList.add(configurableOptnObj);
                }
              });
              mProductParamsJSON["superAttribute"] = configurableOptnList;
              break;
            }
          case "downloadable":
            {
              if (widget.downloadLinks.isNotEmpty) {
                mProductParamsJSON["links"] = widget.downloadLinks;
              } else {
                isAllRequiredOptionFilled = false;
                widget.productPageBloc?.emit(ProductDetailScreenErrorAlert(
                    Utils.getStringValue(context,
                        AppStringConstant.selectConfigurableOptionsMsg)));
              }
              break;
            }
          case "grouped":
            {
              if (widget.groupedParams.isNotEmpty) {
                mProductParamsJSON["superGroup"] = widget.groupedParams;
                debugPrint(
                    "TEST_LOG ==> grouped ==>   ${mProductParamsJSON.toString()}");
              } else {
                widget.productPageBloc?.emit(ProductDetailScreenErrorAlert(
                    Utils.getStringValue(context,
                        AppStringConstant.selectConfigurableOptionsMsg)));
              }
              break;
            }
          case "bundle":
            {
              // _productDetailPageModel?.bundleOptions?.optionValues?.forEach((element) {
              //   if (bundleParams.isNotEmpty) {
              //     // list.add(bundleParams);
              //     debugPrint("TEST_LOG ==> bundleParams ==>   ${bundleParams.toString()}");
              //   } else {
              //     productPageBloc?.emit(ProductDetailScreenErrorAlert(AppStringConstant.selectConfigurableOptionsMsg));
              //     return;
              //   }
              // });

              mProductParamsJSON["bundleOption"] = widget.bundleParams;
              break;
            }
        }

        if (isAllRequiredOptionFilled &&
            (widget._productDetailPageModel?.customOptions ?? []).isNotEmpty) {
          widget._productDetailPageModel?.customOptions
              ?.forEach((attributeElement) {
            mProductParamsJSON["options"] = widget.customOptionSelection;
            switch (attributeElement.type) {
              case "drop_down":
                //Spinner View;

                // mProductParamsJSON["options"] = customOptionSelection;
                break;
              case "radio":
                //RadioView

                break;
              case "checkbox":
                //CheckBoxView

                break;
              case "multiple":
                //CheckBoxView

                break;
              case "field":
                //EditTextView

                break;
              case "area":
                //EditTextView

                break;

              default:
                break;
            }
          });
        }

        ///get related product data

        relatedProducts = [];
        widget._productDetailPageModel?.relatedProductList?.forEach((element) {
          if (element.isChecked ?? false) {
            relatedProducts.add(element.entityId);
          }
        });
      }
    } catch (e) {
      isAllRequiredOptionFilled = false;
      print(e);
    }

    return isAllRequiredOptionFilled;
  }
}

class ProductParams {
  String? id;
  dynamic? value;

  ProductParams({this.id, this.value});

  factory ProductParams.fromJson(Map<String, dynamic> json) => ProductParams(
        id: json["id"] ?? null,
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        id.toString(): value,
      };
}
