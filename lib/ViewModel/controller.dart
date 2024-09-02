import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx/Model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskViewModel extends GetxController
{
final TextEditingController controllerer=TextEditingController();
  final RxList<Task> tasks=<Task>[].obs;
  int currentPriority=0;
  void loadTask()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList('tasks');
    if(taskList!=null){
      tasks.assignAll(taskList.map((jsonString) =>Task.fromJson(jsonDecode(jsonString))));
    }
  }

  void saveTasks()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String,dynamic>> taskList=tasks.map((task) => task.toJson()).toList();
    prefs.setStringList('tasks', taskList.map((json) => jsonEncode(json)).toList());
  }
void addTask({required String taskTitle}){
  currentPriority++;
    if(taskTitle.isNotEmpty){
      tasks.add(Task(title: taskTitle,priority: currentPriority));
      controllerer.clear();
      saveTasks();
    }

}

void deleteTask(int index){
    tasks.removeAt(index);
    saveTasks();

}


void toggleTask(int index){
    Task task=tasks[index];
    if(task.dueDate!=null && task.dueDate!.isBefore(DateTime.now())){
      task.isCompleted=true;
    }
    else{
      task.isCompleted=!task.isCompleted;
    }
    tasks[index]=task;
    saveTasks();

}

void taskImportantToggle(int index){
    Task task=tasks[index];
    task.isImportant=!task.isImportant;
    tasks[index]=task;
    saveTasks();

}

void setDueDate(int index,DateTime? dueDate){
    Task task=tasks[index];
    task.dueDate=dueDate;
    tasks[index]=task;
    saveTasks();
}




}