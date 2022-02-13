import 'package:detoxa/dataModels/eye_tracker_enums.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/dry_eye_test/dry_eye_view.dart';
import 'package:stacked/stacked.dart';

class DryEyeTestViewModel extends BaseViewModel {
  int _totalImages = 12;
  int _imageNumber = 1;
  double _progress = 0.0;
  List<DryEyeOption> _selectedAnswers = [];
  final List<String> selectedImageDetails = [
    "Eyes that are sensitive to light",
    "Eyes that feel gritty",
    "Painful or sore eyes",
    "Blurred vision",
    "Poor vision",
    "Reading",
    "Driving at night",
    "Working with a computer or using a bank machine (ATM)",
    "Watching TV",
    "Windy conditions",
    "Places or areas with low humidity (Very dry)",
    "Areas that are air conditioned",
  ];

  int get imageNumber => _imageNumber;
  double get progress => _progress;

  DryEyeTestViewModel() {
    // _progress = (1.0 / _totalImages);
  }

  // void updateImageNumber({int newNumber}) {
  //   if (newNumber == null && _imageNumber == _totalImages) {
  //     return;
  //   }
  //   if (newNumber == null) {
  //     print((1.0 / _totalImages));
  //     _imageNumber++;
  //     _progress += (1.0 / _totalImages);
  //     if (_progress > 1.0) {
  //       _progress = 1.0;
  //     }
  //   } else {
  //     _imageNumber = newNumber;
  //   }
  //   notifyListeners();
  // }

  void selectAnswer(DryEyeOption option) {
    if (_progress < 1.0 && _imageNumber < _totalImages) {
      _selectedAnswers.add(option);
      _imageNumber++;
      _progress += (1.0 / _totalImages);
      if (_progress > 1.0) {
        _progress = 1.0;
      }
    } else {
      _progress = 1.0;
    }
    notifyListeners();
  }
}
