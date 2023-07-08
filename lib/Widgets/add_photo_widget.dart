import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import '../../Utilities/constants.dart';
import './rounded_elevated_button.dart';
import '../../Widgets/custom_snack_bar.dart';

class AddPhotoWidget extends StatefulWidget {
  final Function photoAdded;
  final String? imageUrl;
  const AddPhotoWidget({super.key, required this.photoAdded, this.imageUrl});

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  final ImagePicker _picker = ImagePicker();
  String? _path = null;
  String? _imageUrl = null;

  @override
  void initState() {
    if (widget.imageUrl != null) {
      _imageUrl = widget.imageUrl;
    }
    super.initState();
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
      _path = file?.path;
      widget.photoAdded(_path);
    });
  }

  _getFromCamera() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    setState(() {
      _path = file?.path;
      widget.photoAdded(_path);
      print(file!.path);
    });
    // if (file != null) {
    //     File imageFile = File(pickedFile.path);
    // }
  }

  void _removeImage() {
    setState(() {
      _path = null;
      _imageUrl = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 14,
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _imageUrl != null
                              ? Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                )
                              : (_path == null)
                                  ? theme == ThemeMode.light
                                      ? Image.asset(
                                          'assets/images/AddPhotoBackgroundImage.png',
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          'assets/images/AddPhotoBackgroundImageDarkTheme.png',
                                          fit: BoxFit.cover)
                                  : Image.file(
                                      File(_path!),
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                      if (_path != null || _imageUrl != null) ...[
                        Positioned(
                          right: -30,
                          top: -10,
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            elevation: 0.0,
                            // ),
                            onPressed: () => _removeImage(),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/CloseButtonX.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Container(
                //   height: 100,
                //   width: 100,
                //   decoration: BoxDecoration(
                //       image: (_path == null)
                //           ? theme == ThemeMode.light
                //               ? const DecorationImage(
                //                   image: AssetImage(
                //                       'assets/images/AddPhotoBackgroundImage.png'),
                //                   fit: BoxFit.cover)
                //               : const DecorationImage(
                //                   image: AssetImage(
                //                       'assets/images/AddPhotoBackgroundImageDarkTheme.png'),
                //                   fit: BoxFit.cover)
                //           : DecorationImage(
                //               image: Image.file(File(_path!)).image,
                //               fit: BoxFit.cover)),
                //   // child: MaterialButton(
                //   //   padding: EdgeInsets.all(2.0),
                //   //   splashColor: Colors.transparent,
                //   //   elevation: 0.0,
                //   //   child: Container(
                //   //     decoration: BoxDecoration(
                //   //       image: theme == ThemeMode.light
                //   //           ? const DecorationImage(
                //   //               image: AssetImage(
                //   //                   'assets/images/AddPhotoBackgroundImage.png'),
                //   //               fit: BoxFit.cover)
                //   //           : const DecorationImage(
                //   //               image: AssetImage(
                //   //                   'assets/images/AddPhotoBackgroundImageDarkTheme.png'),
                //   //               fit: BoxFit.cover),
                //   //     ),
                //   //     // child: Padding(
                //   //     //   padding: const EdgeInsets.all(8.0),
                //   //     //   child: Text("SIGN OUT"),
                //   //     // ),
                //   //   ),
                //   //   // ),
                //   //   onPressed: () {
                //   //     print('Tapped');
                //   //   },
                //   // ),
                // ),
              ],
            ),
            Container(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                ),
                Container(
                  width: 174,
                  height: 32,
                  child: Text(
                    'Personalize with a photo of your choice',
                    maxLines: 2,
                    style: theme == ThemeMode.light
                        ? Constants.lightThemePhotoDescriptionStyle
                        : Constants.darkThemePhotoDescriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 144,
                  height: 44,
                  child: RoundedElevatedButton(
                      () => _showOptions(context),
                      "+ Upload Photo",
                      theme == ThemeMode.light
                          ? Constants.lightThemePrimaryColor
                          : Constants.lightThemePrimaryColor,
                      Colors.black,
                      34),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
