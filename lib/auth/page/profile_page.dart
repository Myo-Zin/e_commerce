import 'package:e_commerce/order/page/order_history_page.dart';
import 'package:e_commerce/util/app_color.dart';
import 'package:flutter/material.dart';

import '../../util/route.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    "User Name",
                    style: TextStyle(color: AppColor.whiteColor),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildItemCard("Address",Icons.location_pin,(){

            }),
            const SizedBox(
              height: 8,
            ),
            _buildItemCard("Order history",Icons.history,(){
                goto(context, page: const OrderHistoryPage());
            }),
            const SizedBox(
              height: 8,
            ),
            _buildItemCard("WishList",Icons.favorite_outline,(){

            }),
            const SizedBox(
              height: 8,
            ),
            _buildItemCard("Logout",Icons.logout,(){

            }),
          ],
        ),
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
