extends RichTextLabel

@onready var blue_sky_share = %BlueSkyShare
@onready var twitter_share = %TwitterShare
@onready var links_para_compartir = %LinksParaCompartir

func _ready():
	visible = false
	links_para_compartir.visible = false

func aparecer():
	visible = true
	var texto_para_redes: String
	var cantidad_remeras = %RemerasConseguidas.cantidad
	if cantidad_remeras == 0:
		text = "[center]Mejor suerte la proxima :([/center]"
		texto_para_redes = "No le pude manguear ninguna remera a Borza D:"
	elif cantidad_remeras == 1:
		text = "[center]¡¡Conseguiste 1\nremera!![/center]"
		texto_para_redes = "Le mangueé una remera a Borza"
	else:
		text = "[center]¡¡Conseguiste [wave]%d[/wave]\nremeras!![/center]" % cantidad_remeras
		texto_para_redes = "Le mangueé %d remeras a Borza :D" % cantidad_remeras
	blue_sky_share.uri =\
		("https://bsky.app/intent/compose?text=%s. https://j9794.itch.io/borza-pocket" % texto_para_redes).xml_escape()
	twitter_share.uri =\
		("https://twitter.com/intent/tweet?text=%s. https://j9794.itch.io/borza-pocket" % texto_para_redes).xml_escape()
	await create_tween().tween_property(self, "visible_ratio", 1.0, 3.0).from(0.0).finished
	await get_tree().create_timer(0.5).timeout
	links_para_compartir.visible = true
