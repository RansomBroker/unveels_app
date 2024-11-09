/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/reviews/views/reviews_main_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_localizations.dart';
import '../../models/reviews/reviews_list_model.dart';
import 'block/reviews_screen_bloc.dart';
import 'block/reviews_screen_events.dart';
import 'block/reviews_screen_state.dart';

class ReviewsScreen extends StatefulWidget {
  ReviewsScreen(this.isFromDashboard, {Key? key}) : super(key: key);
  bool isFromDashboard = false;

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ScrollController _scrollController = ScrollController();
  ReviewsScreenBloc? _ReviewsScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  ReviewsListModel? reviewsListModel;
  List<ReviewsListData> recentReviews = [];
  int page = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _ReviewsScreenBloc = context.read<ReviewsScreenBloc>();

    _ReviewsScreenBloc?.add(ReviewsScreenDataFetchEvent(page, false));
    _scrollController.addListener(() {
      if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isFromDashboard)
          ? null
          : appToolBar(Utils.getStringValue(context, AppStringConstant.allReviews), context),
      body: BlocBuilder<ReviewsScreenBloc, ReviewsScreenState>(
          builder: (context, currentState) {
        if (currentState is ReviewsScreenInitial) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is ReviewsScreenSuccess) {
          isLoading = false;
          isFromPagination = false;
          reviewsListModel = currentState.reviews;
          if (page == 1) {
            recentReviews = reviewsListModel?.reviewList ?? [];
          } else {
            recentReviews.addAll(reviewsListModel?.reviewList ?? []);
          }
        } else if (currentState is ReviewsScreenError) {
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
        if (recentReviews.isNotEmpty)
          reviewMainView(context, recentReviews, AppLocalizations.of(context), _scrollController,
              scrollPhysics: widget.isFromDashboard
                  ? const AlwaysScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics()
          ),
        Visibility(
          visible: (recentReviews.isEmpty && (!isLoading)),
          child: Center(
            child: LottieAnimation(
                lottiePath: AppImages.emptyOrderLottie,
                title: Utils.getStringValue(context, AppStringConstant.noReviews),
                subtitle: "",
                buttonTitle: Utils.getStringValue(context, AppStringConstant.continueShopping),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.bottomTabBar, (route) => false);
                }),
          ),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (reviewsListModel?.totalCount ?? 0) != recentReviews.length) {
      setState(() {
        var totalPages = (reviewsListModel?.totalCount ?? 10) / 10;
        if (page < totalPages) {
          page++;
          if (!(widget.isFromDashboard)) {
            _ReviewsScreenBloc
                ?.add(ReviewsScreenDataFetchEvent(page, false ));
          }
          isFromPagination = true;
        }
      });
    }
  }
}
