%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generierung von mehreren Spots nach der Linsen und Prismen Methode
% Erzeugung mehrerer Fallen mit dreidimensionaler Anordnung m鰃lich
% Algorithmus implementiert nach Liesener 2000
% September 2015, Jannis K鰄ler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
close all

% x_res = 1920; % Aufl?ung des SLM eingeben
% y_res = 1080;
x_res = 500; % Aufl?ung des SLM eingeben
y_res = 500;
[X,Y] = meshgrid(1:1:x_res, 1:1:y_res);
[X2,Y2] = meshgrid(-x_res/2:1:x_res/2-1, -y_res/2:1:y_res/2-1);

% Spot 1:
shift_x1 = 0; % Auslenkung in x-Richtung, max. Sichtbereich auf CMOS: x = 
shift_y1 = 0; % Auslenkung in y-Richtung, max. Sichtbereich auf CMOS: y = 
shift_z1 = 0.0001; % Verschiebung in z-Richtung (Positiv: verk?zter Fokus, Negativ: verl?gerter Fokus); Achtung: ?derung sehr gro?!

phi1 = mod(1/100 * (2*pi*shift_x1*X + 2*pi*shift_y1*Y)+shift_z1*(X2.^2+Y2.^2),2*pi);

% Spot 2:
shift_x2 = 0;
shift_y2 = 0;
shift_z2 = 0;

phi2 = mod(1/100 * (2*pi*shift_x2*X + 2*pi*shift_y2*Y)+shift_z2*(X2.^2+Y2.^2),2*pi);

% F? den erhalt der 0ten-Ordung: Spot mit x/y/z=0 (ergibt bei der Superposition +1)

%Random Image:
phi_random = rand([1080 1920]);
maxv=max(max(phi_random));
minv=min(min(phi_random));
max_soll=2*pi; %Nach SLM Gamma Curve: max 166
min_soll=0;
As=((phi_random-minv)/(maxv-minv)*(max_soll-min_soll))+min_soll;

% Superposition der einzelnen Spots:
superpos = exp(1i.*phi1) + exp(1i*phi2);% + exp(1i.*As); 
% Ermittlung der Phase:
phi_sp = angle(superpos); % phi_superposition

%Graustufenbild
maxv=max(max(phi_sp));
minv=min(min(phi_sp));
max_soll=255; %Nach SLM Gamma Curve
min_soll=0;
phi_sp_gv=uint8(((phi_sp-minv)/(maxv-minv)*(max_soll-min_soll))+min_soll); %grey value

% Phasenfunktion anzeigen auf dem SLM (2. Bildschirm):
figure()
% set(gcf,'outerposition', [1913         113        1936     1118]); % Verschiebung auf den Bildschirm des SLM
% set(gca,'Position', [0 0 1 1]);
set(gca,'Visible', 'Off');
set(gcf,'menubar','none');
imshow(phi_sp_gv);
imwrite(phi_sp_gv,'ring.jpg');
