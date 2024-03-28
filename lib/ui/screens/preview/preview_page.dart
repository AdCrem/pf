import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pf/model/app_point/app_point.dart';
import 'package:pf/model/result/result_enum.dart';

import '../../../model/result/pathfinding_result.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.pathfindingResult});

  final PathfindingResult pathfindingResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: InteractiveViewer(
        constrained: false,
        minScale: 0.1,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder.all(color: Colors.black, width: 1),
          children: pathfindingResult.result
              .map((row) => TableRow(
                  children: row
                      .map<TableCell>(
                        (e) => TableCell(
                          child: MapCell(appPoint: e),
                        ),
                      )
                      .toList()))
              .toList(),
        ),
      ),
    );
  }
}

class MapCell extends StatelessWidget {
  const MapCell({super.key, required this.appPoint});

  final DetailedAppPoint appPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appPoint.resultTile.color,
      width: 75,
      height: 75,
      alignment: Alignment.center,
      child: Text(
        '(${appPoint.y},${appPoint.x})',
      ),
    );
  }
}
