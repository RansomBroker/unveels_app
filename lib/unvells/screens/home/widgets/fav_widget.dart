// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../../../app_widgets/app_dialog_helper.dart';
// import '../../../constants/app_constants.dart';
// import '../../../constants/app_routes.dart';
// import '../../../constants/app_string_constant.dart';
// import '../../../helper/app_localizations.dart';
// import '../../../helper/app_storage_pref.dart';
// import '../../../helper/utils.dart';
// import '../../compare_products/bloc/compare_product_events.dart';
//
// class FavWidget extends StatelessWidget {
//   const FavWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  InkWell(
//       onTap: () async {
//         if (appStoragePref.isLoggedIn()) {
//           if (widget.product?.isInWishlist != true) {
//             itemCardBloc?.add(
//               AddToWishlistEvent(
//                 widget.product?.entityId.toString(),
//               ),
//             );
//           } else {
//             if (kDebugMode) {
//               print(
//                   "LISTITEMS-------->${widget.product?.wishlistItemId.toString()}");
//             }
//
//             if (context.mounted) {
//               AppDialogHelper.confirmationDialog(
//                   Utils.getStringValue(context,
//                       AppStringConstant.removeItemFromWishlist),
//                   context,
//                   AppLocalizations.of(context),
//                   title: Utils.getStringValue(
//                       context, AppStringConstant.removeItem),
//                   onConfirm: () async {
//                     itemCardBloc?.add(RemoveFromWishlistEvent(
//                         widget.product?.wishlistItemId.toString()));
//                   });
//             }
//           }
//         } else {
//           AppDialogHelper.confirmationDialog(
//               Utils.getStringValue(context,
//                   AppStringConstant.loginRequiredToAddOnWishlist),
//               context,
//               AppLocalizations.of(context),
//               title: Utils.getStringValue(
//                   context, AppStringConstant.loginRequired),
//               onConfirm: () async {
//                 Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
//               });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.4),
//               spreadRadius: 1,
//               blurRadius: 7,
//               offset:
//               const Offset(0, 1), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Icon(
//           (widget.product?.isInWishlist ?? false)
//               ? Icons.favorite
//               : Icons.favorite_border_outlined,
//           color: (widget.product?.isInWishlist ?? false)
//               ? AppColors.lightRed
//               : const Color(0xff292D32),
//           size: 20,
//         ),
//       ),
//     );
//   }
// }
