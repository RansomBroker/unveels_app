/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/place_order/place_order_model.dart';
import 'package:test_new/unvells/models/wallet_extension_models/wallet_dashboard_model.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/payment_info_screen.dart';

import '../../../../models/base_model.dart';
import '../../../../models/checkout/shipping_info/shipping_address_model.dart';

abstract class PaymentInfoScreenState {
  const PaymentInfoScreenState();

  @override
  List<Object> get props => [];
}

class PaymentInfoScreenInitial extends PaymentInfoScreenState {}

class PaymentInfoScreen extends PaymentInfoScreenState {}

class GetPaymentMethodSuccess extends PaymentInfoScreenState {
  final PaymentInfoModel? paymentModel;

  const GetPaymentMethodSuccess(this.paymentModel);

  @override
  List<Object> get props => [];
}

class CheckoutAddressSuccess extends PaymentInfoScreenState {
  final ShippingAddressModel model;

  const CheckoutAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class PaymentInfoScreenError extends PaymentInfoScreenState {
  const PaymentInfoScreenError(this.message);

  final String? message;
}

class PlaceOrderSuccess extends PaymentInfoScreen {
  final PlaceOrderModel placeOrderModel;

  PlaceOrderSuccess(this.placeOrderModel);
}

class ChangeBillingAddressState extends PaymentInfoScreen {
  ChangeBillingAddressState();
}

class ApplyCouponState extends PaymentInfoScreen {
  final BaseModel data;

  ApplyCouponState(this.data);

  @override
  List<Object> get props => [data];
}

class ApplyGiftCouponState extends PaymentInfoScreen {
  final BaseModel data;

  ApplyGiftCouponState(this.data);

  @override
  List<Object> get props => [data];
}class ApplyRewardPointState extends PaymentInfoScreen {
  final BaseModel data;

  ApplyRewardPointState(this.data);

  @override
  List<Object> get props => [data];
}

class PaymentInfoScreenEmptyState extends PaymentInfoScreenState {}

class ApplyWalletPaymentSuccessState extends PaymentInfoScreenState {
  WalletDashboardModel? model;

  ApplyWalletPaymentSuccessState({this.model});
}
