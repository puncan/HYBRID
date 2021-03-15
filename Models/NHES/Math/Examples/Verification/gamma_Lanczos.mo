within NHES.Math.Examples.Verification;
model gamma_Lanczos

  extends Modelica.Icons.Example;

  Utilities.ErrorAnalysis.Errors_AbsRelRMS summary_Error(
    n=n,
    x_1=y,
    x_2=gamma_Matlab)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  final parameter Integer n=10;

  Real[n] gamma_Matlab = {2.67893853470775, 1.35411793942640, 1.0,
                             0.892979511569249, 0.902745292950934, 1.0,
                             1.19063934875900, 1.50457548825156, 2.0,
                             2.77815848043767};

  Real[n] y "Function value";

equation

  for i in 1:10 loop
    y[i] = NHES.Math.gamma_Lanczos(z=i/3.0);
  end for;

  annotation (experiment(StopTime=10),__Dymola_experimentSetupOutput);
end gamma_Lanczos;
