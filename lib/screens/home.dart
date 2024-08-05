import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techdocks_assignment/controllers/task_controller.dart';
import 'package:techdocks_assignment/models/task_model.dart';
import 'package:techdocks_assignment/screens/add_tasks.dart';
import 'package:techdocks_assignment/screens/display_task.dart';
import 'package:techdocks_assignment/services/dark_theme_service.dart';
import 'package:techdocks_assignment/services/notification_service.dart';
import 'package:techdocks_assignment/widgets/custom_button.dart';
import 'package:techdocks_assignment/widgets/task_card_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TaskController _taskController = Get.put(TaskController());

  late NotificationService notificationService = NotificationService();

  DateTime scheduleTime = DateTime.now();

  @override
  void initState() {
    notificationService = NotificationService();
    notificationService.initNotification();

    _taskController.getTasks();
    super.initState();
  }

  // void scheduleTaskNotifications(List<Task> tasks) {
  //   for (var task in tasks) {
  //     if (task.isCompleted != 1 &&
  //         dateFormat.parse(task.date!).isAfter(DateTime.now())) {
  //       final notificationTime = dateFormat
  //           .parse(task.date!)
  //           .subtract(Duration(minutes: task.remind ?? 0));
  //       log(notificationTime.toString());
  //       notificationService.scheduleNotification(
  //         id: task.id.hashCode,
  //         title: 'Task Reminder',
  //         body: 'Your task "${task.title}" is due in ${task.remind} minutes.',
  //         scheduledTime: notificationTime,
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                ThemeService().switchTheme();
              },
              icon: Get.isDarkMode
                  ? const Icon(Icons.lightbulb, size: 20.0, color: Colors.white)
                  : const Icon(Icons.lightbulb,
                      size: 20.0, color: Colors.black)),
          actions: [
            ElevatedButton(
                onPressed: () {
                  notificationService.showNotification(
                      id: 0,
                      title: 'Task r',
                      body: 'You have a task to complete',
                      payLoad: 'payload');
                },
                child: const Text("notification")),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(
                      DateTime.now(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AddTask());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: const Text(
                        "Add Task",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const Text('Today'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: DatePicker(
                  DateTime.now(),
                  height: screenH * 0.127,
                  width: screenW * 0.18,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    setState(() {
                      scheduleTime = date;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Expanded(
                    child: GridView.builder(
                        itemCount: _taskController.tasksList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 200,
                          crossAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          Task task = _taskController.tasksList[index];

                          log(task.startTime.toString());
                          DateTime time = DateFormat("hh:mm")
                              .parse(task.startTime.toString());

                          var myTime = DateFormat("HH:mm").format(time);

                          notificationService.scheduleNotification(
                            scheduledNotificationDateTime: time,
                            hour: int.parse(myTime.toString().split(":")[0]),
                            minute:
                                int.parse(myTime.toString().split(":")[1]) - 5,
                            task: task,
                          );

                          return GestureDetector(
                            onLongPress: () {
                              Get.bottomSheet(Container(
                                height: 100,
                                color: Get.isDarkMode
                                    ? const Color(0xff1f1f21)
                                    : Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(3.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade600,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          task.isCompleted == 1
                                              ? const SizedBox()
                                              : Expanded(
                                                  child: AppButton(
                                                      height: 50,
                                                      color: Colors.green,
                                                      label: 'Completed',
                                                      onTap: () {
                                                        _taskController
                                                            .updateTaskStatus(
                                                                task.id!);
                                                        Get.back();
                                                      }),
                                                ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: AppButton(
                                                height: 50,
                                                color: Colors.red,
                                                label: 'Delete',
                                                onTap: () {
                                                  _taskController
                                                      .deleteTask(task);
                                                  Get.back();
                                                }),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                            },
                            onTap: () {
                              Get.to(() => DisplayTask(
                                    id: int.parse(task.id.toString()),
                                  ));
                            },
                            child: TaskCardWidget(
                              task: _taskController.tasksList[index],
                              index: index,
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ));
  }
}
