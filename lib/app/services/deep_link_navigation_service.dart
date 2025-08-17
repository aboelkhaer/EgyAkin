import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';
import 'package:egy_akin/injection_container.dart' as di;

class DeepLinkNavigationService {
  static final DeepLinkNavigationService _instance = DeepLinkNavigationService._internal();
  factory DeepLinkNavigationService() => _instance;
  DeepLinkNavigationService._internal();

  Future<void> navigateToPostFromDeepLink(String postId, BuildContext context) async {
    try {
      // Check if we're already on a screen that can handle navigation
      if (!context.mounted) {
        debugPrint('Context not mounted, cannot navigate');
        return;
      }

      // Additional check to ensure we're not in a loading state
      final homeCubit = di.sl<HomeCubit>();
      final hasHomeData = homeCubit.homeDataModel.data != null;
      final hasDoctorData = homeCubit.currentDoctorModel.id != null;
      
      if (!hasHomeData || !hasDoctorData) {
        debugPrint('Home data not ready yet, cannot navigate');
        return;
      }

      // No loading indicator - just proceed directly

      // Get current user data and home data first
      final currentDoctorModel = await _getCurrentDoctorModel();
      final homeDataModel = await _getHomeDataModelFromCubit();
      
      debugPrint('Current doctor model: ${currentDoctorModel?.firstName}');
      debugPrint('Home data model: ${homeDataModel?.data != null ? 'loaded' : 'null'}');
      
      if (currentDoctorModel == null || homeDataModel == null) {
        debugPrint('Missing data - Doctor: ${currentDoctorModel != null}, Home: ${homeDataModel != null}');
        _handleUnauthenticatedUser(context);
        return;
      }

      // Get the ShowSingleFeedCubit to fetch post data
      final showSingleFeedCubit = di.sl<ShowSingleFeedCubit>();
      
      // Fetch the post data
      final post = await showSingleFeedCubit.getPostByIdWhenComeFromNotification(postId);
      
      // No need to close loading dialog since we removed it
      
      debugPrint('Both models found, navigating to ShowSingleFeedScreen');
      
      // Navigate to ShowSingleFeedScreen
      // The back button will naturally go back to the previous screen
      Navigator.of(context).pushNamed(
        AppRoutes.showSingleFeed,
        arguments: {
          'currentDoctorModel': currentDoctorModel,
          'homeDataModel': homeDataModel,
          'feed': post,
          'isComeFromNotification': true,
          'feedId': postId,
          'showPostFrom': ShowPostFromEnum.notification.name,

        },
      );
    } catch (e) {
      debugPrint('Error navigating to post from deep link: $e');
      _showErrorDialog(context);
    }
  }

  Future<DoctorModel?> _getCurrentDoctorModel() async {
    try {
      // Get current doctor model using AppPreferences
      final appPreferences = di.sl<AppPreferences>();
      final doctorModel = await appPreferences.getDoctorData();
      return doctorModel;
    } catch (e) {
      debugPrint('Error getting current doctor model: $e');
    }
    return null;
  }

  Future<HomeModelResponse?> _getHomeDataModelFromCubit() async {
    try {
      // Get home data model from HomeCubit
      final homeCubit = di.sl<HomeCubit>();
      
      // Check if home data is already loaded
      if (homeCubit.homeDataModel.data != null) {
        return homeCubit.homeDataModel;
      }
      
      // If not loaded, trigger the home request
      await homeCubit.getHome();
      
      // Return the home data after loading
      return homeCubit.homeDataModel;
    } catch (e) {
      debugPrint('Error getting home data model from cubit: $e');
    }
    return null;
  }

  void _handleUnauthenticatedUser(BuildContext context) {
    // Navigate to login screen or show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please log in to view this post'),
        duration: Duration(seconds: 3),
      ),
    );
    
    // Optionally navigate to login screen
    Navigator.of(context).pushNamed(AppRoutes.signIn);
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Unable to load the post. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
} 



