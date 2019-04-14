extends Node

var actual_scene = null

func _ready():
	var root = get_tree().get_root()
	actual_scene = root.get_child(root.get_child_count() -1 )
	

# Esta función usualmente sera llamada de una señal de
# callback, o alguna otra función de la escena
# que esta corriendo borrar la escena actual en este punto
# puede ser una mala idea, porque puede estar dentro de una
# llamada de retorno o función de ella. El peor caso va a
# ser que se cuelgue o comportamiento no esperado.
# La forma de evitar esto es difiriendo la carga para mas
# tarde, cuando es seguro que ningún código de la escena
# actual esta corriendo:

func go_to_scene(path):
	call_deferred("_go_to_scene_deferred", path)

func _go_to_scene_deferred(path):
	# Inmediatamente libera la escena actual,
	# no hay riesgo aquí.
	actual_scene.free()
	
	# Carga la nueva escena
	var s = ResourceLoader.load(path)
	
	# Instancia la nueva escena
	actual_scene = s.instance()
	
	# Lo agrega a la escena activa, como hijo de root
	get_tree().get_root().add_child(actual_scene)
	
	# Opcional, para hacerlo compatible con la API SceneTree.change_scene()
	get_tree().set_current_scene(actual_scene)


