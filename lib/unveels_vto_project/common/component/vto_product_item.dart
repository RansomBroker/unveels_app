import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project/common/helper/constant.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_bloc.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_events.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_event.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_state.dart';

class VtoProductItem extends StatefulWidget {
  const VtoProductItem({
    super.key,
    required this.product,
  });

  final ProductData product;

  @override
  State<VtoProductItem> createState() => _VtoProductItemState();
}

class _VtoProductItemState extends State<VtoProductItem> {
  ItemCardBloc? itemCardBloc;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    itemCardBloc = context.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          isLoading = true;
        } else {
          isLoading = false;

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

        return Stack(
          children: [
            InkWell(
              onTap: () async {},
              child: SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 15, 10),
                      color: Colors.white,
                      width: 150,
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 9,
                              child: Image.network(
                                widget.product.imageUrl,
                                width: double.infinity,
                              )),
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
                      widget.product.name,
                      style: Constant.whiteBold16.copyWith(fontSize: 11),
                    ),
                    Text(
                      widget.product.brand,
                      style: Constant.whiteRegular12
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 10),
                    ),
                    Row(
                      children: [
                        Text("KWD ${widget.product.price.toString()}",
                            style:
                                Constant.whiteRegular12.copyWith(fontSize: 10)),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            Map<String, dynamic> mProductParamsJSON = {};
                            itemCardBloc?.add(AddtoCartEvent(
                                widget.product.id.toString(),
                                1,
                                mProductParamsJSON));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: const Color(0xFFC89A44),
                            child: const Center(
                                child: Text(
                              "Add to cart",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (isLoading)
              Dialog(
                backgroundColor: Colors.transparent,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
