/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../../models/checkout/place_order/billing_data_request.dart';

abstract class PaymentInfoScreenEvent {
  const PaymentInfoScreenEvent();


}

class  GetPaymentInfoEvent extends PaymentInfoScreenEvent{
  final String shippingMethod;

  const GetPaymentInfoEvent(this.shippingMethod);
}

class CheckoutAddressFetchEvent extends PaymentInfoScreenEvent {
  const CheckoutAddressFetchEvent();

}

class PlaceOrderEvent extends PaymentInfoScreenEvent{
  final String wallet;
  final String paymentMethod;
  final String shippingMethod;
  final BillingDataRequest billingData;

  const PlaceOrderEvent(this.paymentMethod, this.shippingMethod, this.billingData, this.wallet);


}

class ChangeAddressEvent extends PaymentInfoScreenEvent {
  const ChangeAddressEvent();


}

class ApplyCouponEvent extends PaymentInfoScreenEvent{
  String couponCode;
  final int remove;

  ApplyCouponEvent(this.couponCode, this.remove);
}
class ApplyGiftCouponEvent extends PaymentInfoScreenEvent{
  String couponCode;
  final int remove;

  ApplyGiftCouponEvent(this.couponCode, this.remove);
}
class ApplyRewardPointEvent extends PaymentInfoScreenEvent{
  String amount;
  final int remove;

  ApplyRewardPointEvent(this.amount, this.remove);
}

class GetWalletDetails extends PaymentInfoScreenEvent{
  final String? wallet;
  const GetWalletDetails(this.wallet);
}
