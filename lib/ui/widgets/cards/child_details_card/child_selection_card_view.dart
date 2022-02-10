import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/ui/widgets/cards/child_details_card/child_selection_card_view_model.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChildSelectionCard extends StatefulWidget {
  final Function(Child) onPressed;
  final String buttonText;
  final bool isLoading;
  const ChildSelectionCard({
    Key key,
    this.onPressed,
    this.buttonText,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _ChildSelectionCardState createState() => _ChildSelectionCardState();
}

class _ChildSelectionCardState extends State<ChildSelectionCard> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChildSelectionCardViewModel>.reactive(
      builder: (context, model, _) {
        return Card(
          elevation: 8,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            width: double.maxFinite,
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            // decoration: BoxDecoration(
            //   border: Border.all(),
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //image
                const Text(
                  "Your child's details:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: model.childList == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<Child>(
                              isExpanded: true,
                              menuMaxHeight: 200,
                              value: model.selectedChild,
                              items: (model?.childList ?? []).isEmpty
                                  ? []
                                  : model.childList
                                      .map(
                                        (e) => DropdownMenuItem<Child>(
                                          // key: ValueKey(e.id),
                                          value: e,
                                          child: Text(e?.fullName ?? ""),
                                        ),
                                      )
                                      .toList(),
                              onChanged: model.childChanged,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          child: const Text("Add Child"),
                          onPressed: model.onAddChildPressed,
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.errorMessage.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        model.errorMessage,
                        style: AppTextStyles.errorMessage,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Expanded(
                      //   flex: 7,
                      //   child: DropdownButtonHideUnderline(
                      //     child: Container(
                      //       height: 45,
                      //       padding: const EdgeInsets.all(8.0),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: model.genderList == null
                      //               ? Colors.grey
                      //               : Colors.black,
                      //         ),
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //       child: DropdownButton<String>(
                      //         // alignment: AlignmentDirectional.topEnd,

                      //         isExpanded: true,
                      //         menuMaxHeight: 200,
                      //         value: model.selectedGender,
                      //         items: const [
                      //           DropdownMenuItem(
                      //             value: "Male",
                      //             child: Text("Male"),
                      //             // alignment: Alignment.center,
                      //           ),
                      //           DropdownMenuItem(
                      //             value: "Female",
                      //             child: Text("Female"),
                      //           ),
                      //         ],
                      //         onChanged: model.onGenderChanged,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 12),
                      widget.isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: CircularLoader(),
                            )
                          : ElevatedButton(
                              child:
                                  Text(widget.buttonText ?? "Generate Report"),
                              onPressed: model.onGenerateReportPressed,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ChildSelectionCardViewModel(),
      onModelReady: (model) => model.setInitialData(
        onPressed: widget.onPressed,
      ),
    );
  }
}
