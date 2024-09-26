import 'package:flutter/material.dart';
import 'package:foodfixer/core/core.dart';
import 'package:path/path.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AppIcons {
  static const basePath = 'assets';
  static const imagesPath = '$basePath/images';
  static const iconsPath = '$basePath/icons';

  static const m11Logo = AppIcon('$basePath/m11_logo.png');
  static const bubbles = AppIcon('$imagesPath/bubbles.svg');

  static const icFBO = AppIcon('$imagesPath/ic_fbo.svg');
  static const isDepot = AppIcon('$imagesPath/ic_depot.svg');
  static const emptySearch = AppIcon('$imagesPath/empty_search.svg');
  static const icPickUpTruck = AppIcon('$imagesPath/ic_pickup_truck.svg');
  static const icNewPurchase = AppIcon('$imagesPath/new_purchase.svg');
  static const icCanRequest = AppIcon('$imagesPath/ic_can_request.svg');
  static const icSettings = AppIcon('$imagesPath/ic_settings.svg');
  static const bubbleTeaSorry = AppIcon('$iconsPath/ic_bubble_tea_sorry.png');

  // BDE
  static const enrollFBO = AppIcon('$imagesPath/ic_enroll_fbo.svg');
  static const routes = AppIcon('$imagesPath/ic_routes.svg');
  static const fbos = AppIcon('$imagesPath/ic_fbo.svg');
  static const bdeSummary = AppIcon('$imagesPath/ic_summary.svg');

  // BDE Enroll Pics
  static const notInterested = AppIcon('$imagesPath/not_interested.svg');
  static const scheduledImage = AppIcon('$imagesPath/scheduled_image.svg');
  static const followUp = AppIcon('$imagesPath/follow_up.svg');
  static const newVisitContract = AppIcon('$imagesPath/new_visit_contract.svg');
 
  static const greenLayer = AppIcon('$imagesPath/ic_green_layer.svg');
  static const pickUpBg = AppIcon('$imagesPath/pickup_bg.png');

  static const icHome = AppIcon('$iconsPath/ic_home.svg');
  static const icFollowUp = AppIcon('$iconsPath/ic_follow_up.svg');
  static const icCollections = AppIcon('$iconsPath/ic_collections.svg');
  static const icReport = AppIcon('$iconsPath/ic_report.svg');

  static const icFBOWelcome = AppIcon('$imagesPath/ic_fbo_welcome.svg');

  // FBO
  static const icUCOEnrollment = AppIcon('$imagesPath/ic_uco_enrollment.svg');
  static const icNotifications = AppIcon('$imagesPath/ic_notifications.svg');

  // DEO
  static const icAssignCE = AppIcon('$iconsPath/ic_assign_ce.svg');
  static const icGateEntry = AppIcon('$iconsPath/ic_gate_entry.svg');
  static const icGateExit = AppIcon('$iconsPath/ic_gate_exit.svg');
  static const icMonthlyReport = AppIcon('$iconsPath/ic_monthly_report.svg');
  static const icUCODeposit = AppIcon('$iconsPath/ic_uco_deposit.svg');
}

class AppIcon {
  const AppIcon(this.path);

  final String path;

  Widget toWidget({
    double width = 30,
    double height = 30,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    final fileextension = extension(path);
    if(fileextension == '.svg') {
      return SvgPicture.asset(path, 
        width: width, 
        height: height, 
        colorFilter: color.isNotNull 
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
        fit: fit,
      ); 
    }
    return Image.asset(path, width: width, height: height, color: color, fit: fit);
  }
}