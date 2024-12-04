import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/logic/get_product_utils/get_brand_name.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_bloc.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_events.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_event.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_state.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../skin_tone_finder/skin_tone_product_model.dart';
import '../../look_product_model.dart';

class PFProductItemWidget extends StatefulWidget {
  const PFProductItemWidget(
      {super.key, this.productData, this.lookData, this.showTryOn = true});

  final SkinToneProductData? productData;
  final LookProfiles? lookData;
  final bool? showTryOn;

  @override
  State<PFProductItemWidget> createState() => _PFProductItemWidgetState();
}

class _PFProductItemWidgetState extends State<PFProductItemWidget> {
  ItemCardBloc? itemCardBloc;
  bool isLoading = false;
  bool _isAddingToCart = false;

  String get brandName {
    String brand = "";
    try {
      brand = getBrandNameByValue(widget.productData?.customAttributes
                  .firstWhere((e) => e.attributeCode == "brand")
                  .value ??
              "") ??
          "";
    } catch (e) {
      print(e);
      brand = "";
    }

    return brand;
  }

  @override
  Widget build(BuildContext context) {
    itemCardBloc = context.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
        builder: (context, currentState) {
      if (currentState is ItemCardInitial) {
        isLoading = true;
      } else {
        isLoading = false;
        _isAddingToCart = false;
        if (currentState is ItemCardErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddToCartError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is AddProductToWishlistStateSuccess) {
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishListModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is AddtoCartState) {
          if (currentState.model?.success == true) {
            if ((currentState.model?.quoteId ?? 0) != 0) {
              appStoragePref.setQuoteId(currentState.model?.quoteId);
            }
            appStoragePref.setCartCount(currentState.model?.cartCount);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? "", context);
              itemCardBloc?.emit(WishlistIdleState());
            });
          }
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
          if (currentState.fromWishlist) {
            Future.delayed(Duration.zero).then(
              (value) {
                HiveStore().reset();
                context
                    .read<HomeScreenBloc>()
                    .add(const HomeScreenDataFetchEvent(true));
              },
            );
          }
        }
      }
      return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.productPage,
            arguments: getProductDataAttributeMap(
              widget.productData?.name ?? '',
              widget.productData?.id.toString() ?? '',
            )),
        child: SizedBox(
          height: 242,
          width: 151,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.lookData == null
                  ? CachedNetworkImage(
                      imageUrl:
                          "${ApiConstant.webUrl}/media/catalog/product${widget.productData?.customAttributes.where((e) => e.attributeCode == 'small_image').first.value}",
                      placeholder: (context, url) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator())),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Icon(Icons.error))),
                        );
                      },
                      height: 242 * 0.65,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          "${ApiConstant.webUrl}/media/${widget.lookData?.image}",
                      placeholder: (context, url) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator())),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Icon(Icons.error))),
                        );
                      },
                      height: 242 * 0.65,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lookData?.name ??
                              widget.productData?.name ??
                              '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          brandName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.lookData == null)
                    Text(
                      "\$${widget.productData?.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SvgPicture.asset(
                IconPath.fourStarsExample,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _isAddingToCart
                        ? const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          )
                        : ButtonWidget(
                            onTap: () async {
                              Map<String, dynamic> mProductParamsJSON = {};
                              itemCardBloc?.add(AddtoCartEvent(
                                  widget.productData!.id.toString(),
                                  1,
                                  mProductParamsJSON));
                              setState(() {
                                _isAddingToCart = true;
                              });
                            },
                            text: "ADD TO CART",
                            backgroundColor: Colors.transparent,
                            borderColor: Colors.white,
                            height: 27,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: widget.showTryOn == true
                        ? ButtonWidget(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.lookBookList);
                            },
                            text: "TRY ON",
                            backgroundColor: Colors.white,
                            height: 27,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
