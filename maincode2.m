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
buttonPort = 2;

while 1 %infinite loop
    colorSense = brick.ColorCode(colorSensePort); %turn on color sensor
    distSense = brick.UltrasonicDist(distSensePort); %turn on ultrasonic sensor
    buttonSense = brick.TouchPressed(buttonSensePort); %turn on touch sensor