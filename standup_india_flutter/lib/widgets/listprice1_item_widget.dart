import 'package:flutter/material.dart';

import '../CommonImageView.dart';
import '../color_constant.dart';
import '../image_constant.dart';
import '../math_utils.dart';

// ignore: must_be_immutable
class Listprice1ItemWidget extends StatelessWidget {
  Listprice1ItemWidget();

  @override
  Widget build(BuildContext context) {
bool isRtl = true;
    return IntrinsicWidth(
      child: Container(
        margin: getMargin(
          right:isRtl?0: 12,
          left:isRtl?12: 0,
          bottom: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: getSize(
                160.00,
              ),
              width: getSize(
                160.00,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          24.00,
                        ),
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgImage79,
                        height: getSize(
                          160.00,
                        ),
                        width: getSize(
                          160.00,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: getMargin(
                        left: 20,
                        top: 40,
                        right: 20,
                        bottom: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            24.00,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              left: 0,
                              right: 0,
                            ),
                            child: Text(
                              "TOP 100",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: getFontSize(
                                  24,
                                ),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: getVerticalSize(
                              1.00,
                            ),
                            width: getHorizontalSize(
                              120.00,
                            ),
                            margin: getMargin(
                              top: 16,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.gray200,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  0.50,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 16,
                              top: 15,
                              right: 16,
                            ),
                            child: Text(
                              "Global",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: getFontSize(
                                  12,
                                ),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                top: 8,
              ),
              child: Text(
                "TOP 100 - Global",
                overflow: TextOverflow.ellipsis,
                textAlign:   TextAlign.start,
                style: TextStyle(
                     
                  fontSize: getFontSize(
                    18,
                  ),
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
