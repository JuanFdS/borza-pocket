extends GPUParticles2D

func _ready():
	finished.connect(func(): self.queue_free())
