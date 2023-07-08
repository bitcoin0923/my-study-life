import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '../Models/holidays_datasource.dart';
import '../Widgets/holiday_xtra_info_card.dart';
import '../Models/API/holiday.dart';
import '../Models/API/xtra.dart';

import '../Home_Screens/create_screen.dart';

class HolidayXtraDetailScreen extends StatefulWidget {
  final Holiday? item;
  final Xtra? xtraItem;

  const HolidayXtraDetailScreen({super.key, required this.item, this.xtraItem});

  @override
  State<HolidayXtraDetailScreen> createState() =>
      _HolidayXtraDetailScreenState();
}

class _HolidayXtraDetailScreenState extends State<HolidayXtraDetailScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _path = null;

  void _editButtonPressed(BuildContext context) {
    bottomSheetForSignIn(context);
  }

  bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return CreateScreen(
            holidayItem: widget.item,
            xtraItem: widget.xtraItem,
          );
        });
  }

  void _closeButtonPressed(context) {
    Navigator.pop(context);
  }

  void _addButtonPressed(context) {
    bottomSheetForSignIn(context);

    //_showOptions(context);
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromCamera();
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  void _showPhotoLibrary() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file?.path;
      //  print(file!.path);
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
      print(file!.path);
    });
    // if (file != null) {
    //     File imageFile = File(pickedFile.path);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        return Container(
          color: theme == ThemeMode.light
              ? Constants.lightThemeClassExamDetailsBackgroundColor
              : Constants.darkThemeBackgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              if (widget.item != null) ...[
                // Holiday
                if (widget.item?.imageUrl == null) ...[
                  if (_path == null) ...[
                    Container(
                      height: screenHeight - 290,
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/images/BackgroundForBlur.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_path != null) ...[
                    Container(
                      height: screenHeight - 290,
                      alignment: Alignment.topCenter,
                      child: Image.file(
                        File(_path!),
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                  Container(
                    margin: EdgeInsets.only(top: 251),
                    alignment: Alignment.topCenter,
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: () => _addButtonPressed(context),
                      child: Container(
                        height: 57,
                        width: 57,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/AddButtonImage.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 322),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Personalize With A Photo',
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
                if (widget.item?.imageUrl != null) ...[
                  Container(
                    height: screenHeight - 290,
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      widget.item?.imageUrl ?? "",
                      height: screenHeight - 290,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
                Container(
                  height: 36,
                  width: 75,
                  margin: const EdgeInsets.only(left: 20, top: 50),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                          minimumSize:
                              MaterialStateProperty.all(const Size((75), 45)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                      onPressed: () => _editButtonPressed(context),
                      child: Text("Edit")),
                ),
                Positioned(
                  right: -10,
                  top: 45,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    elevation: 0.0,
                    // ),
                    onPressed: () => _closeButtonPressed(context),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/CloseButtonX.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(top: (screenHeight - 290) - 100),
                  child: HolidayXtraInfoInfoCard(widget.item, null),
                ),
              ],
              if (widget.xtraItem != null) ...[
                // Xtra
                if (widget.xtraItem?.imageUrl == null) ...[
                  if (_path == null) ...[
                    Container(
                      height: screenHeight - 290,
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/images/BackgroundForBlur.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_path != null) ...[
                    Container(
                      height: screenHeight - 290,
                      alignment: Alignment.topCenter,
                      child: Image.file(
                        File(_path!),
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                  Container(
                    margin: EdgeInsets.only(top: 251),
                    alignment: Alignment.topCenter,
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: () => _addButtonPressed(context),
                      child: Container(
                        height: 57,
                        width: 57,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/AddButtonImage.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 322),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Personalize With A Photo',
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
                if (widget.xtraItem?.imageUrl != null) ...[
                  Container(
                    height: screenHeight - 290,
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      widget.xtraItem?.imageUrl ?? "",
                      height: screenHeight - 290,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
                Container(
                  height: 36,
                  width: 75,
                  margin: const EdgeInsets.only(left: 20, top: 50),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                          minimumSize:
                              MaterialStateProperty.all(const Size((75), 45)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                      onPressed: () => _editButtonPressed(context),
                      child: Text("Edit")),
                ),
                Positioned(
                  right: -10,
                  top: 45,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    elevation: 0.0,
                    // ),
                    onPressed: () => _closeButtonPressed(context),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/CloseButtonX.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(top: (screenHeight - 290) - 100),
                  child: HolidayXtraInfoInfoCard(null, widget.xtraItem),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
