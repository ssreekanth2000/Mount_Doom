%% conect to phone
m = mobiledev;
accel_data = m.accellog;

pub = rospublisher('/raw_vel');
msg = rosmessage(pub);

lambda = 0.2;
delta = 1.5;

omega = (0.1 + 0.1)/0.248;

lambda = 0.9;
delta = 1.2;
i = 0;

for i = 1:2
    x = m.acceleration(1);
    y = m.acceleration(2);
    theta = -atan(y/x)

    msg.Data = [0.1,-0.1];
    send(pub,msg)

    pause(theta/omega);
    msg.Data = [0,0];
    send(pub,msg)
    
    step = theta*lambda*delta^i
end
   