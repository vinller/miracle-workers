clearvars
brick = ConnectBrick("gripy");
global key
InitKeyboard();
SPEED = 40;
LMOTOR = 'A';
RMOTOR = 'B';
DMOTOR = 'D';
colorPort = 4;
distPort = 3;
touchPort = 2;
turningRadius = 430

while 1 %infinite loop
    colorSense = brick.ColorCode(colorSensePort); %turn on color sensor
    distSense = brick.UltrasonicDist(distSensePort); %turn on ultrasonic sensor
    touchSense = brick.TouchPressed(buttonSensePort); %turn on touch sensor
    switch colorSense
        case 1
            if distSense < 40 && touchSense == 0
                brick.MoveMotor(LMOTOR, SPEED);
                brick.MoveMotor(RMOTOR, SPEED);
            elseif buttonSense == 1
                brick.MoveMotor(LMOTOR, -SPEED);
                brick.MoveMotor(RMOTOR, -SPEED);
                pause(3.0);
                brick.MoveMotorAngleRel(LMOTOR, SPEED, 2*TURNING_RADIUS, 'Coast');
                pause(1.0);
                brick.MoveMotor(LMOTOR, SPEED);
                brick.MoveMotor(RMOTOR, SPEED);
            elseif distSense > 40 && touchSense == 0
                pause(1.0);
                brick.ResetMotorAngle(LMOTOR); 
                brick.ResetMotorAngle(RMOTOR); 
                brick.MoveMotorAngleRel(LMOTOR, SPEED, TURNING_RADIUS, 'Coast');
            elseif distSense 
            
            end
        
        case 5
            disp('Stop for 3 seconds');
            brick.StopAllMotors();
            pause(3.0);
            brick.MoveMotor(LMOTOR, SPEED);
            brick.MoveMotor(RMOTOR, SPEED);
        otherwise
            disp('manual mode');
            brick.StopAllMotors();
            switch key
                case 'uparrow'         %For moving forward
                     disp('up Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, SPEED)
                     brick.MoveMotor(LMOTOR, SPEED)
            
                 case 'downarrow'           %For moving backward
                     disp('down Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, -SPEED)
                     brick.MoveMotor(LMOTOR, -SPEED)
            
                 case 'leftarrow'        %For turning left
                     disp('Left Arrow Pressed!');
                     brick.MoveMotor(RMOTOR, SPEED)
                     brick.MoveMotor(LMOTOR, -SPEED)
            
                 case 'rightarrow'         %For turning right
                     disp('Right Arrow Pressed!');
                     brick.MoveMotor(RMOTOR,-SPEED)
                     brick.MoveMotor(LMOTOR,SPEED)
            
                 case 'w'                 %Raises the lift
                     disp('w pressed')
                     brick.MoveMotor(FMOTOR,15)
            
                 case 's'                 %Lowes the lift
                     disp('s pressed')
                     brick.MoveMotor(FMOTOR,-15)
            
                 case 0                   %No key is being pressed.
                     disp('No Key Pressed');
                     brick.StopMotor('A')
                     brick.StopMotor('D')
                     brick.StopMotor('B')
        end
    end
end
