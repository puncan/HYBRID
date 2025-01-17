within NHES.Media.Common;
function FindIndexI
  input Real x;
  input Real v[:];
  output Integer ind[2];

protected
  Integer v_sz=size(v, 1);
  Integer i=integer(v_sz/2) + 1;
  Integer i_max=v_sz;
algorithm
  while x < v[i - 1] or x > v[i + 1] or i <= 1 or i >= v_sz loop
    if x < v[i] then
      i_max := i;
      i := integer(i/2) + 1;
    else
      i := integer((i + i_max)/2);
    end if;
  end while;

  ind := if x < v[i] then {i - 1,i} else {i,i + 1};
end FindIndexI;
