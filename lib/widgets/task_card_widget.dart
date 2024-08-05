import 'package:flutter/material.dart';
import 'package:techdocks_assignment/controllers/task_controller.dart';
import 'package:techdocks_assignment/models/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
    required this.index,
  });

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    List colors = [
      0xff648e9a,
      0xFFFF80A6,
      0xFF3699EC,
      0xff648e9a,
      0xFFFFC04E,
      0xff8c0335,
      0xff103b40,
      0xff191A19
    ];

    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Color(colors[int.parse(task.color.toString())]),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      task.isCompleted == 1 ? "COMPLETED" : "TODO",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: screenH * 0.005),
                Text(
                  task.content ?? "",
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey[200],
                  size: 18,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: screenH * 0.02,
                  width: screenW * 0.12,
                  child: Text(
                    "${task.startTime}",
                    style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenW * 0.01),
                  height: 10,
                  width: 1.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                Icon(
                  Icons.update,
                  color: Colors.grey[200],
                  size: 18,
                ),
                Container(
                  alignment: Alignment.center,
                  height: screenH * 0.02,
                  width: screenW * 0.12,
                  child: Text(
                    " ${task.repeat}",
                    style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
