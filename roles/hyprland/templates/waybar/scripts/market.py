#!/usr/bin/env python3
import requests
import json
import sys
from datetime import datetime

def get_market_data():
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36'
        }
        
        # Get more data to ensure we have previous close
        spx_url = "https://query1.finance.yahoo.com/v8/finance/chart/^GSPC?interval=1d&range=5d"
        ibov_url = "https://query1.finance.yahoo.com/v8/finance/chart/^BVSP?interval=1d&range=5d"
        
        spx_response = requests.get(spx_url, headers=headers, timeout=10)
        ibov_response = requests.get(ibov_url, headers=headers, timeout=10)
        
        if spx_response.status_code != 200 or ibov_response.status_code != 200:
            raise Exception("API request failed")
        
        spx_data = spx_response.json()
        ibov_data = ibov_response.json()
        
        # Extract data
        spx_result = spx_data['chart']['result'][0]
        ibov_result = ibov_data['chart']['result'][0]
        
        # Extract current price
        spx_current = spx_result['meta']['regularMarketPrice']
        ibov_current = ibov_result['meta']['regularMarketPrice']
        
        # Get previous close
        spx_previous = spx_result['meta'].get('previousClose') or spx_result['meta'].get('chartPreviousClose')
        ibov_previous = ibov_result['meta'].get('previousClose') or ibov_result['meta'].get('chartPreviousClose')
        
        # Use historical data if previous close is not available
        if spx_previous is None and 'timestamp' in spx_result:
            closes = spx_result['indicators']['quote'][0]['close']
            spx_previous = closes[-2] if len(closes) >= 2 else spx_current
        if ibov_previous is None and 'timestamp' in ibov_result:
            closes = ibov_result['indicators']['quote'][0]['close']
            ibov_previous = closes[-2] if len(closes) >= 2 else ibov_current
        
        # Calculate changes
        spx_change = ((spx_current - spx_previous) / spx_previous) * 100
        ibov_change = ((ibov_current - ibov_previous) / ibov_previous) * 100
        
        # Determine colors and arrows
        spx_arrow = "↗" if spx_change >= 0 else "↘"
        ibov_arrow = "↗" if ibov_change >= 0 else "↘"
        
        spx_color = "#B0E0B0" if spx_change >= 0 else "#E0B0B0"
        ibov_color = "#B0E0B0" if ibov_change >= 0 else "#E0B0B0"
        
        # Format output with individual colors
        spx_text = f"<span color='{spx_color}'>SPX {spx_arrow} {spx_current:.0f}</span>"
        ibov_text = f"<span color='{ibov_color}'>IBOV {ibov_arrow} {ibov_current:.0f}</span>"
        
        output = {
            "text": f"{spx_text} | {ibov_text}",
            "tooltip": f"SPX: {spx_change:+.2f}% ({spx_current:.2f})\nIBOV: {ibov_change:+.2f}% ({ibov_current:.2f})",
            "class": "market-data"
        }
        
        print(json.dumps(output))
        
    except Exception as e:
        error_output = {
            "text": "Market: Error",
            "tooltip": f"Error: {str(e)}",
            "class": "market-error"
        }
        print(json.dumps(error_output))

if __name__ == "__main__":
    get_market_data()
