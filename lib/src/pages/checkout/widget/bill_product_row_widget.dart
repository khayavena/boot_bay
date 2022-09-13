import 'package:bootbay/src/helpers/string_formaters.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillProductRow extends StatelessWidget {
  final Product expense;
  final String currency;
  final Function(Product) onDismissed;
  final Function(Product) onUpdated;

  const BillProductRow(
      {Key? key,
      required this.expense,
      required this.currency,
      required this.onDismissed,
      required this.onUpdated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => onDismissed(expense),
      key: Key(expense.id.toString()),
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ListTile(
          onTap: () {},
          title: Text(valueWithCurrency(expense.price, currency, true)),
          subtitle: expense.name != null && expense.name.isNotEmpty
              ? Text(expense.name)
              : null,
          trailing: Text(
            DateFormat(
                    'EEEE, d MMMM', Localizations.localeOf(context).toString())
                .format(DateTime.now()),
          ),
        ),
      ),
    );
  }
}
