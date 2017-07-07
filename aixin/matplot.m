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

fprintf('Au62:\n');
[Au62expDiff, Au62theoDiff, Au62alpha, Au62mse] = gammaDiffFun(Au62opp,Au62same,Au6201,0); %min
gammaDiffFun(Au62opp,Au62same,Au6202,0);
gammaDiffFun(Au62opp,Au62same,Au6203,0);

fprintf('Au200:\n');
[Au200expDiff, Au200theoDiff, Au200alpha,Au200mse] = gammaDiffFun(Au200opp,Au200same,Au20001,0); %min
gammaDiffFun(Au200opp,Au200same,Au20002,0);
gammaDiffFun(Au200opp,Au200same,Au20003,0);

fprintf('Pb2760:\n');
[Pb2760expDiff, Pb2760theoDiff, Pb2760alpha,Pb2760mse] = gammaDiffFun(Pb2760opp,Pb2760same,Pb276001,0); %min
gammaDiffFun(Pb2760opp,Pb2760same,Pb276002,0);
gammaDiffFun(Pb2760opp,Pb2760same,Pb276003,0);

fprintf('Cu62:\n');
[Cu62expDiff, Cu62theoDiff, Cu62alpha,Cu62mse] = gammaDiffFun(Cu62opp,Cu62same,Cu6201,0); %min
gammaDiffFun(Cu62opp,Cu62same,Cu6202,0);
gammaDiffFun(Cu62opp,Cu62same,Cu6203,0);

fprintf('Cu200:\n');
gammaDiffFun(Cu200opp,Cu200same,Cu20001,0); 
[Cu200expDiff, Cu200theoDiff, Cu200alpha,Cu200mse] = gammaDiffFun(Cu200opp,Cu200same,Cu20002,0); %min
gammaDiffFun(Cu200opp,Cu200same,Cu20003,0);

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
% Pb 2760GeV diff exp
plot(1:8,Pb2760expDiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Pb 2760GeV diff theory
plot(1:8,Pb2760alpha*Pb2760theoDiff,'-r','LineWidth',linewidth)

% Au 200GeV diff exp
plot(1:8,Au200expDiff,'bs','MarkerFaceColor','b','MarkerSize',markersize)
% Au 200GeV same theory
plot(1:8,Au200alpha*Au200theoDiff,'-b','LineWidth',linewidth)

set(gca,'linewidth',2);
legend({'Pb $2760\,\mathrm{GeV}$ Exp.','Pb $2760\,\mathrm{GeV}$ Theory',...
    'Au $200\,\mathrm{GeV}$ Exp.','Au $200\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
ax = gca;
%ax.YTick = 10.^[-6:-2];
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$a_{++}-a_{+-}$','Interpreter','latex','FontSize',fontsize)
%% plot compare Au-Au and Cu-Cu at 200GeV
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
subplot('Position',[0.10 0.53 0.88 0.43])
hold on
box on
% Cu 200GeV same exp
plot(1:7,Cu200expDiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Cu 200GeV same theory
plot(1:7,Cu200alpha*Cu200theoDiff,'-r','LineWidth',linewidth)

% Au 200GeV same exp
plot(1:8,Au200expDiff,'bs','MarkerFaceColor','b','MarkerSize',markersize)
% Au 200GeV same theory
plot(1:8,Au200alpha*Au200theoDiff,'-b','LineWidth',linewidth)

set(gca,'YMinorTick','on')
set(gca,'xticklabel',{[]})
set(gca,'linewidth',2);
hl = legend({'Cu $200\,\mathrm{GeV}$ Exp.','Cu $200\,\mathrm{GeV}$ Theory',...
    'Au $200\,\mathrm{GeV}$ Exp.','Au $200\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest');
set(hl,'FontSize',12)
%a = get(gca,'YTickLabel');
set(gca,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
%ylim([-6e-4 10e-4])
text(0.05,0.65,'(a) $200\,\mathrm{GeV}$','FontSize',fontsize-2,'Interpreter','latex','Unit','normalized')
%set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
%xlabel('Centrality','FontSize',fontsize)
ylabel('$a_{++}-a_{+-}$','Interpreter','latex','FontSize',fontsize)

% plot compare Au-Au and Cu-Cu at 62GeV
linewidth = 2;
fontsize = 18;
markersize = 10;
subplot('Position',[0.10 0.07 0.88 0.43])

hold on
box on
% Cu 62GeV same exp
plot(1:7,Cu62expDiff,'ro','MarkerFaceColor','r','MarkerSize',10)
% Cu 62GeV same theory
plot(1:7,Cu62alpha*Cu62theoDiff,'-r','LineWidth',linewidth)

% Au 62GeV same exp
plot(1:8,Au62expDiff,'bs','MarkerFaceColor','b','MarkerSize',10)
% Au 62GeV same theory
plot(1:8,Au62alpha*Au62theoDiff,'-b','LineWidth',linewidth)

set(gca,'YMinorTick','on')
set(gca,'linewidth',2);
hl = legend({'Cu $62\,\mathrm{GeV}$ Exp.','Cu $62\,\mathrm{GeV}$ Theory',...
    'Au $62\,\mathrm{GeV}$ Exp.','Au $62\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest');
set(hl,'FontSize',12)
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)

xlim([0.5 8.5])
%ylim([-6e-4 10e-4])
text(0.05,0.65,'(b) $62\,\mathrm{GeV}$','FontSize',fontsize-2,'Interpreter','latex','Unit','normalized')
ax = gca;
%ax.YTick = 10.^[-6:-2];
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$a_{++}-a_{+-}$','Interpreter','latex','FontSize',fontsize)

% compara to H