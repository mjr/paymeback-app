import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymeback/auth/user.dart';
import 'package:paymeback/components/charge_card.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/model/charge_filters.dart';
import 'package:paymeback/screens/charge_list_filters.dart';
import 'package:paymeback/utils/client.dart';

class ListChargesScreen extends StatefulWidget {
  final User user;

  const ListChargesScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ListChargesState createState() => _ListChargesState();
}

class _ListChargesState extends State<ListChargesScreen> {
  final client = Client();
  bool _isLoading = true;
  bool _isError = false;
  List<Charge> _charges = <Charge>[];

  late ChargeFilters filters = ChargeFilters();
  void _updateFilters(ChargeFilters newFilters) {
    filters = newFilters;
  }

  @override
  void initState() {
    super.initState();
    _loadCharges(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
          title: Row(
        children: [
          Text('Olá, ${widget.user.fullName}'),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChargeListFilterScreen(
                          previousFilters: filters,
                          updateFilters: _updateFilters,
                          loadCharges: _loadCharges)));
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      )),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return const Material(
                child: Center(child: CircularProgressIndicator()));
          } else if (_isError) {
            return const Material(
              child: Center(
                child: Text('Não foi possível carregar os dados',
                    textDirection: TextDirection.ltr),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: ListView.builder(
                itemCount: _charges.length,
                itemBuilder: (BuildContext context, int index) => ChargeCard(
                      charge: _charges[index],
                    )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'charge-form');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _loadCharges(ChargeFilters? loadFilters) async {
    try {
      setState(() {
        _isLoading = true;
        _isError = false;
      });

      final String queryParams =
          loadFilters != null ? loadFilters.formatForURLQuery() : '';

      final response = await client.get('charges$queryParams');

      List<Charge> newCrages =
          response["results"].map<Charge>((c) => Charge.fromJson(c)).toList();

      setState(() {
        _charges = newCrages;
        _isError = false;
      });
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
