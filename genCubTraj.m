function cubtraj = genCubTraj(t0, tf, v0, vf, q0, qf, ts)

M = [1 t0 t0^2 t0^3; 0 1 2*t0 3*t0^2; 1 tf tf^2 tf^3; 0 1 2*tf 3*tf^2]; 
q = [q0; v0; qf; vf];
a = M\q;

cubtraj = [];

syms t pos(t) vel(t) acc(t)
pos(t) = a(1) + a(2)*t + a(3)*t^2 + a(4)*t^3;
vel(t) = a(2) + 2*a(3)*t + 3*a(4)*t^2;
acc(t) = 2*a(3) + 6*a(4)*t;

for t = t0:ts:tf
    cubtraj = [cubtraj; subs(t) subs(pos(t)) subs(vel(t)) subs(acc(t))];
end