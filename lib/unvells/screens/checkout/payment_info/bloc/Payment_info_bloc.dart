/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_repository.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_state.dart';

class PaymentInfoScreenBloc
    extends Bloc<PaymentInfoScreenEvent, PaymentInfoScreenState> {
  PaymentInfoScreenRepository? repository;

  PaymentInfoScreenBloc({this.repository}) : super(PaymentInfoScreenInitial()) {
    on<PaymentInfoScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(PaymentInfoScreenEvent event,
      Emitter<PaymentInfoScreenState> emit) async {
    if (event is GetPaymentInfoEvent) {
      try {
        var model = await repository?.getPaymentInfo(event.shippingMethod);
        if (model != null) {
          emit(GetPaymentMethodSuccess(model));
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    }
    if (event is CheckoutAddressFetchEvent) {
      try {
        var model = await repository?.getCheckoutAddress();
        if (model != null) {
          emit(CheckoutAddressSuccess(model));
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is PlaceOrderEvent) {
      try {
        var model = await repository?.placeOrder(
            event.wallet, event.paymentMethod, event.billingData);
        if (model != null) {
          if (model.success ?? false) {
            emit(PlaceOrderSuccess(model));
          } else {
            emit(PaymentInfoScreenError(model.message));
          }
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ApplyCouponEvent) {
      try {
        emit(PaymentInfoScreenInitial());
        var model =
            await repository?.applyCoupon((event).couponCode, event.remove);
        if (model != null) {
          if (model.success ?? false) {
            emit(ApplyCouponState(model));
          } else {
            emit(PaymentInfoScreenError(model.message ?? ''));
          }
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ApplyGiftCouponEvent) {
      try {
        emit(PaymentInfoScreenInitial());
        var model = await repository?.applyGiftCoupon(
          event.couponCode,
          event.remove

        );
        if (model != null) {
          if (model.success ?? false) {
            emit(ApplyGiftCouponState(model));
          } else {
            emit(PaymentInfoScreenError(model.message ?? ''));
          }
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ApplyRewardPointEvent) {
      try {
        emit(PaymentInfoScreenInitial());
        var model = await repository?.applyRewardPoint(
          event.amount,
          event.remove

        );
        if (model != null) {
          if (model.success ?? false) {
            emit(ApplyRewardPointState(model));
          } else {
            emit(PaymentInfoScreenError(model.message ?? ''));
          }
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ChangeAddressEvent) {
      emit(ChangeBillingAddressState());
    } else if (event is GetWalletDetails) {
      emit(PaymentInfoScreenInitial());
      try {
        var model = await repository?.applyPaymentAmount(event.wallet ?? "");
        if (model != null) {
          emit(ApplyWalletPaymentSuccessState(model: model));
        } else {
          emit(const PaymentInfoScreenError(""));
        }
      } catch (e) {
        emit(PaymentInfoScreenError(e.toString()));
      }
    }
  }
}
