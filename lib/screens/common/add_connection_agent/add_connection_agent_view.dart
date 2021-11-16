import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_satate.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_view_1.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_view_2.dart';
import 'package:oogie/screens/common/add_connection_agent/select_location_view.dart';

class AddConnectionAgentView extends StatefulWidget {
  @override
  _AddConnectionAgentViewState createState() => _AddConnectionAgentViewState();
}

class _AddConnectionAgentViewState extends State<AddConnectionAgentView> {
  List<Widget> _samplePages = [];
  final _controller = new PageController();
  int currentPage = 0;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    _samplePages = [
      Center(
        child: BlocProvider.value(
            value: context.read<AddConnectionAgentBloc>(),
            child: AddConnectionAgentView1()),
      ),
      Center(
        child: BlocProvider.value(
            value: context.read<AddConnectionAgentBloc>(),
            child: AddConnectionAgentView2()),
      ),
      Center(
        child: BlocProvider.value(
            value: context.read<AddConnectionAgentBloc>(),
            child: SelectLocationView()),
      ),
    ];
    return BlocListener<AddConnectionAgentBloc, AddConnectionAgentState>(
      listener: (context, state) {
        if (state.index < currentPage) {
          _controller.previousPage(duration: _kDuration, curve: _kCurve);
        } else if (state.index > currentPage) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
        }
        final formStatus = state.formStatus;

        if (formStatus is SubmissionFailed) {
          showSnackBar(context, formStatus.exception);
        } else if (formStatus is SubmissionSuccess) {
          // buildContext.read<ProfileBloc>().getUserData();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: defaultAppBarWhite(context: context, text: 'Add Vendor'),
        body: Column(
          children: <Widget>[
            Flexible(
              child: PageView.builder(
                controller: _controller,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: _samplePages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _samplePages[index % _samplePages.length];
                },
                onPageChanged: (index) {
                  currentPage = index;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
