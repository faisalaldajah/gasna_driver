import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../brand_colors.dart';

class DataViewer extends StatelessWidget {
  final int total;
  final String title;
  final Icon icon;
  const DataViewer({
    this.icon,
    this.title,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: BrandColors.colorAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(        
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: BrandColors.colorBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Icon(
                icon.icon,
                color: BrandColors.colorAccent,
                size: 70,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText(
                  total.toString(),
                  style: TextStyle(
                    color: BrandColors.colorBackground,
                    fontFamily: 'JF-Flat-regular',
                    fontSize: 30,
                  ),
                  minFontSize: 18,
                ),
                AutoSizeText(
                  title,
                  style: TextStyle(
                    color: BrandColors.colorBackground,
                    fontFamily: 'JF-Flat-regular',
                    fontSize: 20,
                  ),
                  minFontSize: 10,
                  maxLines: 4,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
