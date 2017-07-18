%% read data
Au6201 = csvread('result/ratio/ratioAu62GeV0.1.txt',1,0);
Au6202 = csvread('result/ratio/ratioAu62GeV0.2.txt',1,0);
Au6203 = csvread('result/ratio/ratioAu62GeV0.3.txt',1,0);

Au13001 = csvread('result/ratio/ratioAu130GeV0.1.txt',1,0);
Au13002 = csvread('result/ratio/ratioAu130GeV0.2.txt',1,0);
Au13003 = csvread('result/ratio/ratioAu130GeV0.3.txt',1,0);

Au20001 = csvread('result/ratio/ratioAu200GeV0.1.txt',1,0);
Au20002 = csvread('result/ratio/ratioAu200GeV0.2.txt',1,0);
Au20003 = csvread('result/ratio/ratioAu200GeV0.3.txt',1,0);

Pb276001 = csvread('result/ratio/ratioPb2760GeV0.1.txt',1,0);
Pb276002 = csvread('result/ratio/ratioPb2760GeV0.2.txt',1,0);
Pb276003 = csvread('result/ratio/ratioPb2760GeV0.3.txt',1,0);

Cu20001 = csvread('result/ratio/ratioCu200GeV0.1.txt',1,0);
Cu20002 = csvread('result/ratio/ratioCu200GeV0.2.txt',1,0);
Cu20003 = csvread('result/ratio/ratioCu200GeV0.3.txt',1,0);


%% plot
linewidth = 2;
fontsize = 18;
markersize = 10;

figure
subplot('Position',[0.15 0.58 0.75 0.38])
box on
plot(Au20001(:,1),Au20001(:,2),'-.',...
     Au20002(:,1),Au20002(:,2),'--',...
     Au20003(:,1),Au20003(:,2),'-','LineWidth',linewidth);
set(gca,'linewidth',2,'FontName','Times','FontSize',fontsize-2);
legend({'Au $200\,\mathrm{GeV}\,\lambda = 0.1 R$','Au $200\,\mathrm{GeV}\,\lambda = 0.2 R$', 'Au $200\,\mathrm{GeV}\,\lambda = 0.3 R$'},...
     'Interpreter','latex','Location','northwest');
xlabel('$b/R$','Interpreter','latex')
ylabel('$|a_{+-}|/a_{++}$','Interpreter','latex')
text(1,0.9,'(a)','FontSize',fontsize-2)
set(gca,'FontName','Times','FontSize',fontsize-2)

subplot('Position',[0.15 0.1 0.75 0.40])
box on
plot(Pb276001(:,1),Pb276001(:,2),'-.',...
     Pb276002(:,1),Pb276002(:,2),'--',...
     Pb276003(:,1),Pb276003(:,2),'-','LineWidth',linewidth);
ylim([0 1.5])
set(gca,'linewidth',2,'FontName','Times','FontSize',fontsize-2);
legend({'Pb $2760\,\mathrm{GeV}\,\lambda = 0.1 R$','Pb $2760\,\mathrm{GeV}\,\lambda = 0.2 R$', 'Pb $2760\,\mathrm{GeV}\,\lambda = 0.3 R$'},...
     'Interpreter','latex','Location','northwest');
xlabel('$b/R$','Interpreter','latex')
ylabel('$|a_{+-}|/a_{++}$','Interpreter','latex')
text(1,1.35,'(b)','FontSize',fontsize-2)
set(gca,'FontName','Times','FontSize',fontsize-2)
% 
% subplot(2,2,3)
% box on
% plot(Au20002(:,1),Au20002(:,2),...
%      Cu20002(:,1),Cu20002(:,2),'LineWidth',linewidth);
% set(gca,'linewidth',2,'FontName','Times','FontSize',fontsize-2);
% legend({'Au-Au $200\,\mathrm{GeV}\,\lambda=0.2 R$','Cu-Cu $200\,\mathrm{GeV}\,\lambda=0.2 R$'},...
%      'Interpreter','latex','Location','northwest');
% %xlabel('$b/R$','Interpreter','latex')
% ylabel('$|a_{+-}|/a_{++}$','Interpreter','latex')
% 
% subplot(2,2,4)
% box on
% plot(Au6202(:,1),Au6202(:,2),'-.',...
%      Au13002(:,1),Au13002(:,2),'--',...
%      Au20002(:,1),Au20002(:,2),'-','LineWidth',linewidth);
% set(gca,'linewidth',2,'FontName','Times','FontSize',fontsize-2);
% legend({'Au $62\,\mathrm{GeV}\,\lambda=0.2 R$','Au $130\,\mathrm{GeV}\,\lambda=0.2 R$', 'Au $200\,\mathrm{GeV}\,\lambda=0.2 R$'},...
%      'Interpreter','latex','Location','northwest');
% %xlabel('$b/R$','Interpreter','latex')
% ylabel('$|a_{+-}|/a_{++}$','Interpreter','latex')

