import 'package:flutter/material.dart';
import 'package:frontend/controllers/ticket_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/ticket_model.dart';
import 'package:get/get.dart';
class TicketPage extends StatelessWidget {
  TicketPage({super.key});
  final TicketController controller = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double padding = 16.0;
    const double radius = 15.0;

    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'paid':
          return Colors.green;
        case 'pending':
          return theme.colorScheme.primary;
        case 'cancelled':
          return theme.colorScheme.error;
        default:
          return theme.colorScheme.onSurface.withOpacity(0.7);
      }
    }

    Widget buildTimeDot(Color color) => Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 8,
            width: 8,
            child: DecoratedBox(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5))),
          ),
        );

    Widget dashedLine(Color color) {
      return SizedBox(
        height: 2,
        child: LayoutBuilder(builder: (context, constraints) {
          final dashWidth = 6.0;
          final dashSpace = 4.0;
          final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) => SizedBox(width: dashWidth, height: 1, child: DecoratedBox(decoration: BoxDecoration(color: color)))),
          );
        }),
      );
    }

    Widget ticketCard(TicketData ticket) {
      final isDark = theme.brightness == Brightness.dark;
      final shadowColor = isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.08);

      return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [BoxShadow(color: shadowColor, blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            children: [
              // Event Name & Status
              Padding(
                padding: const EdgeInsets.fromLTRB(padding, padding, padding, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(ticket.eventName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: getStatusColor(ticket.status).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(ticket.status, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getStatusColor(ticket.status))),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),

              // Location & Date
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  children: [
                    Row(children: [Icon(Icons.location_on_outlined, color: theme.colorScheme.onSurface.withOpacity(0.7), size: 18), const SizedBox(width: 8), Expanded(child: Text(ticket.location, style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 16)))]),
                    const SizedBox(height: 4),
                    Row(children: [Icon(Icons.date_range_outlined, color: theme.colorScheme.onSurface.withOpacity(0.7), size: 18), const SizedBox(width: 8), Text(ticket.date, style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 16))]),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Time row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  children: [
                    Text(ticket.startTime, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                    const SizedBox(width: 12),
                    buildTimeDot(theme.colorScheme.primary),
                    Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: dashedLine(theme.colorScheme.onSurface.withOpacity(0.3)))),
                    buildTimeDot(theme.colorScheme.onSurface),
                    const SizedBox(width: 12),
                    Text(ticket.endTime, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(height: 1, color: theme.colorScheme.onSurface.withOpacity(0.1), indent: padding, endIndent: padding),

              // Field & Price
              Padding(
                padding: const EdgeInsets.fromLTRB(padding, 12, padding, 16),
                child: Row(
                  children: [
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Icon(Icons.stadium_outlined, color: theme.colorScheme.primary)),
                    const SizedBox(width: 16),
                    Text(ticket.fieldName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface.withOpacity(0.7))),
                    Expanded(child: Text("\$ ${ticket.price.toStringAsFixed(2)}", textAlign: TextAlign.end, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface))),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ticket)),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.tickets.isEmpty) return const Center(child: Text('No tickets found.'));
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          itemCount: controller.tickets.length,
          itemBuilder: (_, index) => ticketCard(controller.tickets[index]),
        );
      }),
    );
  }
}