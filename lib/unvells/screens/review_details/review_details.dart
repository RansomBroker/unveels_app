/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/screens/review_details/views/item_rating_view.dart';

import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/rating_bar.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/utils.dart';
import '../../models/reviews/review_details_model.dart';
import 'block/review_details_screen_bloc.dart';
import 'block/review_details_screen_events.dart';
import 'block/review_details_screen_state.dart';

class ReviewDetailsScreen extends StatefulWidget {
  String reviewId;
  ReviewDetailsScreen(this.reviewId, {Key? key}) : super(key: key);


  @override
  _ReviewDetailsScreenState createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  ReviewDetailsScreenBloc? _reviewsScreenDetailsBloc;
  bool isLoading = false;
  ReviewDetailsModel? reviewDetailsModel;
  List<RatingData> ratingData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _reviewsScreenDetailsBloc = context.read<ReviewDetailsScreenBloc>();

    _reviewsScreenDetailsBloc?.add(ReviewDetailsScreenDataFetchEvent(widget.reviewId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appToolBar(Utils.getStringValue(context, AppStringConstant.reviewDetail), context),
      body: BlocBuilder<ReviewDetailsScreenBloc, ReviewDetailsScreenState>(
          builder: (context, currentState) {
            if (currentState is ReviewDetailsScreenInitial) {
              isLoading = true;
            } else if (currentState is ReviewDetailsScreenSuccess) {
              isLoading = false;
              reviewDetailsModel = currentState.reviews;
              ratingData = reviewDetailsModel?.ratingData ?? [];
            } else if (currentState is ReviewDetailsScreenError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(currentState.message, context);
              });
            }
            return _buildUI();
          }),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        reviewDetailsModel !=null?
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: AppSizes.spacingLarge),
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: ImageView(
                            url: reviewDetailsModel?.thumbNail,
                            height: AppSizes.deviceHeight / 8,
                            width: AppSizes.deviceWidth / 4,
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingGeneric),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              reviewDetailsModel?.productName.toString() ?? " ",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),

                            const SizedBox(height: AppSizes.size8),
                            Row(
                              children: [
                                Text(
                                  Utils.getStringValue(context, AppStringConstant.avg),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: AppSizes.textSizeMedium)  ,
                                ),

                                const SizedBox(width: AppSizes.spacingTiny),
                                RatingBar(
                                  starCount: 5,
                                  color: AppColors.yellow,
                                  rating: reviewDetailsModel?.averageRating ?? 0.0,
                                ),
                                const SizedBox(width: AppSizes.spacingTiny),
                                Text(
                                  "${reviewDetailsModel?.averageRating.toString() ?? ''} ${Utils.getStringValue(context, AppStringConstant.stars)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: AppSizes.textSizeMedium)  ,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.size8),
                            Text(
                              "${reviewDetailsModel?.totalProductReviews.toString() ?? ''} ${AppStringConstant.reviews}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: AppSizes.textSizeMedium)  ,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.0,),
                  Container(
                    padding: const EdgeInsets.all(AppSizes.spacingGeneric),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: AppSizes.spacingTiny),
                        Text(
                          Utils.getStringValue(context, AppStringConstant.yourReviews.toString()).toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSizes.spacingTiny),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.0,),
                  Container(
                    padding: const EdgeInsets.all(AppSizes.spacingGeneric),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: AppSizes.spacingTiny),
                        Text(
                          reviewDetailsModel?.reviewTitle.toString() ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),

                        const SizedBox(height: AppSizes.spacingGeneric),
                        Text(
                          reviewDetailsModel?.reviewDetail.toString() ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // if (ratingData.isNotEmpty)
                        //   itemRatingView(context, ratingData, AppLocalizations.of(context), _scrollController
                        //   ),
                        const SizedBox(height: AppSizes.spacingGeneric),
                        Row(
                          children: [
                            Text(
                              Utils.getStringValue(context, AppStringConstant.avg),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: AppSizes.textSizeMedium)  ,
                            ),

                            const SizedBox(width: AppSizes.spacingTiny),
                            RatingBar(
                              starCount: 5,
                              color: AppColors.yellow,
                              rating: reviewDetailsModel?.averageRating ?? 0.0,
                            ),
                            const SizedBox(width: AppSizes.spacingTiny),
                            Text(
                              "${reviewDetailsModel?.averageRating.toString() ?? ''} ${Utils.getStringValue(context, AppStringConstant.stars)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: AppSizes.textSizeMedium)  ,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacingGeneric),
                        Text(
                          Utils.getStringValue(context, AppStringConstant.submittedOn),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: AppSizes.spacingGeneric),
                        Text(
                          reviewDetailsModel?.reviewDate.toString() ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):Container(),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }
}
