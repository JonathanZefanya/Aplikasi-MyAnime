import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Tunggu pengguna memilih akun
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // Jika pengguna memilih akun, lanjutkan proses login
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential result =
          await firebaseAuth.signInWithCredential(credential);

      User? userDetail = result.user;

      if (userDetail != null) {
        Get.find<ProfileController>().setUserDetails(
          userDetail.uid,
          userDetail.displayName ?? "",
          userDetail.email ?? "",
          userDetail.photoURL ?? "",
        );
      }
      Get.back();
      return result;
    }
    return null;
  }

  Future<void> signOut() async {
    // Sign out dari Firebase
    await firebaseAuth.signOut();

    // Sign out dari Google
    await googleSignIn.signOut();

    // Bersihkan data pengguna
    Get.find<ProfileController>().setUserDetails("", "", "", "");
  }
}
