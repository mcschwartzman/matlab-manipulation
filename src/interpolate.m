function ret = interpolate(startpt, endpt, steps)

step = (endpt - startpt)/steps;

ret(1,:) = startpt(1):step(1):endpt(1);
ret(2,:) = startpt(2):step(2):endpt(2);
ret(3,:) = startpt(3):step(3):endpt(3);

end