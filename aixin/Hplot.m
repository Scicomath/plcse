% H data
Au200Hsame = csvread('Au200Hsame.txt');
Au200Hopp = csvread('Au200Hopp.txt');
Pb2760Hsame = csvread('Pb2760Hsame.txt');
Pb2760Hopp = csvread('Pb2760Hopp.txt');

Au200Hdiff = Au200Hsame - Au200Hopp;
Pb2760Hdiff = Pb2760Hsame - Pb2760Hopp;

% theory data
Au20001 = csvread('result/Au200GeV0.1.txt',1,0);
Au20002 = csvread('result/Au200GeV0.2.txt',1,0);
Au20003 = csvread('result/Au200GeV0.3.txt',1,0);
Pb276001 = csvread('result/Pb2760GeV0.1.txt',1,0);
Pb276002 = csvread('result/Pb2760GeV0.2.txt',1,0);
Pb276003 = csvread('result/Pb2760GeV0.3.txt',1,0);

Au20001Diff = Au20001(2:8,1) - Au20001(2:8,2);
Au20002Diff = Au20002(2:8,1) - Au20002(2:8,2);
Au20003Diff = Au20003(2:8,1) - Au20003(2:8,2);

Pb276001Diff = Pb276001(1:8,1) - Pb276001(1:8,2);
Pb276002Diff = Pb276002(1:8,1) - Pb276002(1:8,2);
Pb276003Diff = Pb276003(1:8,1) - Pb276003(1:8,2);


%% compare to Hdiff at RHIC
Au200HAlpha = 17.3938825521; % lambda = 0.2
Pb2760HAlpha = 24.9015250292; % lambda = 0.2
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(2:8,Au200Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(2:8,Au20002Diff*Au200HAlpha,'-r','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au $200\,\mathrm{GeV}$ Exp.','Au $200\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{SS}-H_{OS}$','Interpreter','latex','FontSize',fontsize)

%% compare to Hdiff at LHC
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(1:8,Pb2760Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(1:8,Pb276002Diff*Pb2760HAlpha,'-r','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Pb $2760\,\mathrm{GeV}$ Exp.','Pb $2760\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{SS}-H_{OS}$','Interpreter','latex','FontSize',fontsize)

%% plot all
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(2:8,Au200Hdiff,'ro','MarkerFaceColor','r','MarkerSize',markersize)
plot(2:8,Au20002Diff*Au200HAlpha,'-r','LineWidth',linewidth)
plot(1:8,Pb2760Hdiff,'ro','MarkerSize',markersize)
plot(1:8,Pb276002Diff*Pb2760HAlpha,'--r','LineWidth',linewidth)
set(gca,'linewidth',2);
legend({'Au $200\,\mathrm{GeV}$ Exp.','Au $200\,\mathrm{GeV}$ Theory',...
    'Pb $2760\,\mathrm{GeV}$ Exp.','Pb $2760\,\mathrm{GeV}$ Theory'},...
    'Interpreter','latex','Location','northwest')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{SS}-H_{OS}$','Interpreter','latex','FontSize',fontsize)

% %% compare to H at RHIC
% Au200HAlpha = 57.3189071147; % lambda = 0.1
% Pb2760HAlpha = 184.449207662; % lambda = 0.1
% linewidth = 2;
% fontsize = 18;
% markersize = 10;
% figure
% hold on
% box on
% % Au 200GeV same exp H
% plot(2:8,Au200Hsame,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% % Au 200GeV opp exp H
% plot(2:8,Au200Hopp,'ro','MarkerSize',markersize)
% % Au 200GeV same theory
% plot(1:8,Au200HAlpha*Au20001(1:8,1),'-r','LineWidth',linewidth)
% % Au 200GeV opp theory
% plot(1:8,Au200HAlpha*Au20001(1:8,2),'--r','LineWidth',linewidth)
% set(gca,'linewidth',2);
% legend({'Au $200\,\mathrm{GeV}$ $a_{++}$ Exp.','Au $200\,\mathrm{GeV}$ $a_{+-}$ Exp.','Au $200\,\mathrm{GeV}$ $a_{++}$ Theory','Au $200\,\mathrm{GeV}$ $a_{+-}$ Theory'},...
%     'Interpreter','latex','Location','northwest')
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
% xlim([0.5 8.5])
% set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
% xlabel('Centrality','FontSize',fontsize)
% ylabel('$a_{++},\,a_{+-}$','Interpreter','latex','FontSize',fontsize)
% 
% %% compare to H at RHIC
% linewidth = 2;
% fontsize = 18;
% markersize = 10;
% figure
% hold on
% box on
% % Pb 2760GeV same exp H
% plot(1:8,Pb2760Hsame,'ro','MarkerFaceColor','r','MarkerSize',markersize)
% % Pb 2760GeV opp exp H
% plot(1:8,Pb2760Hopp,'ro','MarkerSize',markersize)
% % Pb 2760GeV same theory
% plot(1:8,Pb2760HAlpha*Pb276001(1:8,1),'-r','LineWidth',linewidth)
% % Pb 2760GeV opp theory
% plot(1:8,Pb2760HAlpha*Pb276001(1:8,2),'--r','LineWidth',linewidth)
% set(gca,'linewidth',2);
% legend({'Pb $2760\,\mathrm{GeV}$ $a_{++}$ Exp.','Pb $2760\,\mathrm{GeV}$ $a_{+-}$ Exp.','Pb $2760\,\mathrm{GeV}$ $a_{++}$ Theory','Pb $2760\,\mathrm{GeV}$ $a_{+-}$ Theory'},...
%     'Interpreter','latex','Location','northwest')
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
% xlim([0.5 8.5])
% set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
% xlabel('Centrality','FontSize',fontsize)
% ylabel('$a_{++},\,a_{+-}$','Interpreter','latex','FontSize',fontsize)
