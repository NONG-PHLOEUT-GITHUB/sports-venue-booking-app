import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:frontend/presentation/controllers/booking_controller.dart';
import 'package:frontend/domain/entities/ticket.dart';
import 'package:get/get.dart';
import 'package:frontend/l10n/app_localizations.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    final theme = Theme.of(context);

    // Helper to determine status color
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

    Widget ticketCard(TicketData ticket) {
      final Color statusColor = getStatusColor(ticket.status);
      const double radius = 20.0;
      const double padding = 20.0;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.95),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                children: [
                  // Header section
                  _buildHeader(ticket, statusColor, theme, padding),
                  // Time & dash line section
                  _buildTimeRow(ticket, theme, padding),
                  const SizedBox(height: 10),
                  // Price and field section
                  _buildDetails(ticket, theme, padding),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ticket,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Obx(
        () {
          if (controller.tickets.isEmpty) {
            return Center(
              child: Text(
                'No tickets booked yet.',
                style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.6)),
              ),
            );
          }
          return ListView.builder(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            itemCount: controller.tickets.length,
            itemBuilder: (_, index) => ticketCard(controller.tickets[index]),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
      TicketData ticket, Color statusColor, ThemeData theme, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, padding, padding, padding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ticket.venueName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ticket.status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.6), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ticket.location,
                  style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.date_range_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.6), size: 18),
              const SizedBox(width: 8),
              Text(
                ticket.date,
                style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(
      TicketData ticket, ThemeData theme, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Text(
            ticket.startTime,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(
      TicketData ticket, ThemeData theme, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, padding / 2, padding, padding),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.stadium_outlined,
                color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Field',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  ticket.fieldName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${ticket.price.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}