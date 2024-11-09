/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/compare_products/compare_product_model.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_bloc.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_events.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_state.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/rating_container.dart';

class CompareProducts extends StatefulWidget {
  @override
  _CompareProductsState createState() => _CompareProductsState();
}

class _CompareProductsState extends State<CompareProducts> {
  CompareProductModel compareProductModel = CompareProductModel();
  CompareProductBloc? _compareProductBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;

  GlobalKey globleKey = GlobalKey();

  @override
  void initState() {
    _compareProductBloc = context.read<CompareProductBloc>();
    _compareProductBloc?.add(const CompareProductDataFetchEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.compareProduct) ?? '',
            context),
        body: BlocBuilder<CompareProductBloc, CompareProductState>(
            builder: (context, state) {
              if (state is CompareProductInitial) {
                isLoading = true;
              } else if (state is CompareProductSuccess) {
                isLoading = false;
                compareProductModel = state.model;
              } else if (state is CompareProductError) {
                isLoading = false;
                WidgetsBinding?.instance?.addPostFrameCallback((timeStamp) {
                  AlertMessage.showSuccess(state.message ?? '', context);
                });
              }
              return _buildUI();
            }));
  }

  Widget _buildUI() {
    return (isLoading == true)
        ? const Loader()
        : Stack(
      children: [
        compareView(context, compareProductModel),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }
}


///method for ui of whole compare screen

Widget compareView(
    BuildContext context, CompareProductModel compareScreenModel) {
  var h = AppSizes.deviceHeight;
  return SingleChildScrollView(
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: h > 800
                      ? MediaQuery.of(context).size.height / 2.3
                      : MediaQuery.of(context).size.height / 2.1,
                  width: (compareScreenModel.productList?.length ?? 0) *
                      MediaQuery.of(context).size.width /
                      2.2,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: compareScreenModel.productList?.length ?? 0,
                      itemBuilder: (context, index) {
                        int rating = (double.parse(compareScreenModel.productList?[index]
                            .rating
                            .toString() ??
                            "")
                            .toInt());
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ProductPage,
                            //     arguments: PassProductData(
                            //         title: compareScreenModel
                            //             .data?[index].productFlat?.name ??
                            //             "",
                            //         productId: int.parse(compareScreenModel
                            //             .data?[index]
                            //             .productFlat
                            //             ?.product
                            //             ?.id ??
                            //             "")));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                  // bottom: BorderSide(
                                  //   color: Colors.grey,
                                  //   width: 1.5,
                                  // ),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ImageView(
                                      url: compareScreenModel
                                          .productList?[index]
                                          .thumbNail??
                                          "",
                                      width:
                                      MediaQuery.of(context).size.width / 2.2,
                                      height:
                                      MediaQuery.of(context).size.height / 4,
                                    ),
                                    Positioned(
                                      right: 8.0,
                                      top: 8.0,
                                      child: InkWell(
                                        onTap: () {
                                          // CompareScreenBloc compareScreenBloc =
                                          // context.read<CompareScreenBloc>();
                                          // compareScreenBloc.add(
                                          //     OnClickCompareLoaderEvent(
                                          //         isReqToShowLoader: true));
                                          // compareScreenBloc.add(
                                          //     RemoveFromCompareListEvent(
                                          //         compareScreenModel.data?[index]
                                          //             .productFlatId ??
                                          //             "",
                                          //         ""));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              size: AppSizes.size20,
                                              color: Colors.white,
                                            )),
                                      ),
                                      // top: 10.0,
                                      // right: 10.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizes.spacingNormal,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        compareScreenModel
                                            .productList?[index]
                                            .formattedPrice??
                                            "",
                                        style: const TextStyle(
                                            fontSize: AppSizes.textSizeMedium,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          // CompareScreenBloc compareScreenBloc =
                                          // context.read<CompareScreenBloc>();
                                          // if (compareScreenModel
                                          //     .data![index]
                                          //     .productFlat
                                          //     ?.product
                                          //     ?.isInWishlist ??
                                          //     false) {
                                          //   compareScreenBloc.add(
                                          //       FetchDeleteWishlistItemEvent(
                                          //           int.parse(compareScreenModel
                                          //               .data![index]
                                          //               .productFlat
                                          //               ?.product
                                          //               ?.id ??
                                          //               ""),
                                          //           compareScreenModel
                                          //               .data?[index]));
                                          //   compareScreenBloc.add(
                                          //       OnClickCompareLoaderEvent(
                                          //           isReqToShowLoader: true));
                                          // } else {
                                          //   compareScreenBloc.add(
                                          //       AddtoWishlistCompareEvent(
                                          //           compareScreenModel
                                          //               .data![index]
                                          //               .productFlat
                                          //               ?.product
                                          //               ?.id,
                                          //           compareScreenModel
                                          //               .data?[index]));
                                          //   compareScreenBloc.add(
                                          //       OnClickCompareLoaderEvent(
                                          //           isReqToShowLoader: true));
                                          // }
                                        },
                                        child: (compareScreenModel
                                            .productList?[index]
                                            .isInWishlist ??
                                            false)
                                            ? const Icon(
                                          Icons.favorite,
                                          color: Colors.black,
                                        )
                                            : const Icon(
                                          Icons.favorite_outline_rounded,
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: Text(
                                      compareScreenModel
                                          .productList?[index].name ??
                                          "",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: AppSizes.textSizeSmall),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //     height: 30,
                                //     width: 50,
                                //     child: RatingContainer(compareScreenModel.productList?[index]?.rating)
                                // ),

                                Padding(padding: EdgeInsets.fromLTRB(25, 15, 15, 0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.spacingLarge,
                                        vertical: AppSizes.spacingGeneric
                                    ),
                                color: Theme.of(context).cardColor,
                                    child: SizedBox(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Text((Utils.getStringValue(context, AppStringConstant.addToCart.toUpperCase()?? '')),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.textSizeMedium, color: AppColors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                  width: (compareScreenModel.productList?.length ?? 0) *
                      MediaQuery.of(context).size.width /
                      2.2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 6, bottom: 2),
                      child: Text(
                        "SKU",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33,
                  // height: MediaQuery.of(context).size.height/2.3 ,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: compareScreenModel.productList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ProductPage,
                            //     arguments: PassProductData(
                            //         title: compareScreenModel
                            //             .data?[index].productFlat?.name ??
                            //             "",
                            //         productId: int.parse(compareScreenModel
                            //             .data?[index]
                            //             .productFlat
                            //             ?.product
                            //             ?.id ??
                            //             "")));
                          },
                          child: Container(
                            // margin: ,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8, right: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Text(
                                  compareScreenModel
                                      ?.attributeValueList?[0].value?[index].toString() ??
                                      "",
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                  width: (compareScreenModel.productList?.length ?? 0) *
                      MediaQuery.of(context).size.width /
                      2.2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 6, bottom: 2),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 + 60,
                  // height: MediaQuery.of(context).size.height/2.3 ,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: compareScreenModel.productList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ProductPage,
                            //     arguments: PassProductData(
                            //         title: compareScreenModel
                            //             .data?[index].productFlat?.name ??
                            //             "",
                            //         productId: int.parse(compareScreenModel
                            //             .data?[index]
                            //             .productFlat
                            //             ?.product
                            //             ?.id ??
                            //             "")));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 2 + 10,
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, right: 8),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                    child: Html(
                                      data: compareScreenModel.attributeValueList?[1].value?[index]
                                          ??
                                          "",
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 8.0,
                                //       right: 8.0,
                                //       top: MediaQuery.of(context).size.height / 50),
                                //   child: TextButton(
                                //     onPressed: () {
                                //       CompareScreenBloc compareScreenBloc =
                                //       context.read<CompareScreenBloc>();
                                //       compareScreenBloc.add(OnClickCompareLoaderEvent(
                                //           isReqToShowLoader: true));
                                //       if (compareScreenModel.data?[index].productFlat
                                //           ?.product?.type ==
                                //           simple) {
                                //         compareScreenBloc.add(AddToCartCompareEvent(
                                //             (compareScreenModel.data?[index]
                                //                 .productFlat?.product?.id ??
                                //                 ""),
                                //             1,
                                //             ""));
                                //       } else {
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(SnackBar(
                                //           content: Text(
                                //               ApplicationLocalizations.of(context)!
                                //                   .translate('addOptions')),
                                //           duration: const Duration(seconds: 3),
                                //         ));
                                //         compareScreenBloc.add(
                                //             OnClickCompareLoaderEvent(
                                //                 isReqToShowLoader: false));
                                //       }
                                //       // var dict = <String, dynamic>{};
                                //       // dict['product_id'] =
                                //       //     compareScreenModel.data![index].productFlat!.id ?? '';
                                //       // dict['quantity'] = 1;
                                //       // compareScreenBloc.add(AddToCartCompareEvent(
                                //       //     compareScreenModel.data![index].productFlat!.id,
                                //       //     dict,
                                //       //     ""));
                                //     },
                                //     child: Text("AddToCart".localized().toUpperCase(),
                                //         style: TextStyle(color: Colors.black)),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),

              ],
            ),
          ),
        ],
      ));
}

