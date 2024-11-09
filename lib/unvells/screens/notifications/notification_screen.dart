/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/notifications/views/notification_item.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../models/notifications/notification_screen_model.dart';
import 'bloc/notification_screen_state.dart';
import 'bloc/splash_screen_bloc.dart';
import 'bloc/splash_screen_event.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = false;
  NotificationScreenBloc? _notificationBloc;
  NotificationScreenModel? data;
  Notifications? notifications;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _notificationBloc = context.read<NotificationScreenBloc>();
    _notificationBloc?.add(const NotificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationScreenBloc, NotificationScreenState>(
        builder: (context, currentState) {
      if (currentState is NotificationScreenInitial) {
        isLoading = true;
      } else if (currentState is NotificationScreenSuccess) {
        isLoading = false;
        data = currentState.notificationScreenModel;
      } else if (currentState is NotificationScreenError) {
        isLoading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(currentState.message ?? "", context);
        });
      }

      return _buildUI();
    });
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Scaffold(
          appBar: appToolBar(
              Utils.getStringValue(context, AppStringConstant.notifications),
              context,
              isLeadingEnable: true,
              isElevated: true),
          body: (data != null)
              ? (data?.notificationList?.isNotEmpty ?? false)
                  ? ListView.builder(
                      itemCount: data?.notificationList?.length ?? 0,
                      itemBuilder: (context, index) =>
                          NotificationItem(data?.notificationList?[index]))
                  : emptyNotification()
              : Container(),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  Widget emptyNotification() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications,
            size: 160,
          ),
          Text(
            Utils.getStringValue(context, AppStringConstant.emptyNotification),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
