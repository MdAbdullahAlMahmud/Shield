import 'package:flutter/material.dart';

class AudioCallProfileView extends StatefulWidget {
  final String userName;
  final String userImageUrl;

  const AudioCallProfileView({
    required this.userName,
    required this.userImageUrl,
  });

  @override
  _AudioCallProfileViewState createState() => _AudioCallProfileViewState();
}

class _AudioCallProfileViewState extends State<AudioCallProfileView>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _colorShiftController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for pulsing effect around the profile picture
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Fade animation for the user name
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    // Trigger the name fade-in animation after a small delay
    Future.delayed(Duration(milliseconds: 300), () {
      _fadeController.forward();
    });

    // Color-shifting animation for the background gradient
    _colorShiftController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blueAccent,
      end: Colors.purpleAccent,
    ).animate(
      CurvedAnimation(
        parent: _colorShiftController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    _colorShiftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorShiftController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _colorAnimation.value ?? Colors.blueAccent,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Picture with Glowing Pulse Effect
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.userImageUrl),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 25,
                              spreadRadius: 3,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),

                // User Name with Fade-in Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    widget.userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
