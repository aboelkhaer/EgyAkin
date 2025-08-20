import 'dart:developer';

import 'package:egy_akin/features/patient_section_details/data/models/patient_recommendation_model.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';

import '../../../../exports.dart';

class BuildDoseSection extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final SectionModel sectionModel;
  final bool finalSubmitStatus;
  final String patientId;
  final String doctorId;
  final HomeModelResponse homeDataModel;

  const BuildDoseSection({
    super.key,
    required this.currentDoctorModel,
    required this.sectionModel,
    required this.finalSubmitStatus,
    required this.patientId,
    required this.doctorId,
    required this.homeDataModel,
  });

  @override
  State<BuildDoseSection> createState() => _BuildDoseSectionState();
}

class _BuildDoseSectionState extends State<BuildDoseSection> {
  late TextEditingController searchContentController;
  late TextEditingController doseController;
  late TextEditingController routeController;
  late TextEditingController frequencyController;
  late TextEditingController durationController;
  String searchText = '';
  String _lastSearchText = ''; // Track last searched text to prevent duplicates
  final GlobalKey _searchFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  Timer? _debounceTimer;
  bool _isOverlayVisible = false;
  bool _isSearching = false; // Track if a search is in progress
  bool _hasSearched = false; // Track if any search has been performed
  bool _isCreatingMedicine = false; // Track if creating medicine
  late PatientSectionDetailsCubit cubit;
  late ScrollController _searchScrollController;
  VoidCallback? _currentScrollListener;
  
  // Form validation state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    searchContentController = TextEditingController();
    doseController = TextEditingController();
    routeController = TextEditingController();
    frequencyController = TextEditingController();
    durationController = TextEditingController();
    _searchScrollController = ScrollController();
    cubit = PatientSectionDetailsCubit.get(context);
  }

  @override
  void dispose() {
    _removeOverlay();
    _debounceTimer?.cancel();
    searchContentController.dispose();
    doseController.dispose();
    routeController.dispose();
    frequencyController.dispose();
    durationController.dispose();
    _searchScrollController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOverlayVisible = false;
    }
    // Remove scroll listener when overlay is removed
    if (_currentScrollListener != null) {
      _searchScrollController.removeListener(_currentScrollListener!);
      _currentScrollListener = null;
    }
  }

  void _updateOverlay() {
    // Don't update overlay if search text is empty
    if (searchText.isEmpty) {
      _removeOverlay();
      return;
    }

    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
      return;
    }

    _showSearchOverlay();
  }

  void _showAddMedicationDialog(String medicationName, {String? doseValue}) {
    print('Showing Add New Dose dialog for: $medicationName with dose: $doseValue'); // Debug print
    // Hide overlay before showing bottom sheet
    _removeOverlay();
    
    // Pre-fill dose controller with dose value from search if available
    if (doseValue != null && doseValue.isNotEmpty) {
      // todo: add dose value to the dose controller
      // doseController.text = doseValue;
      print('Set dose controller text to: $doseValue'); // Debug print
    } else {
      print('No dose value provided or empty'); // Debug print
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Dose',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              medicationName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Clear controllers
                          doseController.clear();
                          routeController.clear();
                          frequencyController.clear();
                          durationController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Form Fields
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Dose Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Dose',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: doseController,
                                textInputType: TextInputType.multiline,
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter dose';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Route Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Route',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: routeController,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter route';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Frequency Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Frequency',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: frequencyController,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter frequency';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Duration Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: durationController,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter duration';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate form using Form validation
                        if (!_formKey.currentState!.validate()) {
                          // Form validation failed - errors will be shown on the fields
                          return;
                        }

                        // Create new medication
                        final newMedication = PatientRecommendationModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          doseName: medicationName,
                          dose: doseController.text,
                          route: routeController.text,
                          frequency: frequencyController.text,
                          duration: durationController.text,
                        );

                        // Add to list
                        cubit.addPatientRecommendation(
                            newMedication, widget.patientId);

                        // Clear and close
                        doseController.clear();
                        routeController.clear();
                        frequencyController.clear();
                        durationController.clear();
                        Navigator.pop(context);
                        searchContentController.clear();
                        setState(() {
                          searchText = '';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add Medicine',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditMedicationDialog(GetRecommendationsDataModelResponse medication) {
    // Pre-fill the controllers with existing values
    doseController.text = medication.dose ?? '';
    routeController.text = medication.route ?? '';
    frequencyController.text = medication.frequency ?? '';
    durationController.text = medication.duration ?? '';

    // Store original values for comparison
    final originalDose = medication.dose ?? '';
    final originalRoute = medication.route ?? '';
    final originalFrequency = medication.frequency ?? '';
    final originalDuration = medication.duration ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              // Function to check if any changes were made
              bool hasChanges() {
                return doseController.text != originalDose ||
                       routeController.text != originalRoute ||
                       frequencyController.text != originalFrequency ||
                       durationController.text != originalDuration;
              }

              // Add listeners to controllers to trigger state updates
              doseController.addListener(() => setState(() {}));
              routeController.addListener(() => setState(() {}));
              frequencyController.addListener(() => setState(() {}));
              durationController.addListener(() => setState(() {}));

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Medication',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                medication.doseName ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Clear controllers
                              // doseController.clear();
                              // routeController.clear();
                              // frequencyController.clear();
                              // durationController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Form Fields
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _editFormKey,
                          child: Column(
                            children: [
                              // Dose Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Dose',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        ' *',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextFormField(
                                    title: '',
                                    textFormFieldController: doseController,
                                    textInputType: TextInputType.multiline,
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter dose';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Route Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Route',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        ' *',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextFormField(
                                    title: '',
                                    textFormFieldController: routeController,
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter route';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Frequency Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Frequency',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        ' *',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextFormField(
                                    title: '',
                                    textFormFieldController: frequencyController,
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter frequency';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Duration Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Duration',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        ' *',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextFormField(
                                    title: '',
                                    textFormFieldController: durationController,
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter duration';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: hasChanges() ? () {
                            // Validate form using Form validation
                            if (!_editFormKey.currentState!.validate()) {
                              // Form validation failed - errors will be shown on the fields
                              return;
                            }

                            // Create updated medication
                            final updatedMedication = PatientRecommendationModel(
                              id: medication.id?.toString() ?? '',
                              doseName: medication.doseName ?? '',
                              dose: doseController.text,
                              route: routeController.text,
                              frequency: frequencyController.text,
                              duration: durationController.text,
                            );

                            // Update medication
                            cubit.updatePatientRecommendation(
                              updatedMedication,
                              widget.patientId,
                            );

                            // Clear and close
                            doseController.clear();
                            routeController.clear();
                            frequencyController.clear();
                            durationController.clear();
                            Navigator.pop(context);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasChanges() ? AppColors.primary : Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Update Medicine',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCreateNewMedicineDialog(String medicineName) {
    // Create a new controller with the preserved search text
    final medicineNameController = TextEditingController(text: medicineName);
    doseController.clear();
    
    // Add form key for validation
    final createFormKey = GlobalKey<FormState>();
    
    // Add description controller
    final descriptionController = TextEditingController();
    


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: createFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create New Medicine',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Add a new medicine',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Clear controllers
                            medicineNameController.dispose();
                            doseController.clear();
                            descriptionController.dispose();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Form Fields
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Medicine Name Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Medicine Name',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: medicineNameController,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter medicine name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Dose Field (now before Description, with red asterisk and required)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Dose',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: doseController,
                                textInputType: TextInputType.multiline,
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter dose';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Description Field (now after Dose, optional)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomTextFormField(
                                title: '',
                                textFormFieldController: descriptionController,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  // Description is optional, so no validation needed
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate form using FormKey
                          if (createFormKey.currentState!.validate()) {
                            // Store medicine info for later use
                            final medicineName = medicineNameController.text.trim();
                            final doseValue = doseController.text.trim();
                            print('Stored dose value: "$doseValue"'); // Debug print
                            
                            // Show loading dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Loading indicator
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Loading text
                                      Text(
                                        'Creating Medicine...',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Please wait while we save your medicine',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            
                            // Form is valid, create new medicine
                            final success = await cubit.createNewMedicine(
                              medicineName,
                              descriptionController.text.trim(),
                              doseValue,
                            );
                            
                            print('Medicine creation success: $success'); // Debug print

                            // Close loading dialog
                            Navigator.pop(context);
                            
                            // Close the create medicine dialog
                            Navigator.pop(context);

                            // If medicine was created successfully, show Add New Dose dialog
                            if (success) {
                              // Wait a bit for the dialog to close completely
                              await Future.delayed(const Duration(milliseconds: 500));
                              if (mounted) {
                                print('Calling _showAddMedicationDialog with doseValue: "$doseValue"'); // Debug print
                                _showAddMedicationDialog(
                                  medicineName,
                                  doseValue: doseValue,
                                );
                              }
                            }
                            
                            // Clean up controllers after dialog is closed
                            medicineNameController.dispose();
                            descriptionController.dispose();
                          } else {
                            // Form validation failed - errors will be shown on the fields
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                                                child: Text(
                          'Create Medicine',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayContent() {
    return BlocBuilder<PatientSectionDetailsCubit, PatientSectionDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        // Show loading state only for initial search, not for load more
        if (_isSearching ||
            state.maybeWhen(
              medicationSectionLoaded: (response,
                      changesCounter,
                      snackBarMessage,
                      dialogMessage,
                      isSubmitLoading,
                      isSubmitLoaded,
                      isSearchMedicationLoading,
                      searchForDoseInMedicationSectionResponse,
                      isDeletePatientRecommendationLoading,isSeeMore,) =>
                  isSearchMedicationLoading && !isSeeMore, // Only show full loading for initial search
              orElse: () => false,
            )) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text(
                  'Searching...',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        return state.maybeWhen(
          orElse: () => Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Type at least 1 character to search...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          medicationSectionLoaded: (
            response,
            changesCounter,
            snackBarMessage,
            dialogMessage,
            isSubmitLoading,
            isSubmitLoaded,
            isSearchMedicationLoading,
            searchForDoseInMedicationSectionResponse,
            isDeletePatientRecommendationLoading,isSeeMore,
          ) {
            // If no search has been performed yet, show instruction
            if (!_hasSearched) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Type at least 1 character to search...',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              );
            }

            // Use search results if available, otherwise show empty state
            if (searchForDoseInMedicationSectionResponse?.data == null ||
                searchForDoseInMedicationSectionResponse!.data!.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No medications found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        // Show dialog with current search text
                        _showCreateNewMedicineDialog(searchText);
                        // Clear after showing dialog
                        _removeOverlay();
                        searchContentController.clear();
                        setState(() {
                          searchText = '';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Create New Dose',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            final searchDataList =
                searchForDoseInMedicationSectionResponse.data!;

            return ListView.builder(
              controller: _searchScrollController,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: (searchDataList.data!.length + 
                  (state.maybeWhen(
                    medicationSectionLoaded: (response,
                            changesCounter,
                            snackBarMessage,
                            dialogMessage,
                            isSubmitLoading,
                            isSubmitLoaded,
                            isSearchMedicationLoading,
                            searchForDoseInMedicationSectionResponse,
                            isDeletePatientRecommendationLoading,isSeeMore,) =>
                        isSeeMore ? 1 : 0, // Add 1 for loading indicator
                    orElse: () => 0,
                  )) +
                  (searchDataList.data!.length >= 5 && 
                   !cubit.isLastPageInSearch && 
                   searchDataList.data!.isNotEmpty && 
                   !state.maybeWhen(
                     medicationSectionLoaded: (response,
                             changesCounter,
                             snackBarMessage,
                             dialogMessage,
                             isSubmitLoading,
                             isSubmitLoaded,
                             isSearchMedicationLoading,
                             searchForDoseInMedicationSectionResponse,
                             isDeletePatientRecommendationLoading,isSeeMore,) =>
                         isSeeMore,
                     orElse: () => false,
                   ) ? 1 : 0)).toInt(), // Add 1 for load more button
              itemBuilder: (context, index) {
                // Show search results
                if (index < searchDataList.data!.length) {
                  final searchData = searchDataList.data![index];
                  return InkWell(
                    onTap: () {
                      // Show add medication dialog
                      _showAddMedicationDialog(
                        searchData.title ?? 'Unknown',
                        doseValue: searchData.dose,
                      );
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchData.title ?? 'Unknown',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                if (searchData.dose != null)
                                  HtmlWidget(
                                    '${searchData.dose}'.toString(),
                                    textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, size: 20.r),
                            color: AppColors.primary,
                            onPressed: () {
                              // Show add medication dialog
                              _showAddMedicationDialog(
                                searchData.title ?? 'Unknown',
                                doseValue: searchData.dose,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
                // Show loading indicator
                if (state.maybeWhen(
                  medicationSectionLoaded: (response,
                          changesCounter,
                          snackBarMessage,
                          dialogMessage,
                          isSubmitLoading,
                          isSubmitLoaded,
                          isSearchMedicationLoading,
                          searchForDoseInMedicationSectionResponse,
                          isDeletePatientRecommendationLoading,isSeeMore,) =>
                      isSeeMore && index == searchDataList.data!.length,
                  orElse: () => false,
                )) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Loading more...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                // Show load more button
                if (searchDataList.data!.length >= 5 && 
                    !cubit.isLastPageInSearch && 
                    searchDataList.data!.isNotEmpty && 
                    !state.maybeWhen(
                      medicationSectionLoaded: (response,
                              changesCounter,
                              snackBarMessage,
                              dialogMessage,
                              isSubmitLoading,
                              isSubmitLoaded,
                              isSearchMedicationLoading,
                              searchForDoseInMedicationSectionResponse,
                              isDeletePatientRecommendationLoading,isSeeMore,) =>
                          isSeeMore,
                      orElse: () => false,
                    ) && 
                    index == searchDataList.data!.length + 
                        (state.maybeWhen(
                          medicationSectionLoaded: (response,
                                  changesCounter,
                                  snackBarMessage,
                                  dialogMessage,
                                  isSubmitLoading,
                                  isSubmitLoaded,
                                  isSearchMedicationLoading,
                                  searchForDoseInMedicationSectionResponse,
                                  isDeletePatientRecommendationLoading,isSeeMore,) =>
                              isSeeMore ? 1 : 0,
                          orElse: () => 0,
                        ))) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: GestureDetector(
                      onTap: () {
                        if (!cubit.isLoadingMoreForScrollInSearch) {
                          cubit.loadMoreSearchForDoseInMedicationSection(searchText);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Load More',
                              style: TextStyle(
                                color: AppColors.primary,
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
                
                return const SizedBox.shrink(); // Fallback empty widget
              },
            );
          },
        );
      },
    );
  }

  void _setupScrollListener() {
    void scrollListener() {
      if (_searchScrollController.position.pixels >=
          _searchScrollController.position.maxScrollExtent - 50) {
        // Load more when user scrolls near the bottom
        if (searchText.isNotEmpty) {
          // Check current state to see if we can load more
          final currentState = cubit.state;
          currentState.maybeWhen(
            medicationSectionLoaded: (response,
                    changesCounter,
                    snackBarMessage,
                    dialogMessage,
                    isSubmitLoading,
                    isSubmitLoaded,
                    isSearchMedicationLoading,
                    searchForDoseInMedicationSectionResponse,
                    isDeletePatientRecommendationLoading,isSeeMore,) {
              // Only load more if not currently loading and not at last page
              if (!isSeeMore && !cubit.isLastPageInSearch) {
                cubit.loadMoreSearchForDoseInMedicationSection(searchText);
              }
            },
            orElse: () {},
          );
        }
      }
    }
    
    _searchScrollController.addListener(scrollListener);
    
    // Store the listener reference for removal
    _currentScrollListener = scrollListener;
  }

  void _showSearchOverlay() {
    if (_isOverlayVisible || searchText.isEmpty) return;

    final RenderBox? renderBox =
        _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 20,
        top: position.dy + size.height + 10,
        width: size.width - 40,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _buildOverlayContent(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isOverlayVisible = true;
    
    // Setup scroll listener after overlay is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupScrollListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Hide overlay when tapping outside
          _removeOverlay();
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Search Bar - Only show if finalSubmitStatus is false
                    if (!widget.finalSubmitStatus) ...[
                      SizedBox(
                        key: _searchFieldKey,
                        height: 55,
                        child: CustomTextFormField(
                          textFormFieldController: searchContentController,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          showClearButton: true,
                          onClear: () {
                            setState(() {
                              searchText = '';
                              _hasSearched = false;
                            });
                            _removeOverlay();
                            // Reset pagination when search is cleared
                            cubit.currentPageInSearch = 1;
                            cubit.isLastPageInSearch = false;
                            cubit.isLoadingMoreForScrollInSearch = false;
                          },
                          onChanged: (value) {
                            // Cancel previous timer
                            _debounceTimer?.cancel();

                            // Update search text immediately for UI
                            setState(() {
                              searchText = value;
                              // Set searching state immediately when typing starts
                              if (value.isNotEmpty) {
                                _isSearching = true;
                                _hasSearched = true;
                              }
                            });

                            // Remove overlay if search is cleared
                            if (value.isEmpty) {
                              _removeOverlay();
                              _hasSearched = false;
                              _isSearching = false;
                              // Reset pagination when search is cleared
                              cubit.currentPageInSearch = 1;
                              cubit.isLastPageInSearch = false;
                              cubit.isLoadingMoreForScrollInSearch = false;
                              return;
                            }

                            // Show overlay immediately when typing
                            if (!_isOverlayVisible) {
                              _showSearchOverlay();
                            }

                            // Store the current value in a local variable
                            final currentValue = value;

                            // Perform search after a short delay
                            _debounceTimer =
                                Timer(const Duration(milliseconds: 300), () {
                              // Verify the value hasn't changed during the delay
                              if (currentValue == searchContentController.text) {
                                // Call cubit to search with the current value
                                cubit
                                    .searchForDoseInMedicationSection(
                                        currentValue)
                                    .then((_) {
                                  if (mounted) {
                                    setState(() {
                                      _isSearching = false;
                                    });
                                  }
                                }).catchError((_) {
                                  if (mounted) {
                                    setState(() {
                                      _isSearching = false;
                                    });
                                  }
                                });
                              }

                              _updateOverlay();
                            });
                          },
                          onTextClick: () {
                            if (searchText.isNotEmpty && !_isOverlayVisible) {
                              _showSearchOverlay();
                            }
                          },
                          title: 'Search with medication...',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a medication name';
                            }
                            return null;
                          },
                          contentPadding: const EdgeInsets.only(
                              left: 11, right: 11, top: 14, bottom: 14),
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    // Medications List
                    BlocBuilder<PatientSectionDetailsCubit,
                        PatientSectionDetailsState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () =>
                              const Center(child: CircularProgressIndicator()),
                          medicationSectionLoaded: (
                            response,
                            changesCounter,
                            snackBarMessage,
                            dialogMessage,
                            isSubmitLoading,
                            isSubmitLoaded,
                            isSearchMedicationLoading,
                            searchForDoseInMedicationSectionResponse,
                            isDeletePatientRecommendationLoading,
                            isSeeMore,
                          ) {
                            if (response.data == null) {
                              return const Center(
                                  child: Text('No data available'));
                            }

                            // Show all medications without filtering
                            final medications = response.data!;

                            if (medications.isEmpty) {
                              return const Center(
                                  child: Text('No medications available.'));
                            }

                            return Column(
                              children: [
                                ...medications
                                    .map((medication) => Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(14),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Top Row with name and actions
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          medication.doseName ??
                                                              'Unknown',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      // Only show edit/delete buttons if finalSubmitStatus is false
                                                      if (!widget.finalSubmitStatus || widget.homeDataModel.role == AppStrings.roleAdmin)
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.edit,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .blueAccent),
                                                              onPressed: () {
                                                                // Open edit modal
                                                                _showEditMedicationDialog(medication);
                                                              },
                                                            ),
                                                            isDeletePatientRecommendationLoading &&
                                                                    medication.id
                                                                            .toString() ==
                                                                        cubit
                                                                            .deletePatientRecommendationId
                                                                ? const IconButton(
                                                                    hoverColor: Colors
                                                                        .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onPressed:
                                                                        null,
                                                                    icon: SizedBox(
                                                                        width: 15,
                                                                        height: 15,
                                                                        child: CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                        )))
                                                                : IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        size: 20,
                                                                        color: Colors
                                                                            .redAccent),
                                                                    onPressed:
                                                                        () {
                                                                      // Show confirmation
                                                                      cubit.deletePatientRecommendationId =
                                                                          medication
                                                                              .id
                                                                              .toString();
                                                                      cubit.deletePatientRecommendation(
                                                                          widget
                                                                              .patientId);
                                                                    },
                                                                  ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  _buildInfoRow(
                                                      Icons
                                                          .medical_services_outlined,
                                                      'Dose: ${medication.dose ?? 'N/A'}'),
                                                  _buildInfoRow(
                                                      Icons.route_outlined,
                                                      'Route: ${medication.route ?? 'N/A'}'),
                                                  _buildInfoRow(
                                                      Icons.access_time,
                                                      'Frequency: ${medication.frequency ?? 'N/A'}'),
                                                  _buildInfoRow(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      'Duration: ${medication.duration ?? 'N/A'}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    // Add space at the bottom for the button
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // SectionSubmitButton(
            //   doctorId: widget.doctorId,
            //   currentDoctorModel: widget.currentDoctorModel,
            //   currentDoctorRole: widget.homeDataModel.role.toString(),
            //   sectionModel: widget.sectionModel,
            //   patientId: widget.patientId,
            //   currentDoctorPoints:
            //       int.parse(widget.homeDataModel.scoreValue.toString()),
            //   finalSubmitStatus: widget.finalSubmitStatus,
            //   homeDataModel: widget.homeDataModel,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey[800]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
