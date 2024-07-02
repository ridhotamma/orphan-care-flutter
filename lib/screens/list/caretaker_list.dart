import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class CaretakerList extends StatefulWidget {
  const CaretakerList({super.key});

  @override
  CaretakerListState createState() => CaretakerListState();
}

class CaretakerListState extends State<CaretakerList> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> caretakers = [
    {
      'id': '1',
      'name': 'Alice Johnson',
      'profilePicture':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjPtBPtOIj16drcpc4Ht93MyJgtRH89ikp_Q&s',
      'specialty': 'Child Psychology',
    },
    {
      'id': '2',
      'name': 'Bob Williams',
      'profilePicture':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjPtBPtOIj16drcpc4Ht93MyJgtRH89ikp_Q&s',
      'specialty': 'Education',
    },
    // Add more caretakers as needed
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
        title: "Data Pengasuh",
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
          Expanded(child: _buildCaretakerMasonryGridView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.caretakerCreateForm);
        },
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCaretakerMasonryGridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        itemCount: caretakers.length,
        itemBuilder: (context, index) {
          final caretaker = caretakers[index];
          return _buildCaretakerGridItem(caretaker);
        },
      ),
    );
  }

  Widget _buildCaretakerGridItem(Map<String, dynamic> caretaker) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.caretakerDetails,
            arguments: 'id');
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
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
                        backgroundImage:
                            NetworkImage(caretaker['profilePicture']),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Center(
                child: Text(
                  caretaker['name'],
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  caretaker['specialty'],
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
