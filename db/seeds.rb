# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Slot.create(date: '22-01-2015', start_hour: 900, end_hour: 1000, room: 'Meeting Room 2', user: 2, comment: 'Project planning')
Slot.create(date: '22-01-2015', start_hour: 1200, end_hour: 1500, room: 'Meeting Room 2', user: 2, comment: 'Project planning')
Slot.create(date: '22-01-2015', start_hour: 1500, end_hour: 1600, room: 'Meeting Room 1', user: 3, comment: 'Project planning')
