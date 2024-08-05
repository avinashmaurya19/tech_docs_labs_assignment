import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:techdocks_assignment/controllers/task_controller.dart';
import 'package:techdocks_assignment/models/task_model.dart';
import 'package:techdocks_assignment/screens/home.dart';
import 'package:techdocks_assignment/widgets/custom_button.dart';
import 'package:techdocks_assignment/widgets/custom_textfield.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, this.id});
  final int? id;
  @override
  AddTaskState createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  late TextEditingController titleController = TextEditingController();
  late TextEditingController taskBodyController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  DateTime date = DateTime.now();
  final String _currentTime = DateFormat('hh:mm a').format(DateTime.now());
  int _defaultValue = 5;
  String _repeatMode = 'Never';
  Task? task;
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['never', 'Day', 'Week', 'Month'];
  int _colorIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    dateController.text = DateFormat.yMd().format(date);
    startTimeController.text = _currentTime;
    repeatController.text = _repeatMode;
    titleController.text = 'todo';
    remindController.text = '$_defaultValue Minutes';
    widget.id != null ? getTask() : super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.id == null ? 'Add Task' : 'Update Task',
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.off(() => const Home());
            },
            icon: Icon(Icons.arrow_back_ios,
                size: 20.0,
                color: Get.isDarkMode ? Colors.white : Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Color'),
                        Wrap(
                          children: List<Widget>.generate(8, (int index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _colorIndex = index;
                                  });
                                  print(_colorIndex);
                                },
                                child: CircleAvatar(
                                  radius: screenW * 0.032,
                                  backgroundColor: index == 0
                                      ? const Color(0xff648e9a)
                                      : index == 1
                                          ? const Color(0xFFFF80A6)
                                          : index == 2
                                              ? const Color(0xFF3699EC)
                                              : index == 3
                                                  ? const Color(0xff648e9a)
                                                  : index == 4
                                                      ? const Color(0xFFFFC04E)
                                                      : index == 5
                                                          ? const Color(
                                                              0xff8c0335)
                                                          : index == 6
                                                              ? const Color(
                                                                  0xff103b40)
                                                              : const Color(
                                                                  0xff191A19),
                                  child: index == _colorIndex
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20.0,
                                        )
                                      : const SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                    AppButton(
                        color: Colors.green,
                        label: widget.id == null ? 'Save' : 'Update',
                        onTap: () {
                          _submit();
                          Get.offAll(() => const Home());
                        })
                  ],
                ),
                CustomeTextField(
                  textValueController: titleController,
                  label: 'Title',
                  hint: 'Add Task Title',
                  suffixIcon: Container(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Title";
                    }
                    return null;
                  },
                ),
                CustomeTextField(
                  textValueController: taskBodyController,
                  maxLine: 5,
                  label: 'Content',
                  hint: 'Add Task content',
                  suffixIcon: Container(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Task to do";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: screenH * 0.08,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomeTextField(
                        textValueController: dateController,
                        label: 'Date',
                        hint: '$dateController',
                        suffixIcon: const Icon(
                        Icons.calendar_month,
                          color: Colors.green,
                        ),
                        onSuffixTap: () {
                          _getDate();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _getTime();
                        },
                        child: CustomeTextField(
                          isEditable: true,
                          textValueController: startTimeController,
                          label: 'Start time',
                          hint: '$_currentTime',
                          suffixIcon: const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomeTextField(
                        textValueController: remindController,
                        label: 'Remind me ',
                        hint: '$remindController',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _showMinutesList(),
                        ),
                        onSuffixTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: CustomeTextField(
                        textValueController: repeatController,
                        label: 'Repeat every ',
                        hint: '$repeatController',
                        onValidate: (value) {},
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _showRepeatList(),
                        ),
                        onSuffixTap: () {},
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

  _submit() {
    formKey.currentState!.save();
    widget.id == null ? _uploadTask() : _updateTask();
    _taskController.getTasks();
  }

  _updateTask() async {
    print('id ::: ${widget.id}');
    int value = await _taskController.updateTask(
        task: Task(
      id: task!.id,
      title: titleController.text,
      content: taskBodyController.text,
      date: dateController.text,
      startTime: startTimeController.text,
      remind: _defaultValue,
      repeat: repeatController.text,
      color: _colorIndex,
      isCompleted: 0,
    ));
    return value;
  }

  _uploadTask() async {
    print(_defaultValue);
    int value = await _taskController.addTask(
        task: Task(
      title: titleController.text,
      content: taskBodyController.text,
      date: dateController.text,
      startTime: startTimeController.text,
      remind: _defaultValue,
      repeat: repeatController.text,
      color: _colorIndex,
      isCompleted: 0,
    ));
    print(value);
  }

  getTask() async {
    task = await _taskController.getTask(widget.id!.toInt());
    setState(() {
      _colorIndex = task!.color!.toInt();
      titleController.text = task!.title.toString();
      taskBodyController.text = task!.content.toString();
      dateController.text = task!.date.toString();
      startTimeController.text = task!.startTime.toString();
      remindController.text = '${task!.remind} Minutes';
      repeatController.text = task!.repeat.toString();
    });
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (_pickerDate != null) {
      setState(() {
        date = _pickerDate;
        dateController.text = DateFormat.yMd().format(date);
      });
    }
  }

  _getTime() async {
    var selectedTime = await _showTimePicker();
    String timeFormat = await selectedTime.format(context);
    if (timeFormat.isEmpty) {
      print('error');
    } else {
      setState(() {
        startTimeController.text = timeFormat;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_currentTime.split(':')[0]),
        minute: int.parse(_currentTime.split(':')[0].split(' ')[0]),
      ),
    );
  }

  _showMinutesList() {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 18,
      ),
      underline: Container(),
      onChanged: (String? value) {
        setState(() {
          _defaultValue = int.parse(value!);
          remindController.text = '$_defaultValue Minutes';
        });
      },
      items: remindList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  _showRepeatList() {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 18,
      ),
      underline: Container(),
      onChanged: (String? value) {
        _repeatMode = value!;
        setState(() {
          repeatController.text = '$_repeatMode';
        });
      },
      items: repeatList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
