import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/address_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_bloc.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_view.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_bloc.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_event.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_state.dart';

class AddressListView extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Container(
      child: BlocListener<AddressListBloc, AddressListState>(
        listener: (context, state) async {
          Exception e = state.actionErrorMessage;
          if (e != null && e
              .toString()
              .length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<AddressListBloc, AddressListState>(
            builder: (context, state) {
              print('list refreshed');
              return Scaffold(
                appBar:
                defaultAppBarWhite(context: buildContext, text: 'My Addresses'),
                body: state.isLoading
                    ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomProgressIndicator(),
                )
                    : Column(
                  children: [

                    Expanded(
                      child: BlocBuilder<AddressListBloc, AddressListState>(
                          builder: (context, state) {
                            return  ListView.separated(
                              padding: EdgeInsets.all(20),
                              shrinkWrap: true,
                              itemCount: state.addressModels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AddressAdapter(
                                  editAction: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            BlocProvider(
                                              create: (_) =>
                                                  AddAddressBloc(
                                                      profileRepository: context
                                                          .read<
                                                          AddressListBloc>()
                                                          .profileRepository,
                                                      addressListBloc:
                                                      context.read<
                                                          AddressListBloc>(),
                                                      addressModel:
                                                      state
                                                          .addressModels[index]),
                                              child: AddAddressView(),
                                            ),
                                      ),
                                    );
                                  },
                                  optionAction: () {
                                    optionForAddress(
                                        addressModel:
                                        state.addressModels[index],
                                        buildContext: context);
                                  },
                                  makeAsDefaultAction: () {
                                    context.read<AddressListBloc>().add(
                                        ChooseDefaultAddress(
                                            id: state.addressModels[index].id));
                                  },
                                  parentPage: '',
                                  addressModel: state.addressModels[index],
                                );
                              },
                              separatorBuilder: (BuildContext context,
                                  int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: DefaultButton(
                        text: 'Add New Address',
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider(
                                    create: (_) =>
                                        AddAddressBloc(
                                          profileRepository: context
                                              .read<AddressListBloc>()
                                              .profileRepository,
                                          addressListBloc:
                                          context.read<AddressListBloc>(),
                                        ),
                                    child: AddAddressView(),
                                  ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

optionForAddress({BuildContext buildContext, AddressModel addressModel}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: false,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(buildContext).size.height - 30,
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return BlocProvider.value(
          value: buildContext.read<AddressListBloc>(),
          child: BlocBuilder<AddressListBloc, AddressListState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm', style: TextStyles.mediumMedium,),
                      SizedBox(height: 20,),
                      Text('Are you sure to delete this address',
                        style: TextStyles.smallRegular,),

                      SizedBox(
                        height: 20,
                      ),
                      DefaultButton(
                        text: 'Delete',
                        action: () {
                          context.read<AddressListBloc>().add(
                              DeleteSelectedAddress(id: addressModel.id));
                        },
                      )
                    ],
                  ),
                );
              }),
        );
      });
}
