import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class OrphanDetails extends StatefulWidget {
  static const String routeName = '/main/home/orphan_details';

  const OrphanDetails({super.key});

  @override
  OrphanDetailsState createState() => OrphanDetailsState();
}

class OrphanDetailsState extends State<OrphanDetails> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> orphans = [
    {
      'name': 'John Doe',
      'age': 12,
      'bedroom': 'Bedroom A',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
      'name': 'Jane Smith',
      'age': 10,
      'bedroom': 'Bedroom B',
      'profilePicture':
          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236',
    },
    {
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
        onPressed: () {},
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOrphanMasonryGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Jane Smith',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
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
            const Center(
              child: Text(
                'Ummu Kultsum',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
