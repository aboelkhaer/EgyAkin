import 'dart:io';

import 'package:egy_akin/exports.dart' hide ImageSource;
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/services/chat_mute_prefs.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/app/shared/functions/reduce_image_resolution.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ChatInfoScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String displayName;
  final String? imageUrl;
  final String? initials;
  final bool isVerified;
  final String? chatType;
  final int? contextId;
  final int? conversationId;
  final bool isGroup;
  final List<ChatMessageItem> messages;

  const ChatInfoScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.displayName,
    this.imageUrl,
    this.initials,
    this.isVerified = false,
    this.chatType,
    this.contextId,
    this.conversationId,
    this.isGroup = false,
    this.messages = const [],
  });

  @override
  State<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends State<ChatInfoScreen>
    with SingleTickerProviderStateMixin {
  late final String _muteKey;
  late final AnimationController _intro;
  late final Animation<double> _fade;

  bool _muted = false;
  bool _ready = false;
  bool _leaving = false;
  bool _loadingMembers = false;
  bool _savingProfile = false;
  bool _pickingPhoto = false;
  bool _profileChanged = false;
  int? _removingUserId;
  bool _rosterChanged = false;
  String? _membersError;
  List<ChatUserModel> _participants = const [];
  String? _myRole;
  String? _displayName;
  String? _imageUrl;
  File? _localImageFile;
  String? _renamedTo;
  final List<String> _removedMemberNames = [];
  final List<String> _addedMemberNames = [];

  ChatRoomRepository get _repo => GetIt.I<ChatRoomRepository>();

  int? get _addressId {
    // Ad-hoc groups are addressed by conversation id.
    if (widget.chatType == ChatApiType.group) {
      return widget.conversationId ?? widget.contextId;
    }
    return widget.contextId;
  }

  /// Ad-hoc group admins can rename / change photo (not case/social groups).
  bool get _canEditGroupProfile =>
      widget.isGroup &&
      widget.chatType == ChatApiType.group &&
      _myRole == 'admin';

  @override
  void initState() {
    super.initState();
    _displayName = widget.displayName;
    _imageUrl = widget.imageUrl;
    _muteKey = ChatMutePrefs.keyFor(
      conversationId: widget.conversationId,
      chatType: widget.chatType,
      contextId: widget.contextId,
    );
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _intro.forward();
    unawaited(_load());
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    await ChatMutePrefs.ensureLoaded();
    if (!mounted) return;
    setState(() {
      _muted = ChatMutePrefs.isMuted(_muteKey);
      _ready = true;
    });
    if (widget.isGroup) await _loadMembers();
  }

  Future<void> _loadMembers() async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null || chatType.isEmpty) return;

    setState(() {
      _loadingMembers = true;
      _membersError = null;
    });

    final result = await _repo.getConversation(
      contextId: addressId,
      chatType: chatType,
    );
    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _loadingMembers = false;
        _membersError = failure.message;
        _participants = const [];
      }),
      (response) {
        final data = response.data;
        final participants = data?.participants ?? const <ChatUserModel>[];
        ChatUserModel? me;
        for (final p in participants) {
          if (p.id == widget.currentDoctorModel.id) {
            me = p;
            break;
          }
        }
        setState(() {
          _loadingMembers = false;
          _participants = participants;
          _myRole = data?.myRole;
          if (data?.name != null && data!.name!.trim().isNotEmpty) {
            _displayName = data.name!.trim();
          }
          if (data?.image != null && data!.image!.isNotEmpty) {
            _imageUrl = data.image;
          }
          if (me?.muteNotifications != null) {
            _muted = me!.muteNotifications!;
            unawaited(ChatMutePrefs.setMuted(_muteKey, _muted));
          }
          _membersError = null;
        });
      },
    );
  }

  Future<void> _toggleMute(bool value) async {
    setState(() => _muted = value);
    await ChatMutePrefs.setMuted(_muteKey, value);

    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null || chatType.isEmpty) return;

    final result = await _repo.setConversationMute(
      contextId: addressId,
      chatType: chatType,
      mute: value,
    );
    if (!mounted) return;
    result.fold(
      (failure) {
        setState(() => _muted = !value);
        unawaited(ChatMutePrefs.setMuted(_muteKey, !value));
        customSnackBar(context: context, message: failure.message);
      },
      (_) {},
    );
  }

  Future<void> _leaveGroup() async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null || _leaving) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          context.tr(AppStrings.leaveGroup),
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        content: Text(
          context.tr(AppStrings.groupChat),
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.tr(AppStrings.cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.tr(AppStrings.leaveGroup)),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    setState(() => _leaving = true);
    final result = await _repo.leaveConversation(
      contextId: addressId,
      chatType: chatType,
    );
    if (!mounted) return;
    setState(() => _leaving = false);
    result.fold(
      (failure) => customSnackBar(context: context, message: failure.message),
      (_) => Navigator.of(context).pop('left_group'),
    );
  }

  void _openMediaGallery() async {
    final result = await navigatorKey.currentState?.pushNamed(
      AppRoutes.chatMediaGallery,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
        'displayName': _displayName ?? widget.displayName,
        'messages': widget.messages,
        'chatType': widget.chatType,
        'contextId': widget.contextId,
        'conversationId': widget.conversationId,
        'peerImageUrl': _imageUrl ?? widget.imageUrl,
      },
    );
    if (!mounted) return;
    if (result is String && result.isNotEmpty) {
      Navigator.of(context).pop(result);
    }
  }

  Future<void> _openSearch() async {
    final result = await navigatorKey.currentState?.pushNamed(
      AppRoutes.chatSearch,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
        'peerDisplayName': _displayName ?? widget.displayName,
        'peerImageUrl': _imageUrl ?? widget.imageUrl,
        'messages': widget.messages,
        'chatType': widget.chatType,
        'contextId': widget.contextId,
        'conversationId': widget.conversationId,
      },
    );
    if (!mounted) return;
    if (result is String && result.isNotEmpty) {
      Navigator.of(context).pop(result);
    }
  }

  Future<void> _openAddMembers() async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null ||
        chatType == null ||
        chatType != ChatApiType.group ||
        _myRole != 'admin') {
      return;
    }

    final existingIds = <int>{
      for (final p in _participants)
        if (p.id != null) p.id!,
    };

    final result = await navigatorKey.currentState?.pushNamed(
      AppRoutes.chatAddMembers,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
        'conversationId': addressId,
        'chatType': chatType,
        'existingMemberIds': existingIds,
      },
    );
    if (!mounted) return;
    if (result == true ||
        (result is Map && result['added'] == true)) {
      _rosterChanged = true;
      if (result is Map) {
        final names = result['names'];
        if (names is List) {
          for (final n in names) {
            if (n is String && n.trim().isNotEmpty) {
              _addedMemberNames.add(n.trim());
            }
          }
        }
      }
      await _loadMembers();
    }
  }

  Future<void> _removeMember(ChatUserModel user) async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    final userId = user.id;
    if (addressId == null ||
        chatType == null ||
        userId == null ||
        _removingUserId != null) {
      return;
    }

    final ok = await _showRemoveMemberSheet(user);
    if (ok != true || !mounted) return;

    final removedName = ChatMappers.userDisplayName(user);
    setState(() => _removingUserId = userId);
    final result = await _repo.removeParticipant(
      contextId: addressId,
      chatType: chatType,
      userId: userId,
    );
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _removingUserId = null);
        customSnackBar(context: context, message: failure.message);
      },
      (_) {
        setState(() {
          _participants = [
            for (final p in _participants)
              if (p.id != userId) p,
          ];
          _removingUserId = null;
          _rosterChanged = true;
          if (removedName.trim().isNotEmpty) {
            _removedMemberNames.add(removedName.trim());
          }
        });
      },
    );
  }

  Future<bool?> _showRemoveMemberSheet(ChatUserModel user) {
    final name = ChatMappers.userDisplayName(user);
    final initials = ChatMappers.userInitials(user);
    final specialty = user.specialty?.trim();
    final image = user.image;

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final title = isDark ? Colors.white : const Color(0xFF111827);
        final sub = isDark ? Colors.white60 : const Color(0xFF6B7280);
        final primary = HomeDashboardColors.primary(isDark);

        return Padding(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 36.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: sub.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 54.w,
                      height: 54.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFF3B30).withOpacity(0.12),
                      ),
                      child: Icon(
                        Icons.person_remove_rounded,
                        color: const Color(0xFFFF3B30),
                        size: 26.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      context.tr(AppStrings.removeMember),
                      style: TextStyle(
                        color: title,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      context.tr(AppStrings.removeMemberConfirm),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: sub,
                        fontSize: 12.5.sp,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: primary.withOpacity(0.14),
                            child: image != null && image.isNotEmpty
                                ? ClipOval(
                                    child: CustomCachedNetworkImage(
                                      imageUrl: image,
                                      width: 36.r,
                                      height: 36.r,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(
                                    initials,
                                    style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.isEmpty ? '?' : name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: title,
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (specialty != null &&
                                    specialty.isNotEmpty) ...[
                                  SizedBox(height: 2.h),
                                  Text(
                                    specialty,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: sub,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF3B30),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          context.tr(AppStrings.remove),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        style: TextButton.styleFrom(
                          foregroundColor: sub,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          context.tr(AppStrings.cancel),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _popInfo([Object? result]) {
    if (result != null) {
      Navigator.of(context).pop(result);
      return;
    }
    if (_rosterChanged || _profileChanged) {
      Navigator.of(context).pop(<String, dynamic>{
        if (_rosterChanged) 'rosterUpdated': true,
        if (_rosterChanged)
          'participants': List<ChatUserModel>.of(_participants),
        if (_removedMemberNames.isNotEmpty)
          'removedNames': List<String>.of(_removedMemberNames),
        if (_addedMemberNames.isNotEmpty)
          'addedNames': List<String>.of(_addedMemberNames),
        if (_profileChanged) 'profileUpdated': true,
        if (_profileChanged)
          'displayName': _displayName ?? widget.displayName,
        if (_profileChanged) 'imageUrl': _imageUrl,
        if (_renamedTo != null && _renamedTo!.trim().isNotEmpty)
          'renamedTo': _renamedTo!.trim(),
      });
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _editGroupName() async {
    if (!_canEditGroupProfile || _savingProfile) return;
    HapticFeedback.selectionClick();
    final current = (_displayName ?? widget.displayName).trim();
    await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (ctx) {
        final bottom = MediaQuery.viewInsetsOf(ctx).bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: _RenameGroupSheet(
            initialName: current,
            onSave: (name) => _updateGroupProfile(
              name: name,
              showScreenLoading: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _changeGroupPhoto() async {
    if (!_canEditGroupProfile || _savingProfile || _pickingPhoto) return;
    HapticFeedback.selectionClick();

    setState(() => _pickingPhoto = true);
    late final File pickedFile;
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) {
        if (mounted) setState(() => _pickingPhoto = false);
        return;
      }
      try {
        pickedFile = await optimizeImage(File(picked.path));
      } catch (_) {
        pickedFile = File(picked.path);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _pickingPhoto = false);
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.groupUpdateFailed),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _pickingPhoto = false);

    // Let the pick loading state settle before presenting the dialog.
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (!mounted) return;

    final confirmed = await _showGroupPhotoConfirmDialog(pickedFile);
    if (!mounted) return;
    await Future<void>.delayed(const Duration(milliseconds: 240));
    if (!mounted) return;

    if (confirmed != true) return;

    final err = await _updateGroupProfile(image: pickedFile);
    if (err != null && mounted) {
      customSnackBar(context: context, message: err);
    }
  }

  Future<bool?> _showGroupPhotoConfirmDialog(File picked) {
    return showGeneralDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      barrierLabel: 'group-photo-confirm',
      barrierColor: const Color(0x99000000),
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        final dialogIsDark =
            Theme.of(dialogContext).brightness == Brightness.dark;
        final cardBg =
            dialogIsDark ? HomeDashboardColors.cardBg(true) : Colors.white;
        final titleColor = dialogIsDark
            ? HomeDashboardColors.title(true)
            : const Color(0xFF1F2937);
        final descColor = dialogIsDark
            ? HomeDashboardColors.subtitle(true)
            : const Color(0xFF6B7280);
        final primary = HomeDashboardColors.primary(dialogIsDark);
        final maxWidth = MediaQuery.sizeOf(dialogContext).width;
        final dialogWidth = maxWidth > 420 ? 340.0 : maxWidth - 48.0;

        return SafeArea(
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: dialogWidth,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tr(AppStrings.updateGroupPhoto),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primary.withOpacity(0.35),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.file(
                          picked,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          filterQuality: FilterQuality.medium,
                          cacheWidth: 280,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      context.tr(AppStrings.useThisPhotoAsGroupPicture),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1.35,
                        color: descColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: descColor,
                              side: BorderSide(
                                color: dialogIsDark
                                    ? HomeDashboardColors.border(true)
                                    : const Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              context.tr(AppStrings.cancel),
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              context.tr(AppStrings.confirm),
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final opacity = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        return FadeTransition(opacity: opacity, child: child);
      },
    );
  }

  /// Returns error text on failure, or `null` on success.
  Future<String?> _updateGroupProfile({
    String? name,
    File? image,
    bool showScreenLoading = true,
  }) async {
    final addressId = _addressId;
    final chatType = widget.chatType?.trim();
    final failedLabel = context.tr(AppStrings.groupUpdateFailed);
    if (addressId == null || chatType == null || chatType.isEmpty) {
      return failedLabel;
    }
    if (name == null && image == null) return null;

    if (showScreenLoading) {
      setState(() => _savingProfile = true);
    }
    final result = await _repo.updateConversation(
      contextId: addressId,
      chatType: chatType,
      name: name,
      image: image,
    );
    if (!mounted) return failedLabel;
    if (showScreenLoading) {
      setState(() => _savingProfile = false);
    }

    return result.fold(
      (failure) => failure.message.isNotEmpty ? failure.message : failedLabel,
      (response) {
        final data = response.data;
        setState(() {
          _profileChanged = true;
          if (name != null) {
            _displayName = name;
            _renamedTo = name;
          } else if (data?.name != null && data!.name!.trim().isNotEmpty) {
            _displayName = data.name!.trim();
          }
          if (image != null) {
            _localImageFile = image;
          }
          if (data?.image != null && data!.image!.isNotEmpty) {
            _imageUrl = data.image;
            _localImageFile = null;
          }
        });
        return null;
      },
    );
  }

  void _openDoctorProfile(ChatUserModel user) {
    final doctorId = user.id;
    if (doctorId == null) return;
    final home = widget.homeDataModel;
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId.toString(),
        initialIndex: 0,
        currentDoctorModel: widget.currentDoctorModel,
        isSyndicateCardRequired: home.isSyndicateCardRequired.toString(),
        accountVerification: home.verified ?? false,
        currentDoctorRole: home.role.toString(),
        currentDoctorPoints:
            int.tryParse(home.scoreValue?.toString() ?? '') ?? 0,
        homeDataModel: home,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final title = HomeDashboardColors.title(isDark);
        final sub = HomeDashboardColors.subtitle(isDark);
        final scaffold =
            isDark ? const Color(0xFF0B0B0F) : const Color(0xFFF2F2F7);
        final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final initials = (widget.initials ??
                ChatMappers.initialsFromTitle(
                    _displayName ?? widget.displayName))
            .toUpperCase();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: PopScope(
            // Allow the route to pop normally when there's nothing custom to
            // return — keeps swipe-back / system back smooth. When roster or
            // profile changed, intercept so we can pass the result map.
            canPop: !_rosterChanged && !_profileChanged,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) return;
              _popInfo();
            },
            child: Scaffold(
              backgroundColor: scaffold,
              appBar: AppBar(
                backgroundColor: scaffold,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: primary, size: 17.sp),
                  onPressed: _popInfo,
                ),
                title: Text(
                  context.tr(AppStrings.chatInfo),
                  style: TextStyle(
                    color: title,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
              body: FadeTransition(
                opacity: _fade,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 28.h),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (_canEditGroupProfile &&
                                !_savingProfile &&
                                !_pickingPhoto)
                            ? _changeGroupPhoto
                            : null,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              key: ValueKey(
                                _localImageFile?.path ??
                                    _imageUrl ??
                                    'group-avatar-fallback',
                              ),
                              radius: 36.r,
                              backgroundColor: primary.withOpacity(0.12),
                              backgroundImage: _localImageFile != null
                                  ? FileImage(_localImageFile!)
                                  : null,
                              child: _localImageFile != null
                                  ? null
                                  : (_imageUrl != null &&
                                          _imageUrl!.isNotEmpty
                                      ? ClipOval(
                                          child: ChatAuthCachedImage(
                                            imageUrl: _imageUrl!,
                                            width: 72.r,
                                            height: 72.r,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Text(
                                          initials,
                                          style: TextStyle(
                                            color: primary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                          ),
                                        )),
                            ),
                            if (_canEditGroupProfile)
                              Positioned(
                                right: -2.w,
                                bottom: -2.h,
                                child: Container(
                                  width: 26.r,
                                  height: 26.r,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: scaffold,
                                      width: 2,
                                    ),
                                  ),
                                  child: (_pickingPhoto || _savingProfile)
                                      ? Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 1.6,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Icon(
                                          Icons.camera_alt_rounded,
                                          size: 13.sp,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: _canEditGroupProfile ? _editGroupName : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              child: Text(
                                _displayName ?? widget.displayName,
                                key: ValueKey(
                                  _displayName ?? widget.displayName,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: title,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (_canEditGroupProfile) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.edit_rounded,
                              size: 14.sp,
                              color: primary,
                            ),
                          ],
                          if (widget.isVerified) ...[
                            SizedBox(width: 5.w),
                            Image.asset(
                              AppImages.verified,
                              height: 13.h,
                              width: 13.w,
                              color: Colors.green.shade600,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickBtn(
                            icon: Icons.search_rounded,
                            label: context
                                .tr(AppStrings.searchInChat)
                                .split(' ')
                                .first,
                            primary: primary,
                            title: title,
                            surface: surface,
                            onTap: _openSearch,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _QuickBtn(
                            icon: Icons.photo_library_outlined,
                            label: context.tr(AppStrings.mediaGallery),
                            primary: primary,
                            title: title,
                            surface: surface,
                            onTap: _openMediaGallery,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _Card(
                      surface: surface,
                      isDark: isDark,
                      child: _MuteRow(
                        muted: _ready && _muted,
                        enabled: _ready,
                        title: title,
                        sub: sub,
                        primary: primary,
                        onChanged: _toggleMute,
                      ),
                    ),
                    if (widget.isGroup) ...[
                      SizedBox(height: 18.h),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.tr(AppStrings.members).toUpperCase(),
                                style: TextStyle(
                                  color: sub,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            if (widget.chatType == ChatApiType.group &&
                                _myRole == 'admin')
                              TextButton.icon(
                                onPressed: _loadingMembers || _leaving
                                    ? null
                                    : _openAddMembers,
                                style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 0,
                                  ),
                                  minimumSize: Size(0, 28.h),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: Icon(
                                  Icons.person_add_alt_1_rounded,
                                  size: 16.sp,
                                ),
                                label: Text(
                                  context.tr(AppStrings.addMembers),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _Card(
                        surface: surface,
                        isDark: isDark,
                        child: _loadingMembers
                            ? const _MembersShimmer()
                            : _membersError != null
                                ? _MembersError(
                                    title: title,
                                    sub: sub,
                                    primary: primary,
                                    onRetry: _loadMembers,
                                  )
                                : _participants.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 22.h),
                                        child: Center(
                                          child: Text(
                                            context.tr(AppStrings.noMembersYet),
                                            style: TextStyle(
                                              color: sub,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          for (var i = 0;
                                              i < _participants.length;
                                              i++) ...[
                                            if (i > 0)
                                              Divider(
                                                height: 1,
                                                indent: 58.w,
                                                color: sub.withOpacity(0.12),
                                              ),
                                            _MemberRow(
                                              user: _participants[i],
                                              isMe: _participants[i].id ==
                                                  widget.currentDoctorModel.id,
                                              title: title,
                                              sub: sub,
                                              primary: primary,
                                              canRemove: _myRole == 'admin' &&
                                                  widget.chatType ==
                                                      ChatApiType.group &&
                                                  _participants[i].id !=
                                                      widget.currentDoctorModel
                                                          .id,
                                              removing:
                                                  _removingUserId != null &&
                                                      _removingUserId ==
                                                          _participants[i].id,
                                              removeEnabled:
                                                  _removingUserId == null,
                                              onRemove: () => _removeMember(
                                                  _participants[i]),
                                              onTap: _removingUserId ==
                                                      _participants[i].id
                                                  ? () {}
                                                  : () => _openDoctorProfile(
                                                      _participants[i]),
                                            ),
                                          ],
                                        ],
                                      ),
                      ),
                      if (widget.chatType == ChatApiType.group) ...[
                        SizedBox(height: 14.h),
                        _Card(
                          surface: surface,
                          isDark: isDark,
                          child: InkWell(
                            onTap: _leaving ? null : _leaveGroup,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Center(
                                child: _leaving
                                    ? SizedBox(
                                        width: 16.w,
                                        height: 16.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFFFF3B30),
                                        ),
                                      )
                                    : Text(
                                        context.tr(AppStrings.leaveGroup),
                                        style: TextStyle(
                                          color: const Color(0xFFFF3B30),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QuickBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primary;
  final Color title;
  final Color surface;
  final VoidCallback onTap;

  const _QuickBtn({
    required this.icon,
    required this.label,
    required this.primary,
    required this.title,
    required this.surface,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            children: [
              Icon(icon, color: primary, size: 18.sp),
              SizedBox(height: 5.h),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: title,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Color surface;
  final bool isDark;
  final Widget child;

  const _Card({
    required this.surface,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12.r),
        border:
            isDark ? Border.all(color: Colors.white.withOpacity(0.04)) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _MuteRow extends StatelessWidget {
  final bool muted;
  final bool enabled;
  final Color title;
  final Color sub;
  final Color primary;
  final ValueChanged<bool> onChanged;

  const _MuteRow({
    required this.muted,
    required this.enabled,
    required this.title,
    required this.sub,
    required this.primary,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 8.w, 8.h),
      child: Row(
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500),
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Icon(
              muted
                  ? Icons.notifications_off_rounded
                  : Icons.notifications_none_rounded,
              color: Colors.white,
              size: 15.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.muteNotifications),
                  style: TextStyle(
                    color: title,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  context.tr(AppStrings.muteNotificationsSubtitle),
                  style: TextStyle(
                    color: sub,
                    fontSize: 10.5.sp,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: muted,
            onChanged: enabled ? onChanged : null,
            activeColor: primary,
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final ChatUserModel user;
  final bool isMe;
  final Color title;
  final Color sub;
  final Color primary;
  final bool canRemove;
  final bool removing;
  final bool removeEnabled;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const _MemberRow({
    required this.user,
    required this.isMe,
    required this.title,
    required this.sub,
    required this.primary,
    required this.canRemove,
    required this.removing,
    this.removeEnabled = true,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = ChatMappers.userDisplayName(user);
    final initials = ChatMappers.userInitials(user);
    final specialty = user.specialty?.trim();
    final isAdmin = user.role == 'admin';

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: removing ? 0.55 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: removing ? null : onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: primary.withOpacity(0.12),
                  child: user.image != null && user.image!.isNotEmpty
                      ? ClipOval(
                          child: CustomCachedNetworkImage(
                            imageUrl: user.image!,
                            width: 36.r,
                            height: 36.r,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          initials,
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              isMe
                                  ? context.tr(AppStrings.you)
                                  : (name.isEmpty ? '?' : name),
                              style: TextStyle(
                                color: title,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isAdmin) ...[
                            SizedBox(width: 6.w),
                            Text(
                              context.tr(AppStrings.adminOfGroup),
                              style: TextStyle(
                                color: primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (specialty != null && specialty.isNotEmpty) ...[
                        SizedBox(height: 1.h),
                        Text(
                          specialty,
                          style: TextStyle(color: sub, fontSize: 11.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (canRemove)
                  removing
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          child: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFFF3B30),
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: removeEnabled ? onRemove : null,
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.remove_circle_outline_rounded,
                            color: const Color(0xFFFF3B30)
                                .withOpacity(removeEnabled ? 1 : 0.35),
                            size: 18.sp,
                          ),
                        )
                else
                  Icon(
                    Icons.chevron_right_rounded,
                    color: sub.withOpacity(0.55),
                    size: 18.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MembersShimmer extends StatelessWidget {
  const _MembersShimmer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final base = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA);
        final hi = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF2F2F7);

        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: hi,
          child: Column(
            children: List.generate(3, (_) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            height: 8.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _MembersError extends StatelessWidget {
  final Color title;
  final Color sub;
  final Color primary;
  final VoidCallback onRetry;

  const _MembersError({
    required this.title,
    required this.sub,
    required this.primary,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
      child: Column(
        children: [
          Text(
            context.tr(AppStrings.couldntLoadMembers),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              context.tr(AppStrings.tryAgain),
              style: TextStyle(
                color: primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RenameGroupSheet extends StatefulWidget {
  final String initialName;
  final Future<String?> Function(String name) onSave;

  const _RenameGroupSheet({
    required this.initialName,
    required this.onSave,
  });

  @override
  State<_RenameGroupSheet> createState() => _RenameGroupSheetState();
}

class _RenameGroupSheetState extends State<_RenameGroupSheet>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focus;
  late final AnimationController _enter;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
    _focus = FocusNode();
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic));
    _enter.forward().whenComplete(() {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _enter.dispose();
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _error = context.tr(AppStrings.groupNameRequired));
      return;
    }
    if (name == widget.initialName.trim()) {
      Navigator.of(context).pop();
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _saving = true;
      _error = null;
    });
    final err = await widget.onSave(name);
    if (!mounted) return;
    if (err != null) {
      HapticFeedback.heavyImpact();
      setState(() {
        _saving = false;
        _error = err;
      });
      return;
    }
    HapticFeedback.lightImpact();
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final title = isDark ? Colors.white : const Color(0xFF111827);
    final sub = isDark ? Colors.white60 : const Color(0xFF6B7280);
    final primary = HomeDashboardColors.primary(isDark);
    // Keyboard inset is applied by the parent bottom sheet — reading
    // viewInsets here caused rebuild thrash / panic while animating.

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 18.h),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.black.withOpacity(0.05),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: sub.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(0.14),
                    ),
                    child: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: primary,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    context.tr(AppStrings.editGroupName),
                    style: TextStyle(
                      color: title,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.tr(AppStrings.renameGroupSubtitle),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: sub,
                      fontSize: 11.sp,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  TextField(
                    controller: _controller,
                    focusNode: _focus,
                    enabled: !_saving,
                    maxLength: 255,
                    textInputAction: TextInputAction.done,
                    cursorHeight: 16.sp,
                    style: TextStyle(
                      color: title,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      counterText: '',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 11.h,
                      ),
                      hintText: context.tr(AppStrings.groupNameHint),
                      hintStyle: TextStyle(
                        color: sub,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: _error != null
                              ? const Color(0xFFFF3B30).withOpacity(0.55)
                              : (isDark
                                  ? Colors.white.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.08)),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: _error != null
                              ? const Color(0xFFFF3B30)
                              : primary,
                          width: 1.2,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.06),
                        ),
                      ),
                    ),
                    onChanged: (_) {
                      if (_error != null) setState(() => _error = null);
                    },
                    onSubmitted: (_) => _submit(),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: _error == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                _error!,
                                style: TextStyle(
                                  color: const Color(0xFFFF3B30),
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: TextButton(
                            onPressed: _saving
                                ? null
                                : () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: sub,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              context.tr(AppStrings.cancel),
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: _saving ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              disabledBackgroundColor:
                                  primary.withOpacity(0.55),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              child: _saving
                                  ? Row(
                                      key: const ValueKey('saving'),
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 14.r,
                                          height: 14.r,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 1.8,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Flexible(
                                          child: Text(
                                            context
                                                .tr(AppStrings.updatingGroup),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      key: const ValueKey('save'),
                                      context.tr(AppStrings.save),
                                      style: TextStyle(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
