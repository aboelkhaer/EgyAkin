import 'package:egy_akin/features/consultation_from_ai/presentation/cubit/consultation_from_ai_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../exports.dart';

class ConsultationFromAiScreen extends StatelessWidget {
  const ConsultationFromAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultationFromAICubit cubit = ConsultationFromAICubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Opinions'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 60.h,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile picture
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage:
                              const AssetImage('assets/images/ai.png'),
                        ),
                        const SizedBox(
                            width: 10), // Space between avatar and message

                        // Chat bubble
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Oh, It would be a dangerous trip. God bless!!!',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Timestamp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '00:13:23', // Example timestamp
                          style: TextStyle(
                            color: AppColors.description,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20) +
                    const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                child: CustomElevatedButton(
                    onPressed: () {}, title: 'Request AI Opinion'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
