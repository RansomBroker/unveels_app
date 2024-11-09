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
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/add_review/views/item_rating.dart';
import 'package:test_new/unvells/screens/delivery_boy_write_review/views/deliveryboy_item_rating.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/rating_bar.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../../models/productDetail/product_detail_page_model.dart';
import 'bloc/deliveryboy_write_review_screen_bloc.dart';
import 'bloc/deliveryboy_write_review_screen_event.dart';
import 'bloc/deliveryboy_write_review_screen_state.dart';

class DeliveryboyWriteReviewScreen extends StatefulWidget {
  final String deliveryBoyId;
  final String customerId;
  final String orderId;
  AssignedDeliveryBoyDetails? assignedDeliveryBoyDetails;

  DeliveryboyWriteReviewScreen(this.deliveryBoyId, this.customerId, this.assignedDeliveryBoyDetails, this.orderId,
      {Key? key})
      : super(key: key);

  @override
  _DeliveryboyWriteReviewScreenState createState() => _DeliveryboyWriteReviewScreenState();
}

class _DeliveryboyWriteReviewScreenState extends State<DeliveryboyWriteReviewScreen> {
  DeliveryboyReviewReviewScreenBloc? _deliveryboyWriteReviewScreenBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nickName = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController review = TextEditingController();
  double? selectedRating = 0.0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _deliveryboyWriteReviewScreenBloc = context.read<DeliveryboyReviewReviewScreenBloc>();
    if(appStoragePref.getUserData()!.name!.isNotEmpty) {
      nickName.text = appStoragePref.getUserData()!.name!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryboyReviewReviewScreenBloc, DeliveryboyWriteReviewScreenState>(
        builder: (context, currentState) {
      if (currentState is DeliveryboyWriteLoadingState) {
        isLoading = true;
      } else if (currentState is GetAddReviewSuccessState) {
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
        _deliveryboyWriteReviewScreenBloc?.emit(DeliveryboyWriteEmptyState());
      } else if (currentState is DeliveryboyWriteErrorState) {
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
              _localizations?.translate(AppStringConstant.writeYourReview) ?? "",
              context,
              isElevated: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingNormal),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(Utils.getStringValue(context,AppStringConstant.howDoYouRateDeliveryboy).toUpperCase(),
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
                  ratingView(),
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
                                ?.translate(AppStringConstant.summaryOfYourReview) ??
                            "",
                        isRequired: true,
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
                        isRequired: true,
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
                    child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                           if (_formKey.currentState!.validate() && selectedRating != 0.0) {
                             _deliveryboyWriteReviewScreenBloc?.add(
                                    AddReviewSaveEvent(
                                        selectedRating?.toInt() ?? 0,
                                        widget.assignedDeliveryBoyDetails?.customerId?.toInt() ?? 0,
                                        summary.text??"",
                                        review.text??"",
                                        int.parse(widget.deliveryBoyId),
                                        widget.orderId,
                                        nickName.text
                                    ),
                                  );
                                } else if (selectedRating == 0.0) {
                                  AlertMessage.showError(_localizations?.translate(AppStringConstant.selectRating) ?? "", context);
                                }
                        },
                        child: Center(
                          // child: Text((_localizations?.translate(AppStringConstant.submitReview) ?? "").toUpperCase(),
                          child: Text(Utils.getStringValue(context, AppStringConstant.submitReview ?? "").toUpperCase(),
                            style:const TextStyle(color: Colors.white),
                          ),
                        ),),
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

  Widget ratingView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.size12),
      child: InkWell(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: AppSizes.spacingGeneric),
                child: Text(Utils.getStringValue(context, AppStringConstant.rating),
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: AppSizes.spacingGeneric),
                child: Text(":", style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: 0),
                child: RatingBar(
                  starCount: 5,
                  color: AppColors.yellow,
                  rating: selectedRating,
                  onRatingChanged: (_rating) {
                    selectedRating = _rating;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
