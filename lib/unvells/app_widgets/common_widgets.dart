/*
 *


 *
 * /
 */

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../configuration/unvells_theme.dart';

class CommonWidgets {
  ///widget for appbar title
  static Widget getHeadingText(String text, BuildContext context) =>
      Text(text, style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 18),);

  /*const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)*/
  //test flow

  Widget getDropdown(
    Key? key,
    BuildContext context,
    List<String>? itemList,
    String? hintText,
    String? value,
    String? dropDownValue,
    String? labelText,
    Function(String, Key?)? callBack,
    bool isRequired,
  ) {
    return Column(
      children: <Widget>[
        if (labelText != "")
          Row(
            children: <Widget>[
              Text(
                labelText ?? '',
              ),
            ],
          ),
        const SizedBox(height: 6),
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).colorScheme.onBackground,
          ),
          child: DropdownButtonFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
            value: value,
            isExpanded: true,
            key: key,
            validator: (val) {
              if (val == null) {
                return "* Required";
              } else {
                return null;
              }
            },
            onChanged: (String? newValue) {
              if (callBack != null) {
                callBack(newValue ?? '', key);
              }
            },
            items: itemList?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              (hintText ?? "") + ' * ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(color: Colors.grey.shade500),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(color:  Colors.grey.shade500),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///widget for button
  Widget getTextField(
    BuildContext context,
    TextEditingController controller,
    String label,
    String hint,
    String validationMsg, {
    FormFieldValidator<String>? validator,
    String? validLabel,
    String? emailValue,
    bool showPassword = true,
    IconButton? iconButton,
    bool? readOnly,
  }) =>
      TextFormField(
        // focusNode: FocusNode(),
        readOnly: readOnly ?? false,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        obscureText: !showPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color:Theme.of(context).dividerColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.red.shade500),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          suffixIcon: iconButton,
        ),
        validator: validator,
        // onSaved: (email) {
        //   emailValue = email!;
        // },
        // onChanged: (email) {
        //   emailValue = email;
        // },
        // textInputAction: TextInputAction.next,
        // keyboardType: TextInputType.emailAddress,
      );

  ///widget for height
  Widget getTextFieldHeight(double? height) => SizedBox(height: height);

  Widget getTextFieldWidth(double? width) => SizedBox(width: width);

  ///widget for text like product name,drawer titles
  Widget getDrawerTileText(String text, BuildContext context) => Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.grey[800],fontSize: 14),
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      );

  ///widget for button
  Widget appButton(
    BuildContext context,
    String title,
    double buttonWidth,
    VoidCallback onPressed,
  ) =>
      ElevatedButton(
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all(Size(buttonWidth, 104)),
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primaryContainer,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.background,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
             RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: BorderSide(color: Colors.red)
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 17,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ],
        ),
      );

  /// widget for text like product price
  Widget priceText(String price) => Text(
        price,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

  ///widget for divider
  Widget divider() => const Divider(
        thickness: 1,
        height: 1.0,
      );

  Widget textButton(String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: UnvellsTheme.accentColor,
          ),
        ),
      ),
    );
  }
}
