import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: BillSplitter()));
}

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  BillSplitterState createState() => BillSplitterState();
}

class BillSplitterState extends State<BillSplitter> {
  int tipPercentage = 0;
  int repCounter = 1;
  double billTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent.withOpacity(0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total per Person',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "\$ ${calculateTotalPerRep(repCounter, billTotal, tipPercentage)}",
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.brown.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.orange),
                    decoration: const InputDecoration(
                        prefix: Text('Total Bill:'),
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (value) {
                      try {
                        billTotal = double.parse(value);
                      } catch (exception) {
                        billTotal = 0.0;
                      }
                    },
                    /*onSubmitted: (value) {
                      calculateTotalTip(
                          double.parse(value), repCounter, tipPercentage);
                    },*/
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Split'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (repCounter > 1) {
                                  repCounter--;
                                } else {}
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orangeAccent.withOpacity(0.1),
                              ),
                              child: const Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$repCounter",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                repCounter++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orangeAccent.withOpacity(0.1),
                              ),
                              child: const Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tip'),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$${calculateTotalTip(billTotal, repCounter, tipPercentage)}",
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '$tipPercentage%',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          divisions: 20,
                          //label: 'Tip%',
                          activeColor: Colors.orange,
                          inactiveColor: Colors.brown,
                          value: tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              tipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerRep(int rep, double amount, int percent) {
    double totalPerRep =
        (calculateTotalTip(amount, rep, percent) + amount) / rep;

    return totalPerRep.toStringAsFixed(2);
  }

  calculateTotalTip(double amount, int rep, int percent) {
    double totalTip = 0.0;

    if (amount < 0 || amount.toString().isEmpty) {
    } else {
      totalTip = (amount * percent) / 100;
    }
    return totalTip;
  }
}
