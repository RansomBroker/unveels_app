/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../constants/global_data.dart';
import '../../../models/notifications/notification_screen_model.dart';
import 'other_notifications_widget.dart';

class NotificationItem extends StatefulWidget {
  NotificationItem(this.data, {Key? key}) : super(key: key);
  Notifications? data;

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isRead = false;

  @override
  void initState() {
    //isRead = widget.data?.isRead ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).cardColor,
        ),
        child: GestureDetector(
          onTap: () {
            if (widget.data?.notificationType == "custom") {
              Navigator.of(context).pushNamed(
                AppRoutes.catalog,
                arguments: categoryMap(int.parse(widget.data?.id ?? "0"),
                    widget.data?.title ?? "", GlobalData.custom_collection),
              );
            } else if (widget.data?.notificationType == "category") {
              Navigator.of(context).pushNamed(
                AppRoutes.catalog,
                arguments: categoryMap(int.parse(widget.data?.id ?? "0"),
                    widget.data?.title ?? "", ""),
              );
            } else if (widget.data?.notificationType == "other") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => OtherNotificationWidget(
                        widget.data?.title ?? "", widget.data?.content ?? "")),
              );
            } else {
              Navigator.of(context).pushNamed(AppRoutes.productPage,
                  arguments: getProductDataAttributeMap(
                    widget.data?.title ?? "",
                    widget.data?.productId ?? "",
                  ));
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(AppSizes.size16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            widget.data?.title ?? "",
                            style: Theme.of(context).textTheme.labelLarge,
                          )),
                          const SizedBox(
                            height: AppSizes.size8 / 2,
                          ),
                          Flexible(
                              child: Text(widget.data?.content ?? "",
                                  style:
                                      Theme.of(context).textTheme.bodySmall)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: AppSizes.deviceWidth,
                height: AppSizes.deviceWidth / 1.5,
                child: ImageView(
                  url: widget.data?.banner ?? '',
                  fit: BoxFit.fill,
                  isBottomPadding: false,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
              )
            ],
          ),
        ));
  }
}
