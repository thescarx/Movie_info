import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_infos/Screens/itemScreen.dart';

import 'Models/itemList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                addNote();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.note,
                    color: Colors.deepPurple,
                    size: 100,
                  ),
                  Text(
                    'No notes yet',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                       Navigator.push(context,MaterialPageRoute(builder:  (context) =>  ItemScreen(note: notes[index],)));},
                    onDoubleTap: () {
                      titleController.text = notes[index].title;
                      descController.text = notes[index].description;
                      showModify(index);
                    },
                    onLongPress: () => showSupp(index),
                    child: Card(
                      elevation: 2,
                      child: SizedBox(
                        width: size.width * 0.9,
                        height: size.height * 0.15,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset('assets/logo.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      notes[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      notes[index].description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
    );
  }

  Future addNote() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Add a note',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                        ),
                        hintText: "Add your title here",
                        hintStyle: const TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 15,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      maxLines: 7,
                      controller: descController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                        ),
                        hintText: "Add here your description",
                        hintStyle: const TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 15,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            addIt(titleController.text, descController.text);
                          },
                          child: const Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Tajawal",
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Tajawal",
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void addIt(String text, String text2) {
    if (text2.isEmpty) {
      EasyLoading.showError('Description is mendatory');
    } else {
      Navigator.pop(context);
      setState(() {
        notes.add(Note(title: text, description: text2, date: DateTime.now()));
        descController.clear();
        titleController.clear();
      });

      EasyLoading.showSuccess('Note added successfully');
    }
  }

  showSupp(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.auto_delete_rounded,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Delete',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text('Are you sure you want to delete this note'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          notes.removeAt(index);
                        });
                        EasyLoading.showSuccess('Note has been deleted');
                      },
                      child: const Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              )
            ],
          );
        });
  }

  showModify(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.edit,
                  size: 25,
                ),
                Text('Modify')
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                        ),
                        hintText: "Add your title here",
                        hintStyle: const TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 15,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      maxLines: 7,
                      controller: descController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Colors.black38, width: 1.5),
                        ),
                        hintText: "Add here your description",
                        hintStyle: const TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 15,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          notes[index].title = titleController.text;
                          notes[index].description = descController.text;
                        });
                        EasyLoading.showSuccess(
                            'Note has been edited successfuly');
                      },
                      child: const Center(
                        child: Text(
                          'Modify',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              )
            ],
          );
        });
  }
}
