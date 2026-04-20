import 'dart:developer';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

class BuildFilterWidget extends StatefulWidget {
  final List<GetFiltersOptionsDataModelResponse>? filters;
  final dynamic cubit;
  final bool isCurrentDoctor;
  const BuildFilterWidget({
    super.key,
    required this.filters,
    required this.cubit,
    required this.isCurrentDoctor,
  });

  @override
  State<BuildFilterWidget> createState() => _BuildFilterWidgetState();
}

class _BuildFilterWidgetState extends State<BuildFilterWidget> {
  @override
  void initState() {
    super.initState();
    // Call textFormFieldControllersInit if the method exists
    if (widget.cubit != null && widget.filters != null) {
      try {
        widget.cubit.setFiltersForRequest(widget.filters);
        widget.cubit.textFormFieldControllersInit(widget.filters!);
      } catch (e) {
        // Handle case where method doesn't exist
        log('textFormFieldControllersInit not available: $e');
      }
    }
  }

  String? _extractDateFromString(String? dateString, String key) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      // Handle format like {from:2025-10-05,to:2025-10-05} or {from:2025-10-05} or {to:2025-10-05}
      if (dateString.contains('$key:')) {
        final parts = dateString.split('$key:');
        if (parts.length > 1) {
          // Get the part after the key, then split by comma or closing brace
          final datePart = parts[1].split(',')[0].split('}')[0];
          return datePart;
        }
      }
    } catch (e) {
      log('Error extracting date: $e');
    }
    return null;
  }

  String? _extractNumberFromString(String? numberString, String key) {
    if (numberString == null || numberString.isEmpty) return null;

    try {
      // Handle format like {from:100,to:500} or {from:100} or {to:500}
      if (numberString.contains('$key:')) {
        final parts = numberString.split('$key:');
        if (parts.length > 1) {
          // Get the part after the key, then split by comma or closing brace
          final numberPart = parts[1].split(',')[0].split('}')[0];
          return numberPart;
        }
      }
    } catch (e) {
      log('Error extracting number: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
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
                          color: isDarkMode
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
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
                            color: isDarkMode ? Colors.white : Colors.black,
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
                                      color: isDarkMode
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(
                                color: isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
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
                  color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            try {
                              widget.cubit.resetFormData();
                              setState(() {});
                            } catch (e) {
                              log('resetFormData not available: $e');
                            }
                          },
                          title: context.tr(AppStrings.reset),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            navigatorKey.currentState?.pop();
                            try {
                              widget.cubit.applyPatientFilters(
                                  widget.isCurrentDoctor ? 'true' : 'false');
                            } catch (e) {
                              log('applyPatientFilters not available: $e');
                            }
                          },
                          title: context.tr(AppStrings.apply),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFilters(
    GetFiltersOptionsDataModelResponse filter,
    int index,
    dynamic cubit,
  ) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        switch (filter.type) {
          case 'string':
            return CustomTextFormField(
              title: filter.condition.toString(),
              textFormFieldController:
                  widget.cubit.controllers[filter.id.toString()],
              textInputType: filter.keyboardType == 'number'
                  ? TextInputType.phone
                  : filter.keyboardType == 'email'
                      ? TextInputType.emailAddress
                      : filter.keyboardType == 'date'
                          ? TextInputType.datetime
                          : TextInputType.text,
              textInputAction: TextInputAction.next,
              // initialValue: widget.cubit.formData[filter.id.toString()] == null ||
              //         widget.cubit.formData[filter.id.toString()] == ''
              //     ? null
              //     : widget.cubit.formData[filter.id.toString()],
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
              ],
              validator: (value) {
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.cubit.formData[filter.id.toString()] =
                      value.toString();
                });
                log(widget.cubit.formData.toString());
              },
            );
          case 'select':
            // var questionAnswer = cubit.questionModelList[widget.index].answer;
            dynamic selectedValue;
            return Container(
              // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<dynamic>(
                hint: Text(
                  selectedValue ?? context.tr(AppStrings.choose),
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade300 : Colors.black,
                  ),
                ),
                validator: (value) {
                  return null;
                },
                value: widget.cubit.formData[filter.id.toString()] == null ||
                        widget.cubit.formData[filter.id.toString()] == ''
                    ? selectedValue
                    : widget.cubit.formData[filter.id.toString()],

                items: filter.values!.map((value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    widget.cubit.formData[filter.id.toString()] =
                        value.toString();
                  });
                  log(widget.cubit.formData.toString());
                },
                isExpanded: true,
                menuMaxHeight: 200, // Limit dropdown list height
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
                        groupValue: widget.cubit.formData[
                            filter.id.toString()], // current selected value
                        onChanged: (value) {
                          setState(() {
                            widget.cubit.formData[filter.id.toString()] =
                                value!;
                          });
                          log(widget.cubit.formData.toString());
                        },
                      ),
                      Text(
                        answer,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          case 'multiple':
            {
              final stored = widget.cubit.formData[filter.id.toString()];
              final List<String> selectedList =
                  stored != null && stored.toString().trim().isNotEmpty
                      ? stored
                          .toString()
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList()
                      : [];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filter.values!.map((value) {
                  final valueStr = value.toString();
                  final isSelected = selectedList.contains(valueStr);
                  return Theme(
                    data: Theme.of(context).copyWith(
                      chipTheme: Theme.of(context).chipTheme.copyWith(
                        checkmarkColor: Colors.white,
                      ),
                    ),
                    child: ChoiceChip(
                      label: Text(
                        valueStr,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: isDarkMode
                          ? Colors.grey.shade700
                          : Colors.grey.shade400,
                      selected: isSelected,
                      selectedColor: AppColors.primary.withOpacity(0.7),
                      onSelected: (selected) {
                      setState(() {
                        final List<String> updated = List.from(selectedList);
                        if (selected) {
                          if (!updated.contains(valueStr))
                            updated.add(valueStr);
                        } else {
                          updated.remove(valueStr);
                        }
                        widget.cubit.formData[filter.id.toString()] =
                            updated.join(',');
                      });
                      log(widget.cubit.formData.toString());
                    },
                    ),
                  );
                }).toList(),
              );
            }
          case 'date_range':
            return Row(
              children: [
                // From Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.tr(AppStrings.from)}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: isDarkMode
                                      ? const ColorScheme.dark(
                                          primary: AppColors.primary,
                                          onPrimary: Colors.white,
                                          surface: Colors.grey,
                                          onSurface: Colors.white,
                                        )
                                      : const ColorScheme.light(
                                          primary: AppColors.primary,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              // Get existing to date if it exists
                              final existingTo = _extractDateFromString(
                                  widget.cubit.formData['${filter.id}'], 'to');
                              final fromDate =
                                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

                              // Build the complete string with both from and to dates
                              String newValue = '{from:$fromDate';
                              if (existingTo != null) {
                                newValue += ',to:$existingTo';
                              }
                              newValue += '}';

                              widget.cubit.formData['${filter.id}'] = newValue;
                            });
                            log(widget.cubit.formData.toString());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _extractDateFromString(
                                          widget.cubit.formData['${filter.id}'],
                                          'from') ??
                                      context.tr(AppStrings.selectDate),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // To Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.tr(AppStrings.to)}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: isDarkMode
                                      ? const ColorScheme.dark(
                                          primary: AppColors.primary,
                                          onPrimary: Colors.white,
                                          surface: Colors.grey,
                                          onSurface: Colors.white,
                                        )
                                      : const ColorScheme.light(
                                          primary: AppColors.primary,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              // Get existing from date if it exists
                              final existingFrom = _extractDateFromString(
                                  widget.cubit.formData['${filter.id}'],
                                  'from');
                              final toDate =
                                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

                              // Build the complete string with both from and to dates
                              String newValue = '';
                              if (existingFrom != null) {
                                newValue += '{from:$existingFrom,to:$toDate}';
                              } else {
                                newValue = '{to:$toDate}';
                              }

                              widget.cubit.formData['${filter.id}'] = newValue;
                            });
                            log(widget.cubit.formData.toString());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _extractDateFromString(
                                          widget.cubit.formData['${filter.id}'],
                                          'to') ??
                                      context.tr(AppStrings.selectDate),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case 'number_range':
            return Row(
              children: [
                // From Number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.tr(AppStrings.from)}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final fromKey = '${filter.id}_from';
                          final existingFromText = _extractNumberFromString(
                                  widget.cubit.formData['${filter.id}'],
                                  'from') ??
                              '';
                          final fromController =
                              widget.cubit.controllers[fromKey] ??
                                  TextEditingController(
                                    text: existingFromText,
                                  );
                          widget.cubit.controllers[fromKey] = fromController;

                          return CustomTextFormField(
                            title: context.tr(AppStrings.from),
                            textFormFieldController: fromController,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                // Get existing to number if it exists
                                final existingTo = _extractNumberFromString(
                                    widget.cubit.formData['${filter.id}'],
                                    'to');

                                // Build the complete string with both from and to numbers
                                String newValue = '{from:$value';
                                if (existingTo != null) {
                                  newValue += ',to:$existingTo';
                                }
                                newValue += '}';

                                widget.cubit.formData['${filter.id}'] =
                                    newValue;
                              });
                              log(widget.cubit.formData.toString());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // To Number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.tr(AppStrings.to)}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final toKey = '${filter.id}_to';
                          final existingToText = _extractNumberFromString(
                                  widget.cubit.formData['${filter.id}'],
                                  'to') ??
                              '';
                          final toController =
                              widget.cubit.controllers[toKey] ??
                                  TextEditingController(
                                    text: existingToText,
                                  );
                          widget.cubit.controllers[toKey] = toController;

                          return CustomTextFormField(
                            title: context.tr(AppStrings.to),
                            textFormFieldController: toController,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                // Get existing from number if it exists
                                final existingFrom = _extractNumberFromString(
                                    widget.cubit.formData['${filter.id}'],
                                    'from');

                                // Build the complete string with both from and to numbers
                                String newValue = '';
                                if (existingFrom != null) {
                                  newValue += '{from:$existingFrom,to:$value}';
                                } else {
                                  newValue = '{to:$value}';
                                }

                                widget.cubit.formData['${filter.id}'] =
                                    newValue;
                              });
                              log(widget.cubit.formData.toString());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
