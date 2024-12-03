import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
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

import '../buttons/button_widget.dart';

class SmallProductItemWidget extends StatefulWidget {
  final Function()? onAddToCart;
  final ProductData? product;

  const SmallProductItemWidget({
    super.key,
    this.onAddToCart,
    this.product,
  });

  @override
  State<SmallProductItemWidget> createState() => _SmallProductItemWidgetState();
}

class _SmallProductItemWidgetState extends State<SmallProductItemWidget> {
  ItemCardBloc? itemCardBloc;
  bool isLoading = false;
  bool _isAddingToCart = false;
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
      return InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          AppRoutes.productPage,
          arguments: getProductDataAttributeMap(
              widget.product?.name, widget.product?.id.toString()),
        ),
        child: SizedBox(
          height: 130,
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: 100,
                height: 68,
                child: Image.network(widget.product?.imageUrl ?? "",
                    width: 100, height: 68, fit: BoxFit.contain),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                widget.product?.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.product?.brand ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lora(
                  fontSize: 8,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "KWD ${widget.product?.price ?? ""}",
                    style: GoogleFonts.lora(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: ButtonWidget(
                      onTap: () async {
                        Map<String, dynamic> mProductParamsJSON = {};
                        itemCardBloc?.add(AddtoCartEvent(
                            widget.product!.id.toString(),
                            1,
                            mProductParamsJSON));
                        setState(() {
                          _isAddingToCart = true;
                        });
                      },
                      text: "Add to cart",
                      backgroundGradient: const LinearGradient(
                        colors: [
                          Color(0xFFCA9C43),
                          Color(0xFF92702D),
                        ],
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      // onTap: widget.onAddToCart,
                    ),
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
