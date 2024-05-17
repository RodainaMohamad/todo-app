import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../../../models/todo_dm.dart';
import '../../../../providers/list_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  late ListProvider provider;
  final TodoDM model;
   TodoWidget({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
          color: AppColors.white),
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              onPressed: (_){
                provider.clickOnDelete(model.id);
              },
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          height: MediaQuery.of(context).size.height * .13,
          child: Row(
            children: [
               VerticalDivider(
                 color:model.isDone ?Colors.green : AppColors.primiary,
                 thickness:2,
               ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(model.title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.taskTitleTextStyle.copyWith(color: model.isDone?
                           Colors.green :Colors.black),),
                    const SizedBox(height:5),
                    Text(model.description, textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: AppTheme.taskDescriptionTextStyle.copyWith(color: model.isDone ?
                      Colors.green : Colors.black),),
                  ],
                ),
              ),
              InkWell(onTap: () {
                model.isDone = !model.isDone;
                provider.clickOnIsDone(model);
              },
                child:model.isDone? const Text("Done !", style: TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),)
                  : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: AppColors.primiary,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: const Icon(Icons.check, color: AppColors.white,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}