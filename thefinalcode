clearvars   %clear the variables so an overload error does not occur
brick = ConnectBrick("gripy");
global key
%%InitKeyboard();
SPEED = -30; %all variables described
SPEED2 = -32;   %this speed has to be a little larger to account for the lesser motor
LMOTOR = 'A';
RMOTOR = 'B';
DMOTOR = 'D';
colorSensePort= 4;  %more variables created for the sensors
distSensePort = 3;
touchSensePort = 2;
turningRadius = 340;

while 1 %entire loop
    colorSense = brick.ColorCode(colorSensePort); %turn on color sensor
    distSense = brick.UltrasonicDist(distSensePort); %turn on ultrasonic sensor
    touchSense = brick.TouchPressed(touchSensePort); %turn on touch sensor
    switch colorSense
        case 1
            disp('black');
            if (distSense < 40 && touchSense == 0)  %wall on left, nothing in front 
                brick.MoveMotor(LMOTOR, SPEED2);
                brick.MoveMotor(RMOTOR, SPEED);
                %pause(2.0);
            elseif (distSense < 40 && touchSense == 1)  %wall on left, obstacle ahead, turn right
                brick.MoveMotor(RMOTOR,-SPEED);
                brick.MoveMotor(LMOTOR,-SPEED2);
                pause(1.5);
                brick.StopAllMotors;
                brick.MoveMotorAngleRel(LMOTOR, SPEED, turningRadius+10, 'Coast');   %turn right
                brick.WaitForMotor(LMOTOR);
                brick.MoveMotor(RMOTOR, SPEED);
                brick.MoveMotor(LMOTOR, SPEED2);
                pause(4.5)  %moves forward into new position, hopefully stops vehicle from going back the way it came
                brick.StopAllMotors;
            elseif (distSense > 40 && touchSense == 0)  %no wall on left, no obstacle ahead
                brick.StopAllMotors;
                brick.ResetMotorAngle(LMOTOR);
                brick.ResetMotorAngle(RMOTOR);
                brick.MoveMotorAngleRel(RMOTOR, SPEED, turningRadius+22, 'Coast');    %turn left
                brick.WaitForMotor(RMOTOR);
                brick.MoveMotor(RMOTOR, SPEED);
                brick.MoveMotor(LMOTOR, SPEED2);
                pause(4.5);
                brick.StopAllMotors;
             end   
        
        case 5
            disp('Red. Stop for 3 seconds');
            brick.StopAllMotors();
            pause(3.0);
            brick.MoveMotor(LMOTOR, SPEED2);
            brick.MoveMotor(RMOTOR, SPEED);
        otherwise   %when color sensor senses blue, yellow, or green
            disp('manual mode');
            brick.StopAllMotors();
            InitKeyboard();
            while 1 %loop for the manual code
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
                     brick.MoveMotor(DMOTOR,5);
            
                 case 's'                 %Lowes the lift
                     disp('s pressed');
                     brick.MoveMotor(DMOTOR,-5);
            
                 case 0                   %No key is being pressed.
                     disp('No Key Pressed');
                     brick.StopMotor('A');
                     brick.StopMotor('D');
                     brick.StopMotor('B');
                 case 't'   %used to break out of the manual code loop
                     break

            end
            end
            CloseKeyboard();
    end
end
