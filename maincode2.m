clearvars
brick = ConnectBrick("gripy");
global key
InitKeyboard();
SPEED = -40;
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
                
