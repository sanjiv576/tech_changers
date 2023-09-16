import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/common/snackbar_message.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/viewmodel/auth_viewmodel.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _gap = const SizedBox(height: 40);

  final _textStyle = const TextStyle(fontSize: 20);

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _modalForCamera() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                checkCameraPermission();
                _browseImage(ref, ImageSource.camera);
                Navigator.pop(context);
                // Upload image it is not null
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                checkCameraPermission();

                _browseImage(ref, ImageSource.gallery);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
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
  @override
  void initState() {
    super.initState();

    // _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    UserEntity? user = ref.watch(authViewModelProvider).singleUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(18),
            // color: Colors.black,
            // height: 400,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : NetworkImage(
                                // 'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg?w=740&t=st=1694796086~exp=1694796686~hmac=97f185f13daf2fb34ff9271c4e52ea2e197129c57da43b568a2f1d102480ad8a',
                                // ApiEndpoints.imageUrl + user!.userPhoto!,
                                '${ApiEndpoints.imageUrl}${user!.userPhoto!}',
                              ) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: () {
                              print('add photo');
                              _modalForCamera();
                            },
                            icon: const Icon(Icons.add),
                            iconSize: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _gap,
                  Text('Full Name : ${user!.fullName}', style: _textStyle),
                  _gap,
                  Text('Role : ${user.role}', style: _textStyle),
                  _gap,
                  Text('Address : ${user.address}', style: _textStyle),
                  _gap,
                  Text('Contact : ${user.contactNumber}', style: _textStyle),
                  _gap,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   final _gap = const SizedBox(height: 40);

//   final _textStyle = const TextStyle(fontSize: 20);

//   File? _img;
//   Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           ref.read(authViewModelProvider.notifier).uploadImage(_img!);
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   void _modalForCamera() {
//     showModalBottomSheet(
//       backgroundColor: Colors.grey[300],
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton.icon(
//               onPressed: () {
//                 checkCameraPermission();
//                 _browseImage(ref, ImageSource.camera);
//                 Navigator.pop(context);
//                 // Upload image it is not null
//               },
//               icon: const Icon(Icons.camera),
//               label: const Text('Camera'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 _browseImage(ref, ImageSource.gallery);
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.image),
//               label: const Text('Gallery'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: SingleChildScrollView(
//       child: Container(
//         margin: const EdgeInsets.all(18),
//         // color: Colors.black,
//         // height: 400,
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Stack(
//                 children: [
//                   const CircleAvatar(
//                     radius: 100,
//                     backgroundImage: NetworkImage(
//                       'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg?w=740&t=st=1694796086~exp=1694796686~hmac=97f185f13daf2fb34ff9271c4e52ea2e197129c57da43b568a2f1d102480ad8a',
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 5,
//                     right: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: IconButton(
//                         onPressed: () {
//                           print('add photo');
//                         },
//                         icon: const Icon(Icons.add),
//                         iconSize: 50,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               _gap,
//               Text('Full Name : ', style: _textStyle),
//               _gap,
//               Text('Role : ', style: _textStyle),
//               _gap,
//               Text('Location : ', style: _textStyle),
//               _gap,
//               Text('Contact : ', style: _textStyle),
//               _gap,
//             ],
//           ),
//         ),
//       ),
//     )));
//   }
// }
