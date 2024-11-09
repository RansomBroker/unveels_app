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
import 'package:test_new/unvells/models/downloadable_products/downloadable_products_list_model.dart';
import 'package:test_new/unvells/screens/downloadable_products/views/download_product_item.dart';
import 'package:test_new/unvells/screens/orders_list/views/order_main_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_localizations.dart';
import '../../models/download_product/download_product.dart';
import '../../models/order_list/order_list_model.dart';
import '../product_detail/widgets/file_download.dart';
import 'bloc/downloadable_products_screen_bloc.dart';
import 'bloc/downloadable_products_screen_events.dart';
import 'bloc/downloadable_products_screen_state.dart';

class DownloadableProductsScreen extends StatefulWidget {
  DownloadableProductsScreen(this.isFromDashboard, {Key? key})
      : super(key: key);
  bool isFromDashboard = false;

  @override
  _DownloadableProductsScreenState createState() =>
      _DownloadableProductsScreenState();
}

class _DownloadableProductsScreenState
    extends State<DownloadableProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  DownloadableProductsScreenBloc? _downloadableProductsScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  DownloadableProductsListModel? downloadableProductsListModel;
  List<DownloadableProductsListData> downloadableProductsData = [];
  int page = 1;

  @override
  void initState() {
    _downloadableProductsScreenBloc =
        context.read<DownloadableProductsScreenBloc>();

    _downloadableProductsScreenBloc
        ?.add(DownloadableProductsScreenDataFetchEvent(page.toString()));
    _scrollController.addListener(() {
      if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.myDownloadableProducts)
            .localized(),
        context,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, AppRoutes.search);
        //       },
        //       icon: BadgeIcon(
        //         icon: Icon(Icons.search),
        //       )),
        //
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, AppRoutes.cart);
        //       },
        //       icon: BadgeIcon(
        //         icon: Icon(Icons.shopping_cart),
        //         badgeColor: Colors.red,
        //       )),
        // ]
      ),
      body: BlocBuilder<DownloadableProductsScreenBloc,
          DownloadableProductsScreenState>(builder: (context, currentState) {
        if (currentState is DownloadableProductsScreenInitial) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is DownloadableProductsScreenSuccess) {
          isLoading = false;
          isFromPagination = false;
          downloadableProductsListModel =
              currentState.downloadableProductsListModel;
          if (page == 1) {
            downloadableProductsData =
                downloadableProductsListModel?.downloadableProductsList ?? [];
          } else {
            downloadableProductsData.addAll(
                downloadableProductsListModel?.downloadableProductsList ?? []);
          }
        } else if (currentState is DownloadProductSuccess) {
          isLoading = false;
          if (currentState?.downloadProduct.success ?? false) {
            if ((currentState?.downloadProduct.url ?? '').isNotEmpty) {
              DownloadFile().downloadPersonalData(
                currentState?.downloadProduct.url ?? "",
                currentState?.downloadProduct.fileName ?? "",
                "",
                context,
              );
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    Utils.getStringValue(context, AppStringConstant.linkError),
                    context);
              });
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AppDialogHelper.informationDialog(
                currentState?.downloadProduct.message ??
                    Utils.getStringValue(context, AppStringConstant.linkError),
                context,
                AppLocalizations.of(context),
                title: AppStringConstant.error,
              );
            });
          }
        } else if (currentState is DownloadableProductsScreenError) {
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
        Visibility(
          visible:
              (downloadableProductsListModel?.downloadableProductsList != null),
          child: downloadableProductsListModel
                          ?.downloadableProductsList?.length ==
                      0 ||
                  (downloadableProductsListModel?.downloadableProductsList ??
                          [])
                      .isEmpty
              ? LottieAnimation(
                  lottiePath: AppImages.emptyOrderLottie,
                  title: (Utils.getStringValue(context,
                      AppStringConstant.noDownloadableProducts.localized())),
                  subtitle: "",
                  buttonTitle: (Utils.getStringValue(
                      context, AppStringConstant.continueShopping.localized())),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.bottomTabBar, (route) => false);
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: downloadableProductsData.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return downloadProductItem(
                                context,
                                downloadableProductsData[index],
                                (itemHash) {
                                  _downloadableProductsScreenBloc?.add(
                                      DownloadProductEvent(
                                          itemHash.toString()));
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
        ),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }

  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (downloadableProductsListModel?.totalCount ?? 0) !=
            downloadableProductsData.length) {
      setState(() {
        var totalPages = (downloadableProductsListModel?.totalCount ?? 20) / 20;
        if (page < totalPages) {
          page++;
          _downloadableProductsScreenBloc
              ?.add(DownloadableProductsScreenDataFetchEvent(page.toString()));
          isFromPagination = true;
        }
      });
    }
  }
}
