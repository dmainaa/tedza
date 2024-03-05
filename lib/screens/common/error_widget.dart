import 'package:flutter/material.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';
import 'package:tedza_ecommerce/screens/common/common_button.dart';
import 'package:tedza_ecommerce/screens/common/style_manager.dart';


class MErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String buttonLabel;
  const MErrorWidget({Key? key, required this.errorMessage, required this.onRetry, required this.buttonLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(errorMessage, style: getMediumStyle(color: AppColors.lightRed, fontSize: 21), textAlign: TextAlign.center,),),
        const SizedBox(height: 20,),
        _buildretryButton(onRetry)
      ],
    );
  }

  Widget _buildretryButton(VoidCallback onClick) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 13.0),
          decoration: contentButtonStyle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Retry',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
