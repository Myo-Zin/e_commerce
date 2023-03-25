import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/shared_preference_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

final firebaseController = ChangeNotifierProvider<FirebaseController>((ref) {
  return FirebaseController(ref);
});

final successOrFailController = StateProvider.autoDispose((ref) => false);
final successOrFailDeleteController = StateProvider.autoDispose((ref) => false);

class FirebaseController extends ChangeNotifier {
  FirebaseController(this.ref);

  Ref ref;

  Future<void> addUser(String name, String phone, String state, String city,
      String address) async {
    // Call the user's CollectionReference to add a new user
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      final userId = userCredential.user?.uid;
      FirebaseFirestore.instance.collection('users').doc("$userId").set({
        'full_name': name, // John Doe
        'phone': phone, // Stokes and Sons
        'state': state,
        "city": city,
        'address': address, // 42
      }).then((value) async {
        print("Successfully add user");
        await ref.read(sharedPreferencesProvider).setAuthState(value: true);
        await ref.read(sharedPreferencesProvider).setUserId(value: userId!);
        ref.read(successOrFailController.notifier).state = true;
      }).catchError((error) {
        print("Failed to add user: $error");
        ref.read(successOrFailController.notifier).state = false;
      });
    } on FirebaseAuthException catch (e) {
      ref.read(successOrFailController.notifier).state = false;
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    notifyListeners();
  }

  Future<void> updateUser(String name, String phone, String state, String city,
      String address) async {
    // Call the user's CollectionReference to add a new user
    try {
      final shareRef =  ref.read(sharedPreferencesProvider);
      final userId =await shareRef.getUserId();
      FirebaseFirestore.instance.collection('users').doc("$userId").update({
        'full_name': name, // John Doe
        'phone': phone, // Stokes and Sons
        'state': state,
        'city': city,
        'address': address, // 42
      }).then((value) async {
        print("Successfully update user");
       // await ref.read(sharedPreferencesProvider).setAuthState(value: true);
        //ref.refresh(sharedPreferencesProvider);
        //await ref.read(sharedPreferencesProvider).setUserId(value: userId!);
        ref.read(successOrFailController.notifier).state = true;
      }).catchError((error) {
        print("Failed to update user: $error");
        ref.read(successOrFailController.notifier).state = false;
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ref.read(successOrFailController.notifier).state = false;
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    notifyListeners();
  }

  Future<LoginUser> getUser() async {
    final userId = await ref.read(sharedPreferencesProvider).getUserId();
    print("user id $userId");
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    print('Document exists on the database');
    Map<String, dynamic>? data = docSnapshot.data();
    // notifyListeners();
    return LoginUser.fromDocumentSnapshot(data!);
  }

  Future<void> deleteProfile()  async {

    final shareRef =  ref.read(sharedPreferencesProvider);
    final userId =await shareRef.getUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete()
        .then((value) {
      ref.read(successOrFailDeleteController.notifier).state = true;
      ref.refresh(sharedPreferencesProvider).clear();
      FirebaseAuth.instance.signOut();
      print("Successfully delete");
    }).catchError((error) {
      ref.read(successOrFailDeleteController.notifier).state = false;
      print("Failed to delete user: $error");
    });
    await shareRef.clear();
    notifyListeners();

  }
// Future<void> init() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseFirestore.instance
//       .collection('attendees')
//       .where('attending', isEqualTo: true)
//       .snapshots()
//       .listen((snapshot) {
//     _attendees = snapshot.docs.length;
//     notifyListeners();
//   });
//
//   FirebaseAuth.instance.userChanges().listen((user) {
//     if (user != null) {
//       _loginState = ApplicationLoginState.loggedIn;
//       _guestBookSubscription = FirebaseFirestore.instance
//           .collection('guestbook')
//           .orderBy('timestamp', descending: true)
//           .snapshots()
//           .listen((snapshot) {
//         _guestBookMessages = [];
//         for (final document in snapshot.docs) {
//           _guestBookMessages.add(
//             GuestBookMessage(
//               name: document.data()['name'] as String,
//               message: document.data()['text'] as String,
//             ),
//           );
//         }
//         notifyListeners();
//       });
//       _attendingSubscription = FirebaseFirestore.instance
//           .collection('attendees')
//           .doc(user.uid)
//           .snapshots()
//           .listen((snapshot) {
//         if (snapshot.data() != null) {
//           if (snapshot.data()!['attending'] as bool) {
//             _attending = Attending.yes;
//           } else {
//             _attending = Attending.no;
//           }
//         } else {
//           _attending = Attending.unknown;
//         }
//         notifyListeners();
//       });
//     } else {
//       _loginState = ApplicationLoginState.loggedOut;
//       _guestBookMessages = [];
//       _guestBookSubscription?.cancel();
//       _attendingSubscription?.cancel();
//     }
//     notifyListeners();
//   });
// }

// ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
// ApplicationLoginState get loginState => _loginState;
//
// String? _email;
// String? get email => _email;
//
// StreamSubscription<QuerySnapshot>? _guestBookSubscription;
// List<GuestBookMessage> _guestBookMessages = [];
// List<GuestBookMessage> get guestBookMessages => _guestBookMessages;
//
// int _attendees = 0;
// int get attendees => _attendees;
//
// Attending _attending = Attending.unknown;
// StreamSubscription<DocumentSnapshot>? _attendingSubscription;
// Attending get attending => _attending;
// set attending(Attending attending) {
//   final userDoc = FirebaseFirestore.instance
//       .collection('attendees')
//       .doc(FirebaseAuth.instance.currentUser!.uid);
//   if (attending == Attending.yes) {
//     userDoc.set(<String, dynamic>{'attending': true});
//   } else {
//     userDoc.set(<String, dynamic>{'attending': false});
//   }
// }
//
// void startLoginFlow() {
//   _loginState = ApplicationLoginState.emailAddress;
//   notifyListeners();
// }
//
// Future<void> verifyEmail(
//     String email,
//     void Function(FirebaseAuthException e) errorCallback,
//     ) async {
//   try {
//     var methods =
//     await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
//     if (methods.contains('password')) {
//       _loginState = ApplicationLoginState.password;
//     } else {
//       _loginState = ApplicationLoginState.register;
//     }
//     _email = email;
//     notifyListeners();
//   } on FirebaseAuthException catch (e) {
//     errorCallback(e);
//   }
// }
//
// Future<void> signInWithEmailAndPassword(
//     String email,
//     String password,
//     void Function(FirebaseAuthException e) errorCallback,
//     ) async {
//   try {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   } on FirebaseAuthException catch (e) {
//     errorCallback(e);
//   }
// }
//
// void cancelRegistration() {
//   _loginState = ApplicationLoginState.emailAddress;
//   notifyListeners();
// }
//
// Future<void> registerAccount(
//     String email,
//     String displayName,
//     String password,
//     void Function(FirebaseAuthException e) errorCallback) async {
//   try {
//     var credential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     await credential.user!.updateDisplayName(displayName);
//   } on FirebaseAuthException catch (e) {
//     errorCallback(e);
//   }
// }
//
// void signOut() {
//   FirebaseAuth.instance.signOut();
// }
//
// Future<DocumentReference> addMessageToGuestBook(String message) {
//   if (_loginState != ApplicationLoginState.loggedIn) {
//     throw Exception('Must be logged in');
//   }
//
//   return FirebaseFirestore.instance
//       .collection('guestbook')
//       .add(<String, dynamic>{
//     'text': message,
//     'timestamp': DateTime.now().millisecondsSinceEpoch,
//     'name': FirebaseAuth.instance.currentUser!.displayName,
//     'userId': FirebaseAuth.instance.currentUser!.uid,
//   });
// }
}
