% exp gamma data
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

% exp delta data
Au200deltaSS = csvread('exp data/Au200GeV_delta_same.txt');
Au200deltaOS = csvread('exp data/Au200GeV_delta_opp.txt');
Pb2760deltaSS = csvread('exp data/Pb2760GeV_delta_same.txt');
Pb2760deltaOS = csvread('exp data/Pb2760GeV_delta_opp.txt');

% exp v2 data
Au200v2 = csvread('v2/RHICv2.txt',2,0);
Pb2760v2 = csvread('v2/LHCv2.txt',2,0);

kappa = 1.0;
Au200HSS10 = (kappa * Au200v2(:,2) .* Au200deltaSS(2:8,2) - Au200same(2:8,2))./(1+kappa*Au200v2(:,2));
Au200HOS10 = (kappa * Au200v2(:,2) .* Au200deltaOS(2:8,2) - Au200opp(2:8,2))./(1+kappa*Au200v2(:,2));
Au200Hdiff10 = Au200HSS10 - Au200HOS10;
Pb2760HSS10 = (kappa * Pb2760v2(:,2) .* Pb2760deltaSS(:,2) - Pb2760same(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760HOS10 = (kappa * Pb2760v2(:,2) .* Pb2760deltaOS(:,2) - Pb2760opp(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760Hdiff10 = Pb2760HSS10 - Pb2760HOS10;

kappa = 1.5;
Au200HSS15 = (kappa * Au200v2(:,2) .* Au200deltaSS(2:8,2) - Au200same(2:8,2))./(1+kappa*Au200v2(:,2));
Au200HOS15 = (kappa * Au200v2(:,2) .* Au200deltaOS(2:8,2) - Au200opp(2:8,2))./(1+kappa*Au200v2(:,2));
Au200Hdiff15 = Au200HSS15 - Au200HOS15;
Pb2760HSS15 = (kappa * Pb2760v2(:,2) .* Pb2760deltaSS(:,2) - Pb2760same(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760HOS15 = (kappa * Pb2760v2(:,2) .* Pb2760deltaOS(:,2) - Pb2760opp(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760Hdiff15 = Pb2760HSS15 - Pb2760HOS15;

kappa = 2.0;
Au200HSS20 = (kappa * Au200v2(:,2) .* Au200deltaSS(2:8,2) - Au200same(2:8,2))./(1+kappa*Au200v2(:,2));
Au200HOS20 = (kappa * Au200v2(:,2) .* Au200deltaOS(2:8,2) - Au200opp(2:8,2))./(1+kappa*Au200v2(:,2));
Au200Hdiff20 = Au200HSS20 - Au200HOS20;
Pb2760HSS20 = (kappa * Pb2760v2(:,2) .* Pb2760deltaSS(:,2) - Pb2760same(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760HOS20 = (kappa * Pb2760v2(:,2) .* Pb2760deltaOS(:,2) - Pb2760opp(:,2))./(1+kappa*Pb2760v2(:,2));
Pb2760Hdiff20 = Pb2760HSS20 - Pb2760HOS20;

%% Au200
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(2:8,Au200Hdiff10,2:8,Au200Hdiff15,2:8,Au200Hdiff20,'LineWidth',linewidth)
legend({'$\kappa = 1.0$', '$\kappa = 1.5$', '$\kappa = 2.0$'},'Interpreter','latex')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{SS}-H_{OS}$','Interpreter','latex','FontSize',fontsize)
title('Au-Au 200 GeV')

%% Pb2760
linewidth = 2;
fontsize = 18;
markersize = 10;
figure
hold on
box on
plot(1:8,Pb2760Hdiff10,1:8,Pb2760Hdiff15,1:8,Pb2760Hdiff20,'LineWidth',linewidth)
legend({'$\kappa = 1.0$', '$\kappa = 1.5$', '$\kappa = 2.0$'},'Interpreter','latex')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','FontSize',fontsize-2)
xlim([0.5 8.5])
set(gca,'XTickLabel',{'0-5%','5-10%','10-20%','20-30%','30-40%','40-50%','50-60%','60-70%','70-80%'})
xlabel('Centrality','FontSize',fontsize)
ylabel('$H_{SS}-H_{OS}$','Interpreter','latex','FontSize',fontsize)
title('Pb-Pb 2760 GeV')