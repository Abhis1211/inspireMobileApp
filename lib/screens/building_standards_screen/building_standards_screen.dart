import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_cabinets_screen/standards_details_screen.dart';
import 'package:public_housing/screens/building_inspection_summary/building_inspection_summary_screen.dart';
import 'package:public_housing/screens/building_standards_screen/building_standards_controller.dart';

class BuildingStandardsScreen extends GetView<BuildingStandardsController> {
  const BuildingStandardsScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingStandardsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingStandardsController>(
      init: BuildingStandardsController(),
      autoRemove: false,
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
                    Get.back();
                  },
                ),
                Column(
                  children: [
                    MyTextView(
                      '${Strings.propertyNames}${controller.buildingName}',
                      textStyleNew: MyTextStyle(
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w600,
                        textFamily: fontFamilyBold,
                        textSize: 20.px,
                      ),
                    ).paddingOnly(top: 32.px, bottom: 48.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextView(
                          Strings.buildingInspection,
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w500,
                            textFamily: fontFamilyBold,
                            textSize: 40.px,
                          ),
                        ),
                        CommonButton(
                          title: Strings.inspectionSummary,
                          radius: 100.px,
                          width: 198.px,
                          height: 44.px,
                          padding: EdgeInsets.symmetric(
                            vertical: 15.px,
                            horizontal: 24.px,
                          ),
                          textSize: 16.px,
                          textWeight: FontWeight.w500,
                          textFamily: fontFamilyRegular,
                          textColor: controller.appColors.white,
                          color: controller.appColors.appColor,
                          onTap: () {
                            if (controller.imagesList != null) {
                              Get.toNamed(
                                  BuildingInspectionSummaryScreen.routes,
                                  arguments: {
                                    "buildingName": controller.buildingName,
                                    "imagesList": controller.imagesList,
                                    "inspectionName": controller.inspectionName,
                                  });
                            }
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: CommonTextField(
                            isLable: true,
                            onChange: (value) =>
                                controller.searchStandards(searchText: value),
                            controller: controller.searchStandardsController,
                            color: controller.appColors.transparent,
                            padding: EdgeInsets.zero,
                            prefixIcon: SvgPicture.string(
                              icSearch,
                              color: controller.appColors.grey,
                            ).paddingOnly(left: 15.px),
                            contentPadding: EdgeInsets.only(
                                left: 15.px, top: 16.px, bottom: 16.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.searchStandards,
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          flex: 6,
                          child: GestureDetector(
                            onTap: controller.isExpanded,
                            child: Container(
                              height: 44.px,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.px),
                                  border: Border.all(
                                      color: controller.appColors.appColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.isCollapseStandards
                                      ? SvgPicture.string(
                                          icDownArrow,
                                          color: controller.appColors.appColor,
                                        )
                                      : SvgPicture.string(
                                          icUpArrow,
                                          color: controller.appColors.appColor,
                                        ),
                                  MyTextView(
                                    Strings.collapseStandards,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.appColor,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyBold,
                                      textSize: 16.px,
                                    ),
                                  ).paddingOnly(left: 8.px)
                                ],
                              ).paddingSymmetric(horizontal: 16.px),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: 350.px,
                            height: 44.px,
                            child: SegmentedButton<BuildingStandardsStatus>(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? controller.appColors.pinkcolor
                                      : controller.appColors.transparent;
                                }),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? Colors.black
                                      : controller.appColors.border1;
                                }),
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) {
                                  return BorderSide(
                                      color: states
                                              .contains(MaterialState.selected)
                                          ? Colors.black
                                          : Colors.grey);
                                }),
                              ),
                              segments: const <ButtonSegment<
                                  BuildingStandardsStatus>>[
                                ButtonSegment<BuildingStandardsStatus>(
                                  value: BuildingStandardsStatus.all,
                                  label: Text(Strings.all),
                                ),
                                ButtonSegment<BuildingStandardsStatus>(
                                  value: BuildingStandardsStatus.failed,
                                  label: Text(Strings.failed),
                                ),
                              ],
                              selected: <BuildingStandardsStatus>{
                                controller.status
                              },
                              onSelectionChanged:
                                  (Set<BuildingStandardsStatus> newSelection) {
                                controller.status = newSelection.first;
                                controller.searchTypeItem();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 32.px),
                  ],
                ).paddingSymmetric(horizontal: 32.px),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.searchList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.searchList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          MyTextView(
                                            controller.searchList[index].type ??
                                                "",
                                            textStyleNew: MyTextStyle(
                                              textColor:
                                                  controller.appColors.black,
                                              textWeight: FontWeight.w600,
                                              textFamily: fontFamilyBold,
                                              textSize: 32.px,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 2.px,
                                              color: AppColors().divider,
                                            ).paddingSymmetric(
                                                horizontal: 16.px),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.isItemExpanded(index);
                                            },
                                            child: SizedBox(
                                              height: 24.px,
                                              width: 24.px,
                                              child: (controller
                                                          .searchList[index]
                                                          .isExpand ??
                                                      false)
                                                  ? SvgPicture.string(
                                                      icDownArrow,
                                                      color: controller
                                                          .appColors.appColor,
                                                    )
                                                  : SvgPicture.string(
                                                      icUpArrow,
                                                      color: controller
                                                          .appColors.appColor,
                                                    ).paddingAll(3.px),
                                            ),
                                          )
                                        ],
                                      ),
                                      if (controller
                                              .searchList[index].isExpand ??
                                          false)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .searchList[index]
                                              .buildingDataModel
                                              ?.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            var buildingDataList = controller
                                                .searchList[index]
                                                .buildingDataModel?[i];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    StandardsDetailsScreen
                                                        .routes,
                                                    arguments: {
                                                      "buildingName": controller
                                                          .buildingName,
                                                      "buildingDataList":
                                                          buildingDataList
                                                    })?.then((value) {
                                                  controller.imagesList =
                                                      value['imagesList'];
                                                  controller.isSuccess =
                                                      value['isSuccess'];

                                                  controller.inspectionName =
                                                      value['buildingName'];
                                                  if (controller.isSuccess) {
                                                    controller.isUpdateList(
                                                        name: value[
                                                            'buildingName']);
                                                  }
                                                  controller.update();
                                                });
                                              },
                                              child: ShadowContainer(
                                                      padding: EdgeInsets.zero,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Image.asset(
                                                                buildingDataList
                                                                        ?.image ??
                                                                    "",
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    MyTextView(
                                                                      buildingDataList
                                                                              ?.title ??
                                                                          "",
                                                                      isMaxLineWrap:
                                                                          true,
                                                                      textStyleNew:
                                                                          MyTextStyle(
                                                                        textColor: controller
                                                                            .appColors
                                                                            .black,
                                                                        textWeight:
                                                                            FontWeight.w400,
                                                                        textFamily:
                                                                            fontFamilyBold,
                                                                        textSize:
                                                                            20.px,
                                                                      ),
                                                                    ),
                                                                    if ((buildingDataList?.isSuccess ??
                                                                            false) ==
                                                                        true)
                                                                      ClipOval(
                                                                          child:
                                                                              SvgPicture.string(
                                                                        icComplete,
                                                                      )),
                                                                  ],
                                                                ),
                                                                MyTextView(
                                                                  buildingDataList
                                                                          ?.description ??
                                                                      "",
                                                                  isMaxLineWrap:
                                                                      true,
                                                                  textStyleNew:
                                                                      MyTextStyle(
                                                                    textColor: controller
                                                                        .appColors
                                                                        .black,
                                                                    textWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    textFamily:
                                                                        fontFamilyBold,
                                                                    textSize:
                                                                        16.px,
                                                                  ),
                                                                ).paddingOnly(
                                                                    top: 8.px),
                                                              ],
                                                            ).paddingSymmetric(
                                                                horizontal:
                                                                    24.px,
                                                                vertical:
                                                                    16.px),
                                                          )
                                                        ],
                                                      ))
                                                  .marginSymmetric(
                                                      vertical: 12.px),
                                            );
                                          },
                                        )
                                    ],
                                  );
                                },
                              ).paddingSymmetric(horizontal: 32.px)
                            : Center(
                                child: MyTextView(
                                  Strings.noDataFound,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.appColor,
                                    textWeight: FontWeight.w500,
                                    textFamily: fontFamilyBold,
                                    textSize: 16.px,
                                  ),
                                ),
                              ),
                      ],
                    ),
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
