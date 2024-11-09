/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/orders_list/views/order_main_view.dart';
import 'package:test_new/unvells/screens/orders_list/views/product_list_review_screen.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_localizations.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../models/order_details/order_detail_model.dart';
import '../../models/order_list/order_list_model.dart';
import 'bloc/order_screen_bloc.dart';
import 'bloc/order_screen_events.dart';
import 'bloc/order_screen_state.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen(this.isFromDashboard, {Key? key}) : super(key: key);
  bool isFromDashboard = false;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();
  OrderScreenBloc? _orderScreenBloc;
  bool isLoading = false;
  bool isVisible = false;

  bool isFromPagination = false;
  // bool isOrderComplete = false;
  OrderListModel? orderListModel;
  OrderData? review;
  List<OrderListData> recentOrders = [];
  int page = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _orderScreenBloc = context.read<OrderScreenBloc>();
    _scrollController?.addListener(() {
      if (_scrollController?.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible == true) {
          setState(() {
            isVisible = false;
          });
        }
      } else {
        if (_scrollController?.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isVisible == false) {
            setState(() {
              isVisible = true;
            });
          }
        }
      }
    });
    _orderScreenBloc
        ?.add(OrderScreenDataFetchEvent(page, widget.isFromDashboard));
    _scrollController.addListener(() {
      if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
        appBar: (widget.isFromDashboard)
            ? null
            : commonAppBar(
                Utils.getStringValue(context, AppStringConstant.allOrders),
                context,
          bgColor: Colors.white

        ),
        body: BlocBuilder<OrderScreenBloc, OrderScreenState>(
            builder: (context, currentState) {
          if (currentState is OrderScreenInitial) {
            if (!isFromPagination) {
              isLoading = true;
              // isOrderComplete = false;
            }
          } else if (currentState is OrderScreenSuccess) {
            isLoading = false;
            isFromPagination = false;
            orderListModel = currentState.orders;
            if (page == 1) {
              recentOrders = orderListModel?.orderList ?? [];
            } else {
              recentOrders.addAll(orderListModel?.orderList ?? []);
            }
            // if(orderListModel?.orderList?.sta)
          } else if (currentState is OrderScreenError) {
            debugPrint("Order"+currentState.message.toString());
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message, context);
            });
          } else if (currentState is ReorderSuccess) {
            isLoading = false;
            if (currentState.response.success ?? false) {
              appStoragePref.setCartCount(currentState.response.cartCount);
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                DialogHelper.confirmationDialog(
                    Utils.getStringValue(
                        context, AppStringConstant.reorderDescription),
                    context,
                    AppLocalizations.of(context),
                    title: Utils.getStringValue(context, AppStringConstant.reorder),
                    onConfirm: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.cart,
                      );
                    },
                    okButton: Utils.getStringValue(
                        context, AppStringConstant.gotoCart)
                );
              });
            }
          } else if (currentState is ReviewProduct) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if ((currentState.model?.orderData?.itemList?.length ?? 0) > 1) {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => ProductListReviewScreen(
                    currentState.model?.orderData,
                  ),
                );
              } else {
                reviewBottomModalSheet(
                    context,
                    currentState.model?.orderData?.itemList?[0].name ?? '',
                    currentState.model?.orderData?.itemList?[0].image ?? '',
                    currentState.model?.orderData?.itemList?[0].productId ?? '',
                    []);
              }
            });
          } else if (currentState is OrderScreenEmptyState) {}
          _orderScreenBloc?.emit(OrderScreenEmptyState());
          return _buildUI();
        }),
        floatingActionButton: Visibility(
          visible: isVisible,
          child: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.ease);
            },
            backgroundColor: Theme.of(context).iconTheme.color,
            elevation: 5,
            child: Icon(
              Icons.arrow_upward,
              color: Theme.of(context).cardColor,
            ),
          ),
        ));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        if (recentOrders.isNotEmpty)
          Visibility(
            visible: (recentOrders.isNotEmpty),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: orderMainView(
                  context, recentOrders, AppLocalizations.of(context),
                  (incrementId) {
                _orderScreenBloc?.add(ReorderEvent(incrementId));
              }, (incrementId) {
                _orderScreenBloc?.add(ReviewProductEvent(incrementId));
              }, _scrollController,
                  scrollPhysics: widget.isFromDashboard
                      ? const AlwaysScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics()),
            ),
          ),
        Visibility(
          visible: (recentOrders.isEmpty && (!isLoading)),
          child: Center(
            child: LottieAnimation(
                lottiePath: AppImages.emptyOrderLottie,
                title:
                    Utils.getStringValue(context, AppStringConstant.noOrders),
                subtitle: Utils.getStringValue(
                    context, AppStringConstant.noOrdersMessage),
                buttonTitle: Utils.getStringValue(
                    context, AppStringConstant.continueShopping),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.bottomTabBar, (route) => false);
                }),
          ),
        ),
        Visibility(visible: isLoading && !widget.isFromDashboard, child: const Loader())
      ],
    );
  }

  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (orderListModel?.totalCount ?? 0) != recentOrders.length) {
      setState(() {
        var totalPages = (orderListModel?.totalCount ?? 10) / 10;
        if (page < totalPages) {
          page++;
          if (!(widget.isFromDashboard)) {
            _orderScreenBloc
                ?.add(OrderScreenDataFetchEvent(page, widget.isFromDashboard));
          }
          isFromPagination = true;
        }
      });
    }
  }
}
