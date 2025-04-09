# GDDateTime

**- Inspired by the need for better DateTime handling in Godot**

A small but smart DateTime management system for Godot 4.x that makes working with dates and times simple and intuitive. This utility script provides easy-to-use functions for date/time manipulation, timestamps, and time-based calculations.

## Features

- **Easy Time Manipulation**
  - Add or subtract years, months, days, hours, minutes, and seconds
  - Handles second/min/hour/day/month/year rollovers automatically
  - Supports negative time operations
  - Knows leap years

- **Simple Integration**
  - Drop-in solution for Godot projects
  - Clean, GDScript-native implementation
  - No external dependencies


## Installation

1. Download the `GDDateTime.gd` script
2. Add it to your Godot project
3. Use the classes from within

## Usage

- Create a new time handler with e.g `var timeutil = GDDateTime.new()`
- Use your new handler to create a time date and datetime objects
  -  `var t = timeutil.create_new_time(15,15,00)` - creates a new time object at time given in constructors ( this would be 15:15:00 or 3:15:00PM )
  -  `var t = timeutil.create_new_time_now()` - creates a new time object with system time at time of creation ( this is pulled from the system the script is running on )
  -  `var d = timeutil.create_new_date(1995,12,12)` - creates a new date object with the given constructors ( this would be 1995:12:12 )
  -  `var d = timeutl.create_new_date_now()` - creates a new date object on date of creation ( this is pulled from the system the script is running on )
  -  `var dt = timeutil.create_new_datetime(1995,12,12,15,15,00)` - creates a new datetime object at date and time given in constructors ( this would be 1995:12:12 -- 15:15:00 )
  -  `var dt = timeutil.create_new_datetime_now()` - creates a new datetime object at date and time of creation ( this is pulled from the system the script is running on )

## Methods

- `return_to_string()` - returns a string format
- `add_time()` - adds time to your date and time objects
- `subtract_time()` - removes time to your date and time objects
- `set_time/date/datetime()` - sets the date or time object to the new constructors
- `get_hours/minutes/seconds_until_next_day()` - returns int
- `get_mintue/second_of_day()` - returns int
- `is_leapyear()` - returns bool
- `get_time_between_unix()` - return dict of TOTAL SECONDS, Hours, minutes, seconds

## Properties

- Date
  - year,month,day,timestamp,init_values
- Time
  - hour,minute,second,timestamp,init_values
- DateTime
  - year,month,day,hour,minute,second,timestamp,init_values


## Issues

- Currently no timezones

## TODO

- Add timezones
- add seasons
- Timestamp Operations 
  - Convert DateTime to timestamps
  - Create DateTime from timestamps
  - Compare different dates easily
- Methods to :







## Support

If you encounter any issues or have questions, please open an issue on the GitHub repository.
