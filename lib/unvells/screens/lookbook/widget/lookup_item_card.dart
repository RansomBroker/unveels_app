/*
 *


 *
 * /
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';

import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/productDetail/product_new_model.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_bloc.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import '../../cart/bloc/cart_screen_bloc.dart';
import '../../cart/bloc/cart_screen_event.dart';
import '../../cart/bloc/cart_screen_repository.dart';
import '../../cart/bloc/cart_screen_state.dart';
import '../../cart/widgets/quantity_changer.dart';
import '../../home/widgets/item_card_bloc/item_card_bloc.dart';
import '../../home/widgets/item_card_bloc/item_card_event.dart';
import '../../home/widgets/item_card_bloc/item_card_state.dart';

class LookupItemCard extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductNewItems? product;

  LookupItemCard(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<LookupItemCard> createState() => _LookupItemCardState();
}

class _LookupItemCardState extends State<LookupItemCard> {
  bool isLoading = false;
  ItemCardBloc? itemCardBloc;
  CartScreenBloc? cartScreenBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.size4;
    itemCardBloc = ctx.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          isLoading = true;
        } else if (currentState is ItemCardErrorState) {
          isLoading = false;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddtoCartState) {
          isLoading = false;
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
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppSizes.deviceWidth / 3.5,
            width: AppSizes.deviceWidth / 3.5,
            child: FluxImage(
              imageUrl: widget.product?.image ?? '',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: AppSizes.deviceWidth * .4,
                child: Text(widget.product?.name ?? '',
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: KTextStyle.of(context).semiBoldSixteen
                    // const TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
              ),
              const SizedBox(
                height: AppSizes.size16,
              ),
              // Spacer()
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    loadingWidget: const CircularProgressIndicator(),
                    isLoading: itemCardBloc?.isLoadingAction,
                    width: AppSizes.deviceWidth * .25,
                    hieght: AppSizes.deviceHeight * .05,
                    title: Utils.getStringValue(
                        context, AppStringConstant.addToCart),
                    onPressed: () {
                      if (widget.product?.type_id == "simple" ||
                          widget.product?.type_id == "virtual") {
                        debugPrint("tappeedddd--->cartCallback");
                        Map<String, dynamic> mProductParamsJSON = {};
                        itemCardBloc?.add(AddtoCartEvent(
                            widget.product?.id.toString() ?? "",
                            1,
                            mProductParamsJSON));
                      } else {
                        AppDialogHelper.confirmationDialog(
                            Utils.getStringValue(
                                context,
                                Utils.getStringValue(context,
                                    AppStringConstant.addOptions)),
                            context,
                            AppLocalizations.of(context),
                            title: Utils.getStringValue(
                                context,
                                Utils.getStringValue(context,
                                    AppStringConstant.chooseVariant)),
                            onConfirm: () async {
                          Navigator.of(context).pushNamed(
                            AppRoutes.productPage,
                            arguments: getProductDataAttributeMap(
                              widget.product?.name ?? "",
                              widget.product?.id.toString() ?? "",
                            ),
                          );
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: AppSizes.deviceWidth * .1,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.productPage,
                        arguments: getProductDataAttributeMap(
                          widget.product?.name ?? "",
                          widget.product?.id.toString() ?? "",
                        ),
                      );
                    },
                    child: Text(
                      Utils.getStringValue(
                        context,
                        AppStringConstant.details,
                      ),
                      style: KTextStyle.of(context).sixteen,
                    ),
                  )
                ],
              )

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   mainAxisSize: MainAxisSize.max,
              //   children: <Widget>[
              //     Text(
              //         (widget.product?.formattedFinalPrice ?? '')
              //                 .isNotEmpty
              //             ? widget.product?.formattedFinalPrice ?? ''
              //             : '',
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //         style: KTextStyle.of(context).sixteen),
              //     if ((widget.product?.hasSpecialPrice() ?? false)) ...[
              //       const SizedBox(
              //         width: AppSizes.size2,
              //       ),
              //       Text(widget.product?.formattedPrice ?? '',
              //           style: KTextStyle.of(context).twelve.copyWith(
              //                 color: Colors.grey,
              //                 decoration: TextDecoration.lineThrough,
              //               )),
              //     ],
              //   ],
              // ),
            ],
          ),
          // if (widget.product?.hasSpecialPrice() == true)
          //   Container(
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //           color: AppColors.green,
          //         )
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: AppSizes.linePadding, bottom: AppSizes.linePadding, left: AppSizes.linePadding, right: AppSizes.linePadding),
          //       child: Text("${widget.product?.getDiscountPercentage()}"
          //           "${Utils.getStringValue(context, AppStringConstant.offPercentage)}", style: TextStyle(color: AppColors.green),),
          //     ),
          //   ),
          // if (widget.product?.hasSpecialPrice() == true)
          //   const SizedBox(
          //     height: AppSizes.spacingGeneric,
          //   ),
          // const SizedBox(
          //   height: AppSizes.spacingGeneric,
          // ),
        ],
      ),
    );
  }
}
