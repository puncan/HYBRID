within NHES.Systems.EnergyStorage.Battery.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.Power W_totalSetPoint "Setpoint for power output from supervisory control";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
