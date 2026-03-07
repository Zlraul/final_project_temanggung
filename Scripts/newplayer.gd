extends CharacterBody2D

@onready var animasi: AnimatedSprite2D = $AnimatedSprite2D

const SHORT_JUMP_VELOCITY = -220.0  # untuk lompat pendek
const MAX_JUMP_VELOCITY = -350.0    # untuk lompat jauh 
var GRAVITY = 980.0                 # gravitasi normal
var JUMP_HOLD_GRAVITY = 350.0       # gravitasi untuk lompat jauh

var is_jumping: bool = false        # untuk mengecek apakah karakter melompat atau tidak
var was_on_floor: bool = false      # untuk mengecek apakah sebelumnya di lantai atau tidak

func _ready():
	animasi.play("berdiri")  

func _physics_process(delta: float) -> void:
	# pengecekan apakah player ada di lantai atau tidak
	# dan di simpan di dalam variabel was_on_floor
	was_on_floor = is_on_floor()
	
	# gravitasi standar
	if not is_on_floor():
		if is_jumping and Input.is_action_pressed("lompat") and velocity.y < 0:
			velocity.y += JUMP_HOLD_GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		is_jumping = false  # Reset when landing
		animasi.play("berlari")
	# pertama di cek jika karakter tidak berada di lantai tapi
	# tombol lompat masih di tahan maka gravitasi yang akan di pakai
	# adalah JUMP_HOLD_GRAVITY atau gravitasi untuk lompatan yang ditahan
	# namun jika tidak maka gravitasi yang digunakan adalah gravitasi normal
	# setelah itu di bagian terkhir adalah jika karakter ada di lantai maka
	# variabel is_jumping di buat menjadi false dan animasi yang di jalankan
	# adalah animasi berlari.
	
	# menjalankan fungsi yang menghandle lompat
	handle_jump()
	
	# logika animasi
	if velocity.y > 0 and not is_on_floor():
		animasi.play("jatuh")
	elif not is_on_floor():
		animasi.play("melompat_2")
	elif Input.is_action_just_pressed("lompat") and is_on_floor():
		animasi.play("melompat")
	# velocity y lebih dari 0 dan tidak di lantai menandakan 
	# bahwa karakter sedang jatuh. 
	
	move_and_slide()

func handle_jump() -> void:
	if Input.is_action_just_pressed("lompat") and is_on_floor():
		velocity.y = SHORT_JUMP_VELOCITY
		is_jumping = true
		animasi.play("melompat")
	# di dalam fungsi ini dijalankan logika untuk melompat di
	# saat tombol lompat di tekan dan karakter berada di lantai
	# maka velocity y yang di gunakan adalah yang untuk lompat pendek
	# lalu variabel is_jumping di ganti menjadi true, lalu animasi yang
	# di mainkan adalah animasi melompat.
	
func is_player(): # bagian ini untuk menandakan bahwa node ini adalah pelayer
	pass
	
