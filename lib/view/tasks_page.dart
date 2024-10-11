import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/notification_controller.dart';
import 'package:rootics_final/controller/task_controller.dart';
import 'package:rootics_final/models/task_model.dart';
import 'package:rootics_final/theme/app_colors.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});
  TaskController taskController = Get.put(TaskController());
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "قائمة المهام",
              style: TextStyle(color: AppColors().lightGreen),
            ),
            leading: BackButton(
              color: AppColors().lightGreen,
            ),
            backgroundColor: AppColors().darkGreen,
          ),
          body: Container(
            color: AppColors().darkGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (taskController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (taskController.taskList.isEmpty) {
                    return Center(
                      child: Text("No suggested plants available."),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: taskController.taskList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: ValueKey(taskController.taskList[index]),
                                onDismissed: (direction) {
                                  notificationController.deleteNotification(
                                      taskController.taskList[index].plant
                                          .plantDetails.plantId);
                                  taskController.deleteTask(
                                      id: taskController.taskList[index].id);
                                },
                                background: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Colors.red,
                                  ),
                                  child: const Icon(Icons.delete),
                                ),
                                child: TaskItem(
                                    myTaskList: taskController.taskList,
                                    index: index, notificationController: notificationController,),
                              );
                            }));
                  }
                })
              ],
            ),
          )),
    );
  }
}

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.myTaskList, required this.index, required this.notificationController});
  final List<TaskModel> myTaskList;
  final NotificationController notificationController;
  final int index;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checkState = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: AppColors().lightGreen,
            borderRadius: const BorderRadius.all(Radius.circular(17))),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 3, left: 8, right: 8, top: 8),
              child: Container(
                decoration: const BoxDecoration(
                    border: BorderDirectional(bottom: BorderSide())),
                child: Row(
                  children: [
                    CachedNetworkImage(
                        imageUrl: widget
                            .myTaskList[widget.index].plant.plantDetails.image
                            .toString(),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(17)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      widget.myTaskList[widget.index].plant.plantDetails.name,
                      style:
                          TextStyle(fontSize: 20, color: AppColors().darkGreen),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(widget.myTaskList[widget.index].description),
                subtitle:
                    Text("كل ${widget.myTaskList[widget.index].taskTime} ايام"),
                leading: Checkbox(
                  focusColor: AppColors().darkGreen,
                  activeColor: AppColors().darkGreen,
                  value: checkState,
                  onChanged: (newValue) {
                    widget.notificationController.deleteNotification(widget
                        .myTaskList[widget.index].plant.plantDetails.plantId);
                    setState(() {
                      checkState = newValue!;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
