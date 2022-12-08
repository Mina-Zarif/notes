import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/UI/contactUs/contactUs.dart';
import 'package:notes/models/NoteModel/NoteModel.dart';
import 'package:notes/shared/cubit/appStates.dart';
import '../../UI/HomeScreen/DeletedTasksScreen/DeletedTasks.dart';
import '../../UI/HomeScreen/NotesScreen/NotesScreens.dart';
import '../../UI/HomeScreen/TasksScreen/TasksScreen.dart';
import '../../models/TaskModel/TaskModel.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [NotesScreen(), TasksScreen(), DeletedTasks()];
  List<String> titles = ['Notes', 'Tasks', 'Trash'];
  int index = 0;
  bool isSelected = false;
  bool darkMood = false;
  var note = TextEditingController();
  var taskTitle = TextEditingController();
  var taskContent = TextEditingController();

  void currentIndex(ind) {
    index = ind;
    // print(index);
    emit(ChangeCurrentIndex());
  }

/*  void switching(bool value) {
    darkMood = value;
    emit(SwitchingToDarkMood());
  }*/

  var uid = FirebaseAuth.instance.currentUser!.uid;

  void storeNote(context) {
    var time = DateFormat.jm().format(DateTime.now());
    var now = DateTime.now();
    String date = "${now.day} - ${now.month} - ${now.year}";
    NoteModel? noteModel =
        NoteModel(abstract: note.text, date: date, time: time);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('notes')
        .doc()
        .set(noteModel.toJson())
        .then((value) {
      getNotes();
      note.text = '';
      Navigator.pop(context);
      emit(AddNoteSuccessState());
    }).catchError((error) {
      print("Error --> $error");
      emit(AddNoteErrorState());
    });
  }

  List<NoteModel> notes = [];
  List<String> noteId = [];

  Future<void> getNotes() async {
    emit(GetNodesLoadingState());
    notes = [];
    noteId = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('notes')
        .get()
        .then((value) {
      for (var element in value.docs) {
        notes.add(NoteModel.fromJson(element.data()));
        noteId.add(element.id);
      }
      emit(AddNoteSuccessState());
    }).catchError((error) {
      print("error --> $error");
      emit(AddNoteErrorState());
    });
  }

  void deleteNote(ind) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('notes')
        .doc(noteId[ind])
        .delete()
        .then((value) {
      emit(DeleteNoteSuccessState());
      getNotes();
    }).catchError((error) {
      print(error);
      emit(DeleteNoteErrorState());
    });
  }

  List<String> msg = ["Delete All Notes", "Delete All Projects", "Clear Trash"];
  List<String> alertMsg = [
    "Are You Sure To Delete All Notes?",
    "Are You Sure To Delete All Projects?",
    "Are You Sure To Clear Trash?"
  ];

  void alertToClear({context}) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert',
            style: TextStyle(color: CupertinoColors.systemPurple)),
        content: Text(
          alertMsg[index],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              'Cancel',
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 15, color: Colors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              if (index == 0) {
                deleteAllNotes();
              } else if (index == 1) {
                deleteAllProjects();
              } else {
                clearTrash();
              }
              Navigator.pop(context);
            },
            child: const Text(
              'Yup',
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllNotes() {
    emit(DeleteAllNoteLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('notes')
        .get()
        .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
          emit(DeleteAllNoteSuccessState());
        })
        .then((value) => getNotes())
        .catchError((error) {
          print(error);
          emit(DeleteAllNoteErrorState());
        });
  }

  void deleteAllProjects() {
    emit(DeleteAllNoteLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('tasks')
        .get()
        .then((value) {
          for (var element in value.docs) {
            TaskModel? model = TaskModel.fromJson(element.data());
            trashModel = model;
            FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection('trash')
                .doc()
                .set(trashModel!.toJson());
            element.reference.delete();
          }
          emit(DeleteAllNoteSuccessState());
          getTasks();
        })
        .then((value) => getTrash())
        .catchError((error) {
          print(error);
          emit(DeleteAllNoteErrorState());
        });
  }

  void clearTrash() {
    emit(DeleteAllNoteLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('trash')
        .get()
        .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
          emit(DeleteAllNoteSuccessState());
        })
        .then((value) => getTrash())
        .catchError((error) {
          print(error);
          emit(DeleteAllNoteErrorState());
        });
  }

  void storeProject() {
    var time = DateFormat.jm().format(DateTime.now());
    var now = DateTime.now();
    String date = "${now.day} - ${now.month} - ${now.year}";
    TaskModel? taskModel = TaskModel(
      title: taskTitle.text,
      content: taskContent.text,
      date: date,
      time: time,
    );
    var dp = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('tasks')
        .doc();
    taskModel.uid = dp.id;
    dp.set(taskModel.toJson()).then((value) {
      getTasks();
      taskContent.text = '';
      taskTitle.text = '';
      emit(AddTaskSuccessState());
    }).catchError((error) {
      print("Error --> $error");
      emit(AddTaskErrorState());
    });
  }

  List<TaskModel> tasks = [];
  List<TaskModel> trash = [];
  List<String> trashId = [];
  List<String> tasksId = [];
  FirebaseFirestore? db;

  void getTasks() async {
    emit(GetTaskLoadingState());
    tasks = [];
    tasksId = [];
    db = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('tasks')
        .orderBy("bin", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        tasks.add(TaskModel.fromJson(element.data()));
        tasksId.add(element.id);
      }
      /*    tasks.forEach((element) {
        print(element.toJson());
      });*/
      // trash.forEach((element) {print(element.toJson());});
      emit(GetTaskSuccessState());
    }).catchError((error) {
      print("error --> $error");
      emit(GetTaskErrorState());
    });
  }

  void deleteTask(ind) {
    if (tasks[ind].check == true) doneTask(false, tasks[ind], ind);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('tasks')
        .doc(tasksId[ind])
        .delete()
        .then((value) {
      trashModel = tasks[ind];
      moveToTrash(ind);
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((error) {
      print(error);
      emit(DeleteTaskErrorState());
    });
  }

  TaskModel? trashModel;

  void moveToTrash(index) {
    String id = tasksId[index];
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('trash')
        .doc(id)
        .set(trashModel!.toJson())
        .then((value) {
      emit(MoveTaskToTrashSuccessState());
      getTrash();
    }).catchError((error) {
      emit(MoveTaskToTrashErrorState());
    });
  }

  void getTrash() async {
    emit(GetTrashLoadingState());
    trash = [];
    trashId = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('trash')
        .get()
        .then((value) {
      for (var element in value.docs) {
        trash.add(TaskModel.fromJson(element.data()));
        trashId.add(element.id);
      }
      emit(GetTrashSuccessState());
    }).catchError((error) {
      print("error --> $error");
      emit(GetTrashErrorState());
    });
  }

  void backToTasks(ind) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('trash')
        .doc(trashId[ind])
        .delete()
        .then((value) {
      trashModel = trash[ind];
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('tasks')
          .doc()
          .set(trashModel!.toJson());
      emit(DeleteTaskSuccessState());
      getTrash();
      getTasks();
    }).catchError((error) {
      print(error);
      emit(DeleteTaskErrorState());
    });
  }

  TaskModel? doneModel;

  void doneTask(bool check, model, index) async {
    doneModel = model;
    String id = doneModel!.uid!;
    doneModel!.check = check;
    emit(DoneTaskLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('tasks')
        .doc(doneModel!.uid)
        .update(doneModel!.toJson())
        .then((value) {
          emit(DoneTaskSuccessState());
          getTasks();
        })
        .then((value) {
          if (check == true) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection('done')
                .doc(doneModel!.uid)
                .set(doneModel!.toJson());
          } else {
            FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection('done')
                .doc(doneModel!.uid)
                .delete();
          }
          emit(DoneTaskSuccessState());
        })
        .then((value) => getDoneTasks())
        .catchError((error) {
          print(error);
          emit(DoneTaskErrorState());
        });
  }

  List<TaskModel> done = [];
  List<String> doneId = [];

  void getDoneTasks() {
    done = [];
    doneId = [];
    emit(GetDoneTasksLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('done')
        .get()
        .then((value) {
      for (var element in value.docs) {
        doneId.add(element.id);
        done.add(TaskModel.fromJson(element.data()));
      }
      emit(GetDoneTasksSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetDoneTasksErrorState());
    });
  }

  void deletDoneTask(ind) {
    doneTask(false, done[ind], ind);
  }

  void clearDoneTask() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('done')
        .get()
        .then((value) {
      for (var element in value.docs) {
        TaskModel? model = TaskModel.fromJson(element.data());
        element.reference.delete();
        model.check = false;
        String id = element.id;
        FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("tasks")
            .doc(id)
            .set(model.toJson());
      }
    }).then((value) {
      emit(ClearDoneTasksSuccessState());
      getTasks();
      getDoneTasks();
    }).catchError((error) {
      emit(ClearDoneTasksErrorState());
    });
  }

  void alertToClearData({required context, required function}) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert',
            style: TextStyle(color: CupertinoColors.systemPurple)),
        content: Text(
          "Are You Sure To Undone All Projects?",
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              'Cancel',
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 15, color: Colors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              function();
              Navigator.pop(context);
            },
            child: const Text(
              'Yup',
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void binTask(index, TaskModel model) {
    if (model.bin == true) {
      model.bin = false;
    } else {
      model.bin = true;
    }
    String id = tasksId[index];
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tasks")
        .doc(id)
        .set(model.toJson())
        .then((value) {
      emit(PinTaskSuccessfullyState());
      getTasks();
    }).catchError((error) {
      emit(PinTaskErrorState());
    });
  }

  void mailUs() async {

  }
}
