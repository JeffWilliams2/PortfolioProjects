# Other

# FRED (Federal Reserve Economic Data) Usage Guide

## Introduction to FRED (Federal Reserve Economic Data)
FRED (Federal Reserve Economic Data) is an extensive economic database provided by the Federal Reserve Bank of St. Louis. It contains a wealth of economic data from various sources, making it a valuable resource for researchers, analysts, and policymakers. The data covers a wide range of economic indicators, including GDP, employment, inflation, and interest rates.

## How to Install PublicDataReader

1. Choose one of the following depending on your System:
- Mac: Terminal
- Windows: CMD

2. Enter and execute the following Shell command:

- Mac: pip install PublicDataReader --upgrade
- PC: ```bash```

## Import Libraries

```python
from PublicDataReader import Fred

# FRED API key
api_key = "YOUR FRED API KEY"

# Create an instance
api = Fred(api_key)
```

## Searching in Series

A 'series' within FRED represents the changes in a specific economic indicator over time. These series express changes in economic indicators over time through a series of continuous data points. Each series represents a specific economic indicator (e.g., unemployment rate, GDP, inflation, etc.) and this data is collected over a specific period (days, months, quarters, years, etc.). These series are helpful in analyzing and understanding economic patterns and trends. To search for such series, input `series_search` for `api_name` and the keyword of the series you wish to search for `search_text` in the `api.get_data()` method. From the search results, you can find the ID value of the series you want. This series ID value is used when querying series data. For instance, to find the series ID value of the consumer price index, an indicator related to inflation, input `consumer price index` for `search_text`.

```python
search_text = "consumer price index"
result = api.get_data(api_name="series_search", search_text=search_text)
result.head()
```

## Querying Series Data

To query series data, input `series_observations` for `api_name` and the series ID value for `series_id` in the `api.get_data()` method. For instance, to query the data series of the consumer price index, input `CPIAUCNS` for `series_id`. Note that this data can also be checked on the [FRED website](https://fred.stlouisfed.org/series/CPIAUCNS).

```python
# Series ID value
series_id = "CPIAUCNS"

# Query series data
df = api.get_data(api_name="series_observations", series_id=series_id)
df.tail()
```
### Example:

###  import requests
```
  ### Define the API key and base URL
  api_key = 'your_api_key_here'
  base_url = 'https://api.stlouisfed.org/fred/series/observations'

  ### Define parameters
  params = {
      'series_id': 'GDP',
      'api_key': api_key,
      'file_type': 'json'
  }

  ### Make the API request
  response = requests.get(base_url, params=params)
  
  data = response.json()

  ### Print the data
  print(data)
```

## Conclusion
FRED is an invaluable resource for accessing a wide range of economic data. Whether you are a researcher, analyst, or developer, FRED provides the tools and data you need to analyze economic trends and make informed decisions. By using the FRED API, you can integrate this rich dataset into your own applications and analyses.
