% H data
Au200Hsame = csvread('Au200Hsame.txt');
Au200Hopp = csvread('Au200Hopp.txt');
Pb2760Hsame = csvread('Pb2760Hsame.txt');
Pb2760Hopp = csvread('Pb2760Hopp.txt');

Au200Hdiff = Au200Hsame - Au200Hopp;
Pb2760Hdiff = Pb2760Hsame - Pb2760Hopp;

% theory data
Au20001 = csvread('result/disklike/Au200GeV0.1.txt',1,0);
Au20002 = csvread('result/disklike/Au200GeV0.2.txt',1,0);
Au20003 = csvread('result/disklike/Au200GeV0.3.txt',1,0);
Cu20001 = csvread('result/disklike/Cu200GeV0.1.txt',1,0);
Cu20002 = csvread('result/disklike/Cu200GeV0.2.txt',1,0);
Cu20003 = csvread('result/disklike/Cu200GeV0.3.txt',1,0);

Pb276001 = csvread('result/disklike/Pb2760GeV0.1.txt',1,0);
Pb276002 = csvread('result/disklike/Pb2760GeV0.2.txt',1,0);
Pb276003 = csvread('result/disklike/Pb2760GeV0.3.txt',1,0);

Au20001Diff = Au20001(2:8,1) - Au20001(2:8,2);
Au20002Diff = Au20002(2:8,1) - Au20002(2:8,2);
Au20003Diff = Au20003(2:8,1) - Au20003(2:8,2);

Cu20001Diff = Cu20001(2:8,1) - Cu20001(2:8,2);
Cu20002Diff = Cu20002(2:8,1) - Cu20002(2:8,2);
Cu20003Diff = Cu20003(2:8,1) - Cu20003(2:8,2);

Pb276001Diff = Pb276001(1:8,1) - Pb276001(1:8,2);
Pb276002Diff = Pb276002(1:8,1) - Pb276002(1:8,2);
Pb276003Diff = Pb276003(1:8,1) - Pb276003(1:8,2);

linewidth = 2;
fontsize = 18;
markersize = 10;
%% plot exp H

figure
hold on
box on
markdersize = 9;
plot(2:8,Au200Hsame,'bo','MarkerFaceColor','b','MarkerSize',markdersize)
plot(2:8,Au200Hopp,'bo','MarkerSize',markdersize)
plot(1:8,Pb2760Hsame,'rs','MarkerFaceColor','r','MarkerSize',markdersize)
plot(1:8,Pb2760Hopp,'rs','MarkerSize',markdersize)
set(gca,'linewidth',2);
legend({'Au $200\,\mathrm{GeV}\,H_{\mathrm{SS}}$','Au $200\,\mathrm{GeV}\,H_{\mathrm{OS}}$',...
    'Pb $2760\,\mathrm{GeV}\,H_{\mathrm{SS}}$','Pb $2760\,\mathrm{GeV}\,H_{\mathrm{OS}}$'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}$ or $H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)

%% compare to Hdiff at RHIC
Au200HAlpha = 38.3196887169; % lambda = 0.2
Pb2760HAlpha = 48.5725746195; % lambda = 0.2
% linewidth = 2;
% fontsize = 18;
% markersize = 10;
figure
hold on
box on
plot(2:8,Au200Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(1:8,(Au20002(1:8,1) - Au20002(1:8,2))*Au200HAlpha,'-k','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au $200\,\mathrm{GeV}$ Exp.','Au $200\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}-H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)

%% compare Au Cu Hdiff at RHIC
Au200HAlpha = 38.3196887169; % lambda = 0.2
figure
hold on
box on
plot(1:7,(Au20002(1:7,1) - Au20002(1:7,2))*Au200HAlpha,'-or','LineWidth',linewidth)
plot(1:7,(Cu20002(1:7,1) - Cu20002(1:7,2))*Au200HAlpha,'-ob','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au-Au $200\,\mathrm{GeV}$ Theory','Cu-Cu $200\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 7.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}-H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)



%% compare to Hdiff at LHC
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(1:8,Pb2760Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(1:8,Pb276002Diff*Pb2760HAlpha,'-k','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Pb $2760\,\mathrm{GeV}$ Exp.','Pb $2760\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}-H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)

%% plot all
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(2:8,Au200Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(2:8,Au20002Diff*Au200HAlpha,'-r','LineWidth',linewidth)
plot(1:8,Pb2760Hdiff,'bo','MarkerSize',markersize)
plot(1:8,Pb276002Diff*Pb2760HAlpha,'--b','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au-Au $200\,\mathrm{GeV}$ Exp.','Au-Au $200\,\mathrm{GeV}$ Theory',...
    'Pb-Pb $2760\,\mathrm{GeV}$ Exp.','Pb-Pb $2760\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}-H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)

%% compare to Hss and Hos at RHIC
Au200HAlpha = 98.7731566758; % lambda = 0.1
Pb2760HAlpha = 395.05382961; % lambda = 0.1
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
subplot(2,1,1)
hold on
box on
% Au 200GeV same exp H
plot(2:8,Au200Hsame,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Au 200GeV opp exp H
plot(2:8,Au200Hopp,'ro','MarkerSize',markersize)
% Au 200GeV same theory
plot(1:8,Au200HAlpha*Au20001(1:8,1),'-r','LineWidth',linewidth)
% Au 200GeV opp theory
plot(1:8,Au200HAlpha*Au20001(1:8,2),'--r','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au-Au $200\,\mathrm{GeV}$ $H_{\mathrm{SS}}$ Exp.','Au-Au $200\,\mathrm{GeV}$ $H_{\mathrm{OS}}$ Exp.','Au-Au $200\,\mathrm{GeV}$ $H_{\mathrm{SS}}$ Theory','Au-Au $200\,\mathrm{GeV}$ $H_{\mathrm{OS}}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}$ or $H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)

% compare to H at LHC
linewidth = 2;
fontsize = 18;
markersize = 10;
%figure
subplot(2,1,2)
hold on
box on
% Pb 2760GeV same exp H
plot(1:8,Pb2760Hsame,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% Pb 2760GeV opp exp H
plot(1:8,Pb2760Hopp,'ro','MarkerSize',markersize)
% Pb 2760GeV same theory
plot(1:8,Pb2760HAlpha*Pb276001(1:8,1),'-r','LineWidth',linewidth)
% Pb 2760GeV opp theory
plot(1:8,Pb2760HAlpha*Pb276001(1:8,2),'--r','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Pb-Pb $2760\,\mathrm{GeV}$ $H_{\mathrm{SS}}$ Exp.','Pb-Pb $2760\,\mathrm{GeV}$ $H_{\mathrm{OS}}$ Exp.','Pb-Pb $2760\,\mathrm{GeV}$ $H_{\mathrm{SS}}$ Theory','Pb-Pb $2760\,\mathrm{GeV}$ $H_{\mathrm{OS}}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{\mathrm{SS}}$ or $H_{\mathrm{OS}}$','Interpreter','latex','FontSize',fontsize)
