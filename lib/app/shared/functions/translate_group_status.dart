import 'package:flutter/material.dart';
import '../../utilities/translation_extension.dart';

String translateGroupStatus(String status, BuildContext context) {
  switch (status.toLowerCase()) {
    case 'invited':
      return context.tr('Invited');
    case 'accepted':
      return context.tr('Accepted');
    case 'declined':
      return context.tr('Declined');
    case 'pending':
      return context.tr('Pending');
    case 'joined':
      return context.tr('Joined');
    default:
      return context.tr('Join'); // Default fallback
  }
} 