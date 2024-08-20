/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shield/modules/authentication/features/sign_up/views/sign_up_screen.dart';
import 'package:shield/pages/my_home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignUpScreen(),
    ),
    // Add more routes for each module
  ],
);
