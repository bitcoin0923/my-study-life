import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';

import '../Models/user.model.dart';
import '../Networking/user_service.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import '../Widgets/regular_teztField.dart';
import '../../app.dart';
import '../../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final Function userUpdated;
  final UserModel? editedUser;
  const EditProfileScreen(
      {super.key, this.editedUser, required this.userUpdated});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ScrollController scrollcontroller = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String firstName = '';
  String lastName = '';
  String? imagePath;
  String? newImagePath;

  @override
  void initState() {
    firstName = widget.editedUser?.firstName ?? "";
    lastName = widget.editedUser?.lastName ?? "";
    firstNameController.text = widget.editedUser?.firstName ?? "";
    lastNameController.text = widget.editedUser?.lastName ?? "";
    imagePath = widget.editedUser?.profileImageUrl ?? "";
    super.initState();
  }

  void _firstNameAdded(String input) {
    firstName = input;
  }

  void _lastNameAdded(String input) {
    lastName = input;
  }

  void _uploadPhoto(context) {
    _showOptions(context);
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromCamera();
                    },
                    leading: const Icon(Icons.photo_camera),
                    title: const Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from photo library"))
              ]));
        });
  }

  void _showPhotoLibrary() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      newImagePath = file?.path;
    });
  }

  _getFromCamera() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    setState(() {
      newImagePath = file?.path;
    });
    // if (file != null) {
    //     File imageFile = File(pickedFile.path);
    // }
  }

  // void _removeImage() {
  //   setState(() {
  //     newImagePath = null;
  //     imagePath = null;
  //   });
  // }

  void _saveUser() async {
    //  LoadingDialog.show(context);

    //     try {
    //       var response =
    //           await UserService().updateProfilePicture(newImagePath!);

    //       if (!context.mounted) return;

    //       LoadingDialog.hide(context);
    //       CustomSnackBar.show(context, CustomSnackBarType.success,
    //           response.data['message'], true);

    //       widget.userUpdated();
    //     } catch (error) {
    //       //print("ADSDADSADAD ${error.toString()}");
    //       if (error is DioError) {
    //         LoadingDialog.hide(context);
    //         CustomSnackBar.show(context, CustomSnackBarType.error,
    //             error.response?.data['message'], true);
    //       } else {
    //         LoadingDialog.hide(context);
    //         CustomSnackBar.show(context, CustomSnackBarType.error,
    //             "Oops, something went wrong", true);
    //       }
    //     }
    firstName = firstNameController.text;
    lastName = lastNameController.text;

    if (firstName.isEmpty) {
      CustomSnackBar.show(
          context, CustomSnackBarType.error, "Please add First Name.", true);
      return;
    }

    if (lastName.isEmpty) {
      CustomSnackBar.show(
          context, CustomSnackBarType.error, "Please add Last Name.", true);
      return;
    }

    if (newImagePath == null && imagePath == null) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please select, or upload Profile picture", true);
      return;
    }

    var body = jsonEncode({'firstName': firstName, 'lastName': lastName});

    LoadingDialog.show(context);

    try {
      var response = await UserService().updateUser(body);

      if (!context.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], true);

      // If there is new image added = upload it
      if (newImagePath != null) {
       // LoadingDialog.show(context);

        try {
          var response =
              await UserService().updateProfilePicture(newImagePath!);

          if (!context.mounted) return;

          // LoadingDialog.hide(context);
          // CustomSnackBar.show(context, CustomSnackBarType.success,
          //     response.data['message'], true);

          widget.userUpdated();
         // Navigator.pop(context);
        } catch (error) {
          //print("ADSDADSADAD ${error.toString()}");
          if (error is DioError) {
            LoadingDialog.hide(context);
            CustomSnackBar.show(context, CustomSnackBarType.error,
                error.response?.data['message'], true);
          } else {
            LoadingDialog.hide(context);
            CustomSnackBar.show(context, CustomSnackBarType.error,
                "Oops, something went wrong", true);
          }
        }
      }
      else {
        widget.userUpdated();
       // Navigator.pop(context);
      }

     // Navigator.pop(context);
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor:
                  theme == ThemeMode.light ? Colors.black : Colors.white,
              elevation: 0.0,
              title: Text(
                "Edit Profile",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color:
                        theme == ThemeMode.light ? Colors.black : Colors.white),
              ),
            ),
            body: ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 30),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(children: [
                  if (index == 0) ...[
                    Container(
                      height: 156,
                      width: 156,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 21),
                            height: 146,
                            width: 146,
                            padding: const EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              color: theme == ThemeMode.light
                                  ? Constants
                                      .lightThemeProfileImageCntainerColor
                                  : Constants
                                      .lightThemeProfileImageCntainerColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 7,
                                  color: theme == ThemeMode.light
                                      ? Constants
                                          .lightThemeProfileImageCntainerColor
                                      : Constants
                                          .lightThemeProfileImageCntainerColor),
                              image: newImagePath == null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imagePath ?? ""))
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(newImagePath ?? ""),
                                      ),
                                    ),
                            ),
                          ),
                          if (imagePath != null || newImagePath != null) ...[
                            Positioned(
                              right: -20,
                              bottom: 0,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                elevation: 0.0,
                                // ),
                                onPressed: () => _uploadPhoto(context),
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/EditProfilePictureIcon.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (imagePath == null && newImagePath == null) ...[
                            Positioned(
                              right: -20,
                              bottom: 0,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                elevation: 0.0,
                                // ),
                                onPressed: () => _uploadPhoto(context),
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/AddProfilePictureIcon.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  if (index == 1) ...[
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            height: 6,
                          ),
                          RegularTextField(
                            firstName.isEmpty ? "First Name" : firstName,
                            (value) {
                              // FocusScope.of(context).unfocus();
                            },
                            TextInputType.name,
                            firstNameController,
                            theme == ThemeMode.dark,
                            autofocus: false,
                          ),
                          Container(
                            height: 26,
                          ),
                          Text(
                            'Last Name',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 6,
                          ),
                          RegularTextField(
                            lastName.isEmpty ? "Last Name" : lastName,
                            (value) {
                              // FocusScope.of(context).unfocus();
                            },
                            TextInputType.name,
                            lastNameController,
                            theme == ThemeMode.dark,
                            autofocus: false,
                          ),
                          Container(
                            height: 26,
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (index == 3) ...[
                    // Save/Cancel buttons
                    Container(
                      height: 68,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      // margin: const EdgeInsets.only(top: 260),
                      padding: const EdgeInsets.only(left: 106, right: 106),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoundedElevatedButton(
                              _saveUser,
                              "Save",
                              Constants.lightThemePrimaryColor,
                              Colors.black,
                              45),
                          RoundedElevatedButton(
                              _cancel,
                              "Cancel",
                              Constants.blueButtonBackgroundColor,
                              Colors.white,
                              45)
                        ],
                      ),
                    ),
                    Container(
                      height: 88,
                    ),
                  ],
                ]);
              },
            ),
          ),
        );
      },
    );
  }
}
