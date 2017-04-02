void draw624(){  
//to define strle and format 
// how to run .x draw1.C
  gROOT->Reset();
//  gStyle->SetNdivisions(505, "X");
//  gStyle->SetNdivisions(506, "Y"); 
  gStyle->SetOptStat(0);

  gROOT->SetStyle("Bold");
  gROOT->ForceStyle();
  gStyle->SetTitleTextColor(1);
  gStyle->SetPadBorderMode(0);
  gStyle->SetOptStat(0);
  gStyle->SetLabelColor(1,"X");
  gStyle->SetLabelColor(1,"Y");
//  gStyle->SetMarkerStyle(8);
//  gStyle->SetMarkerSize(0.9);
//  gStyle->SetMarkerColor(2);
//  gStyle->SetHistLineColor(2);
//  gStyle->SetHistLineWidth(4); 

 //to define canvas
 TCanvas *c1 = new TCanvas("c1","c1",0,0,800,600); 
 c1->Range(0,0,1,1);
 c1->SetFillColor(0);
 c1->SetBorderMode(0);
 c1->SetBorderSize(0);
// c1->SetFrameLineWidth(3);
 c1->SetFrameFillColor(0);
 c1->SetFrameBorderMode(0);
// c1->Draw();
 c1->cd();
 
// to define pad location
 TPad *pad = new TPad("pad","pad",0.07,0.12,0.98,0.98);
  pad->SetBorderMode(0);
  pad->SetFillColor(kWhite);
  pad->Draw(); 
  pad->cd();

  TH2D *ff1= new TH2D("","",1,0.,10.,500,-2.1E-3,2.1E-3);
  ff1->GetXaxis()->SetNdivisions(503);
  ff1->GetXaxis()->SetLabelOffset(0.06);
  ff1->GetXaxis()->SetLabelSize(0.08);
  ff1->GetXaxis()->SetTickLength(0.1);
  ff1->GetYaxis()->SetNdivisions(506);
  ff1->GetYaxis()->SetLabelSize(0.045);
  ff1->GetYaxis()->SetLabelFont(12);
  ff1->GetYaxis()->SetTickLength(0.04);
 
  const  Int_t n=9; // point num. for test  

 Double_t x1[n],y1[n];                     
  ifstream in1;                                
  in1.open("a++_624_lambda0.3R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in1 >>x1[i]>>y1[i];                   
  }                                            
  in1.close();

   
  Double_t x2[n],y2[n];                     
  ifstream in2;                                
  in2.open("a+-_624_lambda0.3R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in2 >>x2[i]>>y2[i];                   
 }                                            
  in2.close(); 
  /* 

  Double_t x3[n],y3[n];                     
  ifstream in3;                                
  in3.open("a++_200_lambda0.3R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in3 >>x3[i]>>y3[i];                   
  }                                            
  in3.close();  

  Double_t x4[n],y4[n];
  ifstream in4;
  in4.open("fig3/a++_2760_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in4 >>x4[i]>>y4[i];
  }
  in4.close();

  Double_t x5[n],y5[n];
  ifstream in5;
  in5.open("a+-_624_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in5 >>x5[i]>>y5[i];
  }
  in3.close();

  Double_t x6[n],y6[n];
  ifstream in6;
  in6.open("a+-_130_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in6 >>x6[i]>>y6[i];
  }
  in6.close();

  Double_t x7[n],y7[n];
  ifstream in7;
  in7.open("fig3/a+-_200_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in7 >>x7[i]>>y7[i];
  }
  in7.close();

  Double_t x8[n],y8[n];
  ifstream in8;
  in8.open("a+-_2760_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in8 >>x8[i]>>y8[i];
  }
  in8.close();*/

Double_t x[n]={1.,2.,3.,4.,5.,6.,7.,8.,9.};

 //2D graph for 62.4 GeV                             
 dv1 = new TGraph(n,x,y1);
 dv2 = new TGraph(n,x,y2);
/*
 dv3 = new TGraph(n,x,y3);
 dv4 = new TGraph(n,x,y4);
 dv5 = new TGraph(n,x,y5);
 dv6 = new TGraph(n,x,y6);
 dv7 = new TGraph(n,x,y7);
 dv8 = new TGraph(n,x,y8);*/

  dv1->SetMarkerStyle(20);  dv1->SetMarkerSize(1.5);  dv1->SetMarkerColor(1);
  dv2->SetMarkerStyle(20);  dv2->SetMarkerSize(1.5);  dv2->SetMarkerColor(2);
  
  /*
  dv3->SetMarkerStyle(22);  dv3->SetMarkerSize(1.5);  dv3->SetMarkerColor(1);
  dv4->SetMarkerStyle(34);  dv4->SetMarkerSize(1.5);  dv4->SetMarkerColor(1);
  dv5->SetMarkerStyle(20);  dv5->SetMarkerSize(1.5);  dv5->SetMarkerColor(2);
  dv6->SetMarkerStyle(21);  dv6->SetMarkerSize(1.5);  dv6->SetMarkerColor(2);
  dv7->SetMarkerStyle(22);  dv7->SetMarkerSize(1.5);  dv7->SetMarkerColor(2);
  dv8->SetMarkerStyle(34);  dv8->SetMarkerSize(1.5);  dv8->SetMarkerColor(2);
  */

    gPad->SetBorderMode(0);
    gPad->SetFrameBorderMode(0);
    gPad->SetFillColor(kWhite);
    gPad->SetTopMargin(0.05);
    gPad->SetBottomMargin(0.03);
    gPad->SetLeftMargin(0.09);
  //  gPad->SetLogy();

    ff1->Draw();
    dv1->Draw("psame"); dv2->Draw("psame"); 

    /*
      dv2->Draw("psame"); dv3->Draw("psame");  dv4->Draw("psame");dv5->Draw("psame");  dv6->Draw("psame"); dv7->Draw("psame");  dv8->Draw("psame");
   leg1 = new TLegend(0.2,0.6,0.4,0.85);
   leg1->SetTextAlign(22);
   leg1->SetTextFont(12);
   leg1->SetTextSize(0.045);
   leg1->SetLineColor(1);
   leg1->SetFillColor(0);
  entry = leg1->AddEntry(dv1,"62.4 GeV","p");
   entry = leg1->AddEntry(dv2,"130  GeV","p");
  entry = leg1->AddEntry(dv3,"200  GeV","p");
  entry = leg1->AddEntry(dv4,"2.76 TeV","p");
   leg1->Draw();*/

   
   /* leg1 = new TLegend(0.2,0.12,0.4,0.37);
   leg1->SetTextAlign(22);
   leg1->SetTextFont(12);
   leg1->SetTextSize(0.045);
   leg1->SetLineColor(1);
   leg1->SetFillColor(0);
   /* entry = leg1->AddEntry(dv2,"62.4 GeV","p");
 
  entry = leg1->AddEntry(dv6,"130  GeV","p");
  entry = leg1->AddEntry(dv7,"200  GeV","p");
  entry = leg1->AddEntry(dv8,"2.76 TeV","p");
  leg1->Draw();*/


  tex = new TLatex(7.,0.0015,"#lambda = 0.3");
  tex->SetLineWidth(2);tex->SetTextSize(0.07);  tex->SetTextFont(12);
  tex->Draw();

  tex = new TLatex(0.80,0.0015,"#sqrt{S_{NN}} = 62.4 GeV");
  tex->SetLineWidth(2);tex->SetTextSize(0.07);  tex->SetTextFont(12);
  tex->Draw();

  L1 = new TLine(0.,0.,10.,0.);
  L1->SetLineWidth(3);    L1->SetLineColor(4);
  L1->SetLineStyle(1);    L1->Draw();

    gPad->Modified();
   c1->cd();

  tex = new TLatex(0.45,0.04,"Centrality (%)");
  tex->SetLineWidth(2);tex->SetTextSize(0.045);  tex->SetTextFont(12);
  tex->Draw();
  tex = new TLatex(0.2,0.09,"0-5  5-10 10-20 20-30 30-40 40-50 50-60 60-70 70-80");
  tex->SetLineWidth(2);tex->SetTextSize(0.045);  tex->SetTextFont(12);
  tex->Draw();
  tex = new TLatex(0.05,0.65,"a_{++},a_{--}");
  tex->SetLineWidth(2);tex->SetTextSize(0.05);  tex->SetTextFont(12);
  tex->SetTextAngle(90);  tex->SetTextColor(1);
  tex->Draw();
  tex = new TLatex(0.05,0.3,"a_{+-}");
  tex->SetLineWidth(2);tex->SetTextSize(0.05);  tex->SetTextFont(12);
  tex->SetTextAngle(90); tex->SetTextColor(1);
  tex->Draw();  
/*
  tex = new TLatex(0.05,0.3,"#lambda = 0.3");
  tex->SetLineWidth(2);tex->SetTextSize(0.075);  tex->SetTextFont(12);
  tex->Draw();
*/
   c1->cd();
   c1->SaveAs("624.eps");   //save and produce a EPS file
     }
