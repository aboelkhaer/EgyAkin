import '../../../../exports.dart';

class EquationImplementation extends StatelessWidget {
  final String equationName;
  final String? currentCreatinineValue;
  final String? basalCreatinineValue;
  final String? creatinineOnDischargeValue;
  const EquationImplementation(
      {super.key,
      required this.equationName,
      this.currentCreatinineValue,
      this.basalCreatinineValue,
      this.creatinineOnDischargeValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 300.w,
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 0),
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.primary)),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '- Current Creatinine:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '- Basal Creatinine:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '- Creatinine: On Discharge',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentCreatinineValue.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        basalCreatinineValue.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        creatinineOnDischargeValue.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 15.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180.w,
                    color: Colors.grey.shade100,
                    alignment: Alignment.center,
                    child: Text(
                      equationName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
