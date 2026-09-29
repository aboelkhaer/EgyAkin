import 'package:egy_akin/app/shared/functions/doctor_name.dart';
import 'package:egy_akin/app/shared/widgets/custom_cached_network_image.dart';
import 'package:egy_akin/app/shared/widgets/local_profile_avatar_image.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Safe remote image URL for a [DoctorModel] (never the literal `"null"`).
String? doctorImageUrl(DoctorModel? doctor) {
  final raw = doctor?.image?.trim();
  if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
  return raw;
}

/// Display name for a doctor; empty when nothing usable is available.
String doctorDisplayName(
  DoctorModel? doctor, {
  String fallback = '',
}) {
  if (doctor == null) return fallback;
  final name = doctorName(
    firstName: doctor.firstName,
    lastName: doctor.lastName,
    role: doctor.isSyndicateCardRequired?.toString() ?? '',
  ).trim();
  if (name.isNotEmpty) return name;
  return fallback;
}

String doctorInitials(DoctorModel? doctor, {String fallback = 'DR'}) {
  final first = doctor?.firstName?.trim() ?? '';
  final last = doctor?.lastName?.trim() ?? '';
  if (first.isEmpty && last.isEmpty) return fallback;
  if (last.isEmpty) return first[0].toUpperCase();
  if (first.isEmpty) return last[0].toUpperCase();
  return '${first[0]}${last[0]}'.toUpperCase();
}

bool doctorIsVerified(DoctorModel? doctor) =>
    doctor?.isSyndicateCardRequired == 'Verified';

/// Prefer [HomeCubit]'s doctor when [doctor] is the signed-in user (or an
/// incomplete local copy), so community strips / comments keep the real photo
/// and display name.
DoctorModel? resolveDoctorForAvatar(DoctorModel? doctor) {
  DoctorModel? homeDoctor;
  String? homeVerification;
  try {
    final home = resolveHomeCubit();
    homeDoctor = home.currentDoctorModel;
    homeVerification = home.homeDataModel.isSyndicateCardRequired?.toString();
  } catch (_) {
    return doctor;
  }
  if (homeDoctor.id == null) return doctor;
  if (doctor == null) {
    final role = homeDoctor.isSyndicateCardRequired ?? homeVerification;
    if (role == null || role == homeDoctor.isSyndicateCardRequired) {
      return homeDoctor;
    }
    return homeDoctor.copyWith(isSyndicateCardRequired: role);
  }
  if (doctor.id != null && doctor.id != homeDoctor.id) return doctor;

  final image =
      doctorImageUrl(doctor) ?? doctorImageUrl(homeDoctor) ?? homeDoctor.image;
  final first = (doctor.firstName?.trim().isNotEmpty ?? false)
      ? doctor.firstName
      : homeDoctor.firstName;
  final last = (doctor.lastName?.trim().isNotEmpty ?? false)
      ? doctor.lastName
      : homeDoctor.lastName;
  final role = doctor.isSyndicateCardRequired ??
      homeDoctor.isSyndicateCardRequired ??
      homeVerification;

  return doctor.copyWith(
    id: doctor.id ?? homeDoctor.id,
    image: image,
    firstName: first,
    lastName: last,
    isSyndicateCardRequired: role,
  );
}

/// Circular doctor avatar used across community comments, replies, and posts.
///
/// Uses the local profile cache when [doctor] is the signed-in user so home /
/// create-post / comments stay consistent after account switches.
class DoctorCircleAvatar extends StatelessWidget {
  final DoctorModel? doctor;
  final double size;
  final Color primary;
  final BoxFit fit;

  const DoctorCircleAvatar({
    super.key,
    required this.doctor,
    required this.size,
    required this.primary,
    this.fit = BoxFit.cover,
  });

  bool _isCurrentUser(DoctorModel? effective) {
    final id = effective?.id;
    if (id == null) return false;
    try {
      return resolveHomeCubit().currentDoctorModel.id == id;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effective = resolveDoctorForAvatar(doctor);
    final url = doctorImageUrl(effective);
    final initials = doctorInitials(effective);
    final isMe = _isCurrentUser(effective);

    Widget child;
    if (isMe) {
      child = LocalProfileAvatarImage(
        imageUrl: url,
        userId: effective?.id,
        width: size,
        height: size,
        fit: fit,
        fallback: _InitialsFallback(
          initials: initials,
          primary: primary,
          size: size,
        ),
      );
    } else if (url != null) {
      child = CustomCachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: fit,
        showLoaderPlaceholder: false,
      );
    } else {
      child = _InitialsFallback(
        initials: initials,
        primary: primary,
        size: size,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primary.withOpacity(0.25), width: 1.2),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.2.w),
          child: ClipOval(child: child),
        ),
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  final String initials;
  final Color primary;
  final double size;

  const _InitialsFallback({
    required this.initials,
    required this.primary,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primary.withOpacity(0.12),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: (size * 0.36).sp,
            color: primary,
          ),
        ),
      ),
    );
  }
}
