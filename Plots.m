%% Import data for plot

clear all
ramp1 = importdata("ramp1.mat");
ramp2 = importdata("ramp2.mat");
ramp3 = importdata("ramp3.mat");
scalini = importdata("scalini.mat");
senil = importdata("seni_largeamplitude_nooffset.mat");
senin = importdata("seni_nooffset.mat");
senio = importdata("seni_offset2.mat");
seni1 = importdata("sine1.mat");
seni2 = importdata("sine2.mat");
seni3 = importdata("sine3.mat");
seni4 = importdata("sine4.mat");
seni5 = importdata("sine5.mat");
seni6 = importdata("sine6.mat");
square = importdata("square.mat");

alltogheter = {ramp1; ramp2; ramp3; scalini; senil; senin; senio; seni1; seni2; seni3; seni4; seni5; seni6; square};
%% Plots
l = size(alltogheter);
for i = 1:1:l(1)
    figure
    subplot(3,1,1)
    plot(alltogheter{i}(1,:), alltogheter{i}(2, : ))
    title("Input Voltage [V]")
    subplot(3,1,2)
    plot(alltogheter{i}(1,:), alltogheter{i}(3, : ))
    title("Output position [rad]")
    subplot(3,1,3)
    plot(alltogheter{i}(1,:), alltogheter{i}(4, : ))
    title("Output velocità [rad/s]")
end