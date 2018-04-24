%% conect to phone
m = mobiledev;
m.logging = 1;
accel_data = m.accellog;
m.logging = 1;
%%
pub = rospublisher('/raw_vel');
msg = rosmessage(pub);

lambda = 0.8;
delta = 1.5;

d = 0.248;
omega = 2*pi/10;

VR = omega*d/2;
VL = -VR;
i = 0;
grad=0
for i = 1:10

    grad1 = abs(m.acceleration(1));
    a = grad1-grad;
    if a > 0
        r=i/10;
        grad = grad1;
    end
    

    msg.Data = [VL,VR];
    send(pub,msg)

    pause(0.1);
    
    i

    msg.Data = [0,0];
    send(pub,msg)
end
r
msg.Data = [VL,VR];
send(pub,msg)

pause(r);


msg.Data = [0,0];
send(pub,msg)
