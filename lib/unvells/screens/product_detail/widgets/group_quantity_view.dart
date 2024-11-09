/*
 *


 *
 * /
 */

// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../app_widgets/image_view.dart';

class GroupQuantityView extends StatefulWidget {
  String title;
  String thumbNail;
  String qty;
  bool displayImage;
  bool displayTitle;
  Widget? subTitle;
  int minimum;
  ValueChanged<int>? callBack;
  GroupQuantityView({Key? key,this.minimum = 1, this.callBack,this.title = "Quantity", this.thumbNail = "",this.subTitle,this.qty = "1", this.displayImage = false, this.displayTitle = false}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _GroupQuantityViewState();
  }
}
class _GroupQuantityViewState extends State<GroupQuantityView> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _updateqty();
  }
  _updateqty(){
    controller.text = widget.qty /*?? "0"*/;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(AppSizes.spacingNormal),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.displayImage)
              SizedBox(
                height: AppSizes.deviceHeight / 7,
                width: AppSizes.deviceWidth / 4,
                child: ImageView(
                  url: widget.thumbNail,
                  height: AppSizes.deviceHeight / 7,
                  width: AppSizes.deviceWidth / 4,
                ),
              ),

            const SizedBox(width: AppSizes.paddingGeneric),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (widget.displayTitle)
                  SizedBox(child: Text(widget.title?? '',maxLines: 3,style: TextStyle(fontWeight: FontWeight.bold),)),

                // const SizedBox(height: AppSizes.spacingTiny),
                if(widget.subTitle != null)
                  widget.subTitle!,

                const SizedBox(height: AppSizes.spacingTiny),
                Container(
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            int counter = int.tryParse(controller.text) ?? 1;
                            if (counter > widget.minimum) {
                              setState(() {
                                counter--;
                                controller.text = counter.toString();
                                if (widget.callBack != null){
                                  widget.callBack!(counter);
                                }
                              });
                            }
                          },
                          child:  Container(
                              padding: EdgeInsets.all(4),
                              // height: MediaQuery.of(context).size.height/22,
                              // width: MediaQuery.of(context).size.width/14,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 1.5, color: Colors.grey),
                              ),
                              child:Icon(Icons.remove,size:16, color:Colors.grey[500]))),
                      // SizedBox(
                      //   width: 8.0,
                      // ),
                      SizedBox(
                          width: 30,child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        style:   TextStyle(fontSize: 17,color:Theme.of(context).colorScheme.onPrimary,),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none
                        ),
                      )),
                      // Text(
                      //   "$_counter",
                      //   style: TextStyle(fontSize: 16.0, color: Colors.black),
                      // ),
                      InkWell(
                          onTap: () {
                            int counter = int.tryParse(controller.text) ?? 1;
                            setState(() {
                              counter = counter + 1;
                              controller.text = counter.toString();
                              if (widget.callBack != null){
                                widget.callBack!(counter);
                              }
                            });

                          },
                          child:   Container(
                              padding: EdgeInsets.all(4),
                              // height: MediaQuery.of(context).size.height/22,
                              // width: MediaQuery.of(context).size.width/14,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 1.5, color: Colors.grey),
                              ),
                              child:Icon(Icons.add,size:16, color:Colors.black,))),

                    ],
                  ),
                ),
              ],
            ),

          ],)

    );
  }

}