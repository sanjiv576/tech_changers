import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/state/auth_state.dart';

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

  late UserEntity _user;
  @override
  void initState() {
    super.initState();

    _user = AuthState.userEntity!;
  }

  @override
  Widget build(BuildContext context) {
    // UserEntity? user = ref.watch(authViewModelProvider).singleUser;
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
                                '${ApiEndpoints.imageUrl}${_user.userPhoto!}',
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
                  Text('Full Name : ${_user.fullName}', style: _textStyle),
                  _gap,
                  Text('Role : ${_user.role}', style: _textStyle),
                  _gap,
                  Text('Address : ${_user.address}', style: _textStyle),
                  _gap,
                  Text('Contact : ${_user.contactNumber}', style: _textStyle),
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
