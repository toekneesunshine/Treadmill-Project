function Arrayoutput = read_encoder()
% Function to read Arduino serial encoder inputs
% Stores inputs locally in array of name

%% Basic setup
%for serial USB on left side of my Macbook 
serial1 = serial('/dev/tty.usbmodem1411');
serial1.BaudRate=115200;       %defines serial Baudrate
set(serial1, 'Timeout', 0.1);  %defines Timeout parameter

%define terminator key (searches for X)
%set(serial1, 'Terminator', 'X');

%% 
%show serial1 info
%get(serial1);

%set Input Buffer Size
serial1.InputBufferSize = 5120000;

%%
%open serial port, continuous reading
fopen(serial1);

%serial1.ReadAsyncMode = 'continuous';  %true by default

% First line of fscanf input is always empty (unknown reason)
A=fscanf(serial1);
A=' ';
rawdata='';
while ~isempty(A)
    %define A as output
    A=fscanf(serial1);
    rawdata=[rawdata A];
    
    %A = fscanf(serial1, '%i', serial1.ValuesReceived)
end

Arrayoutput = strread(rawdata); %if rawdata is the output of read_encoder
%parse read_encoder and store as usable nx2 array
%column 1 is millisec elapsed, column 2 is pulse position

fclose(serial1);


end