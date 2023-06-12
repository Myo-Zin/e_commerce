import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/category_controller.dart';
import '../../product/page/product_by_category_page.dart';
import '../../util/app_theme.dart';
import '../../util/route.dart';
import '../../widget/loading.dart';
import '../../widget/loading_dialog.dart';
import '../controller/product_category_controller.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(productCategoryController);
    return categoryState.when(
        data: (data) {
          final list = data;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text("Categories",style: AppTextStyle.titleTextStyle,),
                  const SizedBox(height: 8.0,),
                  SizedBox(
                    height: 95,
                    child: list.isEmpty? const Center(child: Text ("No category")): ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final category = list[index];
                          final image = category.image!;
                          return InkWell(
                            onTap: () {
                              goto(context,
                                  page: ProductByCategoryPage(
                                      category.id.toString(), category.name ?? ""));
                            },
                            child: SizedBox(
                              width: 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(image.src.toString()),
                                          //image: AssetImage(AssetString.logo),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0,),
                                  Text(category.name ?? "",style: const TextStyle(fontSize: 11),),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stack) => Text("$error"),
        loading: () => loading());
    // ref.listen<List<Category>>(slugIdStateProvider, (previous, next) async {
    //   print("click category ${next.first}");
    //   if (next == []) {
    //     return;
    //   }
    //
    //   ///close loading
    //   Navigator.pop(context);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => CategoryDetailScreen(next.first)));
    // });
    // return Card(
    //   child: Column(
    //     children: [
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       Row(
    //         children: [
    //           Expanded(
    //               child: _buildEachCategory("Bdsm",
    //                   () => gotoCategoryDetail(context, ref, "sex-accessory"))),
    //           Expanded(
    //               child: _buildEachCategory("နောက်ပေါက်",
    //                   () => gotoCategoryDetail(context, ref, "anal"))),
    //           Expanded(
    //               child: _buildEachCategory("ကွန်ဒုံ",
    //                   () => gotoCategoryDetail(context, ref, "condom"))),
    //           Expanded(
    //               child: _buildEachCategory("ကျားတု",
    //                   () => gotoCategoryDetail(context, ref, "Dildo"))),
    //           Expanded(
    //               child: _buildEachCategory("ချောဆီ",
    //                   () => gotoCategoryDetail(context, ref, "lubricant-gel"))),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       Row(
    //         children: [
    //           Expanded(
    //               child: _buildEachCategory(
    //                   "မတု",
    //                   () => gotoCategoryDetail(
    //                       context, ref, "masturbation-cup"))),
    //           Expanded(
    //               child: _buildEachCategory("ဆေး",
    //                   () => gotoCategoryDetail(context, ref, "medicines"))),
    //           Expanded(
    //               child: _buildEachCategory(
    //                   "ပြောင်း",
    //                   () => gotoCategoryDetail(
    //                       context, ref, "enlargement-pump "))),
    //           Expanded(
    //               child: _buildEachCategory("တုန်ခါစက်",
    //                   () => gotoCategoryDetail(context, ref, "vibrator"))),
    //           Expanded(
    //               child: _buildEachCategory("အားလုံး", () {
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const CategoryScreen()));
    //           })),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //     ],
    //   ),
    // );
  }

  void gotoCategoryDetail(BuildContext context, WidgetRef ref, String slug) {
    FocusManager.instance.primaryFocus?.unfocus();
    loadingDialog(context);
    ref.read(slugIdController).getSlugId(slug);
  }

  Widget _buildEachCategory(String name, Function() onTap) {
    return InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),
            )));
  }
}