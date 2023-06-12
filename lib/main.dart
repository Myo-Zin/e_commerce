import 'package:e_commerce/auth/page/login_page.dart';
import 'package:e_commerce/category/page/category_page.dart';
import 'package:e_commerce/home/page/home_page.dart';
import 'package:e_commerce/profile/page/profile_page.dart';
import 'package:e_commerce/cart/page/cart_page.dart';
import 'package:e_commerce/util/app_color.dart';
import 'package:e_commerce/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'auth/controller/auth_controller.dart';
import 'controller/cart_controller_provider.dart';
import 'auth/page/register_page.dart';
import 'data/local/data_model.dart';
import 'data/local/database_service.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.primaryColor));
  await Hive.initFlutter();
  Hive.registerAdapter<DataModel>(DataModelAdapter());
  Hive.registerAdapter<LocalImage>(LocalImageAdapter());
  final _databaseService = DatabaseService();
  await _databaseService.initTheme();
  // await Hive.openBox<DataModel>(cartBoxName);

  WidgetsFlutterBinding.ensureInitialized();


  runApp(ProviderScope(
      overrides: [databaseService.overrideWithValue(_databaseService)],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _selectedItemIndex = 0;
  final screens = [
    const HomePage(),
    const CategoryPage(),
    const CartScreen(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(authControllerProvider.notifier).getAuth();
    });
    initialize();
  }

  void initialize() async {
    /// here we will add a wait second to move on next scree
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
  //  final cartBox = ref.watch(cartControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: IndexedStack(
        index: _selectedItemIndex,
        children: screens,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _selectedItemIndex,
        // selectedItemColor: Colors.white,
        // showUnselectedLabels: true,
        // unselectedItemColor: Colors.white60,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.deepPurple,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            // icon: cartBox.isNotEmpty
            //     ? Badge(
            //         label: Text("${cartBox.length}"),
            //         backgroundColor: Colors.white,
            //         child: const Icon(Icons.shopping_cart))
               // :
            icon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTap);
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
}
