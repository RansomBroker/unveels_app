import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:test_new/logic/get_product_details/get_product_details_bloc.dart';
import 'package:test_new/logic/get_product_details/get_product_details_state.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/custom_drop_down.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/models/productDetail/product_new_model.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_bloc.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/date_picker.dart';
import '../../../helper/utils.dart';
import '../../../helper/validator.dart';
import '../bloc/product_detail_screen_state.dart';

class AddGiftInfoView extends StatefulWidget {
  const AddGiftInfoView({
    super.key,
    required this.addToCart,
  });

  final Function() addToCart;

  @override
  State<AddGiftInfoView> createState() => _AddGiftInfoViewState();
}

class _AddGiftInfoViewState extends State<AddGiftInfoView> {

  // FocusNodes for each text field to manage keyboard focus explicitly
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode nameOfAddresseeFocusNode = FocusNode();
  final FocusNode emailOfAddresseeFocusNode = FocusNode();
  final FocusNode messageFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose FocusNodes when not needed to prevent memory leaks
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    nameOfAddresseeFocusNode.dispose();
    emailOfAddresseeFocusNode.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetProductDetailsNewBloc, GetProductDetailsState>(
      builder: (context, state) {
        final giftModel = context
            .read<GetProductDetailsNewBloc>()
            .model
            ?.items
            ?.firstOrNull
            ?.giftcardOptions;
        final bloc = GetProductDetailsNewBloc.of(context);

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Utils.getStringValue(context, AppStringConstant.send_information),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                          fontWeight: FontWeight.w600,
                        )
                        .apply(fontSizeFactor: 0.8)),
                const SizedBox(
                  height: 5,
                ),
                Text(Utils.getStringValue(context, AppStringConstant.sendInfoDescription),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.grey)
                        .apply(fontSizeFactor: 0.8)),
                const SizedBox(
                  height: 16,
                ),
                KRequestOverlay(
                  isLoading: state is GetProductDetailsStateLoading,
                  child: CustomDropDownField<Amount>(
                    value: bloc.selectedAMount,
                    itemList: giftModel?.amount?.map<DropdownMenuItem<Amount>>(
                          (Amount? value) {
                            return DropdownMenuItem<Amount>(
                              value: value,
                              child: Text(
                                "${value?.price} ${appStoragePref.getCurrencyCode()}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                    hintText:
                        Utils.getStringValue(context, AppStringConstant.amount),
                    key: const Key('amount'),
                    callBack: (p0, p1) {
                      bloc.selectAmount(p0??Amount());
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                KRequestOverlay(
                  isLoading: state is GetProductDetailsStateLoading,
                  child: CustomDropDownField<Template>(
                    value: bloc.selectedTemplate,

                    itemList:
                        giftModel?.template?.map<DropdownMenuItem<Template>>(
                      (Template value) {
                        return DropdownMenuItem<Template>(
                          value: value,
                          child: Text(
                            value.name.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    ).toList(),
                    hintText: Utils.getStringValue(context, AppStringConstant.template),
                    key: const Key('template'),
                    callBack: (Template? p0, p1) {
                      debugPrint(p0?.images?.length.toString());
                      setState(() {});
                      bloc.selectTemplate(
                        template: p0 ?? Template(),
                      );
                      bloc.isSelectedImage = List<bool>.filled(
                          bloc?.selectedTemplate?.images?.length ?? 0, false);
                    },
                  ),
                ),
                if (bloc.selectedTemplate != null) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                  Utils.getStringValue(context, AppStringConstant.select_image),
                    style: KTextStyle.of(context).boldTwelve,
                  )),
                  Wrap(
                    children: List.generate(
                      bloc.selectedTemplate?.images?.length ?? 0,
                      (index) => SizedBox(
                        width: AppSizes.deviceWidth*.3,
                        child: SelectableContainer(

                          unselectedBorderColor: Colors.transparent,
                          // unselectedBackgroundColor: Colors.transparent,
                          selected: bloc.isSelectedImage[index],

                          onValueChanged: (bool value) {
                            // debugPrint("onValueChanged${field.validate()}");
                            setState(() {
                              // Deselect all images
                              for (int i = 0;
                                  i < bloc.isSelectedImage.length;
                                  i++) {
                                bloc.isSelectedImage[i] = false;
                              }
                              // Select the tapped image
                              bloc.isSelectedImage[index] = value;
                            });
                            bloc.selectTemplateImage(
                                image: bloc.selectedTemplate?.images?[index] ??
                                    TemplateImages());
                            debugPrint("onValueChanged${bloc.selectedImage?.id}");
                          },
                          child: FluxImage(
                            imageUrl: bloc
                                    .selectedTemplate?.images?[index].thumbnail
                                    .toString() ??
                                '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 16,
                ),
                KRequestOverlay(
                  isLoading: state is GetProductDetailsStateLoading,
                  child: CustomDropDownField<BssGetListTimezone>(
                    value: bloc.selectedTimeZone,
                    title: bloc.model?.bssGetListTimezone
                        ?.map(
                          (e) => e.label,
                        )
                        .toString(),
                    itemList: bloc.model?.bssGetListTimezone
                            ?.map<DropdownMenuItem<BssGetListTimezone>>(
                          (BssGetListTimezone value) {
                            return DropdownMenuItem<BssGetListTimezone>(
                              value: value,
                              child: Text(
                                value.label.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                    hintText: Utils.getStringValue(context, AppStringConstant.time_zone),
                    key: const Key('timeZone'),
                    callBack: (BssGetListTimezone? p0, p1) {
                      bloc.selectTimeZone(
                        p0 ?? BssGetListTimezone(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                AppTextField(
                  controller: bloc.nameController,
                  isRequired: true,
                  focusNode: nameFocusNode, // Attach FocusNode

                  hintText: Utils.getStringValue(context, AppStringConstant.yourName),
                  onChange: (value) {},
                  validation: (value) {
                    if (value!.trim().isEmpty) {
                      return Utils.getStringValue(context, AppStringConstant.required);
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                AppTextField(
                  focusNode: emailFocusNode, // Attach FocusNode

                  isRequired: true,
                  controller: bloc.emailController,
                  hintText: Utils.getStringValue(context, AppStringConstant.your_email),
                  onChange: (value) {},
                  validation: (value) {
                    if (Validator.isEmailValid(value ?? '', context) == null) {
                      return null;
                    }
                    return Utils.getStringValue(context, AppStringConstant.enterValidEmail);;
                  },
                ),

                const SizedBox(
                  height: 14,
                ),
                AppTextField(
                  focusNode: nameOfAddresseeFocusNode, // Attach FocusNode
                  isRequired: true,

                  controller: bloc.nameOfAddresseeController,
                  hintText: Utils.getStringValue(context, AppStringConstant.nameOfAddressee),
                  validation: (value) {
                    if (value!.trim().isEmpty) {
                      return Utils.getStringValue(context, AppStringConstant.required);
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                AppTextField(
                  focusNode: emailOfAddresseeFocusNode, // Attach FocusNode
                  isRequired: true,

                  controller: bloc.emailOfAddresseeController,
                  hintText: Utils.getStringValue(context, AppStringConstant.emailAddressee),
                  onChange: (value) {},
                  validation: (value) {
                    if (Validator.isEmailValid(value ?? '', context) == null) {
                      return null;
                    }
                    return Utils.getStringValue(context, AppStringConstant.enterValidEmail);;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                GestureDetector(
                  onTap: () async {
                    final date = await SfDatePicker.showDateTimePickerHG(
                        context,
                        type: KDateTimePickerType.dateGregorian,
                        start: DateTime.now(),
                        initial: DateTime.now(),
                        end: DateTime(2030),
                        isFromGift: true);
                    if (date == null) return;
                    dateController.text = date;
                    bloc.dateController.text = date;
                    debugPrint('date: ${dateController.text}');
                  },
                  child: AbsorbPointer(
                    child: AppTextField(
                      isRequired: true,

                      controller: dateController,
                      hintText: Utils.getStringValue(context, AppStringConstant.deliveryDateDescription),
                      validation: (value) {
                        if (value!.isEmpty) {
                          return Utils.getStringValue(context, AppStringConstant.required);
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                AppTextField(

                  controller: bloc.messageController,
                  hintText: Utils.getStringValue(context, AppStringConstant.messageDescription),
                  onChange: (value) {},
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<ProductDetailScreenBloc, ProductDetailScreenState>(
                  builder: (context, state) {
                    return CustomButton(
                      isLoading:
                          context.read<ProductDetailScreenBloc>().isLoading,
                      title: Utils.getStringValue(context, AppStringConstant.addToCart),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.addToCart();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
