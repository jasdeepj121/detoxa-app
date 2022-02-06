import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:detoxa/ui/widgets/cards/child_details_card/child_details_card_view.dart';
import 'package:detoxa/ui/widgets/textfields/box_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

const Color weightColor = Colors.pink;
const Color heightColor = Colors.deepPurple;
const Color ageColor = Colors.red;

class GrowthTrackerView extends StatefulWidget {
  const GrowthTrackerView({Key key}) : super(key: key);

  @override
  _GrowthTrackerViewState createState() => _GrowthTrackerViewState();
}

class _GrowthTrackerViewState extends State<GrowthTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<GrowthTrackerViewModel>.reactive(
      viewModelBuilder: () => GrowthTrackerViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            height: size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8).copyWith(left: 0),
                      height: 200,
                      child: Column(
                        children: [
                          CustomSlider(
                            color: weightColor,
                            controller: model.weightController,
                            currentSliderValue: model.weightValue,
                            maxValue: model.maxWeight,
                            minValue: model.minWeight,
                            onChanged: model.onWeightChanged,
                            text: "Weight",
                            unit: "Kg",
                          ),
                          CustomSlider(
                            color: heightColor,
                            controller: model.heightController,
                            currentSliderValue: model.heightValue,
                            maxValue: model.maxHeight,
                            minValue: model.minHeight,
                            onChanged: model.onHeightChanged,
                            text: "Height",
                            unit: "cm",
                          ),
                          CustomSlider(
                            color: ageColor,
                            controller: model.ageController,
                            currentSliderValue: model.ageValue,
                            maxValue: model.maxAge,
                            minValue: model.minAge,
                            onChanged: model.onAgeChanged,
                            text: "Age",
                            unit: "Yr",
                          ),
                        ],
                      ),
                    ),
                    ChildDetailsCard(
                      onPressed: model.onGeneratePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomSlider extends StatelessWidget {
  final int maxValue;
  final int minValue;
  final TextEditingController controller;
  final Color color;
  final double currentSliderValue;
  final Function(double) onChanged;
  final String text;
  final String unit;

  const CustomSlider({
    Key key,
    this.color,
    this.controller,
    this.currentSliderValue,
    this.maxValue,
    this.minValue,
    this.onChanged,
    this.text,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            max: maxValue.toDouble(),
            min: minValue.toDouble(),
            value: currentSliderValue,
            onChanged: onChanged,
            // divisions: maxValue,
            label: text,
            activeColor: color,
            thumbColor: color,
            inactiveColor: color.withOpacity(0.25),
          ),
        ),
        Container(
          width: 70,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
        Container(
          width: 75,
          height: 42,
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            enabled: false,
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxValue.toString().length),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: color),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 6,
              ),
            ),
          ),
        ),
        Container(
          width: 35,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            unit ?? "unit",
            style: TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}
