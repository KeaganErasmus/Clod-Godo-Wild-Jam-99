extends CharacterBody2D

var velocity_factor: float = 50

func _digging_particles(enabled: bool):
	$CPUParticles2D.emitting = enabled

func _set_particle_velocity_max(velocity: float):
	$CPUParticles2D.initial_velocity_max = velocity_factor * velocity
