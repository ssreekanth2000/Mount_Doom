%%
pub = rospublisher('/raw_vel');
msg = rosmessage(pub);
sub_bump = rossubscriber('/bump');
accel = rossubscriber('/accel');
threshhold = 0.02;
lambda = 0.8;
delta = 1.5;

d = 0.248;
omega = 2*pi/10;

VR = omega*d/2;
VL = -VR;

while true
    accel_abs = receive(accel);
    x_accel = accel_abs.Data(1);
    y_accel = accel_abs.Data(2)
    
    if y_accel >= threshhold
       msg.Data = [VL, VR];
       send(pub,msg)
       pause(0.1)
    
    
    elseif y_accel <= -threshhold
       msg.Data = [-VL, -VR];
       send(pub,msg)
       pause(0.1)
     
        
   
    
    elseif x_accel < 0
       msg.Data = [VL, VR];
       send(pub,msg)
       pause(0.1)
       
     else -threshhold < y_accel < threshhold
        msg.Data = [-VL, VR];
        send(pub,msg)
        pause(0.4)
    end
    
%     accel_abs_2 = receive(accel);
%     x_accel_2 = accel_abs_2.Data(1);
%     y_accel_2 = accel_abs_2.Data(2);
%     abs(y_accel-y_accel_2)
%     abs(x_accel-x_accel_2)
%     
%     if and(abs(y_accel-y_accel_2) < threshhold/10, abs(x_accel-x_accel_2) < threshhold/10)
%          msg.Data = [0,0];
%          send(pub,msg);
%          break
%     end
end