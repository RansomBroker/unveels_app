/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/screens/add_review/views/item_rating.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/rating_bar.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../models/productDetail/product_detail_page_model.dart';
import 'bloc/add_review_screen_bloc.dart';
import 'bloc/add_review_screen_event.dart';
import 'bloc/add_review_screen_state.dart';

class AddReviewScreen extends StatefulWidget {
  final String productName;
  final String thumbNail;
  final String productId;
  List<RatingFormData>? ratingFormData;

  AddReviewScreen(
      this.productName, this.thumbNail, this.productId, this.ratingFormData,
      {Key? key})
      : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  AddReviewScreenBloc? _addReviewScreenBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nickName = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController review = TextEditingController();
  double rating = 0.0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _addReviewScreenBloc = context.read<AddReviewScreenBloc>();
    _addReviewScreenBloc?.add(GetRatingFormDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReviewScreenBloc, AddReviewScreenState>(
        builder: (context, currentState) {
      if (currentState is AddReviewLoadingState) {
        isLoading = true;
      } else if (currentState is GetRatingFormDataSuccessState) {
        isLoading = false;
        if (currentState.data.success ?? false) {
          if ((currentState.data.ratingFormData ?? []).isNotEmpty) {
            widget.ratingFormData = currentState.data.ratingFormData;
          }
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.data.message ?? '', context);
          });
        }
      } else if (currentState is AddReviewSuccessState) {
        isLoading = false;
        if (currentState.data.success ?? false) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(currentState.data.message ?? '', context);
            Navigator.pop(context);
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.data.message ?? '', context);
          });
        }
      } else if (currentState is AddReviewErrorState) {
        isLoading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(currentState.message, context);
        });
      }
      return _buildUI();
    });
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: appToolBar(
              _localizations?.translate(AppStringConstant.addReview) ?? "",
              context,
              isElevated: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppSizes.linePadding, 0.0, AppSizes.size20, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                                height: AppSizes.deviceHeight / 7,
                                width: AppSizes.deviceWidth / 4,
                                child: ImageView(url: widget.thumbNail)),
                          )),
                      Expanded(
                          child: Text(widget.productName,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyLarge))
                    ],
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: AppSizes.spacingGeneric,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) =>
                        ItemRating(widget.ratingFormData![index], _localizations),
                    itemCount: ( widget.ratingFormData!.length ?? 0),
                  ),

                  const SizedBox(
                    height: AppSizes.spacingNormal,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      AppTextField(
                        controller: nickName,
                        isPassword: false,
                        hintText: _localizations
                                ?.translate(AppStringConstant.nickName) ??
                            "",
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: AppSizes.spacingGeneric,
                      ),
                      AppTextField(
                        controller: summary,
                        isPassword: false,
                        hintText: _localizations
                                ?.translate(AppStringConstant.summary) ??
                            "",
                        isRequired: false,
                      ),
                      const SizedBox(
                        height: AppSizes.spacingGeneric,
                      ),
                      AppTextField(
                        controller: review,
                        isPassword: false,
                        hintText: _localizations
                                ?.translate(AppStringConstant.review) ??
                            "",
                        isRequired: false,
                        minLine: 4,
                        maxLine: 20,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingNormal,
                  ),
                  SizedBox(
                    height: AppSizes.genericButtonHeight,
                    child: CustomButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if((_formKey.currentState?.validate() ?? false)){
                            List<Map<String, String>> ratingItemData = [];

                            if ((widget?.ratingFormData ?? []).isNotEmpty) {

                              for (var element in widget.ratingFormData!) {
                                Map<String, String> ratingData = {};
                                if (_formKey.currentState!.validate() &&
                                    element.selectedRating != 0.0) {
                                  ratingData["ratingId"] = element.id ?? "";

                                  if ((element?.values ?? []).isNotEmpty) {
                                    if (element.selectedRating!.ceil() == 1) {
                                      ratingData["optionId"] = element.values?[0] ?? "";
                                    } else if (element.selectedRating!.ceil() == 2) {
                                      ratingData["optionId"] = element.values?[1] ?? "";
                                    } else if (element.selectedRating!.ceil() == 3) {
                                      ratingData["optionId"] = element.values?[2] ?? "";
                                    } else if (element.selectedRating!.ceil() == 4) {
                                      ratingData["optionId"] = element.values?[3] ?? "";
                                    } else if (element.selectedRating!.ceil() == 5) {
                                      ratingData["optionId"] = element.values?[4] ?? "";
                                    }
                                  }
                                  ratingItemData.add(ratingData);

                                } else if (element.selectedRating == 0.0) {
                                  AlertMessage.showError(
                                      _localizations?.translate(
                                          AppStringConstant.selectRating) ??
                                          "",
                                      context);
                                }
                              }
                            }

                            _addReviewScreenBloc?.add(
                              AddReviewSaveEvent(
                                  rating.toInt(),
                                  nickName.text,
                                  summary.text,
                                  review.text,
                                  widget.productId,
                                  ratingItemData),
                            );
                          }

                        },
                      title:   (_localizations?.translate(AppStringConstant
                          .submitReviewForApproval) ??
                          ""),
                        // child: Center(
                        //   child: Text(
                        //     (_localizations?.translate(AppStringConstant
                        //                 .submitReviewForApproval) ??
                        //             "")
                        //        ,
                        //     style:const TextStyle(color: Colors.white),
                        //   ),
                        // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }
}
