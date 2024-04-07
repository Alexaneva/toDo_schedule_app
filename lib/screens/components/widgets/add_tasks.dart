import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/task_controller.dart';
import '../../../models/task.dart';
import '../fade_animation.dart';
import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30";
  String _startTime = DateFormat.Hm().format(DateTime.now()).toString();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "none";
  List<String> repeatList = ["none", "daily", "weekly", "monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: FadeAnimation(
        delay: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: blackStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                _enterTitle(),
                const SizedBox(height: 8),
                _enterTask(),
                const SizedBox(height: 8),
                _enterDate(),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Flexible(child: _enterStartTime()),
                    const SizedBox(width: 8),
                    Flexible(child: _enterEndTime()),
                  ],
                ),
                const SizedBox(height: 8),
                _makeRemind(),
                const SizedBox(height: 8),
                _makeRepeat(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _chooseColor(),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: MaterialButton(
                        onPressed: () {
                          _validateDate();
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
                              "Create Task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Caveat-Variable',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _enterTitle() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Title',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            autofocus: false,
            controller: _titleController,
            style: subGreyStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "  Enter your title",
            ),
          ),
        ),
      ),
    ]);
  }

  _enterTask() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Task',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            autofocus: false,
            controller: _noteController,
            style: subGreyStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "  Enter your task",
            ),
          ),
        ),
      ),
    ]);
  }

  _enterDate() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Date',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            readOnly: true,
            autofocus: false,
            style: subGreyStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "  ${DateFormat.yMd().format(_selectedDate)}",
                suffixIcon: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                )),
          ),
        ),
      ),
    ]);
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      if (kDebugMode) {
        print("It's null or something went wrong");
      }
    }
  }

  _enterStartTime() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Start time',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          readOnly: true,
          autofocus: false,
          style: subGreyStyle,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "  $_startTime",
              suffixIcon: IconButton(
                onPressed: () {
                  _getTimeFromUser(isStartTime: true);
                },
                icon: const Icon(Icons.access_time),
              )),
        ),
      ),
    ]);
  }

  _enterEndTime() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'End time',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            readOnly: true,
            autofocus: false,
            style: subGreyStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "  $_endTime",
                suffixIcon: IconButton(
                  onPressed: () {
                    _getTimeFromUser(isStartTime: false);
                  },
                  icon: const Icon(Icons.access_time),
                )),
          ),
        ),
      ),
    ]);
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTime();
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
    String formattedTime = DateFormat.Hm().format(selectedDateTime);
    if (pickedTime == null) {
      if (kDebugMode) {
        print('Canceled time');
      }
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formattedTime;
      });
    }
  }

  _showTime() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 5),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  _makeRemind() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Remind',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            readOnly: true,
            autofocus: false,
            style: subGreyStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "  $_selectedRemind minutes early",
              suffixIcon: DropdownButton(
                underline: Container(
                  height: 0,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subGreyStyle,
                items: remindList.map<DropdownMenuItem<String>>(
                  (int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _makeRepeat() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Repeat',
        style: subStyle,
      ),
      Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Expanded(
          child: TextFormField(
            readOnly: true,
            autofocus: false,
            style: subGreyStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "  $_selectedRepeat",
              suffixIcon: DropdownButton(
                underline: Container(
                  height: 0,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subGreyStyle,
                items: repeatList.map<DropdownMenuItem<String>>(
                  (String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _chooseColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: subStyle),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: index == 0
                      ? bluishClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.black87 : Colors.white,
        icon: const Icon(
          Icons.warning_amber,
          color: Colors.red,
        ),
        colorText: Colors.red,
      );
    }
  }

  _addTaskToDB() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    if (kDebugMode) {
      print("My id is $value");
    }
  }
}
