# Matches

## Data Fetcher and Database Inserter

## Overview
This project is designed to fetch data from a provider, process it into a unique format, and insert it into a database. It ensures that duplicate data is not inserted into the database based on specified criteria.

## Features
- Fetches data from a provider every 30 seconds.
- Processes data into a unique format.
- Inserts processed data into a database.
- Prevents duplicate data insertion based on specified criteria (unique index for home_team, away_team, kickoff_at).
- if by any chance a worker dies, a new worker will be restarted automatically

## Logic
1. Application starts
2. A Supervisor is created and initialize two workers (with 15 seconds between), one for each provider.
3. The worker will fetch data from its provider, prepare its data and insert in the database every 30 seconds
   

            Data Fecher Supervisor
                  /      \
                 /        \
                /          \
               /            \
         Data Fecher     Data Fetcher
         (FastBall)       (MatchBeam)
   

## Side effects 
I decided to put the time to wait for each worker spawn as environment variable so I could set that time as 0 when running tests.
The side effect of that is that the first call after application starts delay 15 seconds. That was an easy way to have that without
overthinking.


## Installation
Clone the repository:
```
git clone git@github.com:bernardocaputo/matches.git
```

Install dependencies:
```
mix deps.get
```

Run application:
```
mix run --no-halt
```
