import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/services/bedroom_service.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class BedroomList extends StatefulWidget {
  const BedroomList({super.key});

  @override
  State<BedroomList> createState() => _BedroomListState();
}

class _BedroomListState extends State<BedroomList> {
  late Future<List<BedRoom>> _bedroomFuture;
  late StreamSubscription _eventBusSubscription;

  @override
  void initState() {
    super.initState();
    _fetchData();

    _eventBusSubscription = eventBus.on<DataMasterCreatedEvent>().listen(
      (event) {
        _fetchData();
      },
    );
  }

  Future<void> _fetchData() async {
    setState(() {
      _bedroomFuture = BedroomService(context: context).fetchBedRooms();
    });
  }

  void onDeleteSuccess(bedRoomName) {
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.successColor,
        content: Text(
          'Bedroom $bedRoomName deleted',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, String itemName) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete $itemName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Deleting...'),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _eventBusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyleConfig.primaryBackgroundColor,
        appBar: const CustomAppBar(
          title: 'Data Kamar',
          automaticallyImplyLeading: true,
        ),
        body: FutureBuilder<List<BedRoom>>(
          future: _bedroomFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildBedRoomSkeletons();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildBedRoomEmptyState();
            } else {
              return _buildBedRoomListView(snapshot.data!);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, RoutePaths.bedroomCreateForm);
          },
          backgroundColor: AppStyleConfig.secondaryColor,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBedRoomSkeletons() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              tileColor: Colors.white,
              leading: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.bedroom_parent,
                  color: Colors.grey.shade300,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 100.0,
                  ),
                  const SizedBox(
                      height: 8.0), // Spacing between title and subtitle
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 150.0,
                  ),
                ],
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey.shade300),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBedRoomEmptyState() {
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
              Icons.bedroom_parent,
              color: Colors.blue.shade900,
              size: 60.0,
            ),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'There is no bedroom',
            style: AppStyleConfig.headlineMediumTextStyle,
          )
        ],
      ),
    );
  }

  Widget _buildBedRoomListView(List<BedRoom> data) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final bedroom = data[index];
        return Dismissible(
          key: Key(bedroom.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await _showDeleteConfirmationDialog(context, bedroom.name!);
          },
          onDismissed: (direction) async {
            _showLoadingDialog(context);

            try {
              await BedroomService(context: context)
                  .deleteBedRoomById(bedroom.id!);
              setState(() {
                data.removeAt(index);
              });
            } finally {
              onDeleteSuccess(bedroom.name);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.bedroom_parent,
                  color: Colors.blue.shade900,
                ),
              ),
              title: Text(
                bedroom.name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(bedroom.bedRoomType!.name!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.bedroomDetails,
                  arguments: bedroom.id,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
