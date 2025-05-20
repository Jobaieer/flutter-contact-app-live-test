import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Main app class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      home: ContactListPage(),
    );
  }
}

// Contact class (name and number store korbe)
class Contact {
  String name;
  String number;

  Contact(this.name, this.number);
}

// Main page (Stateful because list update hobe)
class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  // Input field er controller
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // Contact list
  List<Contact> contacts = [];

  // Add button e click korle ei function call hobe
  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add(Contact(name, number)); // List e add korlam
        nameController.clear();
        numberController.clear();
      });
    }
  }

  // Delete confirmation dialog
  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure for Delete?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.removeAt(index); // Delete
                });
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact List", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), centerTitle: true, backgroundColor: Colors.blueGrey,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
            ),

            SizedBox(height: 10),

            // Input for Number
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: "Number", border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Add Button
            ElevatedButton(
              onPressed: addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,      // button color
                minimumSize: Size(double.infinity, 48), // full width & height 48
              ),
              child: Text("Add", style: TextStyle(color: Colors.white),),
            ),

            SizedBox(height: 20),
            // Contact List
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].number),
                    trailing: Icon(Icons.phone),
                    onLongPress:
                        () => confirmDelete(index), // Long press e delete
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
