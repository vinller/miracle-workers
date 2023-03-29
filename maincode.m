while 1
  brick.MoveMotor('A', 20); %Moves the motors
  brick.MoveMotor('B', 20);

  brick.SetColorMode(4, 2); %color sensor activates
  color = brick.ColorCode(4);		%color will gather the color
  touch = brick.TouchPressed(2); %touch sensor 1 or 0
  distance = brick.UltrasonicDist(3); %ultrasonic

  if color == 5	%if color is Red
	  disp('red');
		brick.StopMotor('A');
		brick.StopMotor('B');
		pause(3);
		brick.MoveMotor('A', 20);
		brick.MoveMotor('B', 20);
		pause(0.5);
		color = 0;
  elseif color == 2 || color == 3 || color == 4 %switches to manual code when BGY
	  disp('blue/green/yellow');
    	  global key
    	  InitKeyboard();
    	  while 1
			pause(0.1);
			switch key
				case 'uparrow'
					disp('Up Arrow Pressed!');
          				brick.MoveMotor('A', 60);
          				brick.MoveMotor('B', 60);
        
				case 'downarrow'
					disp('Down Arrow Pressed!');
          				brick.MoveMotor('A', -60);
          				brick.MoveMotor('B', -60);
				case 'leftarrow'
					disp('Left Arrow Pressed!');
          				brick.MoveMotor('A',-60); 
          				brick.MoveMotor('B',60);
				case 'rightarrow'
					disp('Right Arrow Pressed!');
          				brick.MoveMotor('B',-60);   
          				brick.MoveMotor('A', 60);
		
				case 0		% No key is being pressed.
					disp('No Key Pressed!');
          				brick.StopAllMotors;
				case 'w'    % Press w to lift.
					disp('Lift Commencing');
					brick.MoveMotor('D', -1);
				case 's'    % Press s to delift.
					disp('Lift Delifting');
					brick.MoveMotor('D', 1);
				case 'a'    % Press a to stop the lift.
					disp('Stop the lift');
					brick.StopMotor('D');
		
				case 't' 	% Terminating the whole process.
					brick.StopAllMotors;
					break;

      			end	%ends switch key
    	  end	%ends while loop
    	  CloseKeyboard();
    	  color = 0;
  
  else
  	brick.MoveMotor('A', 20);
  	brick.MoveMotor('B', 20);
	if distance > 10 %follow the right wall
  		brick.StopAllMotors; %stop
  		%brick.MoveMotor('B', -20) %turn right
		brick.MoveMotorAngleRel('B', -20, 90, 'Break');
		%pause(2.5);
  		brick.StopAllMotors; %stop
  		brick.MoveMotor('A', 20); %keep moving forward
		brick.MoveMotor('B', 20);
  	end

  	if touch
  		brick.StopAllMotors; %stop
  		brick.MoveMotor('A', -2) %back up from wall
		brick.MoveMotor('B', -2)
		%pause(2.5);
		brick.StopAllMotors;
  		distance = brick.UltrasonicDist(3); %get distance from right wall
  		if distance < 10
			%brick.MoveMotor('A', -20); %turn left
			brick.MoveMotorAngleRel('A', -20, 90, 'Break');
			pause(2.5);
		end
	
  	end
  end

end %ends the entire program
