#vibe ~ but functional: We look through a parent's children to return a roster with the favorite at the front
#NOTE: Singleton: Taken
extends Node
var is_favorite_found:bool = false
var who: Array[String]
var roster: Array[String]
var the_fav: String


func get_roster(favorite_child:StringName, parent:Node=self)->Array[String]:
	await _are_they_safe(favorite_child,parent)
	return roster

func get_favorite(favorite_child:StringName, parent:Node=self)->String:
	await _are_they_safe(favorite_child,parent,false)
	return the_fav

func get_others(favorite_child:StringName, parent:Node=self)->Array[String]:
	await _are_they_safe(favorite_child,parent)
	roster = roster.slice(1)
	return roster


func _are_they_safe(favorite_child,parent,just_favorite=true):
	roster.clear()
	for child in parent.get_children():
		if child.name == favorite_child:
			the_fav = child.name
			if just_favorite: roster.push_front(the_fav)
		else:
			if just_favorite: roster.push_back(child.name)

########################

func roll_call():
	whos_my_favorite()
	and_of_course()

func whos_my_favorite():
	print_rich("[rainbow]~~~~~~[/rainbow]")
	print_rich("[shake][rainbow]", roster[0], "![/rainbow]")
	print_rich("[rainbow]~~~~~~[/rainbow]\n")

func and_of_course():
	print("oh yeah, and:  \n", ", ".join(roster.filter(func(item): return roster.find(item) != 0)))
	print("\n",roster)
