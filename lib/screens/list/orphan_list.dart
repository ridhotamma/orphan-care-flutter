import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class OrphanList extends StatefulWidget {
  const OrphanList({super.key});

  @override
  OrphanListState createState() => OrphanListState();
}

class OrphanListState extends State<OrphanList> {
  late Future<List<UserResponse>> orphanFuture;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      orphanFuture =
          UserService(context: context).fetchUserProfiles(roles: 'ROLE_USER');
    });
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
      body: FutureBuilder<List<UserResponse>>(
        future: orphanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildOrphanSkeletons();
          } else if (snapshot.hasError) {
            return _buildOrphanEmptyState();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildOrphanEmptyState();
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
                Expanded(child: _buildOrphanMasonryGridView(snapshot.data!)),
              ],
            );
          }
        },
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

  Widget _buildOrphanSkeletons() {
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

  Widget _buildOrphanEmptyState() {
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
            'No orphans found',
            style: AppStyleConfig.headlineMediumTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildOrphanMasonryGridView(List<UserResponse> orphans) {
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

  Widget _buildOrphanGridItem(UserResponse orphan) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePaths.orphanDetails,
          arguments: orphan.id,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
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
                            NetworkImage(orphan.profile.profilePicture ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Center(
                child: Text(
                  orphan.profile.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  orphan.profile.bedRoom?.name ?? '',
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
