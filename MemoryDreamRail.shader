/*
MIT License

Copyright (c) 2020 Shadowriver

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

Shader "Shadowriver/Memory Dream Rail"
{
	Properties
	{
		[Header(Progression)]
		_Progress ("Progress", Float) = 0.0
		_AutoProgress ("Auto Progression Speed", Float) = 0.0
		[Toggle()]_ProgressScale ("Scale Progression by Total", Int) = 0
		
		[Space(20)]
		[Header(Rail Settings)]
		_RailRadius ("Rail Radius", Float) = 5.0
		_FrameSeperation ("Frame Separation", Float) = 2.0
		_RailPitch ("Rail Pitch/Roll", Float) = 0.0
		_RailYaw ("Rail Yaw", Float) = 0.0
		[Toggle()]_IgnoreScale ("Ignore Scale", Int) = 1
		_Translate ("Translate", Vector) = (0.0, 0.0, 0.0, 0.0)
		
		[Space(20)]
		[Header(Distance Fader)]
		_DistanceFade ("Distance Fade Range (0 = Disable)", Float) = 0.0
		_DistanceFadeSize ("Distance Fade Length", Float) = 1.0
		[Toggle()]_FadeRailRadius ("Fade Rail Radius", Int) = 0
		_DistanceColorFadeRange ("Distance Color Fade Range (0 = Disable)", Float) = 0.0
		_DistanceColorFadeLength ("Distance Color Fade Length", Float) = 3.0
		_DistanceColorFade ("Distance Fade Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_DistanceColorFadeFOV ("Distance Color Fade FOV", Float) = 0.0
		_DistanceColorFadeFOVLength ("Distance Color Fade FOV Width", Float) = 10.0
		
		[Space(20)]
		[Header(Up Vector Fader)]
		_UpVectorFade("Up Vector Fade Angle (0 = Disable)", Float) = 0.0
		_UpVectorFadeLength("Up Vector Fade Width", Float) = 0.0
		[Toggle()]_UpVectorRailFade("Fade Rail Radius", Int) = 0

		[Space(20)]
		[Header(Rail Edge Faders)]
		_FadeOpacity ("Opacity", Float) = 0.5
		[Space(5)]_FadeColorFade ("Color Fade", Float) = 0.0
		_FadeColorFadeOffset ("-----Fade Offset", Float) = 0.0
		_FadeColor ("-----Color", Color) = (0.0, 0.0, 0.0, 1.0)
		[Toggle()]_FadeColorFadeMul ("-----Multiply", Int) = 0
		[Space(5)]_FadeScaleX ("Scale X", Float) = 0.0
		_FadeScaleXEase ("-----Ease Factor", Float) = 0.0
		_FadeScaleXTarget ("-----Target Value", Float) = 0.0
		[Space(5)]_FadeScaleY ("Scale Y", Float) = 0.5
		_FadeScaleYEase ("-----Ease Factor", Float) = 0.0
		_FadeScaleYTarget ("-----Target Value", Float) = 0.0
		[Space(5)]_FadePitch ("Pitch rotation", Float) = 0.0
		_FadePitchOffset ("-----Fade Offset", Float) = 0.0
		_FadePitchEase ("-----Ease Factor", Float) = 1.0
		_FadePitchTarget ("-----Target Value", Float) = 0.0
		[Toggle()]_FadePitchMirror ("-----Mirror", Int) = 1
		[Space(5)]_FadeYaw ("Yaw Rotation", Float) = 0.0
		_FadeYawOffset ("-----Fade Offset", Float) = 0.0
		_FadeYawEase ("-----Ease Factor", Float) = 1.0
		_FadeYawTarget ("-----Target Value", Float) = 0.0
		[Toggle()]_FadeYawMirror ("-----Mirror", Int) = 1
		[Space(5)]_FadeRoll ("Roll Rotation", Float) = 0.0
		_FadeRollOffset ("-----Fade Offset", Float) = 0.0
		_FadeRollEase ("-----Ease Factor", Float) = 1.0
		_FadeRollTarget ("-----Target Value", Float) = 0.0
		[Toggle()]_FadeRollMirror ("-----Mirror", Int) = 1
		[Space(5)]_FadeDisplace ("Displace", Float) = 0.0
		_FadeDisplaceEase ("-----Ease Factor", Float) = 1.0
		_FadeDisplaceTarget ("-----Target Value", Vector) = (0.0, 0.0, 0.0, 0.0)
		[Toggle()]_FadeDisplaceMirrorX ("-----Mirror X", Int) = 1
		[Toggle()]_FadeDisplaceMirrorY ("-----Mirror Y", Int) = 1
		[Toggle()]_FadeDisplaceMirrorZ ("-----Mirror Z", Int) = 1
		
		
		[Space(20)]
		[Header(Image Dimensions)]
		_RatioX ("Ratio X", Float) = 1.0
		_RatioY ("Ratio Y", Float) = 1.0
		_FrameSize ("Frame Size", Float) = 1.0 
		_Cutout ("Frame UV Crop", Float) = (0.0,0.0,0.0,0.0)
		
		[Space(20)]
		[Header(Spreadsheet Setup)]
		[IntRange]_SSNum ("Number Of Spreadsheets", Range(1,16)) = 1
		_RowNum ("Number of Tile Rows", Int) = 1
		_ColNum ("Number of Tile Column", Int) = 1
		_DiscardNum ("Discard Last Frames", Int) = 0
		
		[Space(20)]
		[Header(Stereo Imagery)]
		[Toggle()]_Stereo ("Stereoscopic Image", Int) = 0
		_StereoDistanceFade ("-----Distance Fade", Float) = 1
		_StereoDistanceFadeLength ("-----Distance Fade Length", Float) = 0.1
		_StereoAngleFade ("-----Angle Fade", Range(0,90)) = 10
		_StereoAngleFadeLength ("-----Angle Fade Width", Range(0,90)) = 5
		[Toggle()]_StereoHide ("-----Hide Stereo", Int) = 0
		[Toggle()]_StereoRightEye ("-----Fallback to Right Eye Image", Int) = 0
		[Toggle()]_StereoVertical ("-----Vertical Orientation", Int) = 0
		[Toggle()]_StereoInvert ("-----Invert Eyes", Int) = 0
		
		[Space(20)]
		[Header(Flipbook Animation)]
		_AnimNum ("Animated Frames", Int) = 1
		_AnimSpeed ("Animation Speed", Float) = 10
		
		[Space(20)]
		[Header(Spreadsheet Textures)]
		[NoScaleOffset]_Spreadsheet0 ("Spreadsheet 0", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet1 ("Spreadsheet 1", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet2 ("Spreadsheet 2", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet3 ("Spreadsheet 3", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet4 ("Spreadsheet 4", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet5 ("Spreadsheet 5", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet6 ("Spreadsheet 6", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet7 ("Spreadsheet 7", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet8 ("Spreadsheet 8", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet9 ("Spreadsheet 9", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet10 ("Spreadsheet 10", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet11 ("Spreadsheet 11", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet12 ("Spreadsheet 12", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet13 ("Spreadsheet 13", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet14 ("Spreadsheet 14", 2D) = "white" {}
		[NoScaleOffset]_Spreadsheet15 ("Spreadsheet 15", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent"  "RenderType"="Transparent"}

		Cull Off
		//ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		//ZTest [_ZTest]

		LOD 100

		Pass
		{
			//Tags {"LightMode"="ForwardBase"}
			CGPROGRAM
			#pragma fragment frag
			#pragma vertex vert
			#pragma geometry geom
			// make fog work
			
			#include "UnityCG.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;


			};

			struct v2g
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 imgCorrd : IMAGECOORD;
				float4 objPos : TEXCOORD1;
				float3 normal : NORMAL;
            };
			
			struct g2f : v2g {
				
				float Offset : TEXCOORD2;
				float Fade : TEXCOORD3;
				float RailFade : TEXCOORD4;
				float depth : TEXCOORD5;
				float singleColUV : TEXCOORD6;
				float Dist : TEXCOORD7;
				float UpVectorFade : TEXCOORD8;
			};


			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			sampler2D _Spreadsheet0;
			sampler2D _Spreadsheet1;
			sampler2D _Spreadsheet2;
			sampler2D _Spreadsheet3;
			sampler2D _Spreadsheet4;
			sampler2D _Spreadsheet5;
			sampler2D _Spreadsheet6;
			sampler2D _Spreadsheet7;
			sampler2D _Spreadsheet8;
			sampler2D _Spreadsheet9;
			sampler2D _Spreadsheet10;
			sampler2D _Spreadsheet11;
			sampler2D _Spreadsheet12;
			sampler2D _Spreadsheet13;
			sampler2D _Spreadsheet14;
			sampler2D _Spreadsheet15;
			
			float _RailRadius;
			float _FrameSeperation;
			float _Progress;
			float _AutoProgress;
			uint _ProgressScale;
			uint _IgnoreScale;
			float4 _Translate;
			float _RatioX;
			float _RatioY;
			float _FrameSize;
			float4 _Cutout;
			
			float _DistanceColorFadeRange;
			float _DistanceColorFadeLength;
			float4 _DistanceColorFade;
			float _DistanceColorFadeFOV;
			float _DistanceColorFadeFOVLength;
			float _CircleRailRadius;
			uint _HorizontalCylinder;
			uint _FaceInward;			
			float _RailPitch;
			float _RailYaw;
			
			float _FadeOpacity;
			float _FadeScaleX;
			float _FadeScaleXEase;
			float _FadeScaleXTarget;
			float _FadeScaleY;
			float _FadeScaleYEase;
			float _FadeScaleYTarget;
			float _FadePitch;
			float _FadePitchTarget;
			float _FadePitchOffset;
			float _FadePitchEase;
			uint _FadePitchMirror;
			float _FadeYaw;
			float _FadeYawTarget;
			float _FadeYawOffset;
			float _FadeYawEase;
			uint _FadeYawMirror;
			float _FadeRoll;
			float _FadeRollTarget;
			float _FadeRollOffset;
			float _FadeRollEase;
			uint _FadeRollMirror;
			float _FadeDisplace;
			float _FadeDisplaceEase;
			float4 _FadeDisplaceTarget;
			uint _FadeDisplaceMirrorX;
			uint _FadeDisplaceMirrorY;
			uint _FadeDisplaceMirrorZ;
			
			float _UpVectorFade;
			float _UpVectorFadeLength;
			uint _UpVectorRailFade;
			
			float _DistanceFade;
			float _DistanceFadeSize;
			uint _FadeRailRadius;
			
			float _FadeColorFade;
			float _FadeColorFadeOffset;
			float4 _FadeColor;
			uint _FadeColorFadeMul;
			
			uint _Stereo;
			float _StereoDistanceFade; 
			float _StereoDistanceFadeLength; 
			float _StereoAngleFade;
			float _StereoAngleFadeLength; 
			uint _StereoHide; 
			uint _StereoRightEye; 
			uint _StereoVertical;
			uint _StereoInvert;
			
			uint _SSNum;
			uint _RowNum;
			uint _ColNum;
			uint _AnimNum;
			uint _DiscardNum;
			float _AnimSpeed;
			
			float3x3 RotationPitch(float Angle) {
			
				float3x3 m;
				Angle = (Angle*UNITY_PI)/180.0f;
				m[0] = float3(1,0,0);
				m[1] = float3(0,cos(Angle),-sin(Angle));
				m[2] = float3(0,sin(Angle),cos(Angle));
				
				return m;
			}
			
			float3x3 RotationYaw(float Angle) {
			
				float3x3 m;
				Angle = (Angle*UNITY_PI)/180.0f;
				m[0] = float3(cos(Angle),0,sin(Angle));
				m[1] = float3(0,1,0);
				m[2] = float3(-sin(Angle),0,cos(Angle));
				
				return m;
			}
			
			float3x3 RotationRoll(float Angle) {
			
				float3x3 m;
				Angle = (Angle*UNITY_PI)/180.0f;
				m[0] = float3(cos(Angle),-sin(Angle),0);
				m[1] = float3(sin(Angle),cos(Angle),0);
				m[2] = float3(0,0,1);
				
				return m;
			}
			
			float EaseIn(float Value, float Factor) {
				
				if(Factor <= 0) return Value;
				return max(2 * pow(Value, Factor),0);
			}

			float4 texSS(uint index, float2 uv) {
			
				switch(index) {
					default:
					case 0: return tex2D(_Spreadsheet0,uv);
					case 1: return tex2D(_Spreadsheet1,uv);
					case 2: return tex2D(_Spreadsheet2,uv);
					case 3: return tex2D(_Spreadsheet3,uv);
					case 4: return tex2D(_Spreadsheet4,uv);
					case 5: return tex2D(_Spreadsheet5,uv);
					case 6: return tex2D(_Spreadsheet6,uv);
					case 7: return tex2D(_Spreadsheet7,uv);
					case 8: return tex2D(_Spreadsheet8,uv);
					case 9: return tex2D(_Spreadsheet9,uv);
					case 10: return tex2D(_Spreadsheet10,uv);
					case 11: return tex2D(_Spreadsheet11,uv);
					case 12: return tex2D(_Spreadsheet12,uv);
					case 13: return tex2D(_Spreadsheet13,uv);
					case 14: return tex2D(_Spreadsheet14,uv);
					case 15: return tex2D(_Spreadsheet15,uv);
				}
			
			}			
			
			v2g vert (appdata v)
			{
				v2g o;
				o.vertex = v.vertex; 
				o.normal = v.normal;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.objPos = mul( unity_ObjectToWorld, float4(0,0,0,1));
				o.imgCorrd = float3(0,0,0);

				return o;
			}
			

			[maxvertexcount(3)]
			void geom(triangle v2g IN[3], uint pid : SV_PRIMITIVEID, inout TriangleStream<g2f> tristream) {
				
				uint ID = (pid>>1)&0x7FFFFFFF;
				
				float3 _ActualWorldSpaceCameraPos = _WorldSpaceCameraPos;
				#if UNITY_SINGLE_PASS_STEREO
					 _ActualWorldSpaceCameraPos = unity_StereoWorldSpaceCameraPos[0];
				#endif
				
				float Fade = _DistanceFade > 0.0f ? smoothstep(_DistanceFade,_DistanceFade-_DistanceFadeSize, length(IN[0].objPos.xyz-_WorldSpaceCameraPos)) : 1.0f;
				float UpVectorFade = smoothstep(_UpVectorFade-_UpVectorFadeLength,_UpVectorFade,(((1-((normalize(mul(unity_ObjectToWorld, float4(0,1,0,1))-IN[0].objPos).y)))/2))*180); // I know this is mess ;p
				float FadedRailRadius = _FadeRailRadius ? _RailRadius*Fade :  _RailRadius;
				if(_UpVectorRailFade && _UpVectorFade > 0.0f) FadedRailRadius *= 1-UpVectorFade;
				float CellRadius = _FrameSeperation/2.0f;
				uint CellCountInt = ceil(max(((FadedRailRadius/_FrameSeperation)),0.0))*2;
				
				float Offset = (((_FrameSeperation*(float)ID))-(((CellRadius)*CellCountInt)));
				int IDOffset = (int)round(Offset/_FrameSeperation);
				float total = _ColNum*_RowNum;
				float FramesInSS = floor(total / _AnimNum);
				total = (FramesInSS*_SSNum) - _DiscardNum;
				float Progress = (_Progress+(_Time.y*_AutoProgress)) * (_ProgressScale ? total : 1);
				float trueID = frac((floor(Progress+0.5)-IDOffset)/total)*total;
				Offset += (_FrameSeperation)*((frac(Progress+0.5)-0.5));
				float Frame = _AnimNum > 1 ? (floor(frac((_Time.y*_AnimSpeed)/_AnimNum)*_AnimNum)) : 0;
				
				if(abs(Offset) > FadedRailRadius) return;
				
				
				
				
				float3 CellOffset = float3(0.0f,0.0f,0.0f);

				CellOffset.x = Offset;
				if(_RailPitch != 0.0f) CellOffset = mul(CellOffset,RotationRoll(_RailPitch));
				if(_RailYaw != 0.0f) CellOffset = mul(CellOffset,RotationYaw(_RailYaw));			
				
				float2 Size = (float2(_RatioX,_RatioY)/max(_RatioX,_RatioY))*(_FrameSize/2);
				
				if(_FadeScaleX > 0.0f) Size.x *= lerp(1,_FadeScaleXTarget, EaseIn(smoothstep(FadedRailRadius-_FadeScaleX,FadedRailRadius,abs(Offset)),_FadeScaleXEase));
				if(_FadeScaleY > 0.0f) Size.y *= lerp(1,_FadeScaleYTarget, EaseIn(smoothstep(FadedRailRadius-_FadeScaleY,FadedRailRadius,abs(Offset)),_FadeScaleYEase));
				
				if(!(pid & 0x1)) {
					IN[0].uv.x = 0; IN[0].uv.y = 1; // 0 0
					IN[1].uv.x = 0; IN[1].uv.y = 0; // 0 1
					IN[2].uv.x = 1; IN[2].uv.y = 0; // 1 1
					
					IN[0].vertex.x = Size.x; IN[0].vertex.y = Size.y; IN[0].vertex.z = 0.0;
					IN[1].vertex.x = Size.x; IN[1].vertex.y = -Size.y; IN[1].vertex.z = 0.0;
					IN[2].vertex.x = -Size.x; IN[2].vertex.y = -Size.y; IN[2].vertex.z = 0.0;
					
					
				}
				else {
					IN[0].uv.x = 0; IN[0].uv.y = 1; // 0 0
					IN[1].uv.x = 1; IN[1].uv.y = 0; // 1 1
					IN[2].uv.x = 1; IN[2].uv.y = 1; // 1 0
					 
					IN[0].vertex.x = Size.x; IN[0].vertex.y = Size.y; IN[0].vertex.z = 0.0;
					IN[1].vertex.x = -Size.x; IN[1].vertex.y = -Size.y; IN[1].vertex.z = 0.0;
					IN[2].vertex.x = -Size.x; IN[2].vertex.y = Size.y; IN[2].vertex.z = 0.0;
				}
				
				float4 OUT[3];
				float DEPTH[3];
				
				float3 Scale = _IgnoreScale ? float3(length(unity_ObjectToWorld._m00_m10_m20), length(unity_ObjectToWorld._m01_m11_m21), length(unity_ObjectToWorld._m02_m12_m22)) : 1.0f;
				float dist = 0.0f;
				float3 DisplaceOffset;
				[unroll]
				for (int i = 0; i <= 2; i++) {
					if(_FaceInward && _CircleRailRadius != 0.0f) {
						
					}
					OUT[i].w = 1.0f;
					IN[i].vertex.xyz = (IN[i].vertex.xyz)+_Translate;
					if(_FadeRoll > 0.0f)  IN[i].vertex.xyz = mul(IN[i].vertex.xyz,RotationRoll(lerp(0,_FadeRollTarget,(_FadeRollMirror? -Offset/abs(Offset) : 1)*EaseIn(smoothstep((FadedRailRadius-_FadeRollOffset)-_FadeRoll,FadedRailRadius-_FadeRollOffset,abs(Offset)),_FadeRollEase))));
					if(_FadePitch > 0.0f)  IN[i].vertex.xyz = mul(IN[i].vertex.xyz,RotationPitch(lerp(0,_FadePitchTarget,(_FadePitchMirror? -Offset/abs(Offset) : 1)*EaseIn(smoothstep((FadedRailRadius-_FadePitchOffset)-_FadePitch,FadedRailRadius-_FadePitchOffset,abs(Offset)),_FadePitchEase))));
					if(_FadeYaw > 0.0f)  IN[i].vertex.xyz = mul(IN[i].vertex.xyz,RotationYaw(lerp(0,_FadeYawTarget,(_FadeYawMirror? -Offset/abs(Offset) : 1)*EaseIn(smoothstep((FadedRailRadius-_FadeYawOffset)-_FadeYaw,FadedRailRadius-_FadeYawOffset,abs(Offset)),_FadeYawEase))));
					if(_FaceInward && _CircleRailRadius != 0.0f) {
						
					}
					if(_FadeDisplace > 0.0f) {
						DisplaceOffset = lerp(float3(0.0,0.0,0.0),(_FadeDisplaceTarget),EaseIn(smoothstep(FadedRailRadius-_FadeDisplace,FadedRailRadius,abs(Offset)),_FadeDisplaceEase));
						DisplaceOffset.x *= (_FadeDisplaceMirrorX? -Offset/abs(Offset) : 1);
						DisplaceOffset.y *= (_FadeDisplaceMirrorY? -Offset/abs(Offset) : 1);
						DisplaceOffset.z *= (_FadeDisplaceMirrorZ? -Offset/abs(Offset) : 1);
						IN[i].vertex.xyz += DisplaceOffset;
					}
					IN[i].vertex.xyz += CellOffset;
					OUT[i].xyz = IN[i].vertex.xyz/Scale;
					OUT[i].w = IN[i].vertex.w;

					OUT[i] = mul(UNITY_MATRIX_M, OUT[i]);
					DEPTH[i] = length(OUT[i] - _ActualWorldSpaceCameraPos);
					
				}
				
				if(!(pid & 0x1)) dist = length(lerp(OUT[0].xyz,OUT[2].xyz,0.5)-_ActualWorldSpaceCameraPos);
				else dist = length(lerp(OUT[0].xyz,OUT[1].xyz,0.5)-_ActualWorldSpaceCameraPos);
				
				for (int j = 0; j <= 2; j++) OUT[j] = mul(UNITY_MATRIX_V, OUT[j]);
				
				float3 EdgeA = OUT[1].xyz - OUT[0].xyz;
				float3 EdgeB = OUT[2].xyz - OUT[0].xyz;
				float3 Normal = normalize(cross(EdgeA, EdgeB));

				
				for (i = 0; i <= 2; i++) {
					g2f o;
					o.uv = IN[i].uv;
					o.uv.x = clamp(o.uv.x,_Cutout.x,1-_Cutout.y);
					o.uv.y = clamp(o.uv.y,_Cutout.z,1-_Cutout.w);
					o.depth = DEPTH[i];
					o.vertex = mul(UNITY_MATRIX_P, OUT[i]);
					o.imgCorrd = uint3(0,0,0);
					o.imgCorrd.x = floor(((round(trueID%FramesInSS)*_AnimNum)+max(Frame,0)) % _ColNum);
					o.imgCorrd.y = floor(floor(((round(trueID%FramesInSS)*_AnimNum)+max(Frame,0))/_ColNum)%_RowNum);
					o.imgCorrd.z = floor((trueID)/FramesInSS)%_SSNum;
					float singleColUV = 1.0f/_ColNum;
					float singleRowUV = 1.0f/_RowNum;
					o.singleColUV = singleColUV;
					if(_Stereo){
						o.uv.x = (o.uv.x/(_StereoVertical ? _ColNum : _ColNum*2.0f)+(singleColUV*o.imgCorrd.x));
						o.uv.y = (1-((1-o.uv.y)/(_StereoVertical ? _RowNum*2.0f : _RowNum)))-(singleRowUV*o.imgCorrd.y);
					}
					else {
						o.uv.x = (o.uv.x/_ColNum)+(singleColUV*o.imgCorrd.x);
						o.uv.y = (1-((1-o.uv.y)/_RowNum))-(singleRowUV*o.imgCorrd.y);
					}
					o.normal = Normal;
					o.objPos = IN[i].objPos;
					o.Offset = Offset;
					o.Fade = Fade;
					o.Dist = dist;
					o.RailFade = FadedRailRadius;
					o.UpVectorFade = UpVectorFade;
					tristream.Append(o);
				}

			}
			
			fixed4 frag (g2f i) : SV_Target
			{
				half4 col = 0.0f;
				
				if(smoothstep(_DistanceColorFadeRange-_DistanceColorFadeLength,_DistanceColorFadeRange,i.depth) > 1) return float4(1,1,1,1);
				
				if(_Stereo && !_StereoHide && UNITY_MATRIX_P[0][2] != 0){
					half4 colL = texSS(round(i.imgCorrd.z),i.uv);
					half4 colR = texSS(round(i.imgCorrd.z),float2(!_StereoVertical? i.uv.x+(i.singleColUV/2.0f) : i.uv.x,_StereoVertical? i.uv.y-(i.singleColUV/2.0f) : i.uv.y));
					if(_StereoInvert) {
						col = colL;
						colL = colR;
						colR = col;
					}
					if(_StereoRightEye) col = UNITY_MATRIX_P[0][2] > 0 ? lerp(colR,colL,min(smoothstep(_StereoDistanceFade+_StereoDistanceFadeLength,_StereoDistanceFade,i.Dist),smoothstep(1-((_StereoAngleFade+_StereoAngleFadeLength)/90.0f),1-((_StereoAngleFade)/90.0f),i.normal.z))) : colR;
					else col = UNITY_MATRIX_P[0][2] > 0 ? colR : lerp(colR,colL,min(smoothstep(_StereoDistanceFade+_StereoDistanceFadeLength,_StereoDistanceFade,i.Dist),smoothstep(1-((_StereoAngleFade+_StereoAngleFadeLength)/90.0f),1-((_StereoAngleFade)/90.0f),i.normal.z)));
				}
				else{
					if(_Stereo) col = !_StereoRightEye && !_StereoInvert ? texSS(round(i.imgCorrd.z),i.uv) : texSS(round(i.imgCorrd.z),float2(!_StereoVertical? i.uv.x+(i.singleColUV/2.0f) : i.uv.x,_StereoVertical? i.uv.y-(i.singleColUV/2.0f) : i.uv.y));
					else col = texSS(round(i.imgCorrd.z),i.uv);
				}
				
				
				if(_FadeOpacity > 0.0f) col.a *= 1-smoothstep(i.RailFade-_FadeOpacity,i.RailFade,abs(i.Offset));
				if(!_FadeRailRadius) col.a *= i.Fade;
				if(!_UpVectorRailFade && _UpVectorFade > 0.0f) col.a *= 1-i.UpVectorFade;
					
				if(_FadeColorFade > 0.0f) {
					if(_FadeColorFadeMul) col.rgb *= lerp(1.0f,_FadeColor.rgb,smoothstep((i.RailFade-_FadeColorFadeOffset)-_FadeColorFade,(i.RailFade-_FadeColorFadeOffset),abs(i.Offset)));
					else col.rgb = lerp(col.rgb,_FadeColor.rgb,smoothstep((i.RailFade-_FadeColorFadeOffset)-_FadeColorFade,(i.RailFade-_FadeColorFadeOffset),abs(i.Offset)));
				}
				
				if(_DistanceColorFadeRange > 0) {
				
					col = lerp(col, _DistanceColorFade, smoothstep(_DistanceColorFadeRange-_DistanceColorFadeLength,_DistanceColorFadeRange,i.depth));
				
				}
				
				if(_DistanceColorFadeFOV > 0) {
				
					col = lerp(col, _DistanceColorFade, smoothstep(_DistanceColorFadeFOV-_DistanceColorFadeFOVLength,_DistanceColorFadeFOV,abs((1.0-i.normal.b)*90.0)));
				
				}
				
				
				
				return col;

			}

			ENDCG
		}
	}
}
