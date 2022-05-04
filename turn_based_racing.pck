GDPC                                                                               <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�      �      &�y���ڞu;>��.p    res://assets/environment.tres         Y      ��h��ˇ�x0H��    res://assets/shader/ground.tres p      c      MZ��i~K3�W�(G
     res://assets/shader/player.tres �      /      ���[_�+Eb�M    res://assets/shader/target.tres       �      y� "ܻ��6=m�Yُ�    res://assets/shader/wall.tres   �      �       ��$�7l���t��t�   res://icon.png   Y      �      G1?��z�c��vN��   res://icon.png.import   �      �      ��fe��6�B��^ U�   res://main/map.gd.remap �X      #       �P�&�,y��{P
�   res://main/map.gdc  @      G      ]4�s
�/���qw;�   res://main/map.tscn �      	      n����OC�?I�^.t�   res://main/player.gd.remap  �X      &       1L(I6�KvG��eTR   res://main/player.gdc   �"            {��݃�5����I�~   res://main/player.tscn  �(      �
      �:�])�zO)[qx   res://main/target.gd.remap  �X      &       sT�^�}���o��   res://main/target.gdc   �3      �      }�*'��9� ��z�   res://main/target.tscn   5      P      ]:�uY�:3@�nb�2�   res://map/basic_loop.tscn   p7      !      S�<��9��R����   res://project.binaryf      :      �da���NL1E�����[gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 1
background_sky = SubResource( 1 )
ambient_light_color = Color( 1, 1, 1, 1 )
glow_enabled = true
glow_blend_mode = 0
glow_hdr_threshold = 0.25
glow_hdr_scale = 1.0
glow_bicubic_upscale = true
glow_high_quality = true
       [gd_resource type="ShaderMaterial" load_steps=2 format=2]

[sub_resource type="Shader" id=1]
code = "shader_type spatial;
render_mode world_vertex_coords;



uniform vec4 colour : hint_color = vec4(vec3(0.0, 1.0, 0.0), 1.0);

varying vec3 vtx;



void vertex() {
	vtx = VERTEX;
}



void fragment() {
	float dist = max(
		max(
			mod(vtx.x, 1.0),
			1.0 - mod(vtx.x, 1.0)
		),
		max(
			mod(vtx.z, 1.0),
			1.0 - mod(vtx.z, 1.0)
		)
	);
	dist   = dist * 2.0 - 1.0;
	dist   = pow(dist, 25.0);
	ALBEDO = vec3(dist) * colour.rgb;
}
"

[resource]
shader = SubResource( 1 )
shader_param/colour = Color( 0, 1, 0, 1 )
             [gd_resource type="ShaderMaterial" load_steps=2 format=2]

[sub_resource type="Shader" id=1]
code = "shader_type spatial;



uniform vec3  scale                               = vec3(0.5);
uniform float width       : hint_range(0.0, 10.0) = 0.1;
uniform float sharpness   : hint_range(0.0, 1.0)  = 0.0;
uniform vec4  glow_colour : hint_color            = vec4(vec3(1.0, 0.0, 0.0), 1.0);
uniform vec4  colour      : hint_color            = vec4(vec3(0.0, 0.0, 0.0), 1.0);

varying vec3 vert;
varying vec3 normal;



void vertex(){
	VERTEX += sign(VERTEX) * (scale - 1.0) * 0.5;
	vert   = VERTEX;
	normal = abs(NORMAL);
}



void fragment() {
	vec3 fv  = fract(vec3(vert.x, vert.y * -1.0, vert.z));
	vec3 vs  = abs(vert) - scale * 0.5;
	float ws = width * sharpness;
	ALBEDO   = (colour.rgb * normal.x + colour.rgb * normal.y + colour.rgb * normal.z) * float(width < length(vs.xy)) * float(width < length(vs.yz)) * float(width < length(vs.xz));
	EMISSION = (1.0 - smoothstep(ws, width, length(vs.xy)) * smoothstep(ws, width, length(vs.yz)) * smoothstep(ws, width, length(vs.xz))) * glow_colour.rgb;
}
"

[resource]
shader = SubResource( 1 )
shader_param/scale = Vector3( 0.5, 0.5, 0.5 )
shader_param/width = 0.1
shader_param/sharpness = 0.0
shader_param/glow_colour = Color( 1, 0, 0, 1 )
shader_param/colour = Color( 0, 0, 0, 1 )
 [gd_resource type="ShaderMaterial" load_steps=2 format=2]

[sub_resource type="Shader" id=1]
code = "shader_type spatial;



float fresnel(float amount, vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}



void fragment() {
	float value = fresnel(2.0, NORMAL, VIEW);
	value       = clamp(value, 0.0, 1.0);
	ALBEDO = vec3(1.0);
	ALPHA  = value;
}
"

[resource]
shader = SubResource( 1 )
            [gd_resource type="ShaderMaterial" load_steps=2 format=2]

[sub_resource type="Shader" id=1]
code = "shader_type spatial;



void fragment() {
	ALBEDO = vec3(0.01);
}
"

[resource]
shader = SubResource( 1 )
 GDST@   @            �  WEBPRIFF�  WEBPVP8L�  /?����m��������_"�0@��^�"�v��s�}� �W��<f��Yn#I������wO���M`ҋ���N��m:�
��{-�4b7DԧQ��A �B�P��*B��v��
Q�-����^R�D���!(����T�B�*�*���%E["��M�\͆B�@�U$R�l)���{�B���@%P����g*Ųs�TP��a��dD
�6�9�UR�s����1ʲ�X�!�Ha�ߛ�$��N����i�a΁}c Rm��1��Q�c���fdB�5������J˚>>���s1��}����>����Y��?�TEDױ���s���\�T���4D����]ׯ�(aD��Ѓ!�a'\�G(��$+c$�|'�>����/B��c�v��_oH���9(l�fH������8��vV�m�^�|�m۶m�����q���k2�='���:_>��������á����-wӷU�x�˹�fa���������ӭ�M���SƷ7������|��v��v���m�d���ŝ,��L��Y��ݛ�X�\֣� ���{�#3���
�6������t`�
��t�4O��ǎ%����u[B�����O̲H��o߾��$���f���� �H��\��� �kߡ}�~$�f���N\�[�=�'��Nr:a���si����(9Lΰ���=����q-��W��LL%ɩ	��V����R)�=jM����d`�ԙHT�c���'ʦI��DD�R��C׶�&����|t Sw�|WV&�^��bt5WW,v�Ş�qf���+���Jf�t�s�-BG�t�"&�Ɗ����׵�Ջ�KL�2)gD� ���� NEƋ�R;k?.{L�$�y���{'��`��ٟ��i��{z�5��i������c���Z^�
h�+U�mC��b��J��uE�c�����h��}{�����i�'�9r�����ߨ򅿿��hR�Mt�Rb���C�DI��iZ�6i"�DN�3���J�zڷ#oL����Q �W��D@!'��;�� D*�K�J�%"�0�����pZԉO�A��b%�l�#��$A�W�A�*^i�$�%a��rvU5A�ɺ�'a<��&�DQ��r6ƈZC_B)�N�N(�����(z��y�&H�ض^��1Z4*,RQjԫ׶c����yq��4���?�R�����0�6f2Il9j��ZK�4���է�0؍è�ӈ�Uq�3�=[vQ�d$���±eϘA�����R�^��=%:�G�v��)�ǖ/��RcO���z .�ߺ��S&Q����o,X�`�����|��s�<3Z��lns'���vw���Y��>V����G�nuk:��5�U.�v��|����W���Z���4�@U3U�������|�r�?;�
         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDSC                  ������ڶ   �����¶�   ����¶��   ���������¶�   ��������������������ض��   �����������ζ���   �����������   ������Ҷ   �������������¶�   ���������������۶���   �����ض�   �����׶�   �����������������ض�   ��������������ض   ������ٶ   �����������������ڶ�   ���������������������۶�   �������������������Ӷ���   �����������Ѷ���   �����¶�   �����������Ķ���   �����¶�   ������Ҷ     �B                                           $      7   	   J   
   Q      X      c      o      w      }      3YYYY0�  P�  V�  QV�  &P�  4�  QV�  &P�  T�  �  �  T�  QV�  W�  T�	  T�
  W�  �  T�  P�  T�  Q�  W�  T�  W�  �  T�  P�  T�  Q�  W�  T�  PQ�  W�  T�  PQ�  &PW�  T�  PQQV�  ;�  VW�  T�  PQ�  &P�  4�  QV�  �  T�  PQY`         [gd_scene load_steps=6 format=2]

[ext_resource path="res://assets/shader/ground.tres" type="Material" id=1]
[ext_resource path="res://main/player.tscn" type="PackedScene" id=2]
[ext_resource path="res://main/map.gd" type="Script" id=3]
[ext_resource path="res://map/basic_loop.tscn" type="PackedScene" id=4]

[sub_resource type="PlaneMesh" id=1]
material = ExtResource( 1 )
size = Vector2( 50, 50 )

[node name="world" type="Spatial"]
script = ExtResource( 3 )

[node name="ground" type="MeshInstance" parent="."]
mesh = SubResource( 1 )
material/0 = null

[node name="map" type="Spatial" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.25, 0 )

[node name="basic_loop" parent="map" instance=ExtResource( 4 )]

[node name="players" type="Spatial" parent="."]

[node name="player" parent="players" instance=ExtResource( 2 )]

[node name="camera" type="Spatial" parent="."]

[node name="camera" type="Camera" parent="camera"]
transform = Transform( -4.37114e-08, 1, 4.37114e-08, 0, -4.37114e-08, 1, 1, 4.37114e-08, 1.91069e-15, 0, 10, 0 )
projection = 1
size = 15.0

[node name="ground_control" type="RemoteTransform" parent="camera"]
transform = Transform( -4.37114e-08, 1, 4.37114e-08, 0, -4.37114e-08, 1, 1, 4.37114e-08, 1.91069e-15, 0, 0, 0 )
remote_path = NodePath("../../ground")
update_rotation = false
update_scale = false

[node name="camera_raycast" type="RayCast" parent="."]
enabled = true
exclude_parent = false
cast_to = Vector3( 0, 0, 0 )
collision_mask = 2
collide_with_areas = true
collide_with_bodies = false
       GDSC   "      '        ������ڶ   �������ض���   ��������   �������϶���   ������������ض��   ��������������ض   ���������������Ŷ���   ����׶��   �������������ض�   �������������������϶���   ����������ض   ζ��   ϶��   ����ض��   �����������䶶��   ����¶��   ����������¶   �������ض���   ����Ӷ��   ����Ӷ��   ̶��   �����޶�   �����¶�   �����Ķ�   �����׶�   �������Ӷ���   �����Ӷ�   ���������������۶���   �����ض�   ����������ٶ   ��������ض��   ���׶���   ���Ӷ���   �������ڶ���      translation              ?             @      ../../camera     �@                                                    	   &   
   '      (      )      2      :      >      D      I      Y      \      b      d      k      |      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   	  &     '   3YYYY;�  V�  �  T�  Y;�  V�  �  T�  YY;�  V�  �  Y;�  V�  �  YYYY0�  P�  V�  QV�  &P�  �  QV�  �  �  �  W�  T�	  P�  RR�  �
  R�  P�  T�  R�  R�  T�  QR�  �  R�  �  T�  R�  �  Q�  W�  T�  PQ�  W�  T�  T�  Z�  �  T�  PQ�  W�  T�  T�  �  T�  PQ�  W�  T�
  �  P�  T�  R�  R�  T�  Q�  W�  T�
  �  P�  T�  R�  R�  T�  Q�  �  ;�  V�  P�  Q�  ;�  V�  �  T�
  �  ;�  V�  W�  T�  T�  �  �  T�
  �  T�#  P�  R�  T�  P�  Q�  �  QYYYY0�  P�  V�   QV�  �  �  �  W�  T�!  PQ�  �
  �  P�  T�  R�  R�  T�  Q�  �  �  T�  Y`   [gd_scene load_steps=7 format=2]

[ext_resource path="res://assets/shader/player.tres" type="Material" id=1]
[ext_resource path="res://main/player.gd" type="Script" id=2]
[ext_resource path="res://main/target.tscn" type="PackedScene" id=3]

[sub_resource type="CubeMesh" id=2]
material = ExtResource( 1 )
size = Vector3( 1, 1, 1 )

[sub_resource type="ConvexPolygonShape" id=4]
points = PoolVector3Array( -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, -0.5 )

[sub_resource type="CubeMesh" id=3]
size = Vector3( 0.1, 0.1, 1 )

[node name="player" type="Area"]
script = ExtResource( 2 )

[node name="mesh" type="MeshInstance" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.25, 0 )
mesh = SubResource( 2 )
skeleton = NodePath("../../..")
material/0 = null

[node name="shape" type="CollisionShape" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.25, 0 )
shape = SubResource( 4 )

[node name="arrow_pivot" type="Spatial" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 )

[node name="arrow" type="MeshInstance" parent="arrow_pivot"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.05, 0.5 )
mesh = SubResource( 3 )
skeleton = NodePath("")
material/0 = null

[node name="target" type="Spatial" parent="."]

[node name="offset" type="Spatial" parent="target"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.675, 0 )

[node name="up_left" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1 )

[node name="up" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1 )

[node name="up_right" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -1, 0, 1 )

[node name="left" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0 )

[node name="center" parent="target/offset" instance=ExtResource( 3 )]

[node name="right" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -1, 0, 0 )

[node name="down_left" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, -1 )

[node name="down" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, -1 )

[node name="down_right" parent="target/offset" instance=ExtResource( 3 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -1, 0, -1 )

[node name="center" type="Spatial" parent="."]

[node name="position_tween" type="Tween" parent="."]

[connection signal="body_entered" from="." to="." method="collision"]
   GDSC          
   >      ���׶���   �����¶�   ������Ҷ   �����Ķ�   ���������¶�   �������϶���   ����������ض   ζ��   ̶��   ��������������ض   �������ض���                                           ,      4   	   <   
   3Y2�  YYY0�  PQV�  ;�  V�  PQT�  PQT�  PQ�  �  T�  �  P�  T�  R�  T�  Q�  �  T�	  �  T�
  �  �  T�
  �  T�  Y`           [gd_scene load_steps=5 format=2]

[ext_resource path="res://assets/shader/target.tres" type="Material" id=1]
[ext_resource path="res://main/target.gd" type="Script" id=2]

[sub_resource type="SphereMesh" id=4]
material = ExtResource( 1 )
radius = 0.375
height = 0.75

[sub_resource type="SphereShape" id=5]
radius = 0.18

[node name="target" type="Area"]
collision_layer = 2
collision_mask = 0
script = ExtResource( 2 )

[node name="mesh" type="MeshInstance" parent="."]
mesh = SubResource( 4 )
material/0 = null

[node name="shape" type="CollisionShape" parent="."]
shape = SubResource( 5 )
[gd_scene load_steps=20 format=2]

[ext_resource path="res://assets/shader/wall.tres" type="Material" id=1]

[sub_resource type="CubeMesh" id=2]
material = ExtResource( 1 )
size = Vector3( 1, 1, 10 )

[sub_resource type="ConvexPolygonShape" id=8]
points = PoolVector3Array( -0.5, 0.5, -4.78478, 0.5, 0.357087, 4.78478, 0.5, -0.5, 4.78478, -0.5, -0.5, 4.78478, 0.5, -0.5, -4.78478, -0.5, 0.5, 4.78478, -0.5, -0.5, -4.78478, 0.5, 0.404757, -4.78478, 0.499902, 0.5, 4.78478 )

[sub_resource type="CubeMesh" id=3]
material = ExtResource( 1 )
size = Vector3( 1, 1, 7.5 )

[sub_resource type="ConvexPolygonShape" id=9]
points = PoolVector3Array( -0.5, -0.499998, -3.61572, 0.499908, 0.5, 3.46835, 0.5, -0.479286, 3.469, -0.5, -0.499998, 3.61572, -0.479294, 0.5, 3.46903, 0.499908, 0.5, -3.46835, 0.5, -0.479286, -3.469, -0.479294, 0.5, -3.46903 )

[sub_resource type="ConvexPolygonShape" id=10]
points = PoolVector3Array( -0.5, 0.5, -4.78478, 0.5, 0.357087, 4.78478, 0.5, -0.5, 4.78478, -0.5, -0.5, 4.78478, 0.5, -0.5, -4.78478, -0.5, 0.5, 4.78478, -0.5, -0.5, -4.78478, 0.5, 0.404757, -4.78478, 0.499902, 0.5, 4.78478 )

[sub_resource type="ConvexPolygonShape" id=11]
points = PoolVector3Array( -0.5, 0.5, -4.78478, 0.5, 0.357087, 4.78478, 0.5, -0.5, 4.78478, -0.5, -0.5, 4.78478, 0.5, -0.5, -4.78478, -0.5, 0.5, 4.78478, -0.5, -0.5, -4.78478, 0.5, 0.404757, -4.78478, 0.499902, 0.5, 4.78478 )

[sub_resource type="CubeMesh" id=4]
material = ExtResource( 1 )
size = Vector3( 1, 1, 7.5 )

[sub_resource type="ConvexPolygonShape" id=12]
points = PoolVector3Array( -0.5, -0.499998, -3.61572, 0.499908, 0.5, 3.46835, 0.5, -0.479286, 3.469, -0.5, -0.499998, 3.61572, -0.479294, 0.5, 3.46903, 0.499908, 0.5, -3.46835, 0.5, -0.479286, -3.469, -0.479294, 0.5, -3.46903 )

[sub_resource type="CubeMesh" id=5]
material = ExtResource( 1 )
size = Vector3( 1, 1, 12.5 )

[sub_resource type="ConvexPolygonShape" id=13]
points = PoolVector3Array( -0.5, -0.499997, -5.94901, 0.499899, 0.5, 5.73631, 0.5, -0.481896, 5.73749, -0.5, -0.499997, 5.94901, -0.481896, 0.5, 5.73744, 0.499995, 0.5, -5.73744, 0.5, -0.481896, -5.73749, -0.481896, 0.5, -5.73744 )

[sub_resource type="ConvexPolygonShape" id=14]
points = PoolVector3Array( -0.5, 0.5, -4.78478, 0.5, 0.357087, 4.78478, 0.5, -0.5, 4.78478, -0.5, -0.5, 4.78478, 0.5, -0.5, -4.78478, -0.5, 0.5, 4.78478, -0.5, -0.5, -4.78478, 0.5, 0.404757, -4.78478, 0.499902, 0.5, 4.78478 )

[sub_resource type="ConvexPolygonShape" id=15]
points = PoolVector3Array( -0.5, -0.499997, -5.94901, 0.499899, 0.5, 5.73631, 0.5, -0.481896, 5.73749, -0.5, -0.499997, 5.94901, -0.481896, 0.5, 5.73744, 0.499995, 0.5, -5.73744, 0.5, -0.481896, -5.73749, -0.481896, 0.5, -5.73744 )

[sub_resource type="CubeMesh" id=6]
material = ExtResource( 1 )
size = Vector3( 1, 1, 9 )

[sub_resource type="ConvexPolygonShape" id=16]
points = PoolVector3Array( -0.5, -0.5, -4.30913, 0.5, 0.5, 4.45277, 0.483607, -0.5, 4.30913, 0.5, 0.5, -4.45277, -0.5, 0.483607, 4.30913, 0.483607, -0.5, -4.30913, -0.5, 0.483607, -4.30913, -0.5, -0.5, 4.30913 )

[sub_resource type="ConvexPolygonShape" id=17]
points = PoolVector3Array( -0.5, -0.499997, -5.94901, 0.499899, 0.5, 5.73631, 0.5, -0.481896, 5.73749, -0.5, -0.499997, 5.94901, -0.481896, 0.5, 5.73744, 0.499995, 0.5, -5.73744, 0.5, -0.481896, -5.73749, -0.481896, 0.5, -5.73744 )

[sub_resource type="ConvexPolygonShape" id=18]
points = PoolVector3Array( -0.5, -0.499997, -5.94901, 0.499899, 0.5, 5.73631, 0.5, -0.481896, 5.73749, -0.5, -0.499997, 5.94901, -0.481896, 0.5, 5.73744, 0.499995, 0.5, -5.73744, 0.5, -0.481896, -5.73749, -0.481896, 0.5, -5.73744 )

[sub_resource type="CubeMesh" id=7]
material = ExtResource( 1 )
size = Vector3( 1, 1, 4 )

[sub_resource type="ConvexPolygonShape" id=19]
points = PoolVector3Array( 0.499962, 0.5, 1.91364, -0.5, -0.499999, -1.94843, -0.490992, 0.5, -1.91364, -0.5, -0.499999, 1.94843, 0.5, -0.491029, -1.91378, 0.5, -0.491029, 1.91378, -0.490992, 0.5, 1.91364, 0.499962, 0.5, -1.91364 )

[node name="basic_loop" type="StaticBody"]

[node name="1" type="MeshInstance" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -3, 0, 0 )
mesh = SubResource( 2 )
material/0 = null

[node name="CollisionShape" type="CollisionShape" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -3, 0, 0 )
shape = SubResource( 8 )

[node name="2" type="MeshInstance" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 3, 0, 0 )
mesh = SubResource( 3 )
material/0 = null

[node name="CollisionShape2" type="CollisionShape" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 3, 0, 0 )
shape = SubResource( 9 )

[node name="3" type="MeshInstance" parent="."]
transform = Transform( 0.907543, 0, 0.419959, 0, 1, 0, -0.419959, 0, 0.907543, -0.942556, 0, 9.31458 )
mesh = SubResource( 2 )
material/0 = null

[node name="CollisionShape3" type="CollisionShape" parent="."]
transform = Transform( 0.907543, 0, 0.419959, 0, 1, 0, -0.419959, 0, 0.907543, -0.942556, 0, 9.31458 )
shape = SubResource( 10 )

[node name="4" type="MeshInstance" parent="."]
transform = Transform( 0.711499, 0, 0.702687, 0, 1, 0, -0.702687, 0, 0.711499, 6.38293, 0, 6.95866 )
mesh = SubResource( 2 )
material/0 = null

[node name="CollisionShape4" type="CollisionShape" parent="."]
transform = Transform( 0.711499, 0, 0.702687, 0, 1, 0, -0.702687, 0, 0.711499, 6.38293, 0, 6.95866 )
shape = SubResource( 11 )

[node name="5" type="MeshInstance" parent="."]
transform = Transform( 0.326773, 0, 0.945103, 0, 1, 0, -0.945103, 0, 0.326773, 4.40205, 0, 14.8108 )
mesh = SubResource( 4 )
material/0 = null

[node name="CollisionShape5" type="CollisionShape" parent="."]
transform = Transform( 0.326773, 0, 0.945103, 0, 1, 0, -0.945103, 0, 0.326773, 4.40205, 0, 14.8108 )
shape = SubResource( 12 )

[node name="6" type="MeshInstance" parent="."]
transform = Transform( -0.354927, 0, 0.934894, 0, 1, 0, -0.934894, 0, -0.354927, 13.4409, 0, 13.8103 )
mesh = SubResource( 5 )
material/0 = null

[node name="CollisionShape6" type="CollisionShape" parent="."]
transform = Transform( -0.354927, 0, 0.934894, 0, 1, 0, -0.934894, 0, -0.354927, 13.4409, 0, 13.8103 )
shape = SubResource( 13 )

[node name="7" type="MeshInstance" parent="."]
transform = Transform( -0.999631, 0, -0.0271715, 0, 1, 0, 0.0271715, 0, -0.999631, 9.91577, 0, 5.85373 )
mesh = SubResource( 2 )
material/0 = null

[node name="CollisionShape7" type="CollisionShape" parent="."]
transform = Transform( -0.999631, 0, -0.0271715, 0, 1, 0, 0.0271715, 0, -0.999631, 9.91577, 0, 5.85373 )
shape = SubResource( 14 )

[node name="8" type="MeshInstance" parent="."]
transform = Transform( -0.99991, 0, 0.0134386, 0, 1, 0, -0.0134386, 0, -0.99991, 19.0427, 0, 5.79822 )
mesh = SubResource( 5 )
material/0 = null

[node name="CollisionShape8" type="CollisionShape" parent="."]
transform = Transform( -0.99991, 0, 0.0134386, 0, 1, 0, -0.0134386, 0, -0.99991, 19.0427, 0, 5.79822 )
shape = SubResource( 15 )

[node name="9" type="MeshInstance" parent="."]
transform = Transform( -0.598073, 0, -0.801442, 0, 1, 0, 0.801442, 0, -0.598073, 6.39626, 0, -1.4728 )
mesh = SubResource( 6 )
material/0 = null

[node name="CollisionShape9" type="CollisionShape" parent="."]
transform = Transform( -0.598073, 0, -0.801442, 0, 1, 0, 0.801442, 0, -0.598073, 6.39626, 0, -1.4728 )
shape = SubResource( 16 )

[node name="10" type="MeshInstance" parent="."]
transform = Transform( -0.729828, 0, -0.683631, 0, 1, 0, 0.683631, 0, -0.729828, 14.9725, 0, -4.67708 )
mesh = SubResource( 5 )
material/0 = null

[node name="CollisionShape10" type="CollisionShape" parent="."]
transform = Transform( -0.729828, 0, -0.683631, 0, 1, 0, 0.683631, 0, -0.729828, 14.9725, 0, -4.67708 )
shape = SubResource( 17 )

[node name="11" type="MeshInstance" parent="."]
transform = Transform( 0.105084, 0, -0.994463, 0, 1, 0, 0.994463, 0, 0.105084, 4.91172, 0, -8.42156 )
mesh = SubResource( 5 )
material/0 = null

[node name="CollisionShape11" type="CollisionShape" parent="."]
transform = Transform( 0.105084, 0, -0.994463, 0, 1, 0, 0.994463, 0, 0.105084, 4.91172, 0, -8.42156 )
shape = SubResource( 18 )

[node name="12" type="MeshInstance" parent="."]
transform = Transform( 0.885102, 0, -0.465398, 0, 1, 0, 0.465398, 0, 0.885102, -2.13481, 0, -6.53715 )
mesh = SubResource( 7 )
material/0 = null

[node name="CollisionShape12" type="CollisionShape" parent="."]
transform = Transform( 0.885102, 0, -0.465398, 0, 1, 0, 0.465398, 0, 0.885102, -2.13481, 0, -6.53715 )
shape = SubResource( 19 )
       [remap]

path="res://main/map.gdc"
             [remap]

path="res://main/player.gdc"
          [remap]

path="res://main/target.gdc"
          �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      _global_script_classes�                     class         Target        language      GDScript      path      res://main/target.gd      base      Area   _global_script_class_icons                Target            application/config/name         Turn Based Racing      application/run/main_scene         res://main/map.tscn    application/config/icon         res://icon.png  )   physics/common/enable_pause_aware_picking         )   rendering/environment/default_environment(         res://assets/environment.tres         