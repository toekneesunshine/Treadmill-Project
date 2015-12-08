function results = calcvelocity(encoderdata)
%FUNCTION:
%calculates instantaneous velocity at any given time

%% 
%setup

%zeros(rev_position) %position in revolutions, CW is positive
%zeros(rad_position) %position in radians, CW is positive
%zeros(time) %milliseconds
%% 

%calculate instantaneous velocity (rpm and rad/s)
%128 pulses = 1 rev
rev_position = encoderdata(:,1)/128;
rad_position = encoderdata(:,1)/128*2*pi;
time = encoderdata(:, 2);

%%
%to do so, calculate difference between each position
%note that Matlab starts at index 1, so we want something that's
%like [pos(i+1) - pos(i)]/[time(i+1) - time(i)] 
rev_pos_ind2 = rev_position;
rev_pos_ind2(1) = []; %delete first entry

rev_pos_ind1 = rev_position;
rev_pos_ind1(end) = []; %delete last entry

%difference is ind2 - ind1
diff_rev_position = rev_pos_ind2 - rev_pos_ind1;

%being an idiot, I just noticed that the diff. is always some factor of 0.0078
%this is because the encoder position was a constant difference
%since the encoder was moving 1 pulse at a time
%thus any position n+1 - any position n gives the same result
rad_pos_ind2 = rad_position;
rad_pos_ind2(1) = []; %delete first entry

rad_pos_ind1 = rad_position;
rad_pos_ind1(end) = []; %delete last entry

diff_rad_position = rad_pos_ind2 - rad_pos_ind1;

%brilliant, Holmes.  Now apply the same logic to time
%%

%now calculate the difference for time
%apply same logic as above
time_ind2 = time;
time_ind2(1) = [];

time_ind1 = time;
time_ind1(end) = [];

diff_time = time_ind2 - time_ind1;

%%

%now calculate revolutions per millisec and radians per millisec
%rev. per millisec is ∆rev/∆millisec
%rad. per millisec is ∆rad/∆millisec
rev_per_millisec = rdivide(diff_rev_position, diff_time);
rad_per_millisec = rdivide(diff_rad_position, diff_time);

%convert to rev. per minute (RPM) and rad. per second
RPM = rev_per_millisec * 1000/60
rad_per_sec = rad_per_millisec * 1000

seconds = time*0.001;
seconds(1) = [];

%plot graph of RPM as a function of seconds, rad/sec as a function of
%seconds
figure
plot (seconds, RPM)
title('Graph of RPM as a function of seconds')
xlabel('time in seconds')
ylabel('Revolutions per minute')

figure
plot (seconds, rad_per_sec)
title('Graph of radians per second as a function of seconds')
xlabel('time in seconds')
ylabel('radians per second')


end


