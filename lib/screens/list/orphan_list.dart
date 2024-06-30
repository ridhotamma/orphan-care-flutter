import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class OrphanList extends StatefulWidget {
  const OrphanList({super.key});

  @override
  OrphanListState createState() => OrphanListState();
}

class OrphanListState extends State<OrphanList> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> orphans = [
    {
      'id': '1',
      'name': 'John Doe',
      'age': 12,
      'bedroom': 'Bedroom A',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: "Data Anak Asuh",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (string) {},
              decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: _buildOrphanMasonryGridView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.orphanCreateForm);
        },
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOrphanMasonryGridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        itemCount: orphans.length,
        itemBuilder: (context, index) {
          final orphan = orphans[index];
          return _buildOrphanGridItem(orphan);
        },
      ),
    );
  }

  Widget _buildOrphanGridItem(Map<String, dynamic> orphan) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePaths.orphanDetails,
          arguments: orphan['id'],
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: AppStyleConfig.accentColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Positioned(
                    bottom: -40.0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(orphan['profilePicture']),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Center(
                child: Text(
                  orphan['name'],
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              const Center(
                child: Chip(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Female',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.female_outlined,
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  ),
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  orphan['bedroom'],
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
