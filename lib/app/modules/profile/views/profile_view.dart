import 'package:flutter/material.dart';
import 'package:myanime/app/modules/login/controllers/login_controller.dart';
import 'package:myanime/app/modules/widgets/nointernet_widget.dart';
import 'package:myanime/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Obx(
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/banner.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () =>
                                Navigator.of(context).pushNamed(Routes.LOGIN),
                            child: Text(
                              (ProfileController.userName.value == "")
                                  ? "Login"
                                  : controller.cutString(
                                      ProfileController.userName.value),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            (ProfileController.userName.value == "")
                                ? "***********"
                                : ProfileController.userName.value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            (ProfileController.userEmail.value == "")
                                ? "***********"
                                : ProfileController.userEmail.value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.FAVORITE),
                          child: (ProfileController.userName.value == "")
                              ? Container()
                              : const Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.bookmark,
                                        size: 30,
                                      ),
                                      title: Text(
                                        "Favorite's Anime",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.navigate_next_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                        ),
                        
                        (ProfileController.userName.value == "")
                            ? Container()
                            : Column(
                                children: [
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceAround,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            content: const Text(
                                              textAlign: TextAlign.center,
                                              "Apakah Anda yakin untuk keluar?",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  "Batal",
                                                  style: TextStyle(
                                                    color: (controller
                                                            .isDark.value)
                                                        ? Colors.grey[400]
                                                        : Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  loginController.signOut();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "Logout",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const ListTile(
                                      leading: Icon(
                                        Icons.logout,
                                        size: 30,
                                      ),
                                      title: Text(
                                        "Logout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.navigate_next_outlined,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                        ListTile(
                          leading: const Icon(
                            Icons.dark_mode,
                            size: 30,
                          ),
                          title: const Text(
                            "Dark Mode",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Obx(
                            () => Switch(
                              value: controller.isDark.value,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.grey[700],
                              inactiveTrackColor: Colors.white,
                              inactiveThumbColor: Colors.grey[700],
                              onChanged: (value) async {
                                controller.darkMode(value);
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("darkmode", value);
                              },
                            ),
                          ),
                        ),
                        const Divider(),
                        const Text(
                          "Developer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Nama : Jonathan Natannael Zefanya",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "NIM : 1152200024",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Versi Aplikasi : 1.0.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.28 - 65,
                      left: MediaQuery.of(context).size.width / 2 - 62.5,
                      child: Obx(
                        () => Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            image: (ProfileController.userImage.value == "")
                                ? const DecorationImage(
                                    image: AssetImage(
                                      "assets/profilePicture.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      ProfileController.userImage.value,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            border: Border.all(
                              color: (controller.isDark.value)
                                  ? const Color.fromRGBO(18, 18, 18, 1)
                                  : Colors.white,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
