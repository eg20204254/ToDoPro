import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/addTaskpage.dart';
import 'package:flutter_application_1/Pages/allTaskspage.dart';
import 'package:flutter_application_1/Pages/taskDetail.dart';
import 'package:flutter_application_1/Widgets/button.dart';
import 'package:flutter_application_1/Widgets/taskContainer.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';
import 'package:flutter_application_1/services/ApiService.dart';
import 'package:flutter_application_1/themeData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/TaskModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(TaskApiService()),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addTaskBar(),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 245),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/w.png',
                    width: 500,
                    height: 150,
                  ),
                ),
              ),
            ),
            addDateBar(),
            showTasks(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 9, 1, 64),
          selectedItemColor: Color.fromARGB(255, 121, 114, 241),
          unselectedItemColor: Colors.white,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllTasksPage()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
                color: Color.fromARGB(255, 121, 114, 241),
              ),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All Tasks',
            ),
          ],
        ),
      ),
    );
  }

  Widget addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          Button(
              label: "+ Add Task",
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskPage()),
                  ))
        ],
      ),
    );
  }

  Widget addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color.fromARGB(255, 50, 54, 112),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Widget showTasks() {
    return Container();
    /*return Expanded(
      child: Obx(() {
        var filteredTasks = taskController.taskList.where((task) =>
            task.date.year == _selectedDate.year &&
            task.date.month == _selectedDate.month &&
            task.date.day == _selectedDate.day);

        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            Task task = filteredTasks.elementAt(index);
            return GestureDetector(
              onTap: () => Get.to(TaskDetailPage(task: task)),
              child: TaskContainer(task: task),
            );
          },
        );
      }),
    );*/
  }
}
