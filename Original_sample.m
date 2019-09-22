clear all;
clc;
close all

% x_res = 1920; % Auflösung des SLM eingeben
% y_res = 1080;
x_res = 768; % Selbst Size des Aufloesung eingeben
y_res = 768;

[X,Y] = meshgrid(1:1:x_res, 1:1:y_res);
[X2,Y2] = meshgrid(-x_res/2:1:x_res/2-1, -y_res/2:1:y_res/2-1);

% Spot 1:
shift_x1 = 0; % Auslenkung in x-Richtung, max. Sichtbereich auf CMOS: x = 
shift_y1 = 0; % Auslenkung in y-Richtung, max. Sichtbereich auf CMOS: y = 
shift_z1 = -0.0001; % Verschiebung in z-Richtung (Positiv: verkürzter Fokus, Negativ: verlängerter Fokus); Achtung: Änderung sehr groß!

phi1 = mod(1/100 * (2*pi*shift_x1*X + 2*pi*shift_y1*Y)+shift_z1*(X2.^2+Y2.^2),2*pi); %mod(a,m),m??a????

% Spot 2:
shift_x2 = 0;
shift_y2 = 0;
shift_z2 = 0;

phi2 = mod(1/100 * (2*pi*shift_x2*X + 2*pi*shift_y2*Y)+shift_z2*(X2.^2+Y2.^2),2*pi);

% Für den erhalt der 0ten-Ordung: Spot mit x/y/z=0 (ergibt bei der Superposition +1)

%Random Image:option
phi_random = rand([1080 768]);
maxv=max(max(phi_random));
minv=min(min(phi_random));
max_soll=2*pi; %Nach SLM Gamma Curve: max 166
min_soll=0;
As=((phi_random-minv)/(maxv-minv)*(max_soll-min_soll))+min_soll;
As = As.';

% Superposition der einzelnen Spots:
A = exp(1i.*phi1);
B = exp(1i.*phi2);
C = exp(1i.*As);    %random noise
superpos = A+B;%+C/1000;
% superpos = exp(1i.*phi1) + exp(1i*phi2);% + exp(1i.*As); 
% Ermittlung der Phase:
phi_sp = angle(superpos); % phi_superposition

%Graustufenbild
maxv=max(max(phi_sp));
minv=min(min(phi_sp));
max_soll=255; %Nach SLM Gamma Curve
min_soll=0;
Q = phi_sp-minv;
W = maxv-minv;
E = max_soll-min_soll;
phi_sp_gv=uint8(((Q)/(W)*(E))+min_soll); %grey value

% Phasenfunktion anzeigen auf dem SLM (2. Bildschirm):
figure(6)
% set(gcf,'outerposition', [1913         113        1936     1118]); % Verschiebung auf den Bildschirm des SLM
% set(gca,'Position', [0 0 1 1]);
set(gca,'Visible', 'Off');
set(gcf,'menubar','none');
imshow(phi_sp_gv);
imwrite(phi_sp_gv,'Ring_0.jpg');    %Speichen das Bild fuer weitere Anwendung
