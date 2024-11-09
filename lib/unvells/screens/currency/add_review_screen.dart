/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/rating_bar.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import 'bloc/add_review_screen_bloc.dart';
import 'bloc/add_review_screen_event.dart';
import 'bloc/add_review_screen_state.dart';

class AddReviewScreen extends StatefulWidget {
  final String productName;
  final String thumbNail;
  final String productId;

  const AddReviewScreen(this.productName, this.thumbNail, this.productId,
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
  TextEditingController reviewTitle = TextEditingController();
  TextEditingController reviewDetail = TextEditingController();
  double rating = 0.0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _addReviewScreenBloc = context.read<AddReviewScreenBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReviewScreenBloc, AddReviewScreenState>(
        builder: (context, currentState) {
      if (currentState is AddReviewLoadingState) {
        isLoading = true;
      } else if (currentState is AddReviewSuccessState) {
        isLoading = false;
        if (currentState.data.success ?? false) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pop(context, true);
            AlertMessage.showSuccess(currentState.data.message ?? '', context);
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
          appBar: appToolBar(
              _localizations?.translate(AppStringConstant.addReview) ?? "",
              context,
              isElevated: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingGeneric),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                              AppSizes.linePadding,
                              0.0,
                              AppSizes.size20,
                              0.0),
                          child: SizedBox(
                              height: AppSizes.deviceHeight / 5,
                              width: AppSizes.deviceWidth / 4,
                              child: ImageView(url: widget.thumbNail))),
                      Expanded(
                          child: Text(widget.productName,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headlineLarge))
                    ],
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: AppSizes.spacingGeneric,
                  ),
                  Text(
                      _localizations?.translate(AppStringConstant.rating) ?? "",
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(
                    height: AppSizes.spacingGeneric,
                  ),
                  RatingBar(
                    starCount: 5,
                    color: AppColors.yellow,
                    rating: rating,
                    onRatingChanged: (_rating) {
                      rating = _rating;
                    },
                  ),
                  const SizedBox(
                    height: AppSizes.spacingGeneric,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      AppTextField(
                        controller: reviewTitle,
                        isPassword: false,
                        hintText: _localizations?.translate(
                                AppStringConstant.writeReviewTitle) ??
                            "",
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: AppSizes.linePadding,
                      ),
                      AppTextField(
                          controller: reviewDetail,
                          isPassword: false,
                          hintText: _localizations?.translate(
                                  AppStringConstant.writeReview) ??
                              "",
                          isRequired: true),
                    ]),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingGeneric,
                  ),
                  appOutlinedButton(context, () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate() && rating != 0.0) {
                      _addReviewScreenBloc?.add(
                        AddReviewSaveEvent(rating.toInt(), reviewTitle.text,
                            reviewDetail.text, widget.productId),
                      );
                    } else if (rating == 0.0) {
                      AlertMessage.showError(
                          _localizations
                                  ?.translate(AppStringConstant.selectRating) ??
                              "",
                          context);
                    }
                  },
                      (_localizations?.translate(AppStringConstant.submit) ??
                              "")
                          .toUpperCase(),
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      textColor:
                          Theme.of(context).colorScheme.secondaryContainer),
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
