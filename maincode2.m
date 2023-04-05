clearvars
brick = ConnectBrick("gripy");
global key
InitKeyboard();
SPEED = -40;
LMOTOR = 'A';
RMOTOR = 'B';
DMOTOR = 'D';
colorSensePort= 4;
distSensePort = 3;
touchSensePort = 2;
turningRadius = 430;

while 1 %infinite loop
    colorSense = brick.ColorCode(colorSensePort); %turn on color sensor
    distSense = brick.UltrasonicDist(distSensePort); %turn on ultrasonic sensor
    touchSense = brick.TouchPressed(touchSensePort); %turn on touch sensor
    switch colorSense
        case 1
            disp('black');
            if distSense < 40 && touchSense == 0
                brick.MoveMotor(LMOTOR, SPEED);
                brick.MoveMotor(RMOTOR, SPEED);
            end
            if distSense < 40 && touchSense == 1
                brick.MoveMotor(LMOTOR, -SPEED);
                brick.MoveMotor(RMOTOR, -SPEED);
                pause(3.0);
                brick.MoveMotorAngleRel(LMOTOR, SPEED, 2*turningRadius, 'Coast');
                pause(1.0);
                brick.MoveMotor(LMOTOR, SPEED);
                brick.MoveMotor(RMOTOR, SPEED);
            end
            if distSense > 40 && touchSense == 0
                pause(1.0);
                brick.ResetMotorAngle(LMOTOR); 
                brick.ResetMotorAngle(RMOTOR); 
                brick.MoveMotorAngleRel(LMOTOR, SPEED, turningRadius, 'Coast');
            end
            if distSense > 40 && touchSense == 1
                brick.MoveMotor(RMOTOR,-SPEED);
                brick.MoveMotor(LMOTOR,-SPEED);
                pause(1.2);                            
                brick.StopAllMotors;
                brick.MoveMotorAngleRel(RMOTOR, SPEED, turningRadius, 'Coast');   
            
            end
        
        case 5
            disp('Red. Stop for 3 seconds');
            brick.StopAllMotors();
            pause(3.0);
            brick.MoveMotor(LMOTOR, SPEED);
            brick.MoveMotor(RMOTOR, SPEED);
        otherwise
            disp('manual mode');
            brick.StopAllMotors();
            while 1
                pause(0.1);
            switch key
                case 'uparrow'         %For moving forward
                     disp('up Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, SPEED);
                     brick.MoveMotor(LMOTOR, SPEED);
            
                 case 'downarrow'           %For moving backward
                     disp('down Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, -SPEED);
                     brick.MoveMotor(LMOTOR, -SPEED);
            
                 case 'leftarrow'        %For turning left
                     disp('Left Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, SPEED);
                     brick.MoveMotor(LMOTOR, -SPEED);
            
                 case 'rightarrow'         %For turning right
                     disp('Right Arrow Pressed!');
                     brick.MoveMotor(RMOTOR,-SPEED);
                     brick.MoveMotor(LMOTOR,SPEED);
            
                 case 'w'                 %Raises the lift
                     disp('w pressed');
                     brick.MoveMotor(FMOTOR,5);
            
                 case 's'                 %Lowes the lift
                     disp('s pressed');
                     brick.MoveMotor(FMOTOR,-5);
            
                 case 0                   %No key is being pressed.
                     disp('No Key Pressed');
                     brick.StopMotor('A');
                     brick.StopMotor('D');
                     brick.StopMotor('B');
                 case "t"
                     break

            end
            end
            CloseKeyboard();
    end
end
