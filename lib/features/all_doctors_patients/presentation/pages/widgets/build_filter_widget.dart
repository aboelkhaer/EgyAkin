import 'dart:developer';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';

class BuildFilterWidget extends StatefulWidget {
  final List<GetFiltersOptionsDataModelResponse>? filters;
  final AllDoctorsPatientsCubit cubit;
  const BuildFilterWidget({
    super.key,
    required this.filters,
    required this.cubit,
  });

  @override
  State<BuildFilterWidget> createState() => _BuildFilterWidgetState();
}

class _BuildFilterWidgetState extends State<BuildFilterWidget> {
  @override
  void initState() {
    super.initState();
    widget.cubit.textFormFieldControllersInit(widget.filters!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    width: 60.w,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      context.tr(AppStrings.createFilter),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.filters!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20) +
                      EdgeInsets.only(bottom: 60.h, top: 10),
                  itemBuilder: (context, index) {
                    var filter = widget.filters![index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                filter.condition.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 5),
                          buildFilters(
                            filter,
                            index,
                            widget.cubit,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        widget.cubit.resetFormData();
                        setState(() {});
                      },
                      title: context.tr(AppStrings.reset),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        navigatorKey.currentState?.pop();
                        widget.cubit.applyPatientFilters();
                      },
                      title: context.tr(AppStrings.apply),

                    ),
                  ),
                  // BlocBuilder<AllDoctorsPatientsCubit, AllDoctorsPatientsState>(
                  //   builder: (context, state) {
                  //     return state.maybeWhen(
                  //       orElse: () {
                  //         return const SizedBox.shrink();
                  //       },
                  //       loaded: (
                  //         response,
                  //         isSeeMore,
                  //         isFilterLoading,
                  //         isFilterLoaded,
                  //         message,
                  //         filters,
                  //         isApplyFilterLoading,
                  //         isApplyFilterLoaded,
                  //       ) {
                  //         return Expanded(
                  //           child: isApplyFilterLoading
                  //               ? const Row(
                  //                   children: [
                  //                     CircularProgressIndicator(),
                  //                   ],
                  //                 )
                  //               : CustomElevatedButton(
                  //                   onPressed: () {},
                  //                   title: 'Apply',
                  //                 ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilters(
    GetFiltersOptionsDataModelResponse filter,
    int index,
    AllDoctorsPatientsCubit cubit,
  ) {
    switch (filter.type) {
      case 'string':
        return CustomTextFormField(
          title: filter.condition.toString(),
          textFormFieldController: cubit.controllers[filter.id.toString()],
          textInputType: filter.keyboardType == 'number'
              ? TextInputType.phone
              : filter.keyboardType == 'email'
                  ? TextInputType.emailAddress
                  : filter.keyboardType == 'date'
                      ? TextInputType.datetime
                      : TextInputType.text,
          textInputAction: TextInputAction.next,
          // initialValue: cubit.formData[filter.id.toString()] == null ||
          //         cubit.formData[filter.id.toString()] == ''
          //     ? null
          //     : cubit.formData[filter.id.toString()],
          inputFormatters: [
            LengthLimitingTextInputFormatter(255),
          ],
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            setState(() {
              cubit.formData[filter.id.toString()] = value.toString();
            });
            log(cubit.formData.toString());
          },
        );
      case 'select':
        // var questionAnswer = cubit.questionModelList[widget.index].answer;
        dynamic selectedValue;
        return Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<dynamic>(
            hint: Text(selectedValue ?? context.tr(AppStrings.choose)),
            validator: (value) {
              return null;
            },
            value: cubit.formData[filter.id.toString()] == null ||
                    cubit.formData[filter.id.toString()] == ''
                ? selectedValue
                : cubit.formData[filter.id.toString()],

            items: filter.values!.map((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),

            onChanged: (value) {
              setState(() {
                cubit.formData[filter.id.toString()] = value.toString();
              });
              log(cubit.formData.toString());
            },
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            // decoration: const InputDecoration(label: Text('Choose')),
          ),
        );
      case 'checkbox':
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: filter.values!.map((answer) {
            return Expanded(
              child: Row(
                children: [
                  Radio<String>(
                    value: answer,
                    groupValue: cubit.formData[
                        filter.id.toString()], // current selected value
                    onChanged: (value) {
                      setState(() {
                        cubit.formData[filter.id.toString()] = value!;
                      });
                      log(cubit.formData.toString());
                    },
                  ),
                  Text(answer),
                ],
              ),
            );
          }).toList(),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
