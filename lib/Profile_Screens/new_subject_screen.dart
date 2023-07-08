import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Models/API/subject.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Widgets/rounded_elevated_button.dart';

import '../../app.dart';
import '../Widgets/regular_teztField.dart';
import '../Models/subjectColors_dataosource.dart';
import '../Widgets/ProfileWidgets/select_color_card.dart';
import '../Widgets/ProfileWidgets/select_classphoto_card.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Networking/subject_service.dart';

class AddSubjectScreen extends StatefulWidget {
  final Subject? editedSubject;
  const AddSubjectScreen({super.key, this.editedSubject});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final subjectNameController = TextEditingController();
  final ScrollController scrollcontroller = ScrollController();
  final ImagePicker _picker = ImagePicker();
  String? _path = null;
  Subject newSubject = Subject();

  List<SubjectColor> subjectColors = SubjectColor.subjectColors;
  List<SubjectPhoto> subjectPhotos = SubjectPhoto.subjectPhotos;
  SubjectColor? selectedColor;
  bool isEditing = false;

  @override
  void initState() {
    if (widget.editedSubject != null) {
      isEditing = true;
      newSubject = widget.editedSubject!;
      if (widget.editedSubject?.colorHex != null) {
        var index = subjectColors.indexWhere((element) =>
            element.itemColor.toHex() == widget.editedSubject!.colorHex!);
        if (index < subjectColors.length) {
          subjectColors[index].selected = true;
          selectedColor = subjectColors[index];
        } else {
          subjectColors[0].selected = true;
        }
      } else {
        subjectColors[0].selected = true;
      }

      subjectNameController.text = widget.editedSubject?.subjectName ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    selectedColor = null;
    for (var color in subjectColors) {
      color.selected = false;
    }
    isEditing = false;
    super.dispose();
  }

  void _selectedColor(int index) {
    setState(() {
      for (var savedColor in subjectColors) {
        savedColor.selected = false;
      }

      var color = subjectColors[index];
      color.selected = !color.selected;
      subjectColors[index] = color;
      selectedColor = color;
    });
  }

  void _selectedImage(int index) {
    setState(() {
      for (var savedPhoto in subjectPhotos) {
        savedPhoto.selected = false;
      }

      var photo = subjectPhotos[index];
      photo.selected = !photo.selected;
      subjectPhotos[index] = photo;
    });
  }

  void _uploadPhotoTappedx(context) {
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

  void _saveSubject() async {
    String finalSubjectName = subjectNameController.text;

    if (finalSubjectName.isEmpty) {
      CustomSnackBar.show(
          context, CustomSnackBarType.error, "Please add subject name.", true);
      return;
    }

    if (selectedColor == null) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please select subject color.", true);
      return;
    }

    if (!isEditing) {
      if (_path == null) {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Please select, or upload subject image", true);
        return;
      }
    }

    newSubject.subjectName = finalSubjectName;
    newSubject.colorHex = selectedColor!.itemColor.toHex();
    newSubject.newImageUrl = _path;

    if (isEditing) {
      LoadingDialog.show(context);

      try {
        var response = await SubjectService().updateSubject(newSubject);

        if (!context.mounted) return;

        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], false);
        Navigator.pop(context);
      } catch (error) {
        if (error is DioError) {
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              error.response?.data['msg'], false);
        } else {
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              "Oops, something went wrong", false);
        }
      }
    } else {
      LoadingDialog.show(context);

      try {
        var response = await SubjectService().createSubject(newSubject);

        if (!context.mounted) return;

        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], false);
        Navigator.pop(context);
      } catch (error) {
        //print("ADSDADSADAD ${error.toString()}");
        if (error is DioError) {
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              error.response?.data['msg'], false);
        } else {
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              "Oops, something went wrong", false);
        }
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              foregroundColor:
                  theme == ThemeMode.light ? Colors.black : Colors.white,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                "New Subject",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color:
                        theme == ThemeMode.light ? Colors.black : Colors.white),
              ),
            ),
            body: Container(
                color: theme == ThemeMode.light
                    ? Constants.lightThemeClassExamDetailsBackgroundColor
                    : Constants.darkThemeBackgroundColor,
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                    controller: scrollcontroller,
                    padding:
                        const EdgeInsets.only(top: 26, left: 20, right: 20),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0) ...[
                            Text(
                              'Subject Name',
                              style: theme == ThemeMode.light
                                  ? Constants.lightThemeSubtitleTextStyle
                                  : Constants.darkThemeSubtitleTextStyle,
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 6,
                            ),
                            RegularTextField(
                              "Subject Name",
                              (value) {
                                // FocusScope.of(context).unfocus();
                              },
                              TextInputType.name,
                              subjectNameController,
                              theme == ThemeMode.dark,
                              autofocus: false,
                            ),
                            Container(
                              height: 26,
                            ),
                          ],
                          if (index == 1) ...[
                            Text(
                              'Color',
                              style: theme == ThemeMode.light
                                  ? Constants.lightThemeSubtitleTextStyle
                                  : Constants.darkThemeSubtitleTextStyle,
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 6,
                            ),
                            SizedBox(
                              height: 56,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: subjectColors.length,
                                  itemBuilder:
                                      (BuildContext content, int index) {
                                    return SelectColorCard(
                                        subjectColors[index].itemColor,
                                        subjectColors[index].selected,
                                        index,
                                        _selectedColor);
                                  }),
                            ),
                            Container(
                              height: 22,
                            ),
                          ],
                          if (index == 2) ...[
                            Text(
                              'Photo',
                              style: theme == ThemeMode.light
                                  ? Constants.lightThemeSubtitleTextStyle
                                  : Constants.darkThemeSubtitleTextStyle,
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 6,
                            ),
                            SizedBox(
                              height: 102,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: subjectPhotos.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return SelectSubjectPhotoCard(
                                      subjectPhotos[index],
                                      index,
                                      _selectedImage);
                                },
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                          if (index == 3) ...[
                            Container(
                              height: 34,
                              alignment: Alignment.topLeft,
                              child: ElevatedButton(
                                onPressed: () => _uploadPhotoTappedx(context),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0.0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    )),
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(142, 34)),
                                    backgroundColor: theme == ThemeMode.light
                                        ? MaterialStateProperty.all(
                                            Constants.lightThemePrimaryColor)
                                        : MaterialStateProperty.all(
                                            Constants.darkThemePrimaryColor),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                                child: const Text(
                                  '+ Upload Photo',
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                            ),
                          ],
                          if (index == 4) ...[
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin:
                                  const EdgeInsets.only(bottom: 84, top: 30),
                              width: double.infinity,
                              // margin: const EdgeInsets.only(top: 260),
                              padding:
                                  const EdgeInsets.only(left: 106, right: 106),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  RoundedElevatedButton(
                                      _saveSubject,
                                      "Save Subject",
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
                          ]
                        ],
                      );
                    }))),
      );

//             Stack(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 26),
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Subject Name',
//                         style: theme == ThemeMode.light
//                             ? Constants.lightThemeSubtitleTextStyle
//                             : Constants.darkThemeSubtitleTextStyle,
//                         textAlign: TextAlign.left,
//                       ),
//                       Container(
//                         height: 6,
//                       ),
//                       RegularTextField(
//                         "Subject Name",
//                         (value) {
//                           FocusScope.of(context).unfocus();
//                         },
//                         TextInputType.name,
//                         subjectNameController,
//                         theme == ThemeMode.dark,
//                         autofocus: false,
//                       ),
//                       Container(
//                         height: 26,
//                       ),
//                       Text(
//                         'Color',
//                         style: theme == ThemeMode.light
//                             ? Constants.lightThemeSubtitleTextStyle
//                             : Constants.darkThemeSubtitleTextStyle,
//                         textAlign: TextAlign.left,
//                       ),
//                       Container(
//                         height: 6,
//                       ),
//                       SizedBox(
//                         height: 56,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: subjectColors.length,
//                             itemBuilder: (BuildContext content, int index) {
//                               return SelectColorCard(
//                                   subjectColors[index].itemColor,
//                                   subjectColors[index].selected,
//                                   index,
//                                   _selectedColor);
//                             }),
//                       ),
//                       Container(
//                         height: 22,
//                       ),
//                       Text(
//                         'Photo',
//                         style: theme == ThemeMode.light
//                             ? Constants.lightThemeSubtitleTextStyle
//                             : Constants.darkThemeSubtitleTextStyle,
//                         textAlign: TextAlign.left,
//                       ),
//                       Container(
//                         height: 6,
//                       ),
//                       SizedBox(
//                         height: 102,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: subjectPhotos.length,
//                           itemBuilder: (BuildContext content, int index) {
//                             return SelectSubjectPhotoCard(
//                                 subjectPhotos[index], index, _selectedImage);
//                           },
//                         ),
//                       ),
//                       Container(
//                         height: 10,
//                       ),
//                       Container(
//                         height: 34,
//                         alignment: Alignment.topLeft,
//                         child: ElevatedButton(
//                           onPressed: () => _uploadPhotoTappedx(context),
//                           style: ButtonStyle(
//                               elevation: MaterialStateProperty.all(0.0),
//                               shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4),
//                               )),
//                               minimumSize: MaterialStateProperty.all(
//                                   const Size(142, 34)),
//                               backgroundColor: theme == ThemeMode.light
//                                   ? MaterialStateProperty.all(
//                                       Constants.lightThemePrimaryColor)
//                                   : MaterialStateProperty.all(
//                                       Constants.darkThemePrimaryColor),
//                               foregroundColor:
//                                   MaterialStateProperty.all(Colors.black),
//                               textStyle: MaterialStateProperty.all(
//                                   const TextStyle(
//                                       fontFamily: "Roboto",
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black))),
//                           child: const Text(
//                             '+ Upload Photo',
//                           ),
//                         ),
//                       ),
//                       // Container(
//                       //   height: 200,
//                       // ),
//                       Container(
//                         alignment: Alignment.bottomCenter,
//                         margin: const EdgeInsets.only(bottom: 84, top: 30),
//                         width: double.infinity,
//                         // margin: const EdgeInsets.only(top: 260),
//                         padding: const EdgeInsets.only(left: 106, right: 106),
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             RoundedElevatedButton(
//                                 _saveSubject,
//                                 "Save Subject",
//                                 Constants.lightThemePrimaryColor,
//                                 Colors.black,
//                                 45),
//                             RoundedElevatedButton(
//                                 _cancel,
//                                 "Cancel",
//                                 Constants.blueButtonBackgroundColor,
//                                 Colors.white,
//                                 45)
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               // ],
// //             ),
//           ),
//         );
//       },
//     );
    });
  }
}
