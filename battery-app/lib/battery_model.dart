class ModelBatteryParams {
  double totalVolt = 0;
  double current = 0;
  double soc = 0;
  double cellVolt1 = 0;
  double cellVolt2 = 0;
  double cellVolt3 = 0;

  double cellVolt4 = 0;
  double maxVolt = 0;
  double minVolt = 0;

  ModelBatteryParams(
      this.totalVolt,
      this.current,
      this.soc,
      this.cellVolt1,
      this.cellVolt2,
      this.cellVolt3,
      this.cellVolt4,
      this.maxVolt,
      this.minVolt);

  toString() {
    return "$totalVolt, $current, $soc, $cellVolt1, $cellVolt2, $cellVolt3, $cellVolt4, $maxVolt, $minVolt";
  }
}
