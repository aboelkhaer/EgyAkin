import 'package:egy_akin/app/utilities/formated_date.dart';

import '../../../../exports.dart';

class GfrCalculatorScreen extends StatelessWidget {
  const GfrCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GfrCalculatorCubit cubit = GfrCalculatorCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GFR Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Age',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                title: 'Age',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onChanged: (value) {
                  cubit.ageForm = value;
                },
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'Creatinine (mg/dL)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                title: 'Creatinine (mg/dL)',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your creatinine level';
                  }
                  return null;
                },
                onChanged: (value) {
                  cubit.creatinineForm = value;
                },
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
                              title: const Text('Male'),
                              leading: Radio<String>(
                                value: 'Male',
                                groupValue: cubit.genderForm,
                                onChanged: (String? value) {
                                  cubit.changeRadioButton(value!);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Female'),
                              leading: Radio<String>(
                                value: 'Female',
                                groupValue: cubit.genderForm,
                                onChanged: (String? value) {
                                  cubit.changeRadioButton(value!);
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
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
