import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class OrphanDetails extends StatefulWidget {
  static const String routeName = '/home/orphan_details';

  const OrphanDetails({super.key});

  @override
  OrphanDetailsState createState() => OrphanDetailsState();
}

class OrphanDetailsState extends State<OrphanDetails> {
  List<Orphan> orphans = [
    Orphan(
      name: 'John Doe',
      bedroomName: 'Room 101',
      gender: Gender.male,
      avatarUrl: 'https://robohash.org/1.jpg',
    ),
    Orphan(
      name: 'Jane Doe',
      bedroomName: 'Room 102',
      gender: Gender.female,
      avatarUrl: 'https://robohash.org/1.jpg',
    ),
  ];

  List<Orphan> filteredOrphans = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredOrphans = orphans;
    super.initState();
  }

  void filterOrphans(String query) {
    List<Orphan> filteredList = orphans.where((orphan) {
      return orphan.name.toLowerCase().contains(query.toLowerCase()) ||
          orphan.bedroomName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredOrphans = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyleConfig.secondaryColor,
        title: const Text(
          'Kelola Data Anak Asuh',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterOrphans,
              decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrphans.length,
              itemBuilder: (context, index) {
                final orphan = filteredOrphans[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(orphan.avatarUrl),
                      radius: 30,
                      backgroundColor: AppStyleConfig.primaryBackgroundColor,
                    ),
                    tileColor: Colors.white,
                    title: Text(orphan.name),
                    subtitle: Text(orphan.bedroomName),
                    trailing: Icon(
                      orphan.gender == Gender.male ? Icons.male : Icons.female,
                      color: orphan.gender == Gender.male
                          ? Colors.blue
                          : Colors.pink,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed handler here
        },
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Orphan {
  final String name;
  final String bedroomName;
  final Gender gender;
  final String avatarUrl;

  Orphan({
    required this.name,
    required this.bedroomName,
    required this.gender,
    required this.avatarUrl,
  });
}

// Enum for Gender
enum Gender {
  male,
  female,
}
