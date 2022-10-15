import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huntly/core/utils/scaffold.dart';
import '../bloc/memories_bloc.dart';
import '../widgets/memories_menu_item.dart';

class MemoriesMenuPage extends StatefulWidget {
  const MemoriesMenuPage({Key? key}) : super(key: key);

  @override
  State<MemoriesMenuPage> createState() => _MemoriesMenuPageState();
}

class _MemoriesMenuPageState extends State<MemoriesMenuPage> {
  @override
  void initState() {
    BlocProvider.of<MemoriesBloc>(context).add(GetUserMemories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HuntlyScaffold(
      outerContext: context,
      body: BlocConsumer<MemoriesBloc, MemoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Loaded) {
            // print(state.memories);
            // return Text(state.memories[0].images.toString());
            return ListView.builder(
                itemCount: state.memories.length,
                itemBuilder: (context, index) {
                  return MemoriesMenuItem(memory: state.memories[index]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
