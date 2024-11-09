import 'package:freezed_annotation/freezed_annotation.dart';

import '../../unvells/models/productDetail/product_new_model.dart';
part 'get_product_details_state.freezed.dart';

@freezed
abstract class GetProductDetailsState with _$GetProductDetailsState {
  const factory GetProductDetailsState.initial() = GetProductDetailsStateInitial;
  const factory GetProductDetailsState.loading() = GetProductDetailsStateLoading;
  const factory GetProductDetailsState.success({required ProductsNewModel? model}) = GetProductDetailsStateSuccess;
  // const factory GetProductDetailsState.selectedAmount({required String amount}) = GetProductDetailsStateSelectedAmount;
  const factory GetProductDetailsState.error({required String error}) = GetProductDetailsStateError;
}
// flutter pub run build_runner watch --delete-conflicting-outputs