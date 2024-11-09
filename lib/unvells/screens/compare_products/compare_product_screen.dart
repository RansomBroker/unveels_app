/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/app_widgets/lottie_animation.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/compare_products/compare_product_model.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_bloc.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_events.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_state.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/rating_container.dart';

import '../../app_widgets/app_dialog_helper.dart';
import '../../constants/app_routes.dart';
import '../../constants/arguments_map.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/utils.dart';

class CompareProducts extends StatefulWidget {
  @override
  _CompareProductsState createState() => _CompareProductsState();
}

class _CompareProductsState extends State<CompareProducts> {
  CompareProductModel compareProductModel = CompareProductModel();
  CompareProductBloc? _compareProductBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;

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
            builder: (context, currentState) {
              if (currentState is CompareProductInitial) {
                isLoading = true;
              } else if (currentState is CompareProductSuccess) {
                isLoading = false;
                compareProductModel = currentState.model;
              } else if (currentState is AddProductToWishlistStateSuccess) {
                isLoading = false;
                if (currentState.wishListModel.success == true) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showSuccess(
                        currentState.wishListModel.message ?? '', context);
                    _compareProductBloc?.emit(WishlistIdleState());
                  });
                  if (compareProductModel.productList?[currentState.index]?.entityId.toString() == currentState.productId) {
                    compareProductModel.productList?[currentState.index]?.isInWishlist = true;
                    compareProductModel.productList?[currentState.index]?.wishlistItemId = currentState.wishListModel.itemId;
                  }
                } else {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showError(currentState.wishListModel.message ?? '', context);
                  });
                }
              } else if (currentState is RemoveFromWishlistStateSuccess) {
                isLoading = false;
                if (currentState.baseModel.success == true) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showSuccess(
                        currentState.baseModel.message ?? '', context);
                    _compareProductBloc?.emit(WishlistIdleState());
                  });
                  if (compareProductModel.productList?[currentState.index]?.wishlistItemId.toString() == currentState.productId) {
                    compareProductModel.productList?[currentState.index]?.isInWishlist = false;
                  }
                } else {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showError(
                        currentState.baseModel.message ?? Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
                  });
                }
              } else if (currentState is RemoveFromCompareStateSuccess) {
                isLoading = false;
                if (currentState.baseModel.success == true) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showSuccess(
                        (currentState.baseModel.message ?? '').isEmpty? Utils.getStringValue(context, AppStringConstant.itemRemovedFromCompare) :currentState.baseModel.message ?? '', context);
                    _compareProductBloc?.emit(WishlistIdleState());
                  });
                  _compareProductBloc?.add(const CompareProductDataFetchEvent());
                } else {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showError(
                        currentState.baseModel.message ?? Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
                  });
                }
              } else if (currentState is AddtoCartState) {
                isLoading = false;
                if(currentState.model?.success==true){
                  if ((currentState.model?.quoteId??0) != 0) {
                    appStoragePref.setQuoteId(currentState.model?.quoteId);
                  }
                  appStoragePref.setCartCount(currentState.model?.cartCount);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AlertMessage.showSuccess(
                        currentState.model?.message ?? "", context);
                  });
                }

              } else if (currentState is CompareProductError) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AppDialogHelper.informationDialog(
                      AppStringConstant.errorRequest,
                      context,
                      AppLocalizations.of(context), onConfirm: () async {
                    Navigator.pop(context);
                  },
                      title: AppStringConstant.somethingWentWrong
                  );
                });
              }
              return _buildUI();
            }));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(visible: compareProductModel?.productList != null,
            child: (compareProductModel?.productList?.isNotEmpty??false ) ?
            compareView(context) :
            LottieAnimation(
                icon: Icons.compare,
                title:    _localizations?.translate(Utils.getStringValue(context, AppStringConstant.emptyCompareTitle)).localized() ?? "",
                subtitle:  _localizations?.translate(Utils.getStringValue(context, AppStringConstant.useTheCatalogTo)) ??
                    "",
                titleSmall: _localizations?.translate(Utils.getStringValue(context, AppStringConstant.addProductForCompare)).localized() ?? "" ,
                buttonTitle: _localizations
                    ?.translate(Utils.getStringValue(context, AppStringConstant.continueShopping)).toUpperCase() ??
                    "",
                onPressed:() {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar, (route) => false);
                }),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  Widget compareView(
      BuildContext context,
      ) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: (AppSizes.deviceWidth / 2.5) + 110,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: compareProductModel.productList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return productDetails(
                        context, compareProductModel.productList?[index], _compareProductBloc!, index);
                  }),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: (compareProductModel.attributeValueList ?? [])
                  .map((e) => productAttributes(context, e))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

productDetails(BuildContext context, ProductTileData? productData, CompareProductBloc compareProductBloc, int index,
    {Function? removeCallBack, Function? detailsCallBack}) {
  double imageSize = (AppSizes.deviceWidth / 2.5) - AppSizes.linePadding;

  return SizedBox(
    width: imageSize+20,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
              )),
          padding: const EdgeInsets.all(AppSizes.size8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productPage,
                    arguments: getProductDataAttributeMap(
                      productData?.name ?? "",
                      productData?.entityId.toString() ?? "",
                    ),
                  );
                },
                child: Stack(children: <Widget>[
                  Center(
                    child: ImageView(
                      fit: BoxFit.fill,
                      url: productData?.thumbNail,
                      width: imageSize!,
                      height: imageSize!,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.size8,
                    top: AppSizes.size8,
                    right: AppSizes.size8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                            (productData?.formattedFinalPrice ?? '').isNotEmpty
                                ? productData?.formattedFinalPrice ?? ''
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: AppSizes.textSizeSmall)),
                        Visibility(
                            visible: (productData?.hasSpecialPrice() ?? false),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: AppSizes.linePadding,
                                ),
                                Text(productData?.formattedPrice ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                        fontSize: AppSizes.textSizeSmall)),
                              ],
                            )),
                        const Spacer(),
                       InkWell(
                            onTap: () {
                              if(productData?.typeId=="simple" || productData?.typeId=="virtual"){
                                debugPrint("tappeedddd--->cartCallback");
                                Map<String, dynamic> mProductParamsJSON = {};
                                compareProductBloc?.add(AddtoCartEvent(false, productData?.entityId.toString()??"", 1, mProductParamsJSON));
                              }else{
                                AppDialogHelper.confirmationDialog(Utils.getStringValue(context, Utils.getStringValue(context, AppStringConstant.addOptions)),context,
                                    AppLocalizations.of(context),
                                    title: Utils.getStringValue(context, Utils.getStringValue(context, AppStringConstant.chooseVariant)),
                                    onConfirm: () async {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.productPage,
                                        arguments: getProductDataAttributeMap(
                                          productData?.name ?? "",
                                            productData?.entityId.toString() ?? "",
                                        ),
                                      );
                                    });
                              }
                            },
                            child: Icon(Icons.shopping_cart_outlined,size: 18,)),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.size4,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(productData?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: AppSizes.textSizeSmall)),)
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.size4,
                    ),
                    SizedBox(
                        height: 30,
                        width: 50,
                        child: RatingContainer(double.parse(productData?.rating))),

                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 4,
          left: 4,
          child: IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.grey[400],
            onPressed: () {
              compareProductBloc?.add(RemoveFromCompareEvent(productData?.entityId.toString(), index));
            },
          ),
        ),

        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: Icon(
              (productData?.isInWishlist ?? false)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: (productData?.isInWishlist ?? false)
                  ? AppColors.lightRed
                  : AppColors.lightGray,
              size: 22,
            ),
            color: Colors.grey[400],
            onPressed: () async {
              if (await appStoragePref.isLoggedIn()) {
                if (productData?.isInWishlist != true) {
                  compareProductBloc?.add(AddToWishlistEvent(productData?.entityId.toString(), index));
                } else {
                  print("LISTITEMS-------->${productData?.wishlistItemId.toString()}");
                  AppDialogHelper.confirmationDialog(Utils.getStringValue(context, AppStringConstant.removeItemFromWishlist),context,
                      AppLocalizations.of(context),
                      title: Utils.getStringValue(context, AppStringConstant.removeItem),
                      onConfirm: () async {
                        compareProductBloc?.add(RemoveFromWishlistEvent(productData?.wishlistItemId.toString(), index));
                      });
                }
              } else {
                AppDialogHelper.confirmationDialog(Utils.getStringValue(context, AppStringConstant.loginRequiredToAddOnWishlist),context,
                    AppLocalizations.of(context),
                    title: Utils.getStringValue(context, AppStringConstant.loginRequired),
                    onConfirm: () async {
                      Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                    });
              }
            },
          ),
        ),

      ],
    ),
  );
}

Widget productAttributes(
    BuildContext context, AttributeValue? productAttribute) {
  double imageSize = (AppSizes.deviceWidth / 2.5) - AppSizes.linePadding;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
          width: imageSize+20,
          padding: const EdgeInsets.all(AppSizes.size8),
          child: Text(productAttribute?.attributeName ?? '')),
      IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:( productAttribute?.value ?? [])
                .map(
                  (e) => Container(
                // height: cons.minHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                width: imageSize+20,
                 padding: const EdgeInsets.all(AppSizes.size8),
                child:Text(Utils.parseHtmlString(e))
              ),
            )
                .toList()),
      ),

    ],
  );
}


Widget emptyList(BuildContext context){
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const  Icon(Icons.compare_arrows_outlined, size: 160,),
        Text(Utils.getStringValue(context, Utils.getStringValue(context, AppStringConstant.emptyCompareTitle)), style:  Theme.of(context).textTheme.headlineLarge,),
      ],
    ),
  );
}
