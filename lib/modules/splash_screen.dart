import 'package:flutter/material.dart';
import 'package:shield/core/constants/app_images.dart';
import 'package:shield/core/services/storage/secure_storage.dart';
import 'package:shield/flavors/app_properties.dart';
import 'package:shield/router/app_routes.dart';
import 'package:shield/router/route_path.dart';
/**
 * Created by Abdullah on 25/8/24.
 */

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward().then((_) {
        SecureStorageService.getToken().then((token) {
          if (token != null) {
            AppRoutes.pushAndReplaceNamed(RoutePath.chatUserList);
          } else {
            AppRoutes.pushAndReplaceNamed(RoutePath.login);
          }
        });

        AppRoutes.pushAndReplaceNamed(RoutePath.login);
      });

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _logoScaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.splashLogo, width: 100, height: 100),
                // Replace with your logo
                SizedBox(height: 20),
                Text(
                  AppProperties.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Privacy First',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
