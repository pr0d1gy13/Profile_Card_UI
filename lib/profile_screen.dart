import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfileScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper for staggered entrance animations
  Widget _buildAnimatedItem(Widget child, double start, double end) {
    final Animation<double> fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Slight upward slide
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Colors
    final Color textColor = widget.isDarkMode ? const Color(0xFFF7F4EF) : const Color(0xFF1C1C1C);
    final Color textMuted = widget.isDarkMode ? const Color(0xFFA3A3A3) : const Color(0xFF737373);
    final Color accentRed = widget.isDarkMode ? const Color(0xFFD9534F) : const Color(0xFF8B2B2B);
    final Color avatarBg = widget.isDarkMode ? const Color(0xFF2C1E1E) : const Color(0xFFF2E6E6);
    final Color dividerColor = widget.isDarkMode ? const Color(0xFF333333) : const Color(0xFFE5E0D8);
    final Color buttonBgColor = widget.isDarkMode ? Colors.white : const Color(0xFF141414);
    final Color buttonTextColor = widget.isDarkMode ? Colors.black : Colors.white;
    
    // New UI Tweak: Subtle surface colors for the right column cards
    final Color surfaceColor = widget.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFFFFFFF);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {},
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: textMuted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5, // Added letter spacing for an editorial look
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 800;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? constraints.maxWidth * 0.15 : 24.0,
              vertical: 24.0,
            ),
            child: isWideScreen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildLeftColumn(textColor, textMuted, accentRed, avatarBg, dividerColor, buttonBgColor, buttonTextColor),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 6,
                        child: _buildRightColumn(textColor, textMuted, accentRed, dividerColor, surfaceColor),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftColumn(textColor, textMuted, accentRed, avatarBg, dividerColor, buttonBgColor, buttonTextColor),
                      const SizedBox(height: 48),
                      _buildRightColumn(textColor, textMuted, accentRed, dividerColor, surfaceColor),
                    ],
                  ),
          );
        },
      ),
    );
  }

  // ==========================================
  // LEFT COLUMN: Profile Info
  // ==========================================
  Widget _buildLeftColumn(Color textColor, Color textMuted, Color accentRed, Color avatarBg, Color dividerColor, Color buttonBgColor, Color buttonTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedItem(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UI Tweak: Squircle Avatar instead of perfect circle
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: avatarBg,
                  borderRadius: BorderRadius.circular(28), // Unique squircle shape
                  border: Border.all(color: dividerColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: dividerColor.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'AH',
                  style: TextStyle(
                    color: accentRed,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Abdullah\nHaque',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '@abdullah',
                      style: TextStyle(color: textMuted, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          0.0, 0.4,
        ),
        const SizedBox(height: 28),

        _buildAnimatedItem(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconText(Icons.work_outline, 'Backend Engineer & Cloud Architect', textMuted, textColor),
              const SizedBox(height: 12),
              _buildIconText(Icons.location_on_outlined, 'Mumbai, India', textMuted, textMuted),
              const SizedBox(height: 24),
              Text(
                'Building scalable backend infrastructure and clean databases at the intersection of architecture, technology, and efficiency.',
                style: TextStyle(
                  color: textColor.withOpacity(0.85),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ],
          ),
          0.1, 0.5,
        ),
        const SizedBox(height: 32),

        _buildAnimatedItem(
          Row(
            children: [
              Expanded(
                child: InteractiveFollowButton(
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  borderColor: dividerColor,
                ),
              ),
              const SizedBox(width: 12),
              _buildSquareIconButton(Icons.mail_outline, dividerColor, textColor),
              const SizedBox(width: 12),
              _buildSquareIconButton(Icons.share_outlined, dividerColor, textColor),
            ],
          ),
          0.2, 0.6,
        ),
        const SizedBox(height: 40),

        _buildAnimatedItem(
          Column(
            children: [
              Divider(color: dividerColor, thickness: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('28', 'Projects', textColor, textMuted),
                  _buildVerticalDivider(dividerColor),
                  _buildStatItem('4.8K', 'Followers', textColor, textMuted),
                  _buildVerticalDivider(dividerColor),
                  _buildStatItem('312', 'Following', textColor, textMuted),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: dividerColor, thickness: 1),
            ],
          ),
          0.3, 0.7,
        ),
      ],
    );
  }

  // ==========================================
  // RIGHT COLUMN: About & Activity
  // ==========================================
  Widget _buildRightColumn(Color textColor, Color textMuted, Color accentRed, Color dividerColor, Color surfaceColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedItem(
          // UI Tweak: Enclosed About section in a styled surface card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: dividerColor.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('About', textColor),
                const SizedBox(height: 24),
                _buildInfoBlock(Icons.location_on_outlined, 'Location', 'Mumbai, India', textMuted, textColor),
                Divider(color: dividerColor, height: 32),
                _buildInfoBlock(Icons.calendar_today_outlined, 'Member since', '2024', textMuted, textColor),
                Divider(color: dividerColor, height: 32),
                _buildInfoBlock(Icons.tune_outlined, 'Focus', 'Backend Engineering, Cloud Architecture', textMuted, textColor),
              ],
            ),
          ),
          0.4, 0.8,
        ),
        const SizedBox(height: 24),

        _buildAnimatedItem(
          // UI Tweak: Enclosed Activity section in a styled surface card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: dividerColor.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Activity', textColor),
                const SizedBox(height: 32),
                _buildTimelineItem('2 days ago', 'Developed a GraphQL-based Car Rental System with FastAPI', accentRed, textMuted, textColor, dividerColor),
                _buildTimelineItem('1 week ago', 'Completed an AWS cloud instance recovery and Linux simulation', accentRed, textMuted, textColor, dividerColor),
                _buildTimelineItem('3 weeks ago', 'Participated in MumbaiHacks Hackathon', accentRed, textMuted, textColor, dividerColor, isLast: true),
              ],
            ),
          ),
          0.5, 0.9,
        ),
      ],
    );
  }

  // ==========================================
  // HELPER WIDGETS
  // ==========================================

  Widget _buildIconText(IconData icon, String text, Color iconColor, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14, height: 1.4, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildSquareIconButton(IconData icon, Color borderColor, Color iconColor) {
    return Container(
      height: 52, // Slightly taller for modern proportion
      width: 52,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(14), // UI tweak: softer corners
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: 22),
        onPressed: () {},
      ),
    );
  }

  Widget _buildStatItem(String count, String label, Color textColor, Color textMuted) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: textMuted, fontSize: 13, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildVerticalDivider(Color color) {
    return Container(height: 35, width: 1, color: color);
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Row(
      children: [
        Container(
          width: 24, // Wider accent line
          height: 2,
          decoration: BoxDecoration(
            color: textColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildInfoBlock(IconData icon, String label, String value, Color textMuted, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: textMuted.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: textMuted),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: textMuted, fontSize: 12, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem(String time, String title, Color dotColor, Color textMuted, Color textColor, Color dividerColor, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 10, 
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: dotColor.withOpacity(0.4), blurRadius: 4, spreadRadius: 1),
                ]
              ),
            ),
            if (!isLast)
              Container(
                width: 2, 
                height: 55, // Slightly longer timeline stem
                color: dividerColor, 
                margin: const EdgeInsets.symmetric(vertical: 4)
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time.toUpperCase(), 
                  style: TextStyle(color: textMuted, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0)
                ),
                const SizedBox(height: 8),
                Text(title, style: TextStyle(color: textColor, fontSize: 15, height: 1.4, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// STATEFUL FOLLOW BUTTON WITH SCALE ANIMATION
// ==========================================
class InteractiveFollowButton extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const InteractiveFollowButton({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  State<InteractiveFollowButton> createState() => _InteractiveFollowButtonState();
}

class _InteractiveFollowButtonState extends State<InteractiveFollowButton> {
  bool _isFollowing = false;
  bool _isPressed = false; // Used for scale animation

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isFollowing ? Icons.check_circle : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              _isFollowing 
                ? 'You are now following Abdullah Haque!' 
                : 'You unfollowed Abdullah Haque.',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF141414), 
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _toggleFollow();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0, // Unique UI Tweak: Button shrinks slightly when pressed
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 52,
          decoration: BoxDecoration(
            color: _isFollowing ? Colors.transparent : widget.bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isFollowing ? widget.borderColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            _isFollowing ? 'Following' : 'Follow',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: _isFollowing 
                ? (widget.bgColor == Colors.white ? Colors.white : Colors.black) 
                : widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}