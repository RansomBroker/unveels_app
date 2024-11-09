/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_multi_select_checkbox.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/common_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/models/search/advance_search_model.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_bloc.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_events.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_states.dart';

class AdvanceSearchScreen extends StatefulWidget {
   AdvanceSearchScreen({Key? key}) : super(key: key);

  @override
  State<AdvanceSearchScreen> createState() => _AdvanceSearchScreenState();
}

class _AdvanceSearchScreenState extends State<AdvanceSearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AppLocalizations? _localizations;
  bool isLoading = false;
  AdvanceSearchModel? advanceSearchModel;
  AdvanceSearchScreenBloc? advanceSearchScreenBloc;
  
  
  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }
  
  @override
  void initState() {
    advanceSearchScreenBloc = context.read<AdvanceSearchScreenBloc>();
    advanceSearchScreenBloc?.add(InitialAdvanceSearchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(_localizations?.translate(AppStringConstant.advanceSearch) ?? '', context),
      body: BlocBuilder<AdvanceSearchScreenBloc, AdvanceSearchState>(builder: (context, state){
        if(state is AdvanceSearchLoadingState){
          isLoading = true;
        }
        else if(state is AdvanceSearchScreenSuccess){
          isLoading = false;
          advanceSearchModel = state.advanceSearchModel;
        }
        else if(state is AdvanceSearchScreenError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }

        return _buildUI();
      },

      ),
    );
  }

  Widget _buildUI(){
    return Stack(
      children: [
        Visibility(
          visible: advanceSearchModel?.fieldList?.isNotEmpty ?? false,
            child: _addEditAddressForm()
        ),
        Visibility(
          visible: isLoading,
            child: const Loader()
        ),

      ],
    );
  }

  Widget _addEditAddressForm() {
    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.size8),
            child: Form(
                key: _formKey,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: _getTextField(),
                )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8, vertical: AppSizes.size8),
        child:  commonButton(
            context,(){
          //   _formKey.currentState?.save();
          //   _validateForm();
        }, (_localizations?.translate(AppStringConstant.search) ??'').toUpperCase(),
          width: AppSizes.deviceWidth,
          backgroundColor: AppColors.black,
          textColor: AppColors.white
        ),
      )
    ]);
  }
  List<Widget> _getTextField() {
    List<Widget> columnChildren = <Widget>[];


    advanceSearchModel?.fieldList?.forEach((element) {
      if(element.inputType == "select"){
        columnChildren.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:AppSizes.size8),
                  child: Text(element.label ?? '', style: Theme.of(context).textTheme.headlineLarge,),
                ),
                CheckboxGroup(
                  labels: element.options?.map((e) => e.label ?? '').toList() ?? [],
                  checked: element.options?.where((element) => element.isSelected == true).map((e) => e.label ??'').toList() ??[],
                  onChange: (bool isChecked, String label, int index, Key? key){
                  } ,
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            )

        );

      }
      else {
        columnChildren.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: AppTextField(
              hintText: element.label,
              isPassword: false,
              onSave: (value) {
                element.value = value;
              },
              inputType: (element.inputType == "price")
                  ? TextInputType.number
                  : TextInputType.text,
            ),
          ),
        );
      }

    });
    return columnChildren;
  }
}


// void _validateForm() async {
//   if (_formKey.currentState?.validate() == true) {
//     Map<String, dynamic> data = Map();
//     addressFormModel?.addressFields?.field?.forEach((element) {
//       data[element.fieldName ?? ''] = element.value;
//     });
//     data["id_country"] == null
//         ? data["id_country"] = countries?.first.idCountry
//         : data["id_country"];
//     data['id_address'] = widget.addressId;
//     data['id_customer'] = await AppSharedPref.getCustomerId();
//     addEditBloc?.add(const LoadingEvent());
//     addEditBloc?.add(SaveAddressEvent(data: data));
//     return;
//   }
// }
