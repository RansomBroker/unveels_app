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

import '../../../../shared/widgets/buttons/button_widget.dart';

class SAProductItemWidget extends StatefulWidget {
  final ProductData product;
  const SAProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  State<SAProductItemWidget> createState() => _SAProductItemWidgetState();
}

class _SAProductItemWidgetState extends State<SAProductItemWidget> {
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
              widget.product.name, widget.product.id.toString()),
        ),
        child: SizedBox(
          width: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: 120,
                height: 120 * 0.65,
                child: Image.network(
                  widget.product.imageUrl,
                  width: 120,
                  height: 120 * 0.65,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 3,
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
                          widget.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lora(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.product.brand,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lora(
                            fontSize: 8,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "KWD ${widget.product.price}",
                    style: GoogleFonts.lora(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                      text: "ADD TO CART",
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.white,
                      height: 20,
                      style: GoogleFonts.lora(
                        fontSize: 6,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.seeImprovement);
                      },
                      text: "SEE\nIMPROVEMENT",
                      backgroundColor: Colors.white,
                      height: 20,
                      style: GoogleFonts.lora(
                        fontSize: 6,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
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
