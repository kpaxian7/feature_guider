import 'package:feature_guider/model/guider_item_model.dart';

class GuiderModel {
  final List<GuiderItemModel> guiderList;
  final bool supportSkip;

  const GuiderModel(
    this.guiderList, {
    this.supportSkip = false,
  });
}
