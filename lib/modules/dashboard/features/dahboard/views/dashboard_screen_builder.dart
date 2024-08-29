import 'package:flutter/material.dart';
import 'package:shield/core/base/base_view_state.dart';
import 'package:shield/core/widgets/text_filed/app_text.dart';
import 'package:shield/modules/dashboard/features/dahboard/controller/dashboard_controller.dart';

/**
 * Created by Abdullah on 25/8/24.
 */

class DashboardScreenBuilder extends StatefulWidget {
  const DashboardScreenBuilder({super.key});

  @override
  State<DashboardScreenBuilder> createState() => _DashboardScreenBuilderState();
}

class _DashboardScreenBuilderState
    extends BaseViewState<DashboardScreenBuilder, DashboardController>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: AppText(
        'Dashboard',
      ),
      backgroundColor: Colors.blueGrey[900],
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications
          },
        ),
      ],
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.blueGrey[800],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            label: 'File Sharing',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildMessagesContent();
      case 1:
        return _buildVideoCallsContent();
      case 2:
        return _buildAudioCallsContent();
      case 3:
        return _buildFileSharingContent();
      default:
        return _buildMessagesContent();
    }
  }

  Widget _buildMessagesContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Messages', style: Theme.of(context).textTheme.displayMedium),
        // Add content here for messages
      ],
    );
  }

  Widget _buildVideoCallsContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Video Calls', style: Theme.of(context).textTheme.displayMedium),
        // Add content here for video calls
      ],
    );
  }

  Widget _buildAudioCallsContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Audio Calls', style: Theme.of(context).textTheme.displayMedium),
        // Add content here for audio calls
      ],
    );
  }

  Widget _buildFileSharingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('File Sharing', style: Theme.of(context).textTheme.displayMedium),
        // Add content here for file sharing
      ],
    );
  }
}
