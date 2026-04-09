enum AlertSeverity {
  watch,
  advisory,
  warning,
  emergency;

  String get label => switch (this) {
        watch => '观察',
        advisory => '提示',
        warning => '警告',
        emergency => '紧急',
      };

  int get priority => switch (this) {
        watch => 0,
        advisory => 1,
        warning => 2,
        emergency => 3,
      };
}
