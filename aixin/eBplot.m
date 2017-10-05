fontsize = 15;
LineWidth = 2;

skokov{1} = csvread('eBdata/skokov2014fig1One.txt');
skokov{2} = csvread('eBdata/skokov2014fig1Two.txt');
skokov{3} = csvread('eBdata/skokov2014fig1Three.txt');
skokov{4} = csvread('eBdata/skokov2014fig1Four.txt');

tuchin.blue = csvread('eBdata/tuchin2013fig4blue.txt');
tuchin.brown = csvread('eBdata/tuchin2013fig4brown.txt');
tuchin.green = csvread('eBdata/tuchin2013fig4green.txt');
tuchin.red = csvread('eBdata/tuchin2013fig4red.txt');
tuchin.black2016 = csvread('eBdata/tuchin2016fig2.txt');


hbar = 197.32696;
mpi = 140.0;
tuchin.blue(:,2) = tuchin.blue(:,2)*hbar^2;
tuchin.brown(:,2) = tuchin.brown(:,2)*hbar^2;
tuchin.green(:,2) = tuchin.green(:,2)*hbar^2;
tuchin.red(:,2) = tuchin.red(:,2)*hbar^2;
tuchin.black2016(:,2) = tuchin.black2016(:,2)*hbar^2;

skokov{1}(:,2) = skokov{1}(:,2)*mpi^2;
skokov{2}(:,2) = skokov{2}(:,2)*mpi^2;
skokov{3}(:,2) = skokov{3}(:,2)*mpi^2;
skokov{4}(:,2) = skokov{4}(:,2)*mpi^2;

Au200b8Mo = dlmread('eBdata/oriAu200b8Mo.dat');
Au200b8QGP = dlmread('eBdata/oriAu200b8QGP.dat');
Au200b7QGP = dlmread('eBdata/oriAu200b7QGP.dat');
Au200b6QGP = dlmread('eBdata/oriAu200b6QGP.dat');
Pb2760b8Mo = dlmread('eBdata/oriPb2760b8Mo.dat');
Pb2760b8QGP = dlmread('eBdata/oriPb2760b8QGP.dat');

%%
figure
semilogy(Au200b8QGP(:,1),Au200b8QGP(:,2),'k-',...
    Au200b8Mo(:,1),Au200b8Mo(:,2),'k--',...
    Pb2760b8QGP(:,1),Pb2760b8QGP(:,2),'k-',...
    Pb2760b8Mo(:,1),Pb2760b8Mo(:,2),'k--',...
    'LineWidth',LineWidth)
%set(gca, 'YTick', 10.^[-2:2:6])
%set(gca, 'YTick', [10.^-2 10.^-1 10.^0 10.^1 10.^2 10.^3 10.^4 10.^5 10.^6 10.^7 10.^8])
set(gca,'YMinorTick','on')
xlim([0 6.7])
ylim([10^-2 10^6])
xlabel('t (fm)','FontSize',fontsize)
%ylabel('$\mathrm{eB}\, (\mathrm{MeV}^2)$','Interpreter','latex','FontSize',fontsize)
ylabel('eB (MeV^2)','FontSize',fontsize)
legend({'QGP Response','in the vacuum'}, 'fontsize',fontsize+3)
text(5.05,132,'$\sqrt{S}=200\,\mathrm{GeV}$','Interpreter','latex','fontsize',fontsize-1)
text(5.05,5.76,'$\sqrt{S}=2760\,\mathrm{GeV}$','Interpreter','latex','fontsize',fontsize-1)
text(5.05,1.14,'$\sqrt{S}=200\,\mathrm{GeV}$','Interpreter','latex','fontsize',fontsize-1)
text(5.05,0.2727,'$\sqrt{S}=2760\,\mathrm{GeV}$','Interpreter','latex','fontsize',fontsize-1)
set(gca,'linewidth',LineWidth) 
set(gca,'fontsize',fontsize+2)
%%
% RHIC ???? b=6 ?????????? skokov????
figure
subplot(2,1,1)
p=semilogy(Au200b6QGP(1:251,1),Au200b6QGP(1:251,2),'k-',...
    skokov{1}(25:end,1),skokov{1}(25:end,2),'k-.',...
    skokov{2}(26:end,1),skokov{2}(26:end,2),'k:',...
    'LineWidth',LineWidth);
text(0.1,3e5,'(a)','FontSize',fontsize)
xlabel('t (fm)','FontSize',fontsize)
ylabel('eB (MeV^2)','FontSize',fontsize)
h = legend('Our method', 'Skokov: in the vacuum','Skokov: $\sigma_{\mathrm{LQCD}}$');
set(h,'Interpreter','latex')
set(gca,'linewidth',LineWidth) 
set(gca,'fontsize',fontsize)
% RHIC ???? b=7 ?????????? Tuchin????
subplot(2,1,2)
p2=semilogy(Au200b7QGP(:,1),Au200b7QGP(:,2),'k-',...
    tuchin.blue(1:53,1),tuchin.blue(1:53,2),'k--',...
    tuchin.red(1:141,1),tuchin.red(1:141,2),'k:',...
    tuchin.black2016(1:105,1),tuchin.black2016(1:105,2),'k-.',...
    'LineWidth',LineWidth);
text(0.2,3e5,'(b)','FontSize',fontsize)
xlabel('t (fm)','FontSize',fontsize)
ylabel('eB (MeV^2)','FontSize',fontsize)
h = legend('Our method', 'Tuchin: in the vacuum','Tuchin: $\sigma = 5.8\,\mathrm{MeV}$',...
    'Tuchin: $B_{\mathrm{init}} + B_{\mathrm{val}}$');
set(h,'Interpreter','latex')
set(gca,'linewidth',LineWidth) 
set(gca,'fontsize',fontsize)