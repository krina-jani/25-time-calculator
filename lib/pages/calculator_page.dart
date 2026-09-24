import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/time_calculator_logic.dart';
import 'about_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Input Controllers for First Time Value
  final TextEditingController _day1Controller = TextEditingController();
  final TextEditingController _hour1Controller = TextEditingController();
  final TextEditingController _minute1Controller = TextEditingController();
  final TextEditingController _second1Controller = TextEditingController();

  // Input Controllers for Second Time Value
  final TextEditingController _day2Controller = TextEditingController();
  final TextEditingController _hour2Controller = TextEditingController();
  final TextEditingController _minute2Controller = TextEditingController();
  final TextEditingController _second2Controller = TextEditingController();

  // Operation selection: false = Add, true = Subtract
  bool _isSubtract = false;

  // Calculation Result State
  TimeResult _result = TimeResult.empty();

  @override
  void dispose() {
    _day1Controller.dispose();
    _hour1Controller.dispose();
    _minute1Controller.dispose();
    _second1Controller.dispose();
    _day2Controller.dispose();
    _hour2Controller.dispose();
    _minute2Controller.dispose();
    _second2Controller.dispose();
    super.dispose();
  }

  void _calculate() {
    FocusScope.of(context).unfocus();

    final res = TimeCalculatorLogic.calculate(
      day1Text: _day1Controller.text,
      hour1Text: _hour1Controller.text,
      minute1Text: _minute1Controller.text,
      second1Text: _second1Controller.text,
      day2Text: _day2Controller.text,
      hour2Text: _hour2Controller.text,
      minute2Text: _minute2Controller.text,
      second2Text: _second2Controller.text,
      isSubtract: _isSubtract,
    );

    setState(() {
      _result = res;
    });
  }

  void _clear() {
    FocusScope.of(context).unfocus();
    setState(() {
      _day1Controller.clear();
      _hour1Controller.clear();
      _minute1Controller.clear();
      _second1Controller.clear();

      _day2Controller.clear();
      _hour2Controller.clear();
      _minute2Controller.clear();
      _second2Controller.clear();

      _isSubtract = false;
      _result = TimeResult.empty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/icons/app_logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.access_time_filled_rounded,
                    color: Color(0xFF2563EB),
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Time Calculator',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: const Color(0x1F000000),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF2563EB),
              size: 26,
            ),
            tooltip: 'Open About',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F1E3A8A),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time Calculator',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'This calculator can be used to "add" or "subtract" two time values. Input fields can be left blank, which will be taken as 0 by default.',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFFE2E8F0),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Main Calculator Container Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBECEF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Column Header Badges
                        _buildColumnHeaderLabels(),
                        const SizedBox(height: 12),

                        // First Time Input Row
                        Row(
                          children: [
                            _buildInputField(_day1Controller),
                            _buildInputField(_hour1Controller),
                            _buildInputField(_minute1Controller),
                            _buildInputField(_second1Controller),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Radio Button Selector: Add+ | Subtract–
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildRadioOption(value: false, label: 'Add+'),
                                const SizedBox(width: 14),
                                _buildRadioOption(value: true, label: 'Subtract–'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Second Time Input Row
                        Row(
                          children: [
                            _buildInputField(_day2Controller),
                            _buildInputField(_hour2Controller),
                            _buildInputField(_minute2Controller),
                            _buildInputField(_second2Controller),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Equals Sign
                        Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E293B),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x29000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            '=',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Result Fields Row (Read-only styled boxes matching input fields exactly)
                        Row(
                          children: [
                            _buildResultField(
                              _result.hasCalculated
                                  ? '${_result.isNegative && _result.days > 0 ? "-" : ""}${_result.days}'
                                  : '',
                            ),
                            _buildResultField(
                              _result.hasCalculated
                                  ? '${_result.isNegative && _result.days == 0 && _result.hours > 0 ? "-" : ""}${_result.hours}'
                                  : '',
                            ),
                            _buildResultField(
                              _result.hasCalculated
                                  ? '${_result.isNegative && _result.days == 0 && _result.hours == 0 && _result.minutes > 0 ? "-" : ""}${_result.minutes}'
                                  : '',
                            ),
                            _buildResultField(
                              _result.hasCalculated
                                  ? '${_result.isNegative && _result.days == 0 && _result.hours == 0 && _result.minutes == 0 ? "-" : ""}${_result.seconds}'
                                  : '',
                            ),
                          ],
                        ),

                        // Formatted summary alert banner
                        if (_result.hasCalculated) ...[
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: _result.isNegative
                                  ? const Color(0xFFFEF2F2)
                                  : const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _result.isNegative
                                    ? const Color(0xFFFCA5A5)
                                    : const Color(0xFF86EFAC),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _result.isNegative
                                      ? Icons.remove_circle_outline_rounded
                                      : Icons.check_circle_outline_rounded,
                                  size: 20,
                                  color: _result.isNegative
                                      ? const Color(0xFFDC2626)
                                      : const Color(0xFF16A34A),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    _result.formattedText,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: _result.isNegative
                                          ? const Color(0xFF991B1B)
                                          : const Color(0xFF15803D),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),

                        // Action Buttons: [ Calculate ▶ ]  [ Clear ]
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3316A34A),
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _calculate,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4B7B1F),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 13,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Calculate',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              ElevatedButton(
                                onPressed: _clear,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8A8A8A),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 13,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnHeaderLabels() {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Day',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF0F172A),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            'Hour',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF0F172A),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            'Minute',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF0F172A),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            'Second',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF0F172A),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Color(0xFF94A3B8), width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Color(0xFF2563EB), width: 1.8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Color(0xFF94A3B8), width: 1.2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            isDense: true,
          ),
        ),
      ),
    );
  }

  Widget _buildResultField(String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF94A3B8), width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption({
    required bool value,
    required String label,
  }) {
    final bool isSelected = _isSubtract == value;
    return InkWell(
      onTap: () {
        setState(() {
          _isSubtract = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF64748B),
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
