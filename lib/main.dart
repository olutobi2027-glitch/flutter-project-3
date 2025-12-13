import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile Setup',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark blue-grey
        cardColor: const Color(0xFF1C3A1E), // Dark Green
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1C3A1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.green),
        ),
      ),
      home: const ProfileSetupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Your Profile'),
        backgroundColor: const Color(0xFF0F172A),
      ),
      drawer: _buildDrawer(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildMobileLayout();
                } else if (constraints.maxWidth < 900) {
                  return _buildTabletLayout();
                } else {
                  return _buildDesktopLayout();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFF0F172A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1C3A1E),
              ),
              child: Text(
                'AllCampus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scrollbar(
      controller: _scrollController1,
      thumbVisibility: true,
      child: ListView(
        controller: _scrollController1,
        children: [
          const SizedBox(height: 24),
          _buildProfileForm(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Scrollbar(
            controller: _scrollController1,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController1,
              children: [
                _buildSetupInstructions(),
                const SizedBox(height: 24),
                _buildProfileForm(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: Scrollbar(
            controller: _scrollController2,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController2,
              children: [_buildRightColumn(context)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Scrollbar(
            controller: _scrollController1,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController1,
              children: [_buildSetupInstructions()],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Scrollbar(
            controller: _scrollController2,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController2,
              children: [_buildProfileForm()],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Scrollbar(
            controller: _scrollController3,
            thumbVisibility: true,
            child: ListView(
              controller: _scrollController3,
              children: [_buildRightColumn(context)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSetupInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        _buildInstructionCard(
          icon: Icons.person_outline,
          title: 'Username',
          subtitle: 'Choose a unique username that represents you. It must start with a letter or underscore.',
        ),
        const SizedBox(height: 16),
        _buildInstructionCard(
          icon: Icons.school_outlined,
          title: 'Educational Rank',
          subtitle: 'Select your current educational status to connect with the right community.',
        ),
        const SizedBox(height: 16),
        _buildInstructionCard(
          icon: Icons.apartment_outlined,
          title: 'Institution name',
          subtitle: 'Add your school or university to find classmates and campus activities.',
        ),
        const SizedBox(height: 16),
        _buildInstructionCard(
          icon: Icons.photo_camera_outlined,
          title: 'Add photo',
          subtitle: 'Add profile and cover photos to personalize your profile. Photos upload instantly!',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C3A1E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white10),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Complete your profile to unlock all features and connect with your campus community.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFF1C3A1E),
          child: Text('Add photo', style: TextStyle(color: Colors.white70)),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Username',
            prefixIcon: Icon(Icons.alternate_email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Student',
            prefixIcon: Icon(Icons.school_outlined),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
         const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Institution name',
            prefixIcon: Icon(Icons.apartment),
            suffixIcon: Icon(Icons.search)
          ),
        ),
        const Align(alignment: Alignment.centerLeft, child: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 8.0),
          child: Text("Institution not found? Add it", style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
        )),
        const SizedBox(height: 16),
         TextField(
          decoration: const InputDecoration(
            hintText: 'Course of study',
            prefixIcon: Icon(Icons.book_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Current year (Level)',
            prefixIcon: Icon(Icons.person_pin_circle_outlined),
             suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF388E3C),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Save', style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitledCard(
          context: context,
          title: 'Profile Tips',
          children: [
            _buildBenefitItem(Icons.check_circle, 'Choose Wisely', 'Your username is permanent and identifies you across the platform.', Colors.green),
            const SizedBox(height: 16),
             _buildBenefitItem(Icons.shield_outlined, 'Be Authentic', 'Use your real educational details to connect with genuine peers.', Colors.blue),
            const SizedBox(height: 16),
            _buildBenefitItem(Icons.photo_library_outlined, 'Quality Photos', 'Upload clear photos for better recognition within your campus.', Colors.orange),
          ],
        ),
        const SizedBox(height: 24),
        _buildTitledCard(
          context: context,
          title: 'Profile Benefits',
          children: [
            _buildBenefitItem(Icons.people_alt_outlined, 'Connect with peers', null, Colors.green),
            const SizedBox(height: 12),
            _buildBenefitItem(Icons.calendar_today_outlined, 'Join campus events', null, Colors.green),
             const SizedBox(height: 12),
            _buildBenefitItem(Icons.chat_bubble_outline, 'Access discussions', null, Colors.green),
             const SizedBox(height: 12),
            _buildBenefitItem(Icons.star_border_outlined, 'Unlock premium features', null, Colors.green),
          ],
        ),
        const SizedBox(height: 24),
        _buildProTipCard(context),
      ],
    );
  }

  Widget _buildTitledCard({required BuildContext context, required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String? subtitle, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ],
          ),
        ),
      ],
    );
  }

   Widget _buildProTipCard(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.amber, size: 32),
          SizedBox(height: 8),
          Text('Pro Tip', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(
            'Complete all fields to maximize your profile visibility and get the most out of AllCampus!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
