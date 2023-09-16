import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/config/router/app_routes.dart';
import 'package:my_project/core/shared_prefs/user_shared_prefs.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/common/snackbar_message.dart';
import '../../../../../core/utils/download_file.dart';
import '../../../../../main.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/state/auth_state.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  void _showUserToken() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    var data = await userSharedPrefs.getUserToken();
    String? token;
    data.fold((l) => print(l.error.toString()), (r) => token = r!);

    print('Reading token from home : $token');
  }

  void _getUserData() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    var data = await userSharedPrefs.getUser();
    data.fold((l) {
      showSnackbarMsg(
          context: context,
          targetTitle: 'Error',
          targetMessage: 'Failed to fetch user data',
          type: ContentType.failure);
    }, (r) => user = r!);

    print('Reading user data from home : $user');
  }

  late UserEntity? user;

  final UserSharedPrefs _userSharedPrefs = UserSharedPrefs();
  @override
  void initState() {
    super.initState();

    user = AuthState.userEntity;

    // _getUserData();
  }

  void _clearSharedPrefs() {
    _userSharedPrefs.clearSharedPrefs();
  }

  final _gap = const SizedBox(height: 20);

  void _showSimpleNotifications() async {
    // image for right image icon on the notification
    final largeIconPath = await DownloadFile.downloadFiles(
      'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bWVkaWNpbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
      'largeIcon',
    );

    // big image at the center on the notification

    final bigPicturePath = await DownloadFile.downloadFiles(
      'https://media.istockphoto.com/id/1410614667/photo/woman-pour-pills-into-palm-to-take-dietary-supplements-vitamins-or-medicines-health-care.jpg?s=612x612&w=0&k=20&c=ZPYWePUw-Oz9Vk9KxTisxpS5tIRZBQzoM3uhgO9LYAs=',
      'bigPicture',
    );

    print('Simple Notification got clicked');

    String channelId = const Uuid().v4();
    // Note: Before making notifications, its details need to be defined for both ios and android
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId,
      channelId + user!.fullName, // channel name can be anything,
      priority: Priority.max,
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,

      // show images and icon as well
      styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          contentTitle: '<b>Attachement Image</b>',
          htmlFormatContentTitle: true,
          summaryText: '<i>Did you forget to take medicine ?</i>',
          htmlFormatSummaryText: true,
          largeIcon: FilePathAndroidBitmap(largeIconPath)),
    );

    DarwinNotificationDetails iosNotificationDetail =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
    );

    // show the notification
    await notificationsPlugin.show(
        123, // Note thid id must be dynamic, but for demo static int is used
        'New Notification', // title
        'Take Medicine', // body
        notificationDetails,

        // Note: add payload
        payload: 'payload data Sanjiv Shrestha');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Hi, ${user!.fullName.split(' ')[0]}!',
            style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _showSimpleNotifications();
              },
              icon: const Icon(Icons.notifications_active),
            ),
            _gap,
            IconButton(
              onPressed: () {
                _clearSharedPrefs();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.loginRoute, (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ));
  }
}
