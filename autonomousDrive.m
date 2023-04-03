clearvars
brick = ConnectBrick("TEEM");
global key
InitKeyboard();
SPEED = -30;
LMOTOR = 'D';
RMOTOR = 'A';
FMOTOR = 'B';
colorSensePort = 1;
distSensePort = 4;
buttonSensePort = 2;

while 1                                                 %infinite loop
    pause(0.1)
    colorSense = brick.ColorCode(colorSensePort);       %sets present colour to variable "colorSense"
    %frontButton = brick.TouchPressed(3);               %sets front button to var "frontButton"
    distSense = brick.UltrasonicDist(distSensePort);    %
    buttonSense = brick.TouchPressed(buttonSensePort);
    switch colorSense
        case 1
            if distSense < 40 && buttonSense == 0                 % BELOW THRESHOLD & NO TOUCH
                 disp('Black,   dist below thres,    button not pressed');
                 brick.MoveMotor(RMOTOR,SPEED)
                 brick.MoveMotor(LMOTOR,SPEED)
            end  
            if distSense < 40 && buttonSense == 1                 % BELOW THRESHOLD & TOUCH
                 disp('Black,   dist below thres,   button pressed')
                 brick.MoveMotor(RMOTOR,-SPEED)
                 brick.MoveMotor(LMOTOR,-SPEED)
                 pause(1.2)                             %moves backward then turns left for 1.5 s
                 brick.StopAllMotors
                 brick.MoveMotor(RMOTOR,SPEED)
                 brick.MoveMotor(LMOTOR,-SPEED)
                 pause(1.2)
                 brick.StopAllMotors
                 %(LEFT)
             end 
             if distSense > 40 && buttonSense == 0                     % ABOVE THRESHOLD & NO TOUCH
                 pause(1.5);
                 brick.StopAllMotors
                 brick.MoveMotor(RMOTOR,-SPEED)
                 brick.MoveMotor(LMOTOR,SPEED)
                 pause(1.5)
                 brick.StopAllMotors
                 brick.MoveMotor(RMOTOR,SPEED)
                 brick.MoveMotor(LMOTOR,SPEED)
                 pause(3)
                 brick.StopAllMotors
                 %(RIGHT)
             end
             if distSense < 40 && buttonSense == 1                 % BELOW THRESHOLD & TOUCH
                 disp('Black,   dist below thres,    button not pressed');
                 brick.MoveMotor(RMOTOR,SPEED)
                 brick.MoveMotor(LMOTOR,SPEED)
            end  
        case 5
            disp('Stop for 4 seconds');
            brick.StopAllMotors()
            pause(4);
            brick.MoveMotor(RMOTOR,SPEED)
            brick.MoveMotor(LMOTOR,SPEED)
            pause(2)
        otherwise
            disp("other")
            brick.StopAllMotors
            switch key
                 case 'downarrow'         %For moving forward
                     disp('down Arrow Pressed!');
                     brick.MoveMotor(RMOTOR,-SPEED)
                     brick.MoveMotor(LMOTOR,-SPEED)
            
                 case 'uparrow'           %For moving backward
                     disp('up Arrow Pressed!');
                     brick.MoveMotor(RMOTOR,SPEED)
                     brick.MoveMotor(LMOTOR,SPEED)
            
                 case 'rightarrow'        %For turning left
                     disp('Right Arrow Pressed!');
                     brick.MoveMotor(RMOTOR,SPEED)
                     brick.MoveMotor(LMOTOR,-SPEED)
            
                 case 'leftarrow'         %For turning right
                     disp('left Arrow Pressed!');
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
