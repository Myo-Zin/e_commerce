import 'package:e_commerce/screen/account_screen.dart';
import 'package:e_commerce/screen/cart_screen.dart';
import 'package:e_commerce/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'controller/cart_controller_provider.dart';
import 'data/local/data_model.dart';
import 'data/local/database_service.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFF1744)
  ));
  await Hive.initFlutter();
  Hive.registerAdapter<DataModel>(DataModelAdapter());
  Hive.registerAdapter<LocalImage>(LocalImageAdapter());
  final _databaseService = DatabaseService();
  await _databaseService.initTheme();
  // await Hive.openBox<DataModel>(cartBoxName);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp( Phoenix(child: ProviderScope(overrides: [databaseService.overrideWithValue(_databaseService)],child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.redAccent.shade400 ,
            secondary: const Color(0xFFf73838), // Your accent color
          ),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState <MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  int _selectedItemIndex = 0;
  final screens =  [
    HomeScreen(),
    const CartScreen(),
    const AccountScreen(),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() async {
    /// here we will add a wait second to move on next scree
    await Future.delayed (const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final cartBox = ref.watch(cartControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: IndexedStack(
        index: _selectedItemIndex,
        children: screens,
      ),
      bottomNavigationBar: _bottomNavigationBar(cartBox),
    );
  }

  Widget _bottomNavigationBar(List<DataModel> cartBox ) {
    return BottomNavigationBar(
        currentIndex: _selectedItemIndex,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white60,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: cartBox.isNotEmpty? Badge(
                label: Text("${cartBox.length}"),
                backgroundColor: Colors.white,
                child: const Icon(Icons.shopping_cart)):
            const Icon( Icons.shopping_cart),
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
