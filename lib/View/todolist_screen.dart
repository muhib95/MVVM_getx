import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx/ViewModel/controller.dart';

class TodolistScreen extends StatelessWidget {
   TodolistScreen({super.key});
final TaskViewModel taskViewModel=Get.put(TaskViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
padding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 5),
       decoration: BoxDecoration(
         color: Colors.blue,
       ),
            child: Text(
              'Add A New Task',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextFormField(
            controller: taskViewModel.controller,
            onFieldSubmitted: (value) => taskViewModel.addTask(taskTitle: value),
            decoration: InputDecoration(
              hintText: 'Enter your task'
            ),
          ),
          SizedBox(height: 10,),
          Text('Tasks List'),
          Expanded(
            child: Obx(
              () =>  ListView.builder(
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  return Text(taskViewModel.tasks[index].title);
                },),
            ),
          )

        ],
      ),
    );
  }
}
