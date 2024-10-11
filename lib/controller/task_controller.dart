import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/task_model.dart';
import 'package:rootics_final/services/api_service.dart';

class TaskController extends GetxController {
  var isLoading = true.obs;
  var isProssing = false.obs;
  var taskList = <TaskModel>[].obs;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController notifyController = TextEditingController();

  @override
  void onInit() {
    fetchAllTasks();
    super.onInit();
  }

  void fetchAllTasks() async {
    try {
      isLoading(true);
      var plants = await ApiService.getAllTasks();

      if (plants != null) {
        taskList.assignAll(plants);
      }
    } finally {
      isLoading(false);
    }
  }

  void addTask({
    required int id,
    required String task,
    required int taskTime,
  }) {
    try {
      isProssing(true);
      ApiService.postTask(id: id, task: task, taskTime: taskTime)
          .then((response) {
        if (response == 200) {
          descriptionController.clear();
          notifyController.clear();
          isProssing(false);

          Get.snackbar("Add Task", "task added succesfuly");
        } else {
          Get.snackbar("Add Task", "faild to add task");
        }
      });
    } catch (e) {
      isProssing(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void deleteTask({required int id,}) {
    try {
      isProssing(true);
      ApiService.deleteTask(id: id).then((response) {
        isProssing(false);
        if (response == 200) {
          Get.snackbar("Delete Task", "task deleted succesfuly");
        } else {
          Get.snackbar("Delete Task", "faild to delete task");
        }
      });
      
    } catch (e) {
      isProssing(false);
      Get.snackbar("Error", e.toString());
    }
    }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    descriptionController.dispose();
    notifyController.dispose();
  }
}
