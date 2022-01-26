import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/cards/child_details_card/child_details_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChildDetailsCard extends StatefulWidget {
  const ChildDetailsCard({Key key}) : super(key: key);

  @override
  _ChildDetailsCardState createState() => _ChildDetailsCardState();
}

class _ChildDetailsCardState extends State<ChildDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChildDetailsCardViewModel>.reactive(
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
                Text(
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
                                color: model.children == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<String>(
                              // alignment: AlignmentDirectional.topEnd,
                              isExpanded: true,
                              menuMaxHeight: 200,
                              // itemHeight: 50,
                              value: model.selectedChild,
                              items: model.children == null
                                  ? null
                                  : [
                                      ...model.children.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e),
                                          ),
                                        ),
                                      ),
                                    ],

                              onChanged: (_) {},
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
                                color: model.genderList == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<String>(
                              // alignment: AlignmentDirectional.topEnd,

                              isExpanded: true,
                              menuMaxHeight: 200,
                              value: model.selectedGender,
                              items: const [
                                DropdownMenuItem(
                                  value: "Male",
                                  child: Text("Male"),
                                  // alignment: Alignment.center,
                                ),
                                DropdownMenuItem(
                                  value: "Female",
                                  child: Text("Female"),
                                ),
                              ],
                              onChanged: model.onGenderChanged,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 6,
                        child: ElevatedButton(
                          child: const Text("Generate Report"),
                          onPressed: model.onGenerateReportPressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ChildDetailsCardViewModel(),
    );
  }
}
