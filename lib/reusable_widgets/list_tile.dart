import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

listTile(BuildContext context,
    {title, subtitle, leading, VoidCallback? ontap}) {
  return ListTile(
    title: TextWidget(
      text: title,
      size: width(context) * 0.04,
      weight: FontWeight.w600,
      color: Colors.grey[900],
    ),
    subtitle: TextWidget(
      text: subtitle,
      size: width(context) * 0.03,
      weight: FontWeight.w400,
      color: Colors.grey[900],
    ),
    leading: Icon(
      leading,
      size: width(context) * 0.06,
      color: Colors.grey,
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: width(context) * 0.04,
      color: Colors.grey,
    ),
    onTap: ontap,
  );
}

listTileWithouST(BuildContext context, {title, leading, VoidCallback? ontap}) {
  return ListTile(
    title: TextWidget(
      text: title,
      size: width(context) * 0.04,
      weight: FontWeight.w600,
      color: Colors.grey[900],
    ),
    leading: Icon(
      leading,
      size: width(context) * 0.06,
      color: Colors.grey,
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: width(context) * 0.04,
      color: Colors.grey,
    ),
    onTap: ontap,
  );
}

listTileWithouTI(BuildContext context, {title, leading, VoidCallback? ontap}) {
  return ListTile(
    title: TextWidget(
      text: title,
      size: width(context) * 0.04,
      weight: FontWeight.w600,
      color: Colors.grey[900],
    ),
    leading: Icon(
      leading,
      size: width(context) * 0.06,
      color: Colors.grey,
    ),
    onTap: ontap,
  );
}

expListTile(BuildContext context, {title, leading, List<Widget>? widget}) {
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: Column(
      children: [
        ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          textColor: SpotmiesTheme.primaryColor,
          iconColor: SpotmiesTheme.primaryColor,
          collapsedIconColor: Colors.grey,
          collapsedTextColor: Colors.grey[900],
          title: Text(title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: width(context) * 0.04,
              )),
          leading: Icon(
            leading,
            size: width(context) * 0.06,
          ),
          children: widget!,
        ),
      ],
    ),
  );
}
