extends Node

# Time tracking class that provides similar functionality to Python's pendulum
class_name GDDateTime


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
	
	func return_to_string() -> String:
		return "%02d:%02d:%02d" % [hour, minute, second]
		
	func add_time(hours:int,mins:int, seconds:int):
		while second + seconds > 59:
			minute + 1
			seconds -= 60
		while minute + mins > 59:
			hours += 1
			mins -= 60
		hour += hours
		minute += mins
		second += seconds
		
	func subtract_time(hours:int, mins:int, seconds:int):
		while seconds > second:
			minute -= 1
			second += 60
		while mins > minute:
			hour -= 1
			minute += 60
		hour -= hours
		minute -= mins
		second -= seconds
		
	func set_time(hours:int,minutes:int, seconds:int):
		hour = clampi(hours, 0, 23)
		minute = clampi(minutes, 0, 59)
		second = clampi(seconds, 0, 59)
		
		
class GDateTime:
	var year: int
	var month: Time.Month
	var day: int
	var hour: int
	var minute: int
	var second: int
	var init_values: Dictionary
	var timestamp: int
	
	
	func _init(y: int = 0, mo: Time.Month = 0, d: int = 0, h: int = 0, m: int = 0, s: int = 0):
		year = clampi(y,1,9999)
		month = clampi(mo,1,12)
		day = clampi(d,1,23)
		hour = clampi(h, 0, 23)
		minute = clampi(m, 0, 59)
		second = clampi(s, 0, 59)
		init_values = {"year":year,"month":month,"day":day,"hour":hour,"minute":minute,"second":second}
		timestamp = Time.get_unix_time_from_datetime_dict(init_values)
		var ts = {"timestamp":timestamp}
		init_values.merge(ts) 
	
	func return_to_string() -> String:
		return "%02d:%02d:%02d -- %02d:%02d:%02d" % [year,month,day,hour, minute, second]
		
	func add_time(years:int, months:int, days:int,hours:int,mins:int, seconds:int):
		while second + seconds > 59:
			minute + 1
			seconds -= 60
		while minute + mins > 59:
			hours += 1
			mins -= 60
		while hour + hours > 23:
			day += 1
			hours -= 24
		while day + days > 30:
			month += 1
			days -= 30
		while month + months > 12:
			year += 1
			months -= 12
		year += years
		month += months
		day += days
		hour += hours
		minute += mins
		second += seconds
		
	func subtract_time(years:int, months:int, days:int, hours:int, mins:int, seconds:int):
		while seconds > second:
			minute -= 1
			second += 60
		while mins > minute:
			hour -= 1
			minute += 60
		while hours > hour:
			day -= 1
			hour += 24
		while days > day:
			month -= 1
			day += 30
		while months > month:
			year -= 1
			month += 12
		year -= years
		month -= months
		day -= days
		hour -= hours
		minute -= mins
		second -= seconds
		
	func set_datetime(years:int, months:Time.Month, days:int,hours:int,minutes:int, seconds:int):
		year = clampi(years,1,9999)
		month = clampi(months,1,12)
		day = clampi(days,1,23)
		hour = clampi(hours, 0, 23)
		minute = clampi(minutes, 0, 59)
		second = clampi(seconds, 0, 59)


class GDate:
	var year: int
	var month: Time.Month
	var day: int
	var init_values: Dictionary
	var timestamp: int
	
	
	func _init(y: int = 0, mo: Time.Month = 0, d: int = 0):
		year = clampi(y,1,9999)
		month = clampi(mo,1,12)
		day = clampi(d,1,23)
		init_values = {"year":year,"month":month,"day":day,"hour":0,"minute":0,"second":0}
		timestamp = Time.get_unix_time_from_datetime_dict(init_values) # will return the date @ 12am
		var ts = {"timestamp":timestamp}
		init_values.merge(ts) 
	
	func return_to_string() -> String:
		return "%02d:%02d:%02d" % [year,month,day]
		
	func add_time(years:int, months:int, days:int):
		while day + days > 30:
			month += 1
			days -= 30
		while month + months > 12:
			year += 1
			months -= 12
		year += years
		month += months
		day += days
		
	func subtract_time(years:int, months:int, days:int):
		while days > day:
			month -= 1
			day += 30
		while months > month:
			year -= 1
			month += 12
			
		year -= years
		month -= months
		day -= days


	func set_date(years:int, months:Time.Month, days:int):
		year = clampi(years,1,9999)
		month = clampi(months,1,12)
		day = clampi(days,1,23)




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
	
func create_new_datetime(year: int = 1 ,month: Time.Month = 1, day: int = 1, hour: int = 0, minute: int = 0, second: int = 0) -> GDateTime:
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
	
func create_new_date(year: int = 1 ,month: Time.Month = 1, day: int = 1) -> GDate:
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
	
