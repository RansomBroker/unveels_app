/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/search/search_screen_model.dart';

import '../../../../constants/arguments_map.dart';

Widget suggestionList(
    SearchScreenModel? searchSuggestionModel,
    BuildContext context,
    AppLocalizations? _localizations,
    TextEditingController controller) {
  return searchSuggestionModel?.suggestProductArray?.products != null
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size16),
          child: Column(
            children: [
              appStoragePref.getShowSearchTag()
                  ? Column(
                      children: [
                        Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.all(AppSizes.size16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _localizations
                                        ?.translate(
                                            AppStringConstant.searchTags)
                                        .toUpperCase() ??
                                    '',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.value = TextEditingValue(
                                            text: Utils.parseHtmlString(
                                                searchSuggestionModel
                                                        ?.suggestProductArray
                                                        ?.tags?[index]
                                                        .label ??
                                                    ""));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search_sharp,
                                            size: 24,
                                            color: Colors.grey[400],
                                          ),
                                          Flexible(
                                              child: Html(
                                                  data: searchSuggestionModel
                                                          ?.suggestProductArray
                                                          ?.tags?[index]
                                                          .label ??
                                                      '')),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 14,
                                            color: Colors.grey[400],
                                          )
                                          // Text((searchSuggestionModel
                                          //         ?.suggestProductArray?.tags?[index].count.toString() ??
                                          //     ''))
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                            height: AppSizes.size8,
                                          ),
                                  itemCount: searchSuggestionModel
                                          ?.suggestProductArray?.tags?.length ??
                                      0),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.size8,
                        ),
                      ],
                    )
                  : Container(),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(AppSizes.size16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _localizations
                              ?.translate(AppStringConstant.popularProduct)
                              .toUpperCase() ??
                          '',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: AppSizes.spacingGeneric,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productPage,
                                arguments: getProductDataAttributeMap(
                                  searchSuggestionModel?.suggestProductArray
                                          ?.products?[index].productName ??
                                      "",
                                  searchSuggestionModel?.suggestProductArray
                                          ?.products?[index].productId ??
                                      "",
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      AppSizes.featuredCategoryImageSizeSmall,
                                  width:
                                      AppSizes.featuredCategoryImageSizeSmall,
                                  child: ImageView(
                                    url: searchSuggestionModel
                                        ?.suggestProductArray
                                        ?.products?[index]
                                        .thumbNail,
                                    height:
                                        AppSizes.featuredCategoryImageSizeSmall,
                                    width:
                                        AppSizes.featuredCategoryImageSizeSmall,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.all(AppSizes.size4),
                                    padding:
                                        const EdgeInsets.all(AppSizes.size4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Html(
                                          data: searchSuggestionModel
                                                  ?.suggestProductArray
                                                  ?.products?[index]
                                                  .productName ??
                                              "",
                                          style: {
                                            "body": Style(
                                              fontSize:  FontSize(
                                                  AppSizes.textSizeSmall),
                                            ),
                                          },
                                        ),
                                        const SizedBox(
                                          height: AppSizes.spacingTiny,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: AppSizes.spacingGeneric),
                                          child: Text(
                                            searchSuggestionModel
                                                    ?.suggestProductArray
                                                    ?.products?[index]
                                                    .price ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 14,
                                  color: Colors.grey[400],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: AppSizes.spacingTiny,
                              thickness: 1,
                            ),
                        itemCount: searchSuggestionModel
                                ?.suggestProductArray?.products?.length ??
                            0),
                  ],
                ),
              ),
            ],
          ),
        )
      : controller.text != ""
          ? Container(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Icon(Icons.search_rounded, size: 50),
                  Padding(
                    padding: EdgeInsets.all(AppSizes.size8),
                    child: Center(
                      child: Text(
                        '${Utils.getStringValue(context, AppStringConstant.accordingToYourRequest)} "${controller.text}" ${Utils.getStringValue(context, AppStringConstant.nothingFound)} ',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            wordSpacing: 1.5,
                            letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(AppSizes.size8),
              child: Center(
                child: Text(''),
              ),
            );
}
