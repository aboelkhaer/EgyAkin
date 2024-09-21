import '../../../../exports.dart';

class GfrCalculatorScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  const GfrCalculatorScreen({super.key, required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    GfrCalculatorCubit cubit = GfrCalculatorCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GFR Calculator'),
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
                      'Equation type',
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
                                            child: const Text('Close'),
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
                                            child: const Text('Close'),
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
                                            child: const Text('Close'),
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
                                      'Height',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomTextFormField(
                                      title: 'Height/cm',
                                      textInputType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter height';
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
                                      'Weight',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomTextFormField(
                                      title: 'Weight/kg',
                                      textInputType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter weight';
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
                                'Black Race',
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
                                            'Yes',
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
                                            'No',
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
                            'Age',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            title: 'Age',
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter age';
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
                            'Creatinine (mg/dL)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            title: 'Creatinine (mg/dL)',
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter creatinine level';
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
                      'Gender',
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
                                  'Male',
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
                                  'Female',
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
                  title: 'Calculate',
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
                      'Temporary History',
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
