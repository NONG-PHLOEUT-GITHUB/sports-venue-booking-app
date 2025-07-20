import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:get/get.dart';

// Placeholder for your Ticket data model
class TicketData {
  final String eventName;
  final String status;
  final String location;
  final String date;
  final String startTime;
  final String endTime;
  final String fieldName;
  final double price;

  TicketData({
    required this.eventName,
    required this.status,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.fieldName,
    required this.price,
  });

  // Example factory constructor for API data (replace with your actual API parsing)
  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      eventName: json['eventName'] ?? 'Unknown Event',
      status: json['status'] ?? 'Pending',
      location: json['location'] ?? 'N/A',
      date: json['date'] ?? 'N/A',
      startTime: json['startTime'] ?? 'N/A',
      endTime: json['endTime'] ?? 'N/A',
      fieldName: json['fieldName'] ?? 'N/A',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// Dummy data for demonstration
final List<TicketData> dummyTickets = [
  TicketData(
    eventName: "Phnom Penh Champion League",
    status: "Paid",
    location: "Phnom Penh National Stadium",
    date: "2/2/2025",
    startTime: "02:30 PM",
    endTime: "04:30 PM",
    fieldName: "Field A",
    price: 20.00,
  ),
  TicketData(
    eventName: "Badminton Friendly Match",
    status: "Pending",
    location: "Olympic Stadium Hall",
    date: "10/3/2025",
    startTime: "07:00 AM",
    endTime: "08:00 AM",
    fieldName: "Court 3",
    price: 10.00,
  ),
  TicketData(
    eventName: "Football Practice",
    status: "Cancelled",
    location: "ISPP Sports Complex",
    date: "15/3/2025",
    startTime: "05:00 PM",
    endTime: "06:30 PM",
    fieldName: "Main Pitch",
    price: 0.00, // Example of a free booking or cancelled
  ),
];

class TicketPage extends StatelessWidget {
  TicketPage({super.key});

  // This would typically come from an API call
  final Future<List<TicketData>> _ticketsFuture = Future.value(dummyTickets);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ticket)),
      body: FutureBuilder<List<TicketData>>(
        future: _ticketsFuture, // Your API call future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tickets found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemBuilder: (context, index) {
                return TicketView(ticket: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  final TicketData ticket;
  const TicketView({super.key, required this.ticket});

  Color _getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (ticket.status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return theme.colorScheme.primary; // Use theme's primary for pending
      case 'cancelled':
        return theme.colorScheme.error; // Use theme's error for cancelled
      default:
        return theme.colorScheme.onSurface.withOpacity(0.7);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color shadowColor;
    if (isDarkMode) {
      shadowColor = Colors.white.withOpacity(0.03); // More subtle in dark mode
    } else {
      shadowColor = Colors.black.withOpacity(0.08); // Standard in light mode
    }

    return Card(
      elevation: 0, // Control elevation via BoxShadow for more custom control
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: theme.colorScheme.surface, // Use theme surface color
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            // Top Section - Event Name & Status
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      ticket.eventName,
                      style: TextStyle(
                        fontSize: 18,
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ticket.status,
                      style: TextStyle(
                        fontSize: 14,
                        color: _getStatusColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Location & Date Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          ticket.location,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ticket.date,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Time and Dashed Line Separator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    ticket.startTime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary, // Use theme primary
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildTimeDot(theme.colorScheme.primary), // Use theme primary
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DashedLine(
                        color: theme.colorScheme.onSurface.withOpacity(0.3),
                      ),
                    ),
                  ),
                  _buildTimeDot(
                    theme.colorScheme.onSurface,
                  ), // Use onSurface for end dot
                  const SizedBox(width: 12),
                  Text(
                    ticket.endTime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface, // Use onSurface
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Dashed Divider Line (middle)
            Divider(
              height: 1,
              color: theme.colorScheme.onSurface.withOpacity(0.1),
              indent: 16,
              endIndent: 16,
            ),
            // Bottom Section - Field Name & Price
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(
                        0.1,
                      ), // Use theme primary
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.stadium_outlined,
                      color: theme.colorScheme.primary, // Use theme primary
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    ticket.fieldName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${ticket.price.toStringAsFixed(2)}", // Display price
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDot(Color color) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 8,
        width: 8,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final Color color;
  const DashedLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2, // Height of the dashed line
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 6.0;
          const dashSpace = 4.0;
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}
