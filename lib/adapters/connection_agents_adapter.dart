import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_bloc.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_view.dart';

class ConnectionAgentsAdapter extends StatelessWidget {
  UserModel userModel;

  ConnectionAgentsAdapter({
    Key key,
    this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => VendorSaleReportBloc(
                  distributorRepository: distributorRepository,
                  parentPage: 'connectionAgentList',
                  orderRepository: orderRepository,
                  userModel: userModel),
              child: VendorSaleReportView(),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Text(
            userModel.name,
            style: TextStyles.mediumMedium,
          ),
          Text(
            userModel.phoneNumber,
            style: TextStyles.smallRegular,
          ),
          Text(
            userModel.email,
            style: TextStyles.smallRegular,
          ),
        ]),
      ),
    );
  }
}
