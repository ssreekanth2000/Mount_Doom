%% conect to phone
m = mobiledev;
accel_data = m.accellog;

pub = rospublisher('/raw_vel');
msg = rosmessage(pub);

lambda = 0.8;
delta = 1.5;

d = 0.248;
omega = 2*pi/10;

VR = omega*d/2;
VL = -VR;
for i = 1:10
    grad = 0;
    i=0

    while True
       
        grad1 = m.accellog(1,1);
        a = grad1-grad;
        if a > 0
            r=i;
            grad = grad1;
        end
        if i == 1
            break
        end
        
        msg.Data = [VL,VR];
        send(pub,msg)

        pause 0.1;
        i=i+0.1;
        
        msg.Data = [0,0];
        send(pub,msg)
    end
    msg.Data = [VL,VR];
    send(pub,msg)

    pause (i);
    
        
    msg.Data = [0,0];
    send(pub,msg)
    if -0.1 < grad < 0.1
        break
    end
    
    t = grad*lambda*delta.^i;
    
    msg.data = [0.1, 0.1];
    pause(t);
    
    
end