import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/services/chat_block_service.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:get_it/get_it.dart';

import '../../../../exports.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  bool _loading = true;
  String? _error;
  final Set<int> _unblockingIds = {};

  ChatBlockService get _service => GetIt.I<ChatBlockService>();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await _service.refresh();
    if (!mounted) return;
    result.fold(
      (f) => setState(() {
        _loading = false;
        _error = f.message;
      }),
      (_) => setState(() => _loading = false),
    );
  }

  Future<void> _unblock(ChatUserModel user) async {
    final id = user.id;
    if (id == null || _unblockingIds.contains(id)) return;
    setState(() => _unblockingIds.add(id));
    final result = await _service.unblockUser(id);
    if (!mounted) return;
    setState(() => _unblockingIds.remove(id));
    result.fold(
      (_) => customSnackBar(
        context: context,
        message: context.tr(AppStrings.unblockFailed),
      ),
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final title = HomeDashboardColors.title(isDark);
        final sub = HomeDashboardColors.subtitle(isDark);

        return Scaffold(
          backgroundColor: scaffold,
          appBar: AppBar(
            backgroundColor: scaffold,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
              color: title,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text(
              context.tr(AppStrings.blockedUsers),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: title,
              ),
            ),
            centerTitle: true,
          ),
          body: _loading
              ? Center(child: CircularProgressIndicator(color: primary))
              : _error != null
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: sub, fontSize: 13.sp),
                            ),
                            SizedBox(height: 12.h),
                            TextButton(
                              onPressed: _refresh,
                              child: Text(context.tr(AppStrings.tryAgain)),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ValueListenableBuilder<int>(
                      valueListenable: _service.revision,
                      builder: (context, _, __) {
                        final users = _service.blockedUsers;
                        if (users.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.block_rounded,
                                    size: 40.sp,
                                    color: sub.withOpacity(0.5),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    context.tr(AppStrings.noBlockedUsers),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: title,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    context.tr(AppStrings.noBlockedUsersHint),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: sub,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return RefreshIndicator(
                          color: primary,
                          onRefresh: _refresh,
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                            itemCount: users.length,
                            separatorBuilder: (_, __) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              final user = users[index];
                              final name = ChatMappers.userDisplayName(user);
                              final initials = ChatMappers.userInitials(user);
                              final busy = user.id != null &&
                                  _unblockingIds.contains(user.id);
                              return Container(
                                decoration: HomeDashboardDecor.card(isDark),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          primary.withOpacity(0.12),
                                      backgroundImage:
                                          (user.image ?? '').isNotEmpty
                                              ? NetworkImage(user.image!)
                                              : null,
                                      child: (user.image ?? '').isEmpty
                                          ? Text(
                                              initials,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: primary,
                                              ),
                                            )
                                          : null,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700,
                                              color: title,
                                            ),
                                          ),
                                          if ((user.specialty ?? '')
                                              .trim()
                                              .isNotEmpty)
                                            Text(
                                              user.specialty!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: sub,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:
                                          busy ? null : () => _unblock(user),
                                      child: busy
                                          ? SizedBox(
                                              width: 16.w,
                                              height: 16.w,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              context.tr(AppStrings.unblock),
                                              style: TextStyle(
                                                color: primary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
