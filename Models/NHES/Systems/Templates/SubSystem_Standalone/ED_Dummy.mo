within NHES.Systems.Templates.SubSystem_Standalone;
model ED_Dummy

  extends BaseClasses.Partial_EventDriver;

equation

annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end ED_Dummy;
