# GDDateTime

A small but smart DateTime management system for Godot 4.x that makes working with dates and times simple and intuitive. This utility script provides easy-to-use functions for date/time manipulation, timestamps, and time-based calculations.

## Features

- **Easy Time Manipulation**
  - Add or subtract years, months, days, hours, minutes, and seconds
  - Handles month/year rollovers automatically
  - Supports negative time operations

- **Timestamp Operations**  -- TO COME
  - Convert DateTime to timestamps
  - Create DateTime from timestamps
  - Compare different dates easily

- **Simple Integration**
  - Drop-in solution for Godot projects
  - Clean, GDScript-native implementation
  - No external dependencies

## Installation

1. Download the `GDDateTime.gd` script
2. Add it to your Godot project
3. Use the classes from within

## Usage -- 

- Create a new time handler with `var timeutil = GDDateTime.new()`
- Use your new handler to create a time object
  -  `var t = timeutil.create_new_time(15,15,00)` - creates a new time object at time given in constructors ( this would be 15:15:00 or 3:15:00PM )
  -  `var t = timeutil.create_new_time_now()` - creates a new time object with system time at time of creation ( this is pulled from the system the script is running on )
  -  `var d = timeutil.create_new_date(1995,12,12)` - creates a new date object with the given constructors ( this would be 1995:12:12 )
  -  `var d = timeutl.create_new_date_now()` - creates a new date object on date of creation ( this is pulled from the system the script is running on )
  -  `var dt = timeutil.create_new_datetime(1995,12,12,15,15,00)` - creates a new datetime object atg date and time given in constructors ( this would be 1995:12:12 -- 15:15:00 )
  -  `var dt = timeutil.create_new_datetime_now()` - creates a new datetime object at date and time of creation ( this is pulled from the system the script is running on )

## Methods

- `return_to_string()` - returns a string format
- `add_time()` - adds time to you date and time objects
- `subtract_time()` - removes time to your date and time objects
- `set_time/date/datetime()` - sets the date or tiem object to the new constructors

## Properties

- Date
  - year,month,day,timestamp,init_values
- Time
  - hour,minute,second,timestamp,init_values
- DateTime
  - year,month,day,hour,minute,second,timestamp,init_values


## Issues

- Currently, all months have 30 days ( yes including feb ) - this will be addressed
- Currently no timezones

## TODO

- Add timezones
- add correct days per month
- add seasons
  



**- Inspired by the need for better DateTime handling in Godot**


## Support

If you encounter any issues or have questions, please open an issue on the GitHub repository.
