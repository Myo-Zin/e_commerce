import 'package:e_commerce/auth/page/login_page.dart';
import 'package:e_commerce/auth/page/register_page.dart';
import 'package:e_commerce/order/page/order_history_page.dart';
import 'package:e_commerce/profile/model/profile_data_response.dart';
import 'package:e_commerce/util/app_color.dart';
import 'package:e_commerce/widget/loading.dart';
import 'package:e_commerce/widget/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';

import '../../util/route.dart';
import '../../widget/error_widget.dart';
import '../controller/providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileController);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: state.map(
            loading: (_) => loading(),
            data: (data) => ProfileWidget(data.profileData),
            unAuthenticated: (u) => const LoginPage(),
            error: (error) {
              return Center(
                  child: AppErrorWidget(
                error: error.message,
                onRetry: () {
                  ref.refresh(profileController);
                },
              ));
            }));
  }
}

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget(this.profileData, {Key? key}) : super(key: key);
  final WooCustomer profileData;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: AppColor.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.whiteColor,
                  maxRadius: 50,
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  profileData.username ?? "",
                  style: TextStyle(color: AppColor.whiteColor),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          _buildItemCard("Address", Icons.location_pin, () {}),
          const SizedBox(
            height: 8,
          ),
          _buildItemCard("Order history", Icons.history, () {
            goto(context, page:  OrderHistoryPage(int.parse(profileData.id.toString())));
          }),
          const SizedBox(
            height: 8,
          ),
          _buildItemCard("WishList", Icons.favorite_outline, () {}),
          const SizedBox(
            height: 8,
          ),
          _buildItemCard("Logout", Icons.logout, () {
            logoutDialog(context, ref);
          }),
        ],
      ),
    );
  }

  Widget _buildItemCard(String title, IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Text(title)),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
