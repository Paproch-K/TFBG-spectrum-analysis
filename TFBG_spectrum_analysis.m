close all;

Ty = readtable('TLO1.CSV','Range','A40:A25040');
T0 = readtable('TLO1.CSV','Range','B40:B25040');


% files = dir('W0*.CSV');  
% filedata = cell(numel(files), 1);
% files = natsortfiles(files);
% for i = 1:numel(files)
%    Ti{i} = readtable(files(i).name,'Range','B35:B25035');
% end


% for j=0:numel(Tw5)-1
%     l = j+1;
%     T = Tw5{:,l};
%     C = T{:,1} ./ T0{:,1};
%     csvwrite(sprintf('Tw5V%d.csv', j),C)
% end

files2 = dir('Tw1V*.CSV'); 
files2 = natsortfiles(files2);
filedata2 = cell(numel(files2), 1);
for i = 1:numel(files2)
   Tii1{i} = readtable(files2(i).name,'Range','A1:A25001');
end


% ki = [];
% si = [];



% title('Zmiany wartości amplitudy', 'FontSize', 24);           %Zmiany współczynnika transmisji
hold on;
for z=0:numel(files2)-1
    h = z+1;
    u = Tii1{h};        %h
%     subplot(2,1,1);

%    plot(Ty{:, 1},u{:, 1});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     wartości szczytowe/minimalne modów dla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     zaokrągleń - stary kod
%     x = Ty{:, 1};
%     y = u{:, 1};
% 
%     y11 = smooth(y,10,'rloess');
%     [pks2,locs2] = findpeaks(y,'MinPeakDistance',220,'NPEAKS', 100);
%     [pks2,locs2] = findpeaks(-y,'MinPeakDistance',220,'NPEAKS', 100);
%     [pks1,locs1] = findpeaks(-y11,'MinPeakDistance',220,'NPEAKS', 100);
%      x_peaks1 = x(locs1);
%     x_peaks2 = x(locs2);
%     y12 = smooth(pks1,10,'rloess');
 %   plot(x_peaks2, u{:,locs2}, 'r*');
 %   plot(x_peaks1, -y12);

%%%%%%%%%%%%%%%%%%%%%%%%%      wartości szczytowe/minimalne modów


%     for f=1:numel(locs2)
%         KK = locs2(f,:);
%         YY = u{KK,:};
%         XX = Ty{KK,:};
%         YY1(f) = YY;
%         XX1(f) = XX;
%     end
%     plot(XX1,YY1,'r*');

% % figure(1);
% % subplot(3,1,1);
% plot(D1);
% xlabel('Numer pomiaru [-]');
% ylabel("Współczynnik transmisji [-]");
% grid on;
% axis([1 19 0.013 0.03]);
% 
% 
% % subplot(3,1,2);
% plot(D2);
% xlabel('Numer pomiaru [-]');
% ylabel("Współczynnik transmisji [-]");
% grid on;
% axis([1 25 0 0.03]);
% 
% % subplot(3,1,3);
% plot(D3);
% xlabel('Numer pomiaru [-]');
% ylabel("Współczynnik transmisji [-]");    
% grid on;
% axis([1 26 0 0.035]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      amplituda
    x = Ty{:, 1};
    y = u{:, 1};

    y11 = smooth(y,10,'rloess');
    [pks2,locs2] = findpeaks(y,'MinPeakDistance',220,'NPEAKS', 100);
    [pks1,locs1] = findpeaks(-y,'MinPeakDistance',220,'NPEAKS', 100);
    x_peaks1 = x(locs1);
    x_peaks2 = x(locs2);

    slm_lower = slmengine(x_peaks1,-pks1,'env','inf','plot','off','knots',30);
    slm_upper = slmengine(x_peaks2,pks2,'env','inf','plot','off','knots',30);
%     plot(slm_lower.x, slm_lower.y);
%     plot(slm_upper.x, slm_upper.y);

    xq = 1480:0.05:1580;
    vq1 = interp1(slm_lower.x,slm_lower.y,xq); %compute new y values
    vq2 = interp1(slm_upper.x,slm_upper.y,xq); %compute new y values
    g = vq2-vq1;
    b = smooth(g,200,'rloess');
%     subplot(2,1,2);
    plot(xq,b);
%    set(gca,'ydir','reverse')

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       kurtoza i skośność
        %axis([1480 1580 0 1]);
%     x = Ty{:, 1};
%     y = u{:, 1};
% 
%     k = kurtosis(y);
%     ki = [ki;h k];
%     s = skewness(y);
%     si = [si;h s];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     [pks,locs] = findpeaks(y11,'MinPeakDistance',220,'NPEAKS', 150);
%     x_peaks = x(locs);
%     [pks1,locs1] = findpeaks(-y11,'MinPeakDistance',220,'NPEAKS', 150);
%     x_peaks1 = x(locs1);
    
%  plot(x,y11);
%  plot(x_peaks,pks);
%  plot(x_peaks1,-pks1);


end
xlabel('Długość fali [nm]');
ylabel("Współczynnik transmisji [-]");                  %Współczynnik transmisji [-]
%ylabel("Amplituda");   
axis([1480 1580 0 1]);
zoom xon;
grid on;
set(gca,"FontSize",24);
hold off;


% subplot(2,1,1);
% plot(ki(:,1),ki(:,2),'-s');
% xlabel('Numer pomiaru [-]');
% ylabel('Kurtoza [-]');
% axis([8 37 1 10]);
% grid;
% 
% 
% subplot(2,1,2);
% plot(si(:,1),si(:,2),'-s');
% xlabel('Numer pomiaru [-]');
% ylabel('Skośność [-]');
% axis([8 37 -3 -1]);
% grid;

% figure(1);
% subplot(2,1,1);
% plot(K11);
% xlabel('Numer pomiaru [-]');
% ylabel('Kurtoza [-]');
% axis([1 50 0 0.8]);
% grid;
% 
% subplot(2,1,2);
% plot(S11);
% xlabel('Numer pomiaru [-]');
% ylabel('Skośność [-]');
% axis([1 50 0 0.25]);
% grid;

% figure, plot(ki(:,1),ki(:,2));
% axis([0 51 4 10]);
% figure, plot(si(:,1),si(:,2));


% slm_upper = slmengine(x,y,'env','sup','knots',60);
% slm_lower = slmengine(x,y,'env','inf','knots',60);
% 
%  [up,up_x,up_y] = slmengine(x,y,'env','sup','plot','off','knots',2); 
%                  slm = slmengine(x,y,'env','sup','knots',2,'reg','cross','plot','on');
%  [dw,dw_x,dw_y] = slmengine(x,y,'env','inf','plot','off','knots',50);
%  plot(x,[y;up_y;dw_y]);

%      [up,dw]=envelope(y,1800,'peak');
%      plot(x,dw);
%      plot(x,up);