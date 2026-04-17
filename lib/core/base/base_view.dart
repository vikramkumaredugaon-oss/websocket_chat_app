import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_viewmodel.dart';
import 'view_state.dart';

typedef ViewModelBuilder<T extends BaseViewModel> = Widget Function(
    BuildContext context,
    T viewModel,
    Widget? child,
    );

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final ViewModelBuilder<T> builder;
  final Function(T)? onModelReady;
  final bool disposeViewModel;

  const BaseView({
    super.key,
    required this.viewModel,
    required this.builder,
    this.onModelReady,
    this.disposeViewModel = true,
  });

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    widget.onModelReady?.call(_viewModel);
  }

  @override
  void dispose() {
    if (widget.disposeViewModel) {
      _viewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: _viewModel,
      child: Consumer<T>(
        builder: (context, model, child) {
          switch (model.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());

            case ViewState.error:
              return Center(
                child: Text(
                  model.errorMessage ?? "Something went wrong",
                  style: const TextStyle(color: Colors.red),
                ),
              );

            case ViewState.idle:
            default:
              return widget.builder(context, model, child);
          }
        },
      ),
    );
  }
}