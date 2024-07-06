import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class CaretakerList extends StatefulWidget {
  const CaretakerList({super.key});

  @override
  CaretakerListState createState() => CaretakerListState();
}

class CaretakerListState extends State<CaretakerList> {
  late Future<List<UserResponse>> caretakerFuture;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      caretakerFuture = UserService(context: context).fetchUserProfiles();
    });
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
      body: FutureBuilder<List<UserResponse>>(
        future: caretakerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildCaretakerSkeletons();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildCaretakerEmptyState();
          } else {
            return Column(
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
                Expanded(child: _buildCaretakerMasonryGridView(snapshot.data!)),
              ],
            );
          }
        },
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

  Widget _buildCaretakerSkeletons() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Positioned(
                      bottom: -40.0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 100.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 150.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaretakerEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.person_outline,
              color: Colors.blue.shade900,
              size: 60.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'No caretakers found',
            style: AppStyleConfig.headlineMediumTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildCaretakerMasonryGridView(List<UserResponse> caretakers) {
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

  Widget _buildCaretakerGridItem(UserResponse caretaker) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.caretakerDetails,
            arguments: caretaker.id);
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
                        backgroundImage: NetworkImage(
                            caretaker.profile.profilePicture ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Center(
                child: Text(
                  caretaker.profile.fullName ?? '',
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  caretaker.profile.gender ?? '',
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
