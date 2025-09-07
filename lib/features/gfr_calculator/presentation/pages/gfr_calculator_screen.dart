import '../../../../exports.dart';

class GfrCalculatorScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  const GfrCalculatorScreen({super.key, required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    GfrCalculatorCubit cubit = GfrCalculatorCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(context.tr(AppStrings.gfrCalculator)),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.tr(AppStrings.equationType),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Wrap(
                          children: [
                            ListTile(
                              title: Text(
                                'CKD-EPI',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              leading: Radio<String>(
                                value: 'CKD-EPI',
                                groupValue: cubit.equationType,
                                onChanged: (String? value) {
                                  cubit.changeEquationTypeValue(value!);
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FullScreenImage(
                                                  imageUrl: AppImages.ckd,
                                                  isLocal: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: Image.asset(
                                                  AppImages.ckd,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child:  Text(context.tr(AppStrings.close)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 20.r,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Sobh Equation',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              leading: Radio<String>(
                                value: 'Sobh Equation',
                                groupValue: cubit.equationType,
                                onChanged: (String? value) {
                                  cubit.changeEquationTypeValue(value!);
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FullScreenImage(
                                                  imageUrl: AppImages.sobh,
                                                  isLocal: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: Image.asset(
                                                  AppImages.sobh,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child:  Text(context.tr(AppStrings.close)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 20.r,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'MDRD',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              leading: Radio<String>(
                                value: 'MDRD',
                                groupValue: cubit.equationType,
                                onChanged: (String? value) {
                                  cubit.changeEquationTypeValue(value!);
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FullScreenImage(
                                                  imageUrl: AppImages.mdrd,
                                                  isLocal: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: Image.asset(
                                                  AppImages.mdrd,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child:  Text(context.tr(AppStrings.close)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 20.r,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                  builder: (context, state) {
                    if (cubit.equationType != 'Sobh Equation') {
                      return const SizedBox.shrink();
                    }
                    return FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.tr(AppStrings.height),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomTextFormField(
                                      title: context.tr(AppStrings.heightCm),
                                      textInputType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return context.tr(AppStrings.pleaseEnterHeight);
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        cubit.heightForm = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.tr(AppStrings.weight),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomTextFormField(
                                      title: context.tr(AppStrings.weightKg),
                                      textInputType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return context.tr(AppStrings.pleaseEnterWeight);



                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        cubit.weightForm = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                  builder: (context, state) {
                    if (cubit.equationType != 'MDRD') {
                      return const SizedBox.shrink();
                    }
                    return FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                context.tr(AppStrings.blackRace),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            context.tr(AppStrings.yes),
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          leading: Radio<String>(
                                            value: 'Yes',
                                            groupValue: cubit.isBlackForm,
                                            onChanged: (String? value) {
                                              cubit
                                                  .changeBlackRaceValue(value!);
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            context.tr(AppStrings.no),
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          leading: Radio<String>(
                                            value: 'No',
                                            groupValue: cubit.isBlackForm,
                                            onChanged: (String? value) {
                                              cubit
                                                  .changeBlackRaceValue(value!);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr(AppStrings.age),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            title: context.tr(AppStrings.age),
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr(AppStrings.pleaseEnterAge);
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.ageForm = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr(AppStrings.creatinineMgDl),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            title: context.tr(AppStrings.creatinineMgDl),
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr(AppStrings.pleaseEnterCreatinineLevel);
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.creatinineForm = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                   
                    Text(
                      context.tr(AppStrings.gender),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  context.tr(AppStrings.male),
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                leading: Radio<String>(
                                  value: 'Male',
                                  groupValue: cubit.genderForm,
                                  onChanged: (String? value) {
                                    cubit.changeGenderValue(value!);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  context.tr(AppStrings.female),
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                leading: Radio<String>(
                                  value: 'Female',
                                  groupValue: cubit.genderForm,
                                  onChanged: (String? value) {
                                    cubit.changeGenderValue(value!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 30.h),
                CustomElevatedButton(
                  onPressed: () => cubit.calculateGFR(context),
                  title: context.tr(AppStrings.calculate),
                ),
                // BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                //   builder: (context, state) {
                //     if (homeDataModel.role == 'Admin') {
                //       return Column(
                //         children: [
                //           SizedBox(height: 20.h),
                //           Text(
                //             'Disclaimer: The results are for informational purposes only and should not be used as a substitute for professional medical advice. Always seek the advice of your physician or another qualified health provider with any questions you may have regarding a medical condition.',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12.0.sp,
                //               color: Colors.red,
                //             ),
                //           ),
                //         ],
                //       );
                //     }
                //     return const SizedBox.shrink();
                //   },
                // ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text(
                      context.tr(AppStrings.temporaryHistory),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                BlocBuilder<GfrCalculatorCubit, GfrCalculatorState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.gfrHistory.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(formatDateTime2(
                                    cubit.gfrHistory[index].date!)),
                                Text(cubit.gfrHistory[index].result!),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
