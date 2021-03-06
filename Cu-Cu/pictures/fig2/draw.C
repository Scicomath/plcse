void draw(){  
//to define strle and format 
// how to run .x test_f2.C
  gROOT->Reset();
  gStyle->SetNdivisions(10, "X");
  gStyle->SetNdivisions(10, "Y"); 
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
 TCanvas *c1 = new TCanvas("c1","c1",0,0,600,800); 
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
 TPad *pad = new TPad("pad","pad",0.1,0.08,0.98,0.98);
  pad->SetBorderMode(0);
  pad->SetFillColor(kWhite);
  pad->Draw(); 
//  pad->SetLogz();
  pad->cd();
  pad->Divide(1,2,0.000001,0.0000001);

  TH2D *ff1= new TH2D("","",100,-5.,90.,500,2.E-9,5.E-3);
  ff1->GetXaxis()->SetNdivisions(506);
  ff1->GetXaxis()->SetLabelOffset(0.04);
  ff1->GetXaxis()->SetLabelSize(0.08);
  ff1->GetXaxis()->SetTickLength(0.1);
  ff1->GetYaxis()->SetNdivisions(503);
  ff1->GetYaxis()->SetLabelSize(0.08);
  ff1->GetYaxis()->SetTickLength(0.04);
 
  const  Int_t n=9; // point num. for test  

 Double_t x1[n],y1[n];                     
  ifstream in1;                                
  in1.open("a++_200_lambda0.1R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in1 >>x1[i]>>y1[i];                   
  }                                            
  in1.close();   
 
  Double_t x2[n],y2[n];                     
  ifstream in2;                                
  in2.open("a++_200_lambda0.2R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in2 >>x2[i]>>y2[i];                   
 }                                            
  in2.close();  

  Double_t x3[n],y3[n];                     
  ifstream in3;                                
  in3.open("a++_200_lambda0.3R.dat");                     
  for(Int_t i=0;i<n;i++){                      
   in3 >>x3[i]>>y3[i];                   
  }                                            
  in3.close();  

  Double_t x4[n],y4[n];
  ifstream in4;
  in4.open("a++_2760_lambda0.1R.dat");
  for(Int_t i=0;i<n;i++){
   in4 >>x4[i]>>y4[i];
  }
  in4.close();

  Double_t x5[n],y5[n];
  ifstream in5;
  in5.open("a++_2760_lambda0.2R.dat");
  for(Int_t i=0;i<n;i++){
   in5 >>x5[i]>>y5[i];
  }
  in3.close();

  Double_t x6[n],y6[n];
  ifstream in6;
  in6.open("a++_2760_lambda0.3R.dat");
  for(Int_t i=0;i<n;i++){
   in6 >>x6[i]>>y6[i];
  }
  in6.close();

Double_t x[n]={2.5,7.5,15.,25.,35.,45.,55.,65.,75.};

 //2D graph for 200 GeV                             
 dv1 = new TGraph(n,x,y1);
 dv2 = new TGraph(n,x,y2);
 dv3 = new TGraph(n,x,y3);
 dv4 = new TGraph(n,x,y4);
 dv5 = new TGraph(n,x,y5);
 dv6 = new TGraph(n,x,y6);

  dv1->SetMarkerStyle(26);  dv1->SetMarkerSize(1.5);  dv1->SetMarkerColor(1);
  dv2->SetMarkerStyle(24);  dv2->SetMarkerSize(1.5);  dv2->SetMarkerColor(2);
  dv3->SetMarkerStyle(25);  dv3->SetMarkerSize(1.5);  dv3->SetMarkerColor(4);
  dv4->SetMarkerStyle(26);  dv4->SetMarkerSize(1.5);  dv4->SetMarkerColor(1);
  dv5->SetMarkerStyle(24);  dv5->SetMarkerSize(1.5);  dv5->SetMarkerColor(2);
  dv6->SetMarkerStyle(25);  dv6->SetMarkerSize(1.5);  dv6->SetMarkerColor(4);

    pad->cd(1);
    gPad->SetBorderMode(0);
    gPad->SetFrameBorderMode(0);
    gPad->SetFillColor(kWhite);
    gPad->SetTopMargin(0.15);
    gPad->SetBottomMargin(0.);
    gPad->SetLeftMargin(0.09);
    gPad->SetLogy();

    ff1->Draw();
    dv1->Draw("psame");  dv2->Draw("psame"); dv3->Draw("psame");
    
  //write some text of 200 GeV  
   TLatex *tex = new TLatex(-0.75,3.E-4,"(a) 200 GeV");
   tex->SetTextSize(0.08);    tex->SetTextFont(102);
   tex->SetLineWidth(2);
   tex->Draw();

   leg1 = new TLegend(0.65,0.1,0.85,0.35);
   leg1->SetTextAlign(22);
   leg1->SetTextFont(102);
   leg1->SetTextSize(0.06);
   leg1->SetLineColor(1);
   leg1->SetFillColor(0);
  entry = leg1->AddEntry(dv1,"#lambda=0.1","p");
  entry = leg1->AddEntry(dv2,"#lambda=0.2","p");
  entry = leg1->AddEntry(dv3,"#lambda=0.3","p");
   leg1->Draw();

   pad->cd();
   gPad->Modified(); 
    
   pad->cd(2);
   gPad->SetLogz();
   gPad->SetBorderMode(0);
   gPad->SetFillColor(kWhite);
   gPad->SetTopMargin(0.);
   gPad->SetBottomMargin(0.15); 
   gPad->SetLeftMargin(0.09);
   gPad->SetLogy();

    ff1->Draw();
    dv4->Draw("psame");  dv5->Draw("psame"); dv6->Draw("psame");

  TLatex *   tex = new TLatex(-0.75,3.E-4,"(b) 2760 GeV");
  tex->SetTextSize(0.08);  tex->SetTextFont(102);
  tex->SetLineWidth(2);
  tex->Draw();

   leg1 = new TLegend(0.65,0.25,0.85,0.5);
   leg1->SetTextAlign(22);
   leg1->SetTextFont(102);
   leg1->SetTextSize(0.06);
   leg1->SetLineColor(1);
   leg1->SetFillColor(0);
  entry = leg1->AddEntry(dv1,"#lambda=0.1","p");
  entry = leg1->AddEntry(dv2,"#lambda=0.2","p");
  entry = leg1->AddEntry(dv3,"#lambda=0.3","p");
   leg1->Draw();

    gPad->Modified();
   c1->cd();

  tex = new TLatex(0.5,0.05,"Certrality (%)");
  tex->SetLineWidth(2);tex->SetTextSize(0.04);
  tex->Draw();
  tex = new TLatex(0.05,0.3,"a_{++},a_{--}");
  tex->SetLineWidth(2);tex->SetTextSize(0.05);
  tex->SetTextAngle(90);
  tex->Draw();
  tex = new TLatex(0.05,0.65,"a_{++},a_{--}");
  tex->SetLineWidth(2);tex->SetTextSize(0.05);
  tex->SetTextAngle(90);
  tex->Draw();  

   c1->cd();
   c1->SaveAs("a_c.eps");   //save and produce a EPS file
     }
