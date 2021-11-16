import 'package:flutter/material.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/ui_widgets/custom_text_button_3.dart';
import 'package:oogie/components/ui_widgets/custom_text_button_4.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

Widget specificationView({SpecificationModel specificationModel,Function addAction,deleteAction,bool isEditable}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            specificationModel.heading,
            style: TextStyles.mediumMedium,

          ),
          Visibility(visible:isEditable,child: InkWell(
            splashColor: Colors.transparent,

            child:Icon(Icons.delete,size: 18,color: AppColors.OutlinedIcon,),
            onTap: (){
              deleteAction();
            },
          ),)
        ],
      ),
      SizedBox(height: 14),
      ListView.separated(
        padding: const EdgeInsets.only(left: 10.0),
        itemCount: specificationModel.values.length,
        // itemCount: 20,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return subSpecificationView(specificationModel.values[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return dividerDefault2;
        },
      ),
      Visibility(
        visible: isEditable,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            InkWell(child:Text('Add',style: TextStyles.smallMediumPrimaryLight,), splashColor:Colors.transparent,onTap: (){addAction();},)
          ],
        ),
      )
    ],
  );
}

Widget subSpecificationView(SubSpecificationModel subSpecificationModel) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        subSpecificationModel.key,
        style: TextStyles.smallRegularSubdued,
      ),
      SizedBox(
        width: 50,
      ),
      Flexible(
        child: Text(
          subSpecificationModel.value,
          style: TextStyles.smallMedium,
          textAlign: TextAlign.right,
        ),
      )
    ],
  );
}