#!/usr/bin/env python
# coding: utf-8

# In[1]:


import yfinance as yf
import streamlit as st

st.write("""
### Simple Stock Price App

Shown are the stock **closing price** and ***volume*** of Apple!
""")
st.write("""
#### Jeff W
""")

#define  ticker
tickerSymbol = 'AAPL'

#get data on this ticker
tickerData = yf.Ticker(tickerSymbol)

#get the historical prices for this ticker
tickerDf = tickerData.history(period='1d', start='2014-6-28', end='2024-6-28')
# Open	High	Low	Close	Volume	Dividends	Stock Splits

st.write("""
### Closing Price
""")
st.line_chart(tickerDf.Close)
st.write("""
### Volume Price
""")
st.line_chart(tickerDf.Volume)

