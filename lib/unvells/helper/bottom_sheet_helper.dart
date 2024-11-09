/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/helper/skeleton_widget.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_state.dart';
import 'package:test_new/unvells/screens/delivery_boy_write_review/deliveryboy_write_review_screen.dart';
import 'package:test_new/unvells/screens/language/bloc/language_screen_bloc.dart';
import 'package:test_new/unvells/screens/language/bloc/language_screen_repository.dart';
import 'package:test_new/unvells/screens/language/language_screen.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/unvells/screens/view_invoice/bloc/view_invoice_screen_bloc.dart';
import 'package:test_new/unvells/screens/view_invoice/bloc/view_invoice_screen_repository.dart';
import 'package:test_new/unvells/screens/view_invoice/view_invoice_screen.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_bloc.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_repository.dart';
import 'package:test_new/unvells/screens/view_order_shipment/view_order_shipment_screen.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/change_address_view.dart';

import '../../logic/get_product_details/get_product_details_bloc.dart';
import '../../logic/get_product_details/get_product_details_state.dart';
import '../app_widgets/bottom_sheet.dart';
import '../constants/app_string_constant.dart';
import '../models/dashboard/UserDataModel.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../models/productDetail/product_detail_page_model.dart';
import '../screens/add_review/add_review_screen.dart';
import '../screens/add_review/bloc/add_review_screen_bloc.dart';
import '../screens/add_review/bloc/add_review_screen_repository.dart';
import '../screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_bloc.dart';
import '../screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_repository.dart';
import '../screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import '../screens/home/widgets/item_card_bloc/item_card_repository.dart';
import '../screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import '../screens/login_signup/bloc/signin_signup_screen_repository.dart';
import '../screens/login_signup/view/create_account_screen.dart';
import '../screens/login_signup/view/signin_screen.dart';
import '../screens/lookbook/widget/lookup_item_card.dart';
import '../screens/notifications/bloc/notification_screen_repository.dart';
import '../screens/notifications/bloc/splash_screen_bloc.dart';
import '../screens/notifications/notification_screen.dart';
import '../screens/orders_list/bloc/order_screen_bloc.dart';
import '../screens/orders_list/bloc/order_screen_repository.dart';
import '../screens/product_detail/bloc/product_detail_screen_repository.dart';
import '../screens/product_detail/widgets/add_gift_info_view.dart';
import '../screens/view_refund/bloc/view_refund_screen_bloc.dart';
import '../screens/view_refund/bloc/view_refund_screen_repository.dart';
import '../screens/view_refund/view_refund_screen.dart';
import 'app_storage_pref.dart';

/*
* TO open Bottom sheet for login or signup options
*
* */
void signInSignUpBottomModalSheet(
    BuildContext context, bool isSignUp, bool? isComingFromCart) {
  showAppModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => BlocProvider(
        create: (context) =>
            AuthBloc(repository: SigninSignupScreenRepositoryImp()),
        child: (isSignUp)
            ? CreateAnAccount(isComingFromCart ?? false)
            : SignInScreen(isComingFromCart ?? false)),
  );
}

void reviewBottomModalSheet(BuildContext context, String productName,
    String thumbNail, String productId, List<RatingFormData>? ratingFormData,
    {Function? function}) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                AddReviewScreenBloc(repository: AddReviewRepositoryImp()),
            child: AddReviewScreen(
                productName, thumbNail, productId, ratingFormData),
          )).then((value) {
    if (value == true && function != null) {
      function();
    }
  });
}

void deliveryboyReviewBottomModalSheet(
    BuildContext context,
    String deliveryBoyId,
    int customerId,
    AssignedDeliveryBoyDetails? assignedDeliveryBoyDetails,
    String orderId,
    {Function? function}) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) => DeliveryboyReviewReviewScreenBloc(
                repository: DeliveryboyWriteReviewRepositoryImp()),
            child: DeliveryboyWriteReviewScreen(deliveryBoyId,
                customerId.toString(), assignedDeliveryBoyDetails, orderId),
          )).then((value) {
    if (value == true && function != null) {
      function();
    }
  });
}

void notificationBottomModelSheet(BuildContext context) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) => NotificationScreenBloc(
                repository: NotificationScreenRepositoryImp()),
            child: const NotificationScreen(),
          ));
}

void languageBottomModelSheet(BuildContext context) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ))),
          child: const LanguageScreen()));
}

void showProductBottomSheet({required BuildContext context, required String sku}) {
  showAppModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductDetailsNewBloc(
              getProductDetailsRepoImp: ProductDetailScreenRepositoryImp())
            ..get(sku: sku),
        ),
        BlocProvider(
          create: (context) =>
              ItemCardBloc(repository: ItemCardRepositoryImp()),
        ),
      ],
      child: BlocBuilder<GetProductDetailsNewBloc, GetProductDetailsState>(
        builder: (context, state) {
          final data = state.whenOrNull(
            success: (model) => model?.items?.firstOrNull,
          );
          return KRequestOverlay(
            isLoading: state is GetProductDetailsStateLoading,
            loadingWidget: Skeleton(height:AppSizes.deviceHeight*.1,width: AppSizes.deviceWidth,),
            child: LookupItemCard(
              product: data,
            ),
          );
        },
      ),
    ),
  );
}

void giftBottomModelSheet({
  required BuildContext context,
  required final Function() addToCart,
  required GetProductDetailsNewBloc bloc,
  required ProductDetailScreenBloc detailsBloc,
}) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ))),
          child: MultiBlocProvider(providers: [
            BlocProvider<GetProductDetailsNewBloc>.value(
              value: bloc,
            ),
            BlocProvider<ProductDetailScreenBloc>.value(
              value: detailsBloc,
            )
          ], child: AddGiftInfoView(addToCart: addToCart))));
}

void ProfileBottomModelSheet(BuildContext context, Widget screen) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ))),
          child: screen));
}

void viewInvoiceBottomModelSheet(
    BuildContext context, String? invoiceId, String? orderId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                ViewInvoiceBloc(repository: ViewInvoiceScreenRepositoryImp()),
            child: ViewInvoiceScreen(orderId, invoiceId, ""),
          ));
}

void viewRefundBottomModelSheet(
    BuildContext context, String? invoiceId, String? orderId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                ViewRefundBloc(repository: ViewRefundScreenRepositoryImp()),
            child: ViewRefundScreen(orderId, invoiceId, ""),
          ));
}

void viewShipmentBottomModelSheet(
    BuildContext context, String? orderId, String? shipmentId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) => ViewOrderShipmentBloc(
                repository: ViewOrderShipmentScreenRepositoryImp()),
            child: ViewOrderShipmentScreen(orderId, shipmentId),
          ));
}

void shippingAddressModelBottomSheet(BuildContext context,
    Function(String) onTap, ShippingAddressModel? addresses) {
  showAppModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SizedBox(
      height:
          AppSizes.deviceHeight - WidgetsBinding.instance!.window.padding.top,
      child: ShowAddressList(onTap, addresses),
    ),
  );
}

void showAddressActions(
  BuildContext context, {
  required void Function() onEdit,
  required void Function()? onDelete,
}) {
  showAppModalBottomSheet(
    isScrollControlled: false,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (context) => Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: onEdit,
            child: Text(
              Utils.getStringValue(context, AppStringConstant.editAddress),
              style: KTextStyle.of(context).boldSixteen,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          if (onDelete != null) ...[
            const Divider(),
            const SizedBox(
              height: 6,
            ),
            InkWell(
              onTap: onDelete,
              child: Text(
                Utils.getStringValue(context, AppStringConstant.delete),
                style: KTextStyle.of(context)
                    .boldSixteen
                    .copyWith(color: const Color(0xffEF0101)),
              ),
            ),
          ]
        ],
      ),
    ),
  );
}
