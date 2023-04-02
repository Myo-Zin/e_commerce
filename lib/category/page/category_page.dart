import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/app_theme.dart';
import '../../widget/loading.dart';
import '../controller/product_category_controller.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(productCategoryController);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        centerTitle: true,
      ),
      body: categoryState.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      category.image!.src.toString()),
                                  //image: AssetImage(AssetString.logo),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(category.name ?? ""),
                        ],
                      ),
                    ),
                  );
                });
          },
          error: (error, stack) => Text("$error"),
          loading: () => loading()),
    );
  }

// void gotoCategoryDetail(BuildContext context, WidgetRef ref, String slug) {
//   FocusManager.instance.primaryFocus?.unfocus();
//   loadingDialog(context);
//   ref.read(slugIdController).getSlugId(slug);
// }

// Widget _buildEachCategory(String name, Function() onTap) {
//   return InkWell(
//       onTap: onTap,
//       child: Center(
//           child: Text(
//             name,
//             style: const TextStyle(
//                 fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),
//           )));
// }
}
