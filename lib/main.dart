import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/bodyScreens/Home/homeScreen.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/repo/repository.dart';
import 'package:todo/data/source/hive_task_source.dart';

const taskBoxName = 'tasks';
const Color primaryColor = Color(0xff794CFF);
const Color primaryContainer = Color(0xff5C0AFF);
const EdgeInsets marginScreen = EdgeInsets.fromLTRB(18, 10, 18, 10);
const Color primaryTextColor = Color(0xff1D2830);
const Color secodaryTextColor = Color(0xffAFBED0);
const Color normalPeriority = Color(0xffD4AF37);
const Color lowPeriority = Color(0xff3BE1F1);

// ===========================================================================================================================================

// final box = Hive.box<TaskEntity>(taskBoxName);

//=============================================================================================================================================

void main() async {
// waite for init
  await Hive.initFlutter();
  // // register first Adapter
  Hive.registerAdapter(TaskAdapter());
  // // Register secound Adapter
  Hive.registerAdapter(PriorityAdapter());
  // reginster ..n Adapter
  // wait run app then open box
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryContainer,
      statusBarIconBrightness: Brightness.light));
  // we use just Repository to access Info
  //  just one
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (BuildContext context) =>
          Repository<TaskEntity>(HivetaskDataSource(Hive.box(taskBoxName))),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: secodaryTextColor, fontSize: 12),
              border: InputBorder.none,
              iconColor: secodaryTextColor),
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              primaryContainer: primaryContainer,
              background: Color(0xffF3F5F8),
              onBackground: primaryTextColor,
              onSurface: primaryColor,
              secondary: primaryColor,
              onSecondary: Colors.white),
          textTheme: const TextTheme(
            titleLarge:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          )),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
