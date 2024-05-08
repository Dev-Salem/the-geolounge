import 'package:flutter/material.dart';
import 'package:the_geolounge/gen/strings.g.dart';

typedef Destination = ({String label, IconData icon});
final List<Destination> navDestination = [
  (
    label: t.destinations.posts,
    icon: Icons.explore,
  ),
  (
    label: t.destinations.chat,
    icon: Icons.message_rounded,
  ),
  (
    label: t.destinations.account,
    icon: Icons.person,
  ),
];
