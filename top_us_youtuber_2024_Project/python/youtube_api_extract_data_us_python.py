#!/usr/bin/env python
# coding: utf-8

# In[5]:


pip install python-dotenv


# In[1]:


pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib


# In[1]:


pip install --upgrade google-api-python-client


# In[15]:


import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build


# In[16]:


load_dotenv() 

api_key = 'AIzaSyDuqfEPVW0xsgSlkAwd1BPGWl2A2sbt3qs'
api_version = 'v3'

# to create service
youtube = build('youtube', api_version, developerKey=api_key)


# In[37]:


# Read CSV into dataframe 
df = pd.read_csv(r"C:\Users\nhi\OneDrive\Desktop\Data Analyst\top_us_youtuber_2024_Project\youtube_data_united-states.csv")

df_first_50 = df.head(50)
# Extract channel IDs and remove potential duplicates
channel_ids = (df_first_50['NAME'].str.split('@').str[-1].unique()).tolist()
#type(channel_ids)


# In[38]:


def get_channel_stats(youtube, channel_id):
    request = youtube.channels().list(
        part='snippet, statistics',
        id= channel_id)
    response = request.execute()

    if response['items']:

        data = dict(channel_name=response['items'][0]['snippet']['title'],
                    total_subscribers=response['items'][0]['statistics']['subscriberCount'],
                    total_views=response['items'][0]['statistics']['viewCount'],
                    total_videos=response['items'][0]['statistics']['videoCount'])

    return data


# In[39]:


channel_id = 'UCrbQpSA6almBZA5qEQyw7NA'
get_channel_stats(youtube, channel_id)


# In[41]:


# Initialize a list to keep track of channel stats
channel_stats=[]
for i in range(len(channel_ids)):
    stats = get_channel_stats(youtube, channel_ids)
    if stats is not None:
        channel_stats.append(stats)


# In[44]:


# Convert the list of stats to a df
stats_df = pd.DataFrame(channel_stats)


df.reset_index(drop=True, inplace=True)
stats_df.reset_index(drop=True, inplace=True)


# Concatenate the dataframes horizontally
combined_df = pd.concat([df, stats_df], axis=1)


# Drop the 'channel_name' column from stats_df (since 'NOMBRE' already exists)
# combined_df.drop('channel_name', axis=1, inplace=True)


# Save the merged dataframe back into a CSV file
combined_df.to_csv('updated_youtube_data_us.csv', index=False)


combined_df.head(50)


# In[ ]:




