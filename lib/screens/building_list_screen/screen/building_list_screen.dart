import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/building_list_screen/controller/building_list_controller.dart';
import 'package:public_housing/screens/building_list_screen/widget/common_building_list_container.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';

class BuildingListScreen extends GetView<BuildingListController> {
  const BuildingListScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingListScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingListController>(
      init: BuildingListController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    if (controller.isComplete) {
                      Get.toNamed(PropertiesListScreen.routes);
                    } else {
                      Get.back();
                    }
                  },
                ),
                Row(
                  children: [
                    MyTextView(
                      '${Strings.buildings} | ',
                      textStyleNew: MyTextStyle(
                          textSize: 32.px,
                          textColor: AppColors.primerColor,
                          textWeight: FontWeight.w600),
                    ),
                    MyTextView(
                      '[Property Name]',
                      textStyleNew: MyTextStyle(
                          textSize: 24.px,
                          textColor: controller.appColors.textcolor,
                          textWeight: FontWeight.w400),
                    ),
                  ],
                ).paddingOnly(
                    left: 32.px, right: 32.px, bottom: 32.px, top: 36.px),
                Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) => CommonBuildingListView(
                      title: 'Building [Building Name]',
                      title1: '[Unit Count] Units',
                      Subtitle: '[Year Constructed]',
                      Subtitle1: '[Building Type]',
                      onTap: () {
                        Get.toNamed(UnitListScreen.routes);
                      },
                      onTap1: () {
                        Get.toNamed(BuildingInspectionScreen.routes,
                            arguments: {"isManually": false});
                      },
                    ).paddingSymmetric(horizontal: 32.px),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 24.px);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
