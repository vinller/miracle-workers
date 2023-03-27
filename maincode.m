while 1
  brick.MoveMotor('A', 60); %Moves the motors
  brick.MoveMotor('B', 60);

  brick.SetColorMode(1, 2);		%Color sensor activates
  color = brick.ColorCode(1);		%color will gather the color
  touch = brick.TouchPressed(2); %touch sensor 1 or 0
  distance = brick.UltrasonicDist(3); %ultrasonic

  if color == 5	%if color is Red
	  disp('red');
		brick.StopMotor('A');
		brick.StopMotor('B');
		pause(3);
		brick.MoveMotor('A', 60);
		brick.MoveMotor('B', 60);
		pause(0.5);
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
					brick.MoveMotor('D', 1);
				case 's'    % Press s to delift.
					disp('Lift Delifting');
					brick.MoveMotor('D', -1);
				case 'a'    % Press a to stop the lift.
					disp('Stop the lift');
					brick.StopMotor('D');
		
				case 't' 	% Terminating the whole process.
					brick.StopAllMotors;
					break;

      end	%ends switch key
    end	%ends while loop
    CloseKeyboard();
  end	%ends color sensor

  if distance > 50
    **turn right**
    pause(1);
    brick.StopAllMotors;
    brick.MoveMotor('A', 
    
  end

  if touch == 1
	  pause(1);
	  disp('touched wall');
	  brick.StopAllMotors;
	  **get distance w/ ultrasonic sensor**
	  brick.MoveMotor('A', -5);
    brick.MoveMotor('B', -5);
	  brick.StopAllMotors;
  end







end %ends the entire program
