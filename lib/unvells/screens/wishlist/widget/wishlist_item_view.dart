/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_state.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/flux_image.dart';
import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/loader.dart';
import '../../../configuration/text_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../models/wishlist/wishlist_model.dart';
import '../../home/widgets/item_card_bloc/item_card_event.dart';

Widget WishlistItemViewProducts(
    List<WishlistData> items, bloc, BuildContext context, bool? isLoading) {
  return (isLoading ?? false)
      ? const Loader()
      : Visibility(
          visible: items.isNotEmpty,
          child: Stack(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    mainAxisExtent: (AppSizes.deviceWidth / 3),
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    IconData? iconRight;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.productPage,
                          arguments: getProductDataAttributeMap(
                            items[index].name ?? "",
                            items[index].entityId.toString() ?? "",
                          ),
                        );
                      },
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppSizes.deviceWidth / 3.5,
                                width: AppSizes.deviceWidth / 3.5,
                                child: ImageView(
                                  url: items[index].thumbNail,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: AppSizes.spacingGeneric,
                                        ),
                                        SizedBox(
                                          width: AppSizes.deviceWidth * .4,
                                          child: Text(items[index].name ?? '',
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: KTextStyle.of(context)
                                                  .semiBoldSixteen
                                              // const TextStyle(fontSize: 12.0, color: Colors.black),
                                              ),
                                        ),
                                        // const SizedBox(
                                        //   height: AppSizes.size8,
                                        // ),
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: double.parse(
                                                  items[index].rating ?? ''),
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.black,
                                              ),
                                              itemCount: 5,
                                              unratedColor:
                                                  Colors.grey.shade400,
                                              itemSize: 15.0,
                                              direction: Axis.horizontal,
                                            ),
                                            Text(
                                              " (${items[index].reviewCount.toString() ?? ''})",
                                            )
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: AppSizes.size8,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              (items[index].formattedFinalPrice ??
                                                          '')
                                                      .isNotEmpty
                                                  ? items[index]
                                                          .formattedFinalPrice ??
                                                      ''
                                                  : '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: KTextStyle.of(context)
                                                  .sixteen,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                bloc.emit(WishlistActionState());
                                bloc.add(MoveToCartEvent(
                                    int.parse(items[index].productId!) ?? 0,
                                    items[index].qty ?? 0,
                                    int.parse(items[index].id!) ?? 0));
                                context.read<ItemCardBloc>().add(
                                    RemoveFromWishlistEvent(
                                        items[index].id.toString(),
                                        fromWishlist: true));
                              },
                              child: const FluxImage(
                                imageUrl: 'assets/icons/add_circle.svg',

                                // width: 40,
                                // height: 40,
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                            top: AppSizes.size16,
                            end: AppSizes.size10,
                            child: GestureDetector(
                              onTap: () {
                                AppDialogHelper.confirmationDialog(
                                    AppStringConstant.removeItemFromWishlist,
                                    context,
                                    AppLocalizations.of(context),
                                    onConfirm: () async {
                                  bloc.emit(WishlistActionState());
                                  bloc.add(
                                      RemoveItemEvent(items[index].id ?? "0"));
                                  context.read<ItemCardBloc>().add(
                                      RemoveFromWishlistEvent(
                                          items[index].id.toString(),
                                          fromWishlist: true));
                                  // Utils.hideSoftKeyBoard();
                                  // bloc?.add(RemoveItemEvent());
                                }, title: AppStringConstant.removeItem);
                              },
                              child: const Icon(
                                Icons.close,
                                // size: AppSizes.size18,
                                // color: Theme.of(context).colorScheme.primary,
                              ),
                            )),
                      ]),
                    );
                  }),
              const Center(
                  child: Visibility(
                visible: false,
                child: Loader(),
              )),
            ],
          ),
        );
}
