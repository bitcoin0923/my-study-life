import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Widgets/ProfileWidgets/collection_widget_four_items.dart';
import 'package:beamer/beamer.dart';
import '../Models/Services/storage_service.dart';
import 'dart:convert';

import '../../app.dart';
import '../Controllers/auth_notifier.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Profile_Screens/profile_screen.dart';
import '../Widgets/ProfileWidgets/edit_list.dart';
import '../Widgets/ProfileWidgets/personalization_list.dart';
import '../Widgets/ProfileWidgets/most_least_practiced_subject.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../../Models/profile_datasource.dart';
import '../../Profile_Screens/manage_subjects_screen.dart';
import '../../Profile_Screens/change_email_screen.dart';
import '../Profile_Screens/change_password_screen.dart';
import './general_settings_screen.dart';
import '../Models/user.model.dart';
import '../Models/API/task.dart';
import '../Profile_Screens/edit_profile_screen.dart';
import './reminder_notifications_screen.dart';
import './personalize_screen.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import '../Networking/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileItemStatic> _itemsPersonalize =
      ProfileItemStatic.personalizationItems;
  final List<ProfileItemStatic> _itemsEdit = ProfileItemStatic.editItems;
  final StorageService _storageService = StorageService();
  List<Task> _tasks = [];
  List<Task> _tasksTotal = [];
  List<Task> _tasksPast = [];

  String userName = '';
  String email = '';
  String imageUrl = '';
  UserModel? editedUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _getData();
    });
  }

  void _getData() async {
    var userString = await _storageService.readSecureData("activeUser");

    // Get Tasks from storage
    var tasksData = await _storageService.readSecureData("user_tasks");

    List<dynamic> decodedDataTasks = jsonDecode(tasksData ?? "");

    var taskDataCurrent =
        await _storageService.readSecureData("user_tasks_current");

    List<dynamic> decodedDataTasksCurrent = jsonDecode(taskDataCurrent ?? "");

    var taskDataOverdue =
        await _storageService.readSecureData("user_tasks_past");

    List<dynamic> decodedDataTasksOverdue = jsonDecode(taskDataOverdue ?? "");

    if (userString != null && userString.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(userString);

      var user = UserModel.fromJson(userMap);
      editedUser = user;
      setState(() {
        userName = "${user.firstName} ${user.lastName}";
        email = user.email ?? "";
        imageUrl = user.profileImageUrl?? "";

        _tasks = List<Task>.from(
          decodedDataTasks.map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
        _tasksTotal = List<Task>.from(
          decodedDataTasksCurrent
              .map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
        _tasksPast = List<Task>.from(
          decodedDataTasksOverdue
              .map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
      });
    }
  }

  void userUpdated() async {
   // LoadingDialog.show(context);

    try {
      var response = await UserService().getUser();
      print("user ${response.statusMessage}");

    // if (!context.mounted) return;

     // var userString = await _storageService.readSecureData("activeUser");
       var user = UserModel.fromJson(response.data['user']);

      editedUser = user;

     setState(() {
        userName = "${user.firstName} ${user.lastName}";
        email = user.email ?? "";
        imageUrl = user.profileImageUrl ?? "";
        Navigator.pop(context);

       // LoadingDialog.hide(context);
        // CustomSnackBar.show(context, CustomSnackBarType.success,
        //     response.data['message'], true);
     });
    } catch (error) {
      if (error is DioError) {
     //   LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
       // LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _selectedGridCard(int index) {
    print("Selected Grid card with Index: $index");
  }

  void _selectedPersonalizationCard(int index) {
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ManageSubjectsScreen(),
              fullscreenDialog: false));
    }
    if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PersonalizeScreen(),
              fullscreenDialog: false));
    }
    if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const GeneralSettingsScreen(),
              fullscreenDialog: false));
    }
    if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ReminderNotificationsScreen(),
              fullscreenDialog: false));
    }
  }

  void _selectedEditListCard(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeEmailScreen(editedUser),
            fullscreenDialog: true),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(),
            fullscreenDialog: true),
      );
    }
    print("Selected Personalization card with Index: $index");
  }

  void _logOutButtonTapped(WidgetRef ref) async {
    await ref.read(authProvider.notifier).logoutUser();

    final currentContext = scaffoldMessengerKey.currentContext!;

    if (!currentContext.mounted) return;

    Beamer.of(currentContext).update();

    print("Logout tapped");
  }

  void _deleteAccountButtonTapped() {
    print("Delete tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
          actions: [
            // Navigate to the Search Screen
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              editedUser: editedUser,
                              userUpdated: userUpdated,
                            ),
                        fullscreenDialog: true));
              },
              child: Text(
                'Edit',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeNavigationButtonStyle
                    : Constants.darkThemeNavigationButtonStyle,
              ),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: ListView.builder(
              // controller: widget._controller,
              itemCount: 11,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Container(
                      margin: const EdgeInsets.only(top: 21),
                      height: 146,
                      width: 146,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: theme == ThemeMode.light
                            ? Constants.lightThemeProfileImageCntainerColor
                            : Constants.darkThemeProfileImageCntainerColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 7,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeProfileImageCntainerColor
                                : Constants.darkThemeProfileImageCntainerColor),
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: NetworkImage(imageUrl),
                        ),
                      ),
                      // child: Container(
                      //   margin: EdgeInsets.all(4),
                      //   height: 142,
                      //   width: 142,
                      //   child: ClipRRect(
                      //     borderRadius:
                      //         BorderRadius.circular(71), // Image border
                      //     child: Image.network(
                      //       fit: BoxFit.fill,
                      //       imageUrl,
                      //       height: 142,
                      //       width: 143,
                      //     ),
                      //   ),
                      // ),
                    );
                  case 1:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 14),
                      child: Text(
                        userName,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeTextSelectionColor
                                : Colors.white),
                      ),
                    );
                  case 2:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(email,
                          style: theme == ThemeMode.light
                              ? Constants.socialLoginLightButtonTextStyle
                              : Constants.socialLoginDarkButtonTextStyle),
                    );
                  case 3:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 38),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          switch (i) {
                            case 0:
                              return CollectionWidgetFourItems(
                                title: "Pending Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Next 7 days",
                                numberFirst: _tasks.length,
                                isOverdue: false,
                                isPending: true,
                                numberSecond: 10,
                                isTasksOrStreak: false,
                              );
                            case 1:
                              return CollectionWidgetFourItems(
                                title: "Overdue Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Total",
                                numberFirst: _tasksPast.length,
                                isOverdue: true,
                                isPending: false,
                                isTasksOrStreak: false,
                              );
                            case 2:
                              return CollectionWidgetFourItems(
                                title: "Tasks Completed",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Last 7 days",
                                numberFirst: 9,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            case 3:
                              return CollectionWidgetFourItems(
                                title: "Your Streak",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Days with no tasks\ngoing late",
                                numberFirst: 9,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            default:
                          }
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 149,
                        ),
                      ),
                    );
                  case 4:
                    return MostLeastPracticedSubject(
                        cardIndex: 0,
                        cardselected: () => {},
                        mostPracticedSubject: "MATHS",
                        mostPracticedSubjectColor: Colors.blue,
                        mostPracticedSubjectTasksCount: 39,
                        leastPracticedSubject: "BIOLOGY",
                        leastPracticedSubjectColor: Colors.green,
                        leastPracticedSubjectTasksCount: 7);
                  case 5:
                    return Container(
                      margin: EdgeInsets.only(top: 33, bottom: 28),
                      child: Container(
                        height: 1,
                        color: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1),
                      ),
                    );
                  case 6:
                    return PersonalizationList(
                        _selectedPersonalizationCard, _itemsPersonalize);
                  case 7:
                    return Container(
                      margin: EdgeInsets.only(top: 33, bottom: 28),
                      child: Container(
                        height: 1,
                        color: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1),
                      ),
                    );
                  case 8:
                    return EditList(_selectedEditListCard, _itemsEdit);
                  case 9:
                    return Container(
                      alignment: Alignment.topCenter,
                      width: 142,
                      margin: const EdgeInsets.only(
                          top: 44, bottom: 57, left: 116, right: 116),
                      child: RoundedElevatedButton(
                          () => _logOutButtonTapped(ref),
                          "Log Out",
                          Constants.logOutButtonColor,
                          Colors.black,
                          34),
                    );
                  case 10:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.1)
                              : Colors.white.withOpacity(0.1),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          // width: 142,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: _deleteAccountButtonTapped,
                            child: Text(
                              "Delete Account",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                  color: Constants.overdueTextColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  default:
                }
              }),
        ),
      );
    });
  }
}
