// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class HtmlTextWidget extends StatelessWidget {
//   final String htmlString;
//
//   const HtmlTextWidget({
//     super.key,
//     required this.htmlString,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Html(
//       data: cleanedHtml(htmlString),
//       style: {
//         "html": Style(
//           margin: Margins.zero,
//           padding: HtmlPaddings.zero,
//           lineHeight: LineHeight.number(1.0),
//         ),
//         "body": Style(
//           margin: Margins.zero,
//           padding: HtmlPaddings.zero,
//           display: Display.inline,
//           lineHeight: LineHeight.number(1.0),
//         ),
//         "p": Style(
//           margin: Margins.zero,
//           padding: HtmlPaddings.zero,
//           display: Display.inline,
//           lineHeight: LineHeight.number(1.0),
//         ),
//         "a": Style(
//           margin: Margins.zero,
//           padding: HtmlPaddings.zero,
//           display: Display.inline,
//           lineHeight: LineHeight.number(1.0),
//         ),
//         "span": Style(
//           margin: Margins.zero,
//           padding: HtmlPaddings.zero,
//           display: Display.inline,
//           lineHeight: LineHeight.number(1.0),
//         ),
//       },
//       onLinkTap: (url, _, __) async {
//         if (url != null && await canLaunchUrl(Uri.parse(url))) {
//           await launchUrl(
//             Uri.parse(url),
//             mode: LaunchMode.externalApplication,
//           );
//         }
//       },
//     );
//   }
//
//   String cleanedHtml(String html) {
//     return "<span>$html</span>";
//   }
// }
