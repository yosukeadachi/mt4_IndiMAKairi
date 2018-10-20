//+------------------------------------------------------------------+
//|                                                  IndiMaKairi.mq4 |
//|                                    Copyright 2018, Yosuke Adachi |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Yosuke Adachi"
#property link      ""
#property version   "1.00"
#property strict

//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  DodgerBlue
//---- indicator parameters
extern int MA_Period=21;
extern int MA_Method=1;
//extern int Apply=0;
//---- indicator buffers
double kairi_buffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(){
  // buffer settings

  //--- 1 additional buffers
  
  //---- indicator buffers mapping
  if(!SetIndexBuffer(0,kairi_buffer))
    Print("cannot set indicator buffers!");

  ArrayInitialize(kairi_buffer,0.0);

  //---- drawing settings
  //SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,1,Red);
  
  //---- indicator short name
  IndicatorShortName("Indi MA Kairi");

  return(INIT_SUCCEEDED);
}
  
  
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
}
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[]) {

  int limit;
  int counted_bars=IndicatorCounted();
  double     MA_buffer[];
//---- check for possible errors
  if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
  if(counted_bars>0) counted_bars--;
  limit=Bars-counted_bars;
  ArrayResize(MA_buffer,limit);
  for(int i=0; i<limit; i++) {
    MA_buffer[i] = iMA(NULL,PERIOD_CURRENT,MA_Period,0,MA_Method,PRICE_CLOSE,i);
    kairi_buffer[i] = (Close[i]-MA_buffer[i])/MA_buffer[i]*100;
  }
  return(0);
}


