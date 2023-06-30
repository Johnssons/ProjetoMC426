import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safe_neighborhood/models/Event.dart';
import 'package:safe_neighborhood/models/event_model.dart';
import 'package:safe_neighborhood/widgets/map_widget.dart';

class EventScreen extends StatelessWidget {
  final Event event;

  const EventScreen(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Ocorrência',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Data/hora:",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text("${DateFormat("dd/MM/yyyy").format(event.dateTime)} às ${DateFormat("HH:mm").format(event.dateTime)}",
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text("Tipo:",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(event.type,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text("Descrição",
              style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Center(child: Text(event.description,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            ),
            const Divider(),
            Text("Localização",
              style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: FutureBuilder<Event>(
                future: EventModel.getEventByLocation(event.location),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                    List<Event> events = [];
                    events.add(snapshot.data ?? Event());
                    return SizedBox(
                      height: 600.0,
                      child: MapWidget(events: events),
                    );
                  }
                }
              )
            )
          ],
        ),
      ),
    );
  }
}