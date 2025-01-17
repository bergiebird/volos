To create a new Template, it must:
	1. Inherit from the Class you want to create a template for.
	2. Be placed in a directory that is CASE SENSITIVE matching this inheritence chain.

	For example:
		res://addons/_ToyBox/script_templates/CharacterBody2D/top_down_movement_template.gd
		or
		res://addons/_ToyBox/script_templates/LimboState/ls_template.gd


For more information: https://docs.godotengine.org/en/stable/tutorials/scripting/creating_script_templates.html

Will potentially add a .gdignore file to this directory so it doesn't clog up the editor but for now I'm leaving
it public.
