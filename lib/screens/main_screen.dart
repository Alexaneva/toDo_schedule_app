import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/task_controller.dart';
import '../models/task.dart';
import '../services/ notification_service.dart';
import '../services/theme_change.dart';
import 'components/fade_animation.dart';
import 'components/task_tile.dart';
import 'components/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'components/widgets/add_tasks.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotificationService();
    notifyHelper.initNotification();
    notifyHelper.requestAndroidPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FadeAnimation(
        delay: 3,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(DateTime.now()),
                            style: greyStyle),
                        Text('Today', style: pinkStyle)
                      ]),
                ),
                _addTask(),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: DatePicker(
                DateTime.now(),
                height: 90,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: primaryClr,
                dateTextStyle: GoogleFonts.alikeAngular(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                dayTextStyle: GoogleFonts.alikeAngular(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                monthTextStyle: GoogleFonts.alikeAngular(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _addTask() {
    return MaterialButton(
      onPressed: () async {
        await Get.to(const AddTaskPage());
        _taskController.getTasks();
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: pinkClr,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(children: [
          SizedBox(height: 10),
          Text(
            "Add Task",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Caveat-Variable',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ]),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeChange().switchTheme();
          notifyHelper.showNotification(
              title: "Theme changed",
              body: Get.isDarkMode
                  ? "Activated light Theme"
                  : "Activated Dark mode");
         //  notifyHelper.scheduledNotification();
        },
        child: const Icon(Icons.light_mode_rounded),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            if (task.repeat == "daily") {
              DateTime date = DateFormat.Hm().parse(task.startTime.toString());
              var myTime = DateFormat.Hm().format(date);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task
              );
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: ((context) {
                        _taskController.delete(task);
                      }),
                      backgroundColor:
                          Get.isDarkMode ? Colors.black12 : Colors.white,
                      icon: Icons.delete_rounded,
                    ),
                    SlidableAction(
                      onPressed: ((context) {
                        _taskController.taskCompleted(task.id!);
                      }),
                      backgroundColor:
                          Get.isDarkMode ? Colors.black12 : Colors.white,
                      icon: task.isCompleted == 1
                          ? Icons.file_download_done_sharp
                          : Icons.done_all_sharp,
                    ),
                  ],
                ),
                child: TaskTile(task),
              );
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              DateTime date = DateFormat.Hm().parse(task.startTime.toString());
              var myTime = DateFormat.Hm().format(date);
              notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task
              );
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: ((context) {
                        _taskController.delete(task);
                      }),
                      backgroundColor:
                          Get.isDarkMode ? Colors.black12 : Colors.white,
                      icon: Icons.delete_rounded,
                    ),
                    SlidableAction(
                      onPressed: ((context) {
                        _taskController.taskCompleted(task.id!);
                      }),
                      backgroundColor:
                          Get.isDarkMode ? Colors.black12 : Colors.white,
                      icon: task.isCompleted == 1
                          ? Icons.file_download_done_sharp
                          : Icons.done_all_sharp,
                    ),
                  ],
                ),
                child: TaskTile(task),
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }
}
