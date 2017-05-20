% exp data
Au62opp = csvread('exp data/Au62GeVopp.csv');
Au62same = csvread('exp data/Au62GeVsame.csv');
Au200opp = csvread('exp data/STARopp.csv');
Au200same = csvread('exp data/STARsame.csv');
Pb2760opp = csvread('exp data/ALICEopp.csv');
Pb2760same = csvread('exp data/ALICEsame.csv');
Cu62opp = csvread('exp data/Cu62GeVopp.csv');
Cu62same = csvread('exp data/Cu62GeVsame.csv');
Cu200opp = csvread('exp data/Cu200GeVopp.csv');
Cu200same = csvread('exp data/Cu200GeVsame.csv');
% theory data
Au6201 = csvread('result/Au62GeV0.1.txt',1,0);
Au6202 = csvread('result/Au62GeV0.2.txt',1,0);
Au6203 = csvread('result/Au62GeV0.3.txt',1,0);
Au20001 = csvread('result/Au200GeV0.1.txt',1,0);
Au20002 = csvread('result/Au200GeV0.2.txt',1,0);
Au20003 = csvread('result/Au200GeV0.3.txt',1,0);
Pb276001 = csvread('result/Pb2760GeV0.1.txt',1,0);
Pb276002 = csvread('result/Pb2760GeV0.2.txt',1,0);
Pb276003 = csvread('result/Pb2760GeV0.3.txt',1,0);
Cu6201 = csvread('result/Cu62GeV0.1.txt',1,0);
Cu6202 = csvread('result/Cu62GeV0.2.txt',1,0);
Cu6203 = csvread('result/Cu62GeV0.3.txt',1,0);
Cu20001 = csvread('result/Cu200GeV0.1.txt',1,0);
Cu20002 = csvread('result/Cu200GeV0.2.txt',1,0);
Cu20003 = csvread('result/Cu200GeV0.3.txt',1,0);

Au62Alpha = -60.3980575503; % lambda = 0.2
Au200Alpha = -87.8939571063; % lambda = 0.2
Pb2760Alpha = -162.363172344; % lambda = 0.2
Cu200Alpha = -124.376317721; % lambda = 0.3
Cu62Alpha = -111.913014855; % lambda = 0.3
%% plot compare 200GeV and 2760GeV
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
% Pb 2760GeV same exp
plot(1:8,Pb2760same(:,2),'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Pb 2760GeV opp exp
plot(1:8,Pb2760opp(:,2),'ro','MarkerSize',markersize)
% Pb 2760GeV same theory
plot(1:8,Pb2760Alpha*Pb276002(1:8,1),'-r','LineWidth',linewidth)
% Pb 2760GeV opp theory
plot(1:8,Pb2760Alpha*Pb276002(1:8,2),'--r','LineWidth',linewidth)

% Au 200GeV same exp
plot(1:8,Au200same(:,2),'bs','MarkerFaceColor','b','MarkerSize',markersize)
% Au 200GeV opp exp
plot(1:8,Au200opp(:,2),'bs','MarkerSize',markersize)
% Au 200GeV same theory
plot(1:8,Au200Alpha*Au20002(1:8,1),'-b','LineWidth',linewidth)
% Au 200GeV opp theory
plot(1:8,Au200Alpha*Au20002(1:8,2),'--b','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Pb $2760\,\mathrm{GeV}$ same Exp.','Pb $2760\,\mathrm{GeV}$ opp Exp.','Pb $2760\,\mathrm{GeV}$ same Theory','Pb $2760\,\mathrm{GeV}$ opp Theory',...
    'Au $200\,\mathrm{GeV}$ same Exp.','Au $200\,\mathrm{GeV}$ opp Exp.','Au $200\,\mathrm{GeV}$ same Theory','Au $200\,\mathrm{GeV}$ opp Theory'},...
    'Interpreter','latex','Location','southwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
ax = gca;
%ax.YTick = 10.^[-6:-2];
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$\cos(\varphi_\alpha + \varphi_\beta - 2 \Psi_{RP})$','Interpreter','latex','FontSize',fontsize)
%% plot compare Au-Au and Cu-Cu at 200GeV
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
subplot('Position',[0.10 0.53 0.88 0.43])
hold on
box on
% Cu 200GeV same exp
plot(1:7,Cu200same(:,2),'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Cu 200GeV opp exp
plot(1:7,Cu200opp(:,2),'ro','MarkerSize',markersize)
% Cu 200GeV same theory
plot(1:7,Cu200Alpha*Cu20003(1:7,1),'-r','LineWidth',linewidth)
% Cu 200GeV opp theory
plot(1:7,Cu200Alpha*Cu20003(1:7,2),'--r','LineWidth',linewidth)

% Au 200GeV same exp
plot(1:8,Au200same(:,2),'bs','MarkerFaceColor','b','MarkerSize',markersize)
% Au 200GeV opp exp
plot(1:8,Au200opp(:,2),'bs','MarkerSize',markersize)
% Au 200GeV same theory
plot(1:8,Au200Alpha*Au20002(1:8,1),'-b','LineWidth',linewidth)
% Au 200GeV opp theory
plot(1:8,Au200Alpha*Au20002(1:8,2),'--b','LineWidth',linewidth)
set(gca,'YMinorTick','on')
set(gca,'xticklabel',{[]}) 
set(gca,'linewidth',2);
hl = legend({'Cu $200\,\mathrm{GeV}$ same Exp.','Cu $200\,\mathrm{GeV}$ opp Exp.','Cu $200\,\mathrm{GeV}$ same Theory','Cu $200\,\mathrm{GeV}$ opp Theory',...
    'Au $200\,\mathrm{GeV}$ same Exp.','Au $200\,\mathrm{GeV}$ opp Exp.','Au $200\,\mathrm{GeV}$ same Theory','Au $200\,\mathrm{GeV}$ opp Theory'},...
    'Interpreter','latex','Location','southwest');
set(hl,'FontSize',12)
%a = get(gca,'YTickLabel');
set(gca,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
ylim([-10e-4 6e-4])
text(0.05,0.88,'(a) $200\,\mathrm{GeV}$','FontSize',fontsize-2,'Interpreter','latex','Unit','normalized')
%set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
%xlabel('Centrality','FontSize',fontsize)
ylabel('$\cos(\varphi_\alpha + \varphi_\beta - 2 \Psi_{RP})$','Interpreter','latex','FontSize',fontsize)

% plot compare Au-Au and Cu-Cu at 62GeV
linewidth = 2;
fontsize = 18;
markersize = 10;
subplot('Position',[0.10 0.07 0.88 0.43])

hold on
box on
% Cu 62GeV same exp
plot(1:7,Cu62same(:,2),'ro','MarkerFaceColor','r','MarkerSize',10)
% Cu 62GeV opp exp
plot(1:7,Cu62opp(:,2),'ro','MarkerSize',10)
% Cu 62GeV same theory
plot(1:7,Cu62Alpha*Cu6203(1:7,1),'-r','LineWidth',linewidth)
% Cu 62GeV opp theory
plot(1:7,Cu62Alpha*Cu6203(1:7,2),'--r','LineWidth',linewidth)

% Au 62GeV same exp
plot(1:8,Au62same(:,2),'bs','MarkerFaceColor','b','MarkerSize',10)
% Au 62GeV opp exp
plot(1:8,Au62opp(:,2),'bs','MarkerSize',10)
% Au 62GeV same theory
plot(1:8,Au62Alpha*Au6202(1:8,1),'-b','LineWidth',linewidth)
% Au 62GeV opp theory
plot(1:8,Au62Alpha*Au6202(1:8,2),'--b','LineWidth',linewidth)
set(gca,'YMinorTick','on')
set(gca,'linewidth',2);
hl = legend({'Cu $62\,\mathrm{GeV}$ same Exp.','Cu $62\,\mathrm{GeV}$ opp Exp.','Cu $62\,\mathrm{GeV}$ same Theory','Cu $62\,\mathrm{GeV}$ opp Theory',...
    'Au $62\,\mathrm{GeV}$ same Exp.','Au $62\,\mathrm{GeV}$ opp Exp.','Au $62\,\mathrm{GeV}$ same Theory','Au $62\,\mathrm{GeV}$ opp Theory'},...
    'Interpreter','latex','Location','southwest');
set(hl,'FontSize',12)
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)

xlim([0.5 8.5])
ylim([-15e-4 6e-4])
text(0.05,0.88,'(b) $62\,\mathrm{GeV}$','FontSize',fontsize-2,'Interpreter','latex','Unit','normalized')
ax = gca;
%ax.YTick = 10.^[-6:-2];
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$\cos(\varphi_\alpha + \varphi_\beta - 2 \Psi_{RP})$','Interpreter','latex','FontSize',fontsize)