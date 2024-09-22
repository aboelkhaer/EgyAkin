import '../../../../exports.dart';

class PostDetailsScreen extends StatefulWidget {
  final PostModel postModel;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  const PostDetailsScreen({
    super.key,
    required this.postModel,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.homeDataModel,
  });

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState() {
    context
        .read<PostDetailsCubit>()
        .getPostComments(widget.postModel.id.toString());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<PostDetailsCubit>();
    if (!cubit.isClosed && cubit.scrollController.hasClients) {
      cubit.scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    PostDetailsCubit cubit = PostDetailsCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: () =>
                cubit.getPostComments(widget.postModel.id.toString()),
            color: AppColors.primary,
            child: SingleChildScrollView(
              controller: cubit.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl: widget.postModel.image.toString(),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'postImage${widget.postModel.id}',
                      child: CachedNetworkImage(
                        imageUrl: widget.postModel.image.toString(),
                        width: double.infinity,
                        fadeInCurve: Curves.easeIn,
                        height: 160.h,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Lottie.asset(AppImages.imageLoader),
                        errorWidget: (context, url, error) {
                          return Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: AppColors.primary,
                                size: 40.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        PostTitle(title: widget.postModel.title.toString()),
                        SizedBox(height: 5.h),
                        PostDate(date: widget.postModel.updatedAt.toString()),
                        SizedBox(height: 15.h),
                        PostContent(
                            content: widget.postModel.content.toString()),
                        SizedBox(height: 20.h),
                        PostComments(
                          cubit: cubit,
                          currentDoctorModel: widget.currentDoctorModel,
                          currentDoctorRole: widget.currentDoctorRole,
                          homeDataModel: widget.homeDataModel,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AddCommentField(
              size: size,
              cubit: cubit,
              currentDoctorModel: widget.currentDoctorModel,
              accountVerification: widget.homeDataModel.verified ?? false,
              postModel: widget.postModel,
              isSyndicateCardRequired:
                  widget.homeDataModel.isSyndicateCardRequired.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
