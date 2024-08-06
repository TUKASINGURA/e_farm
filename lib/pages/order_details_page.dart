import 'package:e_farm_system/models/order.dart';
import 'package:e_farm_system/utils/extensions/date.dart';
import 'package:e_farm_system/widgets/order_item.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orderTimelines = ['Processing', 'Picking', 'Shipping', 'Delivered'];
    int activeStep = 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomStepper(
            steps: orderTimelines,
            currentStep: activeStep,
            activeColor: theme.colorScheme.primary,
            inactiveColor: Colors.grey.shade300,
            completedColor: theme.colorScheme.primary.withOpacity(0.5),
            textColor: Colors.black87,
          ),
          const SizedBox(height: 20),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            elevation: 0.1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order: ${order.id}",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        shape: const StadiumBorder(),
                        side: BorderSide.none,
                        backgroundColor:
                            theme.colorScheme.primaryContainer.withOpacity(0.4),
                        labelPadding: EdgeInsets.zero,
                        avatar: const Icon(Icons.fire_truck),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        label: Text(
                          orderTimelines[activeStep],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery estimate"),
                      Text(
                        order.date.deliveryDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Tukasingura Richard Werinde",
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(Icons.home, size: 15),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "6844 Hall Spring Suite 134\n East Annabury, OK 42291",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(Icons.call, size: 15),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "233 5447 51048",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment method"),
                      Text(
                        "Credit Card **1234",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          OrderItem(order: order, visibleProducts: 1),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final List<String> steps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;
  final Color completedColor;
  final Color textColor;

  const CustomStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.activeColor,
    required this.inactiveColor,
    required this.completedColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (index) {
        bool isCompleted = index < currentStep;
        bool isActive = index == currentStep;

        return Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: isCompleted
                    ? completedColor
                    : (isActive ? activeColor : inactiveColor),
                child: CircleAvatar(
                  radius: 2.5,
                  backgroundColor:
                      isCompleted || isActive ? activeColor : inactiveColor,
                ),
              ),
              if (index < steps.length - 1)
                Container(
                  height: 1.5,
                  color: isCompleted ? activeColor : inactiveColor,
                ),
              const SizedBox(height: 4),
              Text(
                steps[index],
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}



// import 'package:e_farm_system/models/order.dart';
// import 'package:easy_stepper/easy_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// class OrderDetailsPage extends StatelessWidget {
//   const OrderDetailsPage({
//     Key? key,
//     required this.order,
//   }) : super(key: key);

//   final Order order;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final orderTimelines = ['Processing', 'Picking', 'Shipping', 'Delivered'];
//     int activeStep = 2;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Details"),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           EasyStepper(
//             activeStep: activeStep,
//             lineLength: 70,
//             lineSpace: 0,
//             defaultLineColor: Colors.grey.shade300,
//             finishedLineColor: theme.colorScheme.primary,
//             activeStepTextColor: Colors.black87,
//             finishedStepTextColor: Colors.black87,
//             internalPadding: 0,
//             showLoadingAnimation: true,
//             stepRadius: 8,
//             lineThickness: 1.5,
//             steps: List.generate(orderTimelines.length, (index) {
//               return EasyStep(
//                 customStep: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: activeStep > index
//                       ? theme.colorScheme.primary.withOpacity(0.5)
//                       : Colors.grey.shade400,
//                   child: CircleAvatar(
//                     radius: 2.5,
//                     backgroundColor: activeStep > index
//                         ? theme.colorScheme.primary
//                         : Colors.grey.shade200,
//                   ),
//                 ),
//                 title: orderTimelines[index],
//                 topTitle: true,
//               );
//             }),
//             onStepReached: (index) {},
//           ),
//           const SizedBox(height: 20),
//           Card(
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               side: BorderSide(color: Colors.grey.shade200),
//             ),
//             elevation: 0.1,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Order: ${order.id}",
//                         style: theme.textTheme.titleSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Chip(
//                         shape: const StadiumBorder(),
//                         side: BorderSide.none,
//                         backgroundColor:
//                             theme.colorScheme.primaryContainer.withOpacity(0.4),
//                         labelPadding: EdgeInsets.zero,
//                         avatar: const Icon(Icons.fire_truck),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 0, horizontal: 10),
//                         label: Text(
//                           orderTimelines[activeStep],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Delivery estimate"),
//                       Text(
//                         order.date.deliveryDate,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     "Jessi Williams",
//                     style: theme.textTheme.titleSmall
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 5),
//                   const Row(
//                     children: [
//                       Icon(IconlyLight.home, size: 15),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Text(
//                           "6844 Hall Spring Suite 134\n East Annabury, OK 42291",
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   const Row(
//                     children: [
//                       Icon(IconlyLight.call, size: 15),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Text(
//                           "233 5447 51048",
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 25),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Payment method"),
//                       Text(
//                         "Credit Card **1234",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//           OrderItem(order: order, visibleProducts: 1),
//         ],
//       ),
//     );
//   }
// }
