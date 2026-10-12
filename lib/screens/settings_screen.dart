import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool offline = true, refresh = true, haptics = true;
  String base = 'USD', expiry = 'Every 6 hours', precision = '4 (0.0000)';
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
    children: [
      const AppHeader(),
      const SizedBox(height: 18),
      const Text(
        'Settings & Offline',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: ink),
      ),
      const SizedBox(height: 4),
      const Text(
        'Manage Frankfurter API sync, local Room storage, and app preferences',
        style: TextStyle(fontSize: 14, height: 1.45, color: Color(0xFF454A5C)),
      ),
      const SizedBox(height: 16),
      _sectionHeader('DATA & API SOURCE', '● ECB / Frankfurter v1'),
      _panel([
        _apiTile(),
        _divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'api.frankfurter.dev/v1/latest',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF42485C),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.copy_rounded, size: 14),
                label: const Text('Copy', style: TextStyle(fontSize: 11)),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sync_rounded, size: 16),
                  label: const Text(
                    'Force API Sync Now',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '◷  Last Synced: Today at 14:32:10',
                style: TextStyle(fontSize: 12, color: Color(0xFF454A5C)),
              ),
            ],
          ),
        ),
      ]),
      const SizedBox(height: 16),
      _sectionHeader('OFFLINE & ROOM STORAGE', 'SQLite Engine'),
      _panel([
        _switchTile(
          Icons.cloud_off_outlined,
          'Offline Mode',
          'Serve cached exchange rates when offline',
          offline,
              (v) => setState(() => offline = v),
        ),
        _divider(),
        _choiceTile(
          Icons.av_timer_rounded,
          'Cache Expiry\nInterval',
          'Background invalidation\nfrequency',
          expiry,
          ['Every hour', 'Every 6 hours', 'Every 12 hours', 'Every day'],
              (v) => setState(() => expiry = v),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.storage_rounded,
                    size: 17,
                    color: Color(0xFF42485C),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Local Room Database',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: ink,
                    ),
                  ),
                  const Spacer(),
                  _badge('Synced', green),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _stat('Storage Footprint', '142 KB')),
                  const SizedBox(width: 8),
                  Expanded(child: _stat('Cached Pairs', '34 Pairs')),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmClear(context),
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  label: const Text(
                    'Clear Cache & Reset Room DB',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD00019),
                    side: const BorderSide(color: Color(0xFFFFC7CB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      const SizedBox(height: 16),
      _sectionHeader('PREFERENCES', ''),
      _panel([
        _choiceTile(
          Icons.monetization_on_outlined,
          'Base Currency',
          'Default calculation standard',
          base,
          ['USD', 'EUR', 'GBP', 'JPY', 'PKR'],
              (v) => setState(() => base = v),
          compact: true,
        ),
        _divider(),
        _choiceTile(
          Icons.pin_outlined,
          'Decimal Precision',
          'Rounding threshold for rates',
          precision,
          ['2 (0.00)', '3 (0.000)', '4 (0.0000)', '6 (0.000000)'],
              (v) => setState(() => precision = v),
          compact: true,
        ),
        _divider(),
        _switchTile(
          Icons.bolt_rounded,
          'Auto-Refresh on Launch',
          'Fetch fresh rates upon opening',
          refresh,
              (v) => setState(() => refresh = v),
        ),
        _divider(),
        _switchTile(
          Icons.vibration_rounded,
          'Haptic Feedback',
          'Tactile feedback on keypad input',
          haptics,
              (v) => setState(() => haptics = v),
        ),
      ]),
    ],
  );

  Widget _sectionHeader(String title, String trailing) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 6),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF70788C),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: .7,
          ),
        ),
        const Spacer(),
        if (trailing.isNotEmpty)
          Text(
            trailing,
            style: TextStyle(
              color: trailing.startsWith('●') ? green : const Color(0xFF41465A),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    ),
  );
  Widget _panel(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFFE5ECFF)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08001B55),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(children: children),
  );
  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, color: Color(0xFFE1E9FF)),
  );
  Widget _iconBox(IconData icon) => Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: const Color(0xFFEFF3FF),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Icon(icon, size: 20, color: blue),
  );
  Widget _apiTile() => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        _iconBox(Icons.hub_outlined),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frankfurter Rates API',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'European Central Bank Reference',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Color(0xFF42485C)),
              ),
            ],
          ),
        ),
        _badge('● Connected', const Color(0xFF00A77D)),
      ],
    ),
  );
  Widget _badge(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFE0FBF1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
    ),
  );
  Widget _switchTile(
      IconData icon,
      String title,
      String subtitle,
      bool value,
      ValueChanged<bool> onChanged,
      ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    child: Row(
      children: [
        _iconBox(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.25,
                  color: Color(0xFF42485C),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: blue,
        ),
      ],
    ),
  );
  Widget _choiceTile(
      IconData icon,
      String title,
      String subtitle,
      String value,
      List<String> options,
      ValueChanged<String> onChanged, {
        bool compact = false,
      }) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: compact ? 11 : 13),
    child: Row(
      children: [
        _iconBox(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.25,
                  color: Color(0xFF42485C),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          initialValue: value,
          onSelected: onChanged,
          itemBuilder: (_) => options
              .map((v) => PopupMenuItem(value: v, child: Text(v)))
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (compact && title == 'Base Currency')
                Container(
                  width: 21,
                  height: 21,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDE5FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      value == 'USD' ? '\$' : value[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: ink,
                      ),
                    ),
                  ),
                ),
              Text(
                value,
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  fontWeight: FontWeight.w700,
                  color: compact ? ink : blue,
                  fontFamily: title == 'Decimal Precision' ? 'monospace' : null,
                ),
              ),
              Icon(
                compact
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.chevron_right_rounded,
                size: 20,
                color: muted,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget _stat(String label, String value) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE5ECFF)),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: muted)),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: ink,
          ),
        ),
      ],
    ),
  );
  void _confirmClear(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear local cache?'),
        content: const Text(
          'Cached exchange rates and local database records will be removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}