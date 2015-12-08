%this code is out of date.  Don't use this.

%for serial USB on left side of my Macbook 
s = serial('/dev/tty.usbmodem1411');

% create an array of xyz elements to store data
EncoderPositionData = zeros(10000,1);

datestr(now, 'dd-mm-yyyy HH:MM:SS FFF')