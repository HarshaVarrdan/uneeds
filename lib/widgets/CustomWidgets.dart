import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InfoPageOptions extends StatefulWidget {
  const InfoPageOptions(
      {super.key,
      required this.title,
      this.imagePath,
      required this.value,
      required this.onValueChange});

  final bool value;
  final String title;
  final String? imagePath;
  final ValueChanged<bool> onValueChange;

  @override
  State<InfoPageOptions> createState() => _InfoPageOptionState();
}

class _InfoPageOptionState extends State<InfoPageOptions> {
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isClicked = widget.value;
  }

  @override
  void didUpdateWidget(InfoPageOptions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      print("${widget.title} - ${oldWidget.value} : ${widget.value}");
      setState(() {
        isClicked = widget.value;
      });
    }
  }

  void onClicked() {
    setState(() {
      isClicked = !isClicked;
    });
    widget.onValueChange(isClicked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked();
        print("Box Clicked ${isClicked}");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: isClicked
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
                  width: 2)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: widget.imagePath == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    CheckBox(
                      value: isClicked,
                      onChanged: (value) {
                        onClicked();
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Image(
                            image: AssetImage(widget.imagePath ?? ""),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            color: isClicked
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    CheckBox(
                      value: isClicked,
                      onChanged: (value) {
                        onClicked();
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class TaskPageOptions extends StatefulWidget {
  const TaskPageOptions({
    super.key,
    required this.title,
    this.imagePath,
    required this.value,
    required this.onValueChange,
  });

  final bool value;
  final String title;
  final String? imagePath;
  //final bool isEnabled;
  final VoidCallback onValueChange;

  @override
  State<TaskPageOptions> createState() => _TaskPageOptionsState();
}

class _TaskPageOptionsState extends State<TaskPageOptions> {
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isClicked = widget.value;
  }

  @override
  void didUpdateWidget(TaskPageOptions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      print("${widget.title} - ${oldWidget.value} : ${widget.value}");
      setState(() {
        isClicked = widget.value;
      });
    }
  }

  void onClicked() {
    widget.onValueChange();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: isClicked
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
                  width: 2)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: widget.imagePath == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TickBox(
                      value: isClicked,
                      onChanged: (value) {
                        onClicked();
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Image(
                            image: AssetImage(widget.imagePath ?? ""),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            color: isClicked
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TickBox(
                      value: isClicked,
                      onChanged: (value) {
                        onClicked();
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CheckBox extends StatefulWidget {
  const CheckBox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    print(_currentValue);
  }

  @override
  void didUpdateWidget(CheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      onClicked(!oldWidget.value);
    }
  }

  void onClicked(bool? newValue) {
    setState(() {
      _currentValue = newValue!;
      print(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked(!_currentValue);
        widget.onChanged(_currentValue);
        print("CheckBox Clicked ${_currentValue}");
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _currentValue
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context)
                    .colorScheme
                    .tertiary, // Outer circle stroke color
            width: 2.0, // Outer circle stroke width
          ),
        ),
        child: _currentValue
            ? Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary, // Inner circle color
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class TickBox extends StatefulWidget {
  const TickBox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  State<TickBox> createState() => _TickBoxState();
}

class _TickBoxState extends State<TickBox> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    print(_currentValue);
  }

  @override
  void didUpdateWidget(TickBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      onClicked(!oldWidget.value);
    }
  }

  void onClicked(bool? newValue) {
    setState(() {
      _currentValue = newValue!;
      print(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked(!_currentValue);
        widget.onChanged(_currentValue);
        print("CheckBox Clicked ${_currentValue}");
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentValue
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context)
                  .colorScheme
                  .tertiary, // Outer circle stroke color
        ),
        child: _currentValue
            ? const Center(
                child: Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ))
            : null,
      ),
    );
  }
}

class CustomTextFieldA extends StatelessWidget {
  final Widget? prefix;
  final String hintText;
  final TextEditingController controller;

  const CustomTextFieldA({
    super.key,
    this.prefix,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 12,
      child: TextField(
        cursorColor: const Color(0xFF202020),
        controller: controller,
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.start,
          prefix: prefix != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null) prefix!,
                    const SizedBox(width: 10),
                  ],
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
            borderSide: const BorderSide(color: Color(0xFF7E7E7E), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
            borderSide: const BorderSide(color: Color(0xFF7E7E7E), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
            borderSide: const BorderSide(
                color: Color(0xFF7E7E7E),
                width: 1.0), // Customize the color for focus
          ),
          hintText: "Enter your Number",
          hintStyle: const TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 14,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w400,
          ),
        ),
        style: const TextStyle(
          color: Color(0xFF151617),
          fontSize: 18,
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w700,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }
}

class CustomTextFieldB extends StatelessWidget {
  final Widget? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;

  const CustomTextFieldB({
    super.key,
    this.prefix,
    required this.hintText,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          textBaseline: TextBaseline.alphabetic,
          children: [
            const SizedBox(width: 10),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 11,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 16,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            readOnly: readOnly ?? false,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            cursorColor: const Color(0xFF202020),
            controller: controller,
            decoration: InputDecoration(
              floatingLabelAlignment: FloatingLabelAlignment.start,
              prefix: prefix != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (prefix != null) prefix!,
                        const SizedBox(width: 10),
                      ],
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color(0xFF7E7E7E), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color(0xFF7E7E7E), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: Color(0xFF7E7E7E),
                    width: 1.0), // Customize the color for focus
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF7E7E7E),
                fontSize: 14,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF151617),
              fontSize: 16,
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}

class CustomDOBField extends StatelessWidget {
  final String hintText;
  final String labelText;
  bool? valueSelected = false;

  CustomDOBField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.valueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          textBaseline: TextBaseline.alphabetic,
          children: [
            const SizedBox(width: 10),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 11,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height / 16,
          //width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF7E7E7E), width: 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hintText == "" ? "DD/MM/YYYY" : hintText,
                style: valueSelected ?? false
                    ? const TextStyle(
                        color: Color(0xFF151617),
                        fontSize: 16,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w500,
                      )
                    : const TextStyle(
                        color: Color(0xFF7E7E7E),
                        fontSize: 14,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w400,
                      ),
              ),
              ImageIcon(
                const AssetImage("assets/images/dobcalender.png"),
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu(
      {super.key,
      required this.values,
      required this.onValueChange,
      required this.hintText});

  final String hintText;
  final List<String> values;
  final ValueChanged<String> onValueChange;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String selectedItem = widget.values.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          textBaseline: TextBaseline.alphabetic,
          children: [
            const SizedBox(width: 10),
            Text(
              widget.hintText,
              style: const TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 11,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height / 16,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF808080), // Set the color of the border
              width: 1.0, // Set the width of the border
            ),
            borderRadius: BorderRadius.circular(8.0), // Set the border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(8),
              isExpanded: true,
              value: selectedItem,
              icon: ImageIcon(
                const AssetImage("assets/images/dropdown.png"),
                color: Theme.of(context).colorScheme.secondary,
              ),
              underline: Container(
                color: Colors.transparent,
              ),
              elevation: 0,
              style: const TextStyle(
                color: Color(0xFF202020),
                fontWeight: FontWeight.w500,
                fontFamily: "DMSans",
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  selectedItem = value!;
                  widget.onValueChange(value!);
                });
              },
              items:
                  widget.values.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageButtonHolder extends StatelessWidget {
  const ImageButtonHolder(
      {super.key, required this.imagePath, required this.onPressed});

  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        "assets/images/Icons/googlelogo.png",
        fit: BoxFit.fill,
      ),
      iconSize: 1,
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(
            MediaQuery.of(context).size.width / 4,
            MediaQuery.of(context).size.height / 13)),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 35)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFDADADA), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class OpenTicketCard extends StatelessWidget {
  const OpenTicketCard({super.key, required this.TicketData});

  final Map<String, dynamic> TicketData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.4,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: Colors.white),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TicketData["service_name"].toString(),
                style: const TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFF202020)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const ImageIcon(
                        AssetImage(
                          "assets/images/location_dark.png",
                        ),
                        size: 20,
                        color: Color(0xFF808080),
                      ),
                      Text(
                        TicketData["ticket_location"].toString() == "{}"
                            ? "Test Area"
                            : TicketData["ticket_location"].toString(),
                        style: const TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF808080)),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFD9D9D9),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    child: const Center(
                      child: Text(
                        "2.3 Km Away",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xFF202020)),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    DateFormat('dd MMM y')
                        .format(DateTime.parse(TicketData["service_time"])),
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD9D9D9),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "AFTER",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF808080)),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(
                                  DateTime.parse(TicketData["service_time"])),
                              style: const TextStyle(
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF202020)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 3,
                          child: Divider(
                            height: 10,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Before",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF808080)),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(
                                  DateTime.parse(TicketData["service_time"])
                                      .add(const Duration(hours: 2))),
                              style: const TextStyle(
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF202020)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Rs.${TicketData["service_cost"].toString()}",
                    style: const TextStyle(
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xFF202020)),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xFFFFFFFF)),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 15),
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCardsA extends StatefulWidget {
  const SettingsCardsA({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SettingsCardsA> createState() => _SettingsCardsAState();
}

class _SettingsCardsAState extends State<SettingsCardsA> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  ImageIcon(
                    const AssetImage("assets/images/servicehistory.png"),
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service History",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF202020),
                        ),
                      ),
                      Text(
                        "View Your Job History",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF808080),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0xFFD9D9D9)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Row(
                  children: [
                    Image(
                      image: AssetImage(
                        "assets/images/service_logo.png",
                      ),
                      width: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tap Repair",
                          style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Color(0xFF202020),
                          ),
                        ),
                        Text(
                          "Abishek in Lawspet",
                          style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFF808080),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View More...",
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCardsB extends StatelessWidget {
  const SettingsCardsB(
      {super.key,
      required this.CardIconLoc,
      required this.CardName,
      required this.CardDesc,
      required this.onTap});
  final String CardIconLoc;
  final String CardName;
  final String CardDesc;
  final VoidCallback onTap;
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(CardIconLoc),
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CardName,
                    style: const TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF202020),
                    ),
                  ),
                  Text(
                    CardDesc,
                    style: const TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceHistoryCard extends StatelessWidget {
  const ServiceHistoryCard(
      {super.key,
      required this.CardIconLoc,
      required this.onTap,
      required this.TicketData});

  final String CardIconLoc;
  final Map<String, dynamic> TicketData;
  final VoidCallback onTap;

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage(CardIconLoc),
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TicketData["service_name"],
                        style: const TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF202020),
                        ),
                      ),
                      Text(
                        "${TicketData["user_name"]} in ${TicketData["ticket_location"]}",
                        style: const TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color(0xFF808080),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Rs.${TicketData["service_cost"].toString()}",
                style: const TextStyle(
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF202020),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.PageName,
      required this.context,
      this.leadingBool = true,
      this.defaultReturn});

  final String PageName;
  final bool? leadingBool;
  final dynamic defaultReturn;
  final BuildContext context;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + MediaQuery.of(context).size.height / 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingBool ?? false
          ? IconButton(
              onPressed: () {
                Navigator.pop(context, defaultReturn);
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 25,
              ),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 10),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Center(
            child: Text(
              PageName.toString(),
              style: TextStyle(
                fontFamily: "DMSans",
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
