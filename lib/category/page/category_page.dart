import 'package:e_commerce/product/page/product_by_category_page.dart';
import 'package:e_commerce/util/route.dart';
import 'package:e_commerce/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            final list = data;
            return list.isEmpty
                ? const Center(child: Text("No category"))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final category = list[index];
                      return Card(
                        child: InkWell(
                          onTap: () {
                            goto(context,
                                page: ProductByCategoryPage(
                                    category.id.toString(), category.name ?? ""));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
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
                        ),
                      );
                    });
          },
          error: (error, stack) => AppErrorWidget(
              error: error,
              onRetry: () => ref.refresh(productCategoryController)),
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
