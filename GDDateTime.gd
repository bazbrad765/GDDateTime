extends Node

# Time tracking class that provides similar functionality to Python's pendulum
class_name GDDateTime

const DAYS_BEEN_PER_MONTH = [31,59,90,120,151,181,212,243,273,304,334,365]
const DAYS_BEEN_PER_MONTH_LEAP = [31,60,91,121,152,182,213,244,274,305,335,336]
const DAYS_IN_MONTH = [31,28,31,30,31,30,31,31,30,31,30,31]
const DAYS_IN_MONTH_LEAP = [31,28,31,30,31,30,31,31,30,31,30,31]

#Time Class to create new time
class GTime:
	var hour: int
	var minute: int
	var second: int
	var timestamp: int
	var init_values: Dictionary
	
	func _init(h: int = 0, m: int = 0, s: int = 0):
		hour = clampi(h, 0, 23)
		minute = clampi(m, 0, 59)
		second = clampi(s, 0, 59)
		init_values = {"hour":hour,"minute":minute,"second":second}
		timestamp = Time.get_unix_time_from_datetime_dict(init_values) #returns on day 1 of unix time 1975
		var ts = {"timestamp":timestamp}
		init_values.merge(ts) 
		
	func get_hours_until_next_day(hour = hour):
		return 24 - hour
		
	func get_minutes_until_next_day(hour = hour, minute = minute):
		var h = get_hours_until_next_day(hour) * 60
		var m = (60-(minute)) 
		return h + m
		
	func get_seconds_until_next_day(hour = hour, minute = minute, second = second):
		var h = get_hours_until_next_day(hour) * 3600
		var m = (60 - (minute)) * 60
		var s = (60-second)
		return h + m + s
		
	func get_minute_of_day(hour = hour, minute = minute):
		return (hour * 60) + minute
	
	func get_second_of_day(hour = hour, minute = minute, second = second):
		return (hour * 3600) + (minute * 60) + second
		
	func return_to_string() -> String:
		return "%02d:%02d:%02d" % [hour, minute, second]
		
	func add_time(hours:int,mins:int, seconds:int):
		second += seconds
		while second >= 60:
			minute += 1
			second -= 60
		minute += mins
		while minute >= 60:
			hour += 1
			minute -= 60
		hour += hours
		while hour >= 24:
			hour -= 24

	func subtract_time(hours:int, mins:int, seconds:int):
		second -= seconds
		while second < 0:
			minute -= 1
			second += 60
			minute -= mins
		while minute < 0:
			hour -= 1
			minute += 60
			hour -= hours
		while hour < 0:
			hour += 24

	func set_time(hours:int,minutes:int, seconds:int):
		hour = clampi(hours, 0, 23)
		minute = clampi(minutes, 0, 59)
		second = clampi(seconds, 0, 59)
		
		
class GDateTime:
	var year: int
	var month: int
	var day: int
	var hour: int
	var minute: int
	var second: int
	var init_values: Dictionary
	var timestamp: int
	
	func _init(y: int = 0, mo: int = 0, d: int = 0, h: int = 0, m: int = 0, s: int = 0):
		year = clampi(y,1,9999)
		month = clampi(mo,1,12)
		day = clampi(d,1,get_days_in_month(month,year))
		hour = clampi(h, 0, 23)
		minute = clampi(m, 0, 59)
		second = clampi(s, 0, 59)
		init_values = {"year":year,"month":month,"day":day,"hour":hour,"minute":minute,"second":second}
		timestamp = Time.get_unix_time_from_datetime_dict(init_values)
		var ts = {"timestamp":timestamp}
		init_values.merge(ts) 
		
	func is_leapyear(year = year) -> bool:
		if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
			return true
		else:
			return false
	
	func get_minute_of_day(hour = hour, minute = minute):
		return (hour * 60) + minute
	
	func get_second_of_day(hour = hour, minute = minute, second = second):
		return (hour * 3600) + (minute * 60) + second
	
	func get_hours_until_next_day(hour = hour):
		return 24 - hour
		
	func get_minutes_until_next_day(hour = hour, minute = minute):
		var h = get_hours_until_next_day(hour) * 60
		var m = (60-(minute)) 
		return h + m
		
	func get_seconds_until_next_day(hour = hour, minute = minute, second = second):
		var h = get_hours_until_next_day(hour) * 3600
		var m = (60 - (minute)) * 60
		var s = (60-second)
		return h + m + s
	
	func get_day_of_year(day = day,month = month, year = year):
		var x = 0
		if month == 1:
			return day
		elif (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
			for i in range(month - 1):
				x += DAYS_IN_MONTH[i-1]
			x += day
			return x
		else:
			for i in range(month - 1):
				x += DAYS_IN_MONTH[i-1]
			x += day
			return x
	
	func get_days_in_month(month: int, year: int) -> int:    
		if month in [1, 3, 5, 7, 8, 10, 12]:
			return 31
		elif month == 2:
			# Leap year check
			if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
				return 29
			else:
				return 28
		else:
			return 30
	
	func return_to_string() -> String:
		return "%02d:%02d:%02d -- %02d:%02d:%02d" % [year,month,day,hour, minute, second]
		
	func add_time(years:int, months:int, days:int,hours:int,mins:int, seconds:int):
		second += seconds
		while second >= 60:
			minute += 1
			second -= 60
		minute += mins
		while minute >= 60:
			hour += 1
			minute -= 60
		hour += hours
		while hour >= 24:
			day += 1
			hour -= 24
		year += years
		month += months
		while month > 12:
			year += 1
			month -= 12
		day += days
		while day > get_days_in_month(month,year):
			day -= get_days_in_month(month,year)
			month += 1
			if month > 12:
				month = 1
				year += 1
		
	func subtract_time(years:int, months:int, days:int, hours:int, mins:int, seconds:int):
		second -= seconds
		while second < 0:
			minute -= 1
			second += 60
			minute -= mins
		while minute < 0:
			hour -= 1
			minute += 60
			hour -= hours
		while hour < 0:
			day -= 1
			hour += 24
		year -= years
		month -= months
		while month < 1:
			year -= 1
			month += 12
		day -= days
		while day < 1:
			month -= 1
			if month < 1:
				month = 12
				year -= 1
				day += get_days_in_month(month, year)
		
	func set_datetime(years:int, months:int, days:int,hours:int,minutes:int, seconds:int):
		year = clampi(years,1,9999)
		month = clampi(months,1,12)
		day = clampi(days,1,get_days_in_month(month,year))
		hour = clampi(hours, 0, 23)
		minute = clampi(minutes, 0, 59)
		second = clampi(seconds, 0, 59)


class GDate:
	var year: int
	var month: int
	var day: int
	var init_values: Dictionary
	var timestamp: int
	
	
	func _init(y: int = 0, mo: int = 0, d: int = 0):
		year = clampi(y,1,9999)
		month = clampi(mo,1,12)
		day = clampi(d,1,get_days_in_month(month,year))
		init_values = {"year":year,"month":month,"day":day,"hour":0,"minute":0,"second":0}
		timestamp = Time.get_unix_time_from_datetime_dict(init_values) # will return the date @ 12am
		var ts = {"timestamp":timestamp}
		init_values.merge(ts)
		
	func is_leapyear(year = year) -> bool:
		if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
			return true
		else:
			return false
	
	func get_day_of_year(day = day,month = month, year = year) -> int:
		var x = 0
		if month == 1:
			return day
		elif (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
			for i in range(month - 1):
				x += DAYS_IN_MONTH[i-1]
			x += day
			return x
		else:
			for i in range(month - 1):
				x += DAYS_IN_MONTH[i-1]
			x += day
			return x

	func get_days_until_next_year(day = day,month = month, year = year):
		if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
			var x = 366 - get_day_of_year()
			return x
		else: 
			var x = 365 - get_day_of_year()
			return x

	func get_days_in_month(month: int, year: int) -> int:    
		if month in [1, 3, 5, 7, 8, 10, 12]:
			return 31
		elif month == 2:
			# Leap year check
			if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
				return 29
			else:
				return 28
		else:
			return 30
	
	func return_to_string() -> String:
		return "%02d:%02d:%02d" % [year,month,day]
		
	func add_time(years:int, months:int, days:int):
		year += years
		month += months
		while month > 12:
			year += 1
			month -= 12
		day += days
		while day > get_days_in_month(month,year):
			day -= get_days_in_month(month,year)
			month += 1
			if month > 12:
				month = 1
				year += 1
		
	func subtract_time(years:int, months:int, days:int):
		while month < 1:
			year -= 1
			month += 12
		day -= days
		while day < 1:
			month -= 1
			if month < 1:
				month = 12
				year -= 1
				day += get_days_in_month(month, year)

	func set_date(years:int, months:int, days:int):
		year = clampi(years,1,9999)
		month = clampi(months,1,12)
		day = clampi(days,1,get_days_in_month(month,year))


# Create a time object from input
func create_new_time(hour: int = 0, minute: int = 0, second: int = 0) -> GTime:
	return GTime.new(hour, minute, second)

# Create a time object with right nows time
func create_new_time_now() -> GTime:
	var x = Time.get_time_dict_from_system()
	var hour = int(x["hour"])
	var minute = int(x["minute"])
	var second = int(x["second"])
	return GTime.new(hour,minute,second)
	
func create_new_datetime(year: int = 1 ,month: int = 1, day: int = 1, hour: int = 0, minute: int = 0, second: int = 0) -> GDateTime:
	return GDateTime.new(year, month, day, hour, minute, second)
	
func create_new_datetime_now() -> GDateTime:
	var x = Time.get_datetime_dict_from_system()
	var year = int(x["year"])
	var month = int(x["month"])
	var day = int(x["day"])
	var hour = int(x["hour"])
	var minute = int(x["minute"])
	var second = int(x["second"])
	return GDateTime.new(year,month,day,hour,minute,second)
	
func create_new_date(year: int = 1 ,month: int = 1, day: int = 1) -> GDate:
	return GDate.new(year, month, day)
	
func create_new_date_now() -> GDate:
	var x = Time.get_datetime_dict_from_system()
	var year = int(x["year"])
	var month = int(x["month"])
	var day = int(x["day"])
	return GDate.new(year,month,day)
	
func convert_minutes_to_hours(minutes: int) -> Dictionary:
	var hours: int = minutes / 60
	var remaining_minutes: int = minutes % 60
	return {"hours": hours, "minutes": remaining_minutes}

func get_total_days_in_year(year: int):
	if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
		return 366
	else:
		return 365
		
	
func get_time_between_unix(unix1: int, unix2:int) -> Dictionary:
	var dif
	var mins
	var hours
	var seconds
	if unix1 > unix2:
		dif = unix1 - unix2
		mins = dif / 60
		seconds = dif - (mins * 60)
		hours = mins / 60
		mins -= hours * 60
	else:
		dif = unix2 - unix1
		mins = dif / 60
		seconds = dif - (mins * 60)
		hours = mins / 60
		mins -= hours * 60
	print("Total Seconds: " +str(dif))
	print("Hours: " +str(hours))
	print("Minutes: " +str(mins))
	print("Seconds: " +str(seconds))
	var ret_dict = {"Total Seconds": dif, "Hours": hours, "Minutes": mins, "Seconds": seconds}
	return ret_dict
		
