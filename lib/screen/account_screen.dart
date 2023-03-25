import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restart_app/restart_app.dart';

import '../controller/check_is_login_controller.dart';
import '../controller/firebase_controller.dart';
import '../model/user.dart';
import '../widget/loading.dart';
import '../widget/loading_dialog.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartUpProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
        ),
        body: state == AuthState.authenticated? const ProfileScreen() : const RegisterScreen("", null),
    );
  }
}

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen(this.from, this.loginUser, {Key? key}) : super(key: key);
  final String from;
  final LoginUser? loginUser;

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

late TextEditingController nameTextEditingController;
late TextEditingController phoneTextEditingController;
late TextEditingController stateTextEditingController;
late TextEditingController cityTextEditingController;
late TextEditingController addressTextEditingController;
class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    String name = widget.loginUser?.name ?? "";
    String phone = widget.loginUser?.phone ?? "";
    String state = widget.loginUser?.state ?? "";
    String city = widget.loginUser?.city ?? "";
    String address = widget.loginUser?.address ?? "";
     nameTextEditingController = TextEditingController(text: name);
     phoneTextEditingController = TextEditingController(text: phone);
     stateTextEditingController = TextEditingController(text: state);
     cityTextEditingController = TextEditingController(text: city);
     addressTextEditingController = TextEditingController(text: address);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    final formKey = GlobalKey<FormState>();
    ref.listen<bool>(successOrFailController, (prev, next) {
      if (next) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Success')));
       // if (widget.from == "create")
        Navigator.pop(context);
        Phoenix.rebirth(context);

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Fail')));
        Navigator.pop(context);
      }
    });
    return
      Scaffold(
      appBar: widget.from.isEmpty
          ? widget.loginUser == null
              ? null
              : AppBar(
                  title: const Text("Edit Profile"),
                )
          : AppBar(
              title: const Text("Create Profile"),
            ),
      body:
    SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Center(
                      child: Container(
                        width: 130.0,
                        height: 130.0,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 8, color: Colors.grey),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.person_outline,
                          size: 80,
                          color: Colors.grey,
                        )),
                      ),
                    )),
                // const SizedBox(height: 40.0,),
                TextFormField(
                  //initialValue: "hht",
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "eg; U Aung Aung",
                    labelText: 'Name *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),

                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    } else if (value.length < 4) {
                      return 'Name must be 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  // initialValue: "",
                  controller: phoneTextEditingController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number *',
                    hintText: "eg; 09223335566",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 11) {
                      return 'Please enter correct phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  //initialValue: "",
                  controller: stateTextEditingController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "eg; စစ်ကိုင်း",
                      labelText: 'Region *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12.0)),

                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter region name';
                    } else if (value.length < 4) {
                      return 'Region must be 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  //initialValue: "",
                  controller: cityTextEditingController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "eg; မုံရွှာ",
                      labelText: 'City *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12.0)),

                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state name';
                    } else if (value.length < 4) {
                      return 'City must be 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  //initialValue: address,
                  controller: addressTextEditingController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "eg;ကျိုက်လက်လမ်း၊ စမ်းချောင်းမြို့နယ်",
                      labelText: 'Address *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0)),

                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    } else if (value.length < 4) {
                      return 'Address must be 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // background
                      // primary: Theme.of(context).colorScheme.secondary,
                      // onPrimary: Colors.white, // foreground
                      minimumSize: const Size.fromHeight(60),
                      //  maximumSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loadingDialog(context);
                        widget.loginUser == null
                            ? ref.read(firebaseController.notifier).addUser(
                                  nameTextEditingController.text,
                                  phoneTextEditingController.text,
                                  stateTextEditingController.text,
                                  cityTextEditingController.text,
                                  addressTextEditingController.text,
                                )
                            : ref.read(firebaseController.notifier).updateUser(
                                  nameTextEditingController.text,
                                  phoneTextEditingController.text,
                                  stateTextEditingController.text,
                                  cityTextEditingController.text,
                                  addressTextEditingController.text,
                                );
                      }
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('')),
                      // );
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ));
    //);
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(firebaseController);
    ref.listen<bool>(successOrFailDeleteController, (prev, next) {
      if (next) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Success')));
        Navigator.pop(context);
        Phoenix.rebirth(context);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Fail')));
      }
    });
    return FutureBuilder(
        future: controller.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              print("Snapshot ${snapshot.data}");
              final user = snapshot.data as LoginUser;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    buildContainer(context, "Name", user.name),
                    const SizedBox(
                      height: 2,
                    ),
                    buildContainer(context, "Phone", user.phone),
                    const SizedBox(
                      height: 2,
                    ),
                    buildContainer(context, "Sate", user.state),
                    const SizedBox(
                      height: 2,
                    ),
                    buildContainer(context, "City", user.city),
                    const SizedBox(
                      height: 2,
                    ),
                    buildContainer(context, "Address", user.address),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen("", user)));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          color: Colors.white,
                          child: const Center(child: Text("Edit"))),
                    ),
                    InkWell(
                      onTap: () async {
                        loadingDialog(context);
                        await ref.watch(firebaseController).deleteProfile();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          color: Colors.white,
                          child: const Center(
                              child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ))),
                    )
                  ],
                ),
              );
            }
          }
          return loading();
        });
  }

  Container buildContainer(BuildContext context, String title, String? label) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(
            width: 16.0,
          ),
          Expanded(child: Text(title)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              label ?? "",
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
        ],
      ),
    );
  }
}
