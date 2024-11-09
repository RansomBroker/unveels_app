/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/widget_space.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/models/productDetail/product_new_model.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_repository.dart';

import '../../logic/get_product_details/get_product_details_bloc.dart';
import '../../logic/get_product_details/get_product_details_state.dart';
import '../configuration/text_theme.dart';
import '../helper/generic_methods.dart';
import '../helper/utils.dart';
import '../models/categoryPage/product_tile_data.dart';
import '../screens/lookbook/widget/lookup_item_card.dart';
import '../screens/product_detail/bloc/product_detail_screen_repository.dart';
import 'custom_button.dart';

class DialogHelper {
  static confirmationDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm,
      VoidCallback? onCancel,
      String? title,
      String? okButton,
      bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        title: (title != null)
            ? Text(
                localizations?.translate(title) ?? '',
                style: KTextStyle.of(context)
                    .semiBoldSixteen
                    .copyWith(color: AppColors.gold),
              )
            : null,
        content: Text(
          localizations?.translate(text) ?? "",
          style: KTextStyle.of(context).semiTwelve,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(
                (localizations?.translate(AppStringConstant.cancel) ?? "")
                    .toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge,
              )),
          CustomButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            width: AppSizes.deviceWidth * .25,
            hieght: AppSizes.deviceWidth * .1,
            title: okButton != null
                ? okButton.toString().toUpperCase()
                : (localizations?.translate(AppStringConstant.ok) ?? "")
                    .toUpperCase(),
          ),
        ],
      ),
    );
  }

  //==============Forgot Password Dialog===========//
  static forgotPasswordDialog(
      BuildContext context,
      AppLocalizations? localizations,
      String title,
      String message,
      String email,
      {ValueChanged<String>? onConfirm,
      ValueChanged<bool>? onCancel,
      bool isForgotPassword = true}) {
    var textEditingController = TextEditingController(text: email);
    showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: KTextStyle.of(context)
              .semiBoldSixteen
              .copyWith(color: AppColors.gold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message,
              style: KTextStyle.of(context).semiTwelve,
            ),
            const SizedBox(
              height: AppSizes.spacingLarge,
            ),
            if (isForgotPassword)
              AppTextField(
                  controller: textEditingController,
                  isRequired: true,
                  isPassword: false,
                  validationType: AppStringConstant.email,
                  inputType: TextInputType.emailAddress,
                  hintText: Utils.getStringValue(
                      context, AppStringConstant.emailAddress)),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onCancel != null) {
                onCancel(true);
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.cancel) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          CustomButton(
            onPressed: () {
              if (isForgotPassword) {
                if (textEditingController.text.isEmpty) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showWarning(
                        localizations
                                ?.translate(AppStringConstant.invalidEmail) ??
                            '',
                        context);
                  });
                  return;
                }
                Utils.hideSoftKeyBoard();
                if (onConfirm != null) {
                  onConfirm(textEditingController.text.trim());
                }
              } else {
                if (onConfirm != null) {
                  onConfirm("");
                }
              }
              Navigator.of(ctx).pop();
            },
            width: AppSizes.deviceWidth * .2,
            hieght: AppSizes.deviceWidth * .1,
            title: (localizations?.translate(AppStringConstant.ok) ?? "")
                .toUpperCase(),
          ),
        ],
      ),
    );
  }

  //===============Search Screen Text/Image selection=========//
  static searchDialog(BuildContext context, GestureTapCallback onImageTap,
      GestureTapCallback onTextTap) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      useRootNavigator: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
            GenericMethods.getStringValue(
                context, AppStringConstant.searchByScanning),
            style: KTextStyle.of(context).semiTwelve),
        backgroundColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(AppSizes.spacingNormal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: onTextTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.format_color_text),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.spacingNormal),
                    child: Text(
                        GenericMethods.getStringValue(
                            context, AppStringConstant.textSearch),
                        style: KTextStyle.of(context).semiTwelve),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onImageTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.image_search),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.spacingNormal),
                    child: Text(
                        GenericMethods.getStringValue(
                            context, AppStringConstant.imageSearch),
                        style: KTextStyle.of(context).semiTwelve),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=====================SignUp Term And Conditions===================//

  static signUpTerms(
    String data,
    BuildContext context,
  ) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        contentPadding: const EdgeInsets.all(AppSizes.size8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Html(
          data: data,
          style: {"body": Style(fontSize: FontSize.large)},
        ),
      ),
    );
  }

  // static showProductDialog(
  //   String sku,
  //   BuildContext context,
  // ) {
  //   showDialog(
  //     context: context,
  //     useSafeArea: true,
  //     builder: (ctx) => MultiBlocProvider(
  //       providers: [
  //         BlocProvider(
  //           create: (context) => GetProductDetailsNewBloc(
  //               getProductDetailsRepoImp: ProductDetailScreenRepositoryImp())
  //             ..get(sku: sku),
  //         ),
  //         BlocProvider(
  //           create: (context) =>
  //               ItemCardBloc(repository: ItemCardRepositoryImp()),
  //         ),
  //       ],
  //       child: BlocBuilder<GetProductDetailsNewBloc, GetProductDetailsState>(
  //         builder: (context, state) {
  //           final data = state.whenOrNull(
  //             success: (model) => model?.items?.firstOrNull,
  //           );
  //           return KRequestOverlay(
  //             isLoading: state is GetProductDetailsStateLoading,
  //             child: LookupItemCard(
  //               product: data,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  static networkErrorDialog(BuildContext context, {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          GenericMethods.getStringValue(
              context, AppStringConstant.networkError),
          style: KTextStyle.of(context)
              .semiBoldSixteen
              .copyWith(color: AppColors.gold),
        ),
        content: Text(
          GenericMethods.getStringValue(
              context, AppStringConstant.networkConnectionError),
          style: KTextStyle.of(context).semiTwelve,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: <Widget>[
          CustomButton(
            onPressed: () {
              if (onConfirm != null) {
                closeDialog(ctx);
                onConfirm();
              }
            },
            width: AppSizes.deviceWidth * .2,
            hieght: AppSizes.deviceWidth * .1,
            title: GenericMethods.getStringValue(
                    context, AppStringConstant.tryAgain)
                .toUpperCase(),
          ),
        ],
      ),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static deleteAccountConfirmationDialog(BuildContext context, String title,
      String description, Function(String)? onConfirm) {
    TextEditingController _passwordEditingController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: KTextStyle.of(context)
              .semiBoldSixteen
              .copyWith(color: AppColors.gold),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description,
                style: KTextStyle.of(context).semiTwelve,
              ),
              widgetSpace(),
              AppTextField(
                onSave: (value) {},
                controller: _passwordEditingController,
                isPassword: true,
                validation: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return GenericMethods.getStringValue(
                            context, AppStringConstant.password) +
                        " " +
                        GenericMethods.getStringValue(
                            context, AppStringConstant.required);
                  }
                  if (value.toString().length < 6) {
                    return GenericMethods.getStringValue(
                        context, AppStringConstant.passwordValidationMessage);
                  }
                },
                hintText: GenericMethods.getStringValue(
                    context, AppStringConstant.password),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              closeDialog(ctx);
            },
            child: Text(
              GenericMethods.getStringValue(context, AppStringConstant.cancel)
                  .toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          CustomButton(
            onPressed: () {
              closeDialog(ctx);
              if (_formKey.currentState?.validate() == true) {
                Utils.hideSoftKeyBoard();
                if (onConfirm != null) {
                  onConfirm(_passwordEditingController.text);
                }
              }
            },
            width: AppSizes.deviceWidth * .2,
            hieght: AppSizes.deviceWidth * .1,
            title: GenericMethods.getStringValue(context, AppStringConstant.ok)
                .toUpperCase(),
          ),
        ],
      ),
    );
  }
}
