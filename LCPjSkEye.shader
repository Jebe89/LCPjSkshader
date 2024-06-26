// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LCPjSkshader/Eye"
{
	Properties
	{
		[Header(Diffuse)]_MainTex("Diffuse Map (_eye)", 2D) = "white" {}
		[HDR]_AdditionalDiffuseColor("AdditionalDiffuseColor", Color) = (1,1,1,1)
		[ToggleUI]_EyeShadow("EyeShadow", Float) = 1
		[HDR]_Shadow("Shadow", Color) = (0.7,0.7,0.7,0)
		_ShadowStep("ShadowStep", Range( 0 , 1)) = 0.3
		_ShadowFeather("ShadowFeather", Range( 0 , 1)) = 0.01
		[ToggleUI]_ReceiveShadowLerp("ReceiveShadowLerp", Float) = 0
		[ToggleUI]_ShadowinLightColor("Shadow in LightColor", Float) = 0
		[ToggleUI]_NoShadowinDirectionalLightColor("NoShadow in DirectionalLightColor", Float) = 0
		[Header(Emissive and Other)]_EmiTex("Emissive (_emi) [optional]", 2D) = "white" {}
		[HDR]_EmissiveColor("EmissiveColor", Color) = (1,1,1,1)
		_EmmisiveStrength("EmmisiveStrength", Range( 0 , 10)) = 0
		[HDR]_CharaColor("CharaColor", Color) = (1,1,1,1)
		_Saturation("Saturation", Range( 0 , 1)) = 1
		[HDR]_UnsaturationColor("UnsaturationColor", Color) = (0.2117647,0.7137255,0.07058824,0)
		[Header(Light)]_MinDirectLight("MinDirectLight", Range( 0 , 1)) = 0
		_MaxDirectLight("MaxDirectLight", Range( 0 , 2)) = 1
		[ToggleUI]_UnifyIndirectDiffuseLight("Unify IndirectDiffuseLight", Float) = 1
		_MinIndirectLight("MinIndirectLight", Range( 0 , 1)) = 0.1
		_MaxIndirectLight("MaxIndirectLight", Range( 0 , 2)) = 1
		_LightColorGrayScale("LightColor GrayScale", Range( 0 , 1)) = 0
		_EyeLightFactor("EyeLightFactor", Range( 0 , 1)) = 0.5
		_GlobalLightFactor("GlobalLightFactor", Range( 0 , 1)) = 0
		[Header(Vertex Function)]_VertexOffsetL("Vertex OffsetL", Vector) = (0,0,0,0)
		[ToggleUI]_FakeEyeTrackingL("FakeEyeTrackingL", Float) = 0
		_MoveRangeLxxyy("+/-MoveRangeL.xxyy", Vector) = (0.003,0.004,0.004,0.004)
		_WorkingAngleLxxyy("+/-WorkingAngleL.xxyy", Vector) = (30,45,30,30)
		_VertexOffsetR("Vertex OffsetR", Vector) = (0,0,0,0)
		[ToggleUI]_FakeEyeTrackingR("FakeEyeTrackingR", Float) = 0
		_MoveRangeRxxyy("+/-MoveRangeR.xxyy", Vector) = (0.004,0.003,0.004,0.004)
		_WorkingAngleRxxyy("+/-WorkingAngleR.xxyy", Vector) = (45,30,30,30)
		[Header(Custom Transform Direction)][Toggle]_UseCustomTransform("Use Custom Transform", Float) = 0
		[Toggle]_IsBlenderCoordinateSystem("IsBlenderCoordinateSystem", Float) = 0
		_XAxisVectorL("+X Axis Vector L", Vector) = (0,0,0,0)
		_YAxisVectorL("+Y Axis Vector L", Vector) = (0,0,0,0)
		_XAxisVectorR("+X Axis Vector R", Vector) = (0,0,0,0)
		_YAxisVectorR("-Y Axis Vector R", Vector) = (0,0,0,0)
		[Header(HeadBoneTransform)][Toggle]_ObjectSpace("ObjectSpace", Float) = 1
		_FaceCenterPos("FaceCenterPos", Vector) = (0,0.15,0,0)
		_FaceForward("FaceForward", Vector) = (0,0,1,0)
		_FaceUp("FaceUp", Vector) = (0,1,0,0)
		[Header(Stencil Buffer)]_StencilReference("Stencil Reference", Range( 0 , 255)) = 0
		_StencilReadMask("Stencil ReadMask", Range( 0 , 255)) = 255
		_StencilWriteMask("Stencil WriteMask", Range( 0 , 255)) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComparison("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilPassFront("Stencil PassFront", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilFailFront("Stencil FailFront", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilZFailFront("Stencil ZFailFront", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry" }
	LOD 100

		Cull Off
		CGINCLUDE
		#pragma target 3.0 
		ENDCG

       	
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend Off
			AlphaToMask Off
			Cull [_CullMode]
			ColorMask RGBA
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			Stencil
			{
				Ref [_StencilReference]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComparison]
				Pass [_StencilPassFront]
				Fail [_StencilFailFront]
				ZFail [_StencilZFailFront]
			}
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
			#define UNITY_PASS_FORWARDBASE
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_SHADOWS 1

			//This is a late directive
			
			uniform float _StencilZFailFront;
			uniform float _StencilFailFront;
			uniform float _StencilPassFront;
			uniform float _StencilComparison;
			uniform float _StencilWriteMask;
			uniform float _StencilReadMask;
			uniform float _StencilReference;
			uniform float _CullMode;
			uniform float _UseCustomTransform;
			uniform float _FakeEyeTrackingL;
			uniform float3 _VertexOffsetL;
			uniform float _ObjectSpace;
			uniform float3 _FaceForward;
			uniform float3 _FaceUp;
			uniform float3 _FaceCenterPos;
			uniform float4 _WorkingAngleLxxyy;
			uniform float4 _MoveRangeLxxyy;
			uniform float _IsBlenderCoordinateSystem;
			uniform float3 _XAxisVectorL;
			uniform float3 _YAxisVectorL;
			uniform float _FakeEyeTrackingR;
			uniform float3 _VertexOffsetR;
			uniform float4 _WorkingAngleRxxyy;
			uniform float4 _MoveRangeRxxyy;
			uniform float3 _XAxisVectorR;
			uniform float3 _YAxisVectorR;
			uniform float4 _UnsaturationColor;
			uniform float4 _CharaColor;
			uniform float _EyeShadow;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float4 _AdditionalDiffuseColor;
			uniform float4 _Shadow;
			uniform float _ShadowStep;
			uniform float _ReceiveShadowLerp;
			uniform float _ShadowFeather;
			uniform float _NoShadowinDirectionalLightColor;
			uniform float _MinDirectLight;
			uniform float _ShadowinLightColor;
			uniform float _MaxDirectLight;
			uniform float _UnifyIndirectDiffuseLight;
			uniform float _MinIndirectLight;
			uniform float _MaxIndirectLight;
			uniform float _LightColorGrayScale;
			uniform float _EyeLightFactor;
			uniform float _GlobalLightFactor;
			uniform sampler2D _EmiTex;
			uniform float4 _EmiTex_ST;
			uniform float4 _EmissiveColor;
			uniform float _EmmisiveStrength;
			uniform float _Saturation;
			inline float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max( 0.001f , dot( inVec , inVec ) );
				return inVec* rsqrt( dp3);
			}
			
			float IsThereALight(  )
			{
				return any(_WorldSpaceLightPos0.xyz);
			}
			
			float PureLightAttenuation( float3 worldPos )
			{
				#ifdef POINT
				        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
				        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
				#endif
				#ifdef SPOT
				#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))
				#else
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord
				#endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
				#endif
				#ifdef DIRECTIONAL
				        return 1;
				#endif
				#ifdef POINT_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
				#endif
				#ifdef DIRECTIONAL_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTexture0, lightCoord).w;
				#endif
			}
			
			float3 ShadeSH9out( half4 Normal )
			{
				return ShadeSH9(Normal);
			}
			
			float3 MaxShadeSH9(  )
			{
				return max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb);
			}
			


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_SHADOW_COORDS(4)
			};
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				
				float3 objToWorldDir1741 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceForward, 0 ) ).xyz );
				float3 normalizeResult1978 = normalize( ( _ObjectSpace == 0.0 ? _FaceForward : objToWorldDir1741 ) );
				float3 Forward1743 = normalizeResult1978;
				float isObjectSpace1965 = _ObjectSpace;
				float3 objToWorldDir1740 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceUp, 0 ) ).xyz );
				float3 normalizeResult1979 = normalize( ( isObjectSpace1965 == 0.0 ? _FaceUp : objToWorldDir1740 ) );
				float3 Up1742 = normalizeResult1979;
				float3 normalizeResult1732 = normalize( cross( Forward1743 , Up1742 ) );
				float3 Left1737 = normalizeResult1732;
				float3 objToWorld1733 = mul( unity_ObjectToWorld, float4( _FaceCenterPos, 1 ) ).xyz;
				float3 temp_output_1969_0 = ( isObjectSpace1965 == 0.0 ? _FaceCenterPos : objToWorld1733 );
				float3 normalizeResult1729 = normalize( ( _WorldSpaceCameraPos - temp_output_1969_0 ) );
				float3 Center2Cam1734 = normalizeResult1729;
				float dotResult1761 = dot( (Left1737).xz , (Center2Cam1734).xz );
				float Xsign1763 = sign( dotResult1761 );
				float3 FCenterPos1735 = temp_output_1969_0;
				float3 temp_output_1745_0 = ( _WorldSpaceCameraPos - FCenterPos1735 );
				float3 normalizeResult1746 = normalize( temp_output_1745_0 );
				float dotResult1749 = dot( normalizeResult1746 , Up1742 );
				float3 normalizeResult1754 = normalize( ( _WorldSpaceCameraPos - ( ( dotResult1749 * length( temp_output_1745_0 ) * Up1742 ) + FCenterPos1735 ) ) );
				float3 Cylinder1755 = normalizeResult1754;
				float dotResult1764 = dot( Forward1743 , Cylinder1755 );
				float Xvalue1768 = acos( dotResult1764 );
				float dotResult1769 = dot( Up1742 , Center2Cam1734 );
				float Ysign1778 = sign( dotResult1769 );
				float dotResult1773 = dot( Center2Cam1734 , Cylinder1755 );
				float Yvalue1777 = acos( dotResult1773 );
				float3 appendResult1836 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1781 = (float3(-_XAxisVectorL.x , _XAxisVectorL.z , -_XAxisVectorL.y));
				float3 normalizeResult1787 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1781 : _XAxisVectorL ) );
				float3 appendResult1785 = (float3(-_YAxisVectorL.x , _YAxisVectorL.z , -_YAxisVectorL.y));
				float3 normalizeResult1786 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1785 : _YAxisVectorL ) );
				float3 normalizeResult1790 = ASESafeNormalize( cross( normalizeResult1787 , normalizeResult1786 ) );
				float3x3 CustomMatrixL1802 = float3x3(normalizeResult1787, normalizeResult1786, normalizeResult1790);
				float3 appendResult1898 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1792 = (float3(-_XAxisVectorR.x , _XAxisVectorR.z , -_XAxisVectorR.y));
				float3 normalizeResult1797 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1792 : _XAxisVectorR ) );
				float3 break1806 = -_YAxisVectorR;
				float3 appendResult1795 = (float3(-break1806.x , break1806.z , -break1806.y));
				float3 normalizeResult1796 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1795 : -_YAxisVectorR ) );
				float3 normalizeResult1800 = ASESafeNormalize( cross( normalizeResult1797 , normalizeResult1796 ) );
				float3x3 CustomMatrixR1801 = float3x3(normalizeResult1797, normalizeResult1796, normalizeResult1800);
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				
				v.vertex.xyz += ( v.ase_texcoord1.y >= 0.5 ? ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )), CustomMatrixL1802 ) : (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )) ) : ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )), CustomMatrixR1801 ) : (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )) ) );
				o.pos = UnityObjectToClipPos(v.vertex);
				#if ASE_SHADOWS
					#if UNITY_VERSION >= 560
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#else
						TRANSFER_SHADOW( o );
					#endif
				#endif
				return o;
			}
			
			float4 frag (v2f i ) : SV_Target
			{
				float3 outColor;
				float outAlpha;

				float2 uv_MainTex = i.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 temp_output_1425_0 = ( tex2D( _MainTex, uv_MainTex ) * _AdditionalDiffuseColor );
				float4 Shadow1322 = _Shadow;
				float localIsThereALight797 = IsThereALight();
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float dotResult779 = dot( worldSpaceLightDir , ase_worldNormal );
				float HalfLambertTerm781 = ( localIsThereALight797 == 1.0 ? (dotResult779*0.5 + 0.5) : 1.0 );
				float localIsThereALight1962 = IsThereALight();
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float HalfShadowAttenuation1955 = ( localIsThereALight1962 == 1.0 ? (saturate( ase_atten )*0.5 + 0.5) : 1.0 );
				float shad_lerp1312 = saturate( ( ( _ShadowStep - (( _ReceiveShadowLerp )?( ( HalfLambertTerm781 * HalfShadowAttenuation1955 ) ):( HalfLambertTerm781 )) ) / _ShadowFeather ) );
				float4 lerpResult1325 = lerp( temp_output_1425_0 , ( temp_output_1425_0 * Shadow1322 ) , shad_lerp1312);
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_cast_0 = (_MinDirectLight).xxx;
				float3 temp_output_1974_0 = max( ase_lightColor.rgb , temp_cast_0 );
				float3 worldPos1939 = ase_worldPos;
				float localPureLightAttenuation1939 = PureLightAttenuation( worldPos1939 );
				float3 temp_output_1942_0 = ( temp_output_1974_0 * (( _ShadowinLightColor )?( ase_atten ):( localPureLightAttenuation1939 )) );
				float3 temp_cast_1 = (_MinDirectLight).xxx;
				float3 temp_cast_2 = (_MinDirectLight).xxx;
				#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch1941 = temp_output_1942_0;
				#else
				float3 staticSwitch1941 = temp_output_1974_0;
				#endif
				float3 temp_cast_3 = (_MaxDirectLight).xxx;
				float4 Normal1973 = float4( 0,0,0,0 );
				float3 localShadeSH9out1973 = ShadeSH9out( Normal1973 );
				float3 localMaxShadeSH9876 = MaxShadeSH9();
				float3 temp_cast_4 = (_MinIndirectLight).xxx;
				float3 temp_cast_5 = (_MaxIndirectLight).xxx;
				float3 temp_output_1706_0 = max( min( (( _NoShadowinDirectionalLightColor )?( staticSwitch1941 ):( temp_output_1942_0 )) , temp_cast_3 ) , min( max( (( _UnifyIndirectDiffuseLight )?( localMaxShadeSH9876 ):( localShadeSH9out1973 )) , temp_cast_4 ) , temp_cast_5 ) );
				float3 temp_cast_6 = (_MinDirectLight).xxx;
				float3 temp_cast_7 = (_MaxDirectLight).xxx;
				float3 temp_cast_8 = (_MinIndirectLight).xxx;
				float3 temp_cast_9 = (_MaxIndirectLight).xxx;
				float grayscale1945 = dot(temp_output_1706_0, float3(0.299,0.587,0.114));
				float3 temp_cast_10 = (grayscale1945).xxx;
				float3 lerpResult1944 = lerp( temp_output_1706_0 , temp_cast_10 , _LightColorGrayScale);
				float3 LightColor208 = lerpResult1944;
				float EyeLightFactor1708 = _EyeLightFactor;
				float4 lerpResult1712 = lerp( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) , ( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) * float4( LightColor208 , 0.0 ) ) , EyeLightFactor1708);
				float4 blend_diff916 = ( lerpResult1712 + float4( 0,0,0,0 ) );
				float GlobalLightFactor1719 = _GlobalLightFactor;
				float4 lerpResult1723 = lerp( ( _CharaColor * blend_diff916 ) , ( _CharaColor * blend_diff916 * float4( LightColor208 , 0.0 ) ) , GlobalLightFactor1719);
				float2 uv_EmiTex = i.ase_texcoord1.xy * _EmiTex_ST.xy + _EmiTex_ST.zw;
				float4 Emissive600 = tex2D( _EmiTex, uv_EmiTex );
				float4 Refined_diff612 = ( lerpResult1723 + ( Emissive600 * _EmissiveColor * _EmmisiveStrength ) );
				float dotResult614 = dot( _UnsaturationColor , Refined_diff612 );
				float4 temp_cast_13 = (dotResult614).xxxx;
				float4 lerpResult616 = lerp( temp_cast_13 , Refined_diff612 , _Saturation);
				float4 output_diff618 = lerpResult616;
				
				
				outColor = output_diff618.rgb;
				outAlpha = 1;
				return float4(outColor,outAlpha);
			}
			ENDCG
		}
		
		
		Pass
		{
			Name "ForwardAdd"
			Tags { "LightMode"="ForwardAdd" }
			ZWrite Off
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend One One, Zero One
			BlendOp Max, Max
			AlphaToMask Off
			Cull [_CullMode]
			ColorMask RGBA
			Stencil
			{
				Ref [_StencilReference]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComparison]
				Pass [_StencilPassFront]
				Fail [_StencilFailFront]
				ZFail [_StencilZFailFront]
			}
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdadd_fullshadows
			#ifndef UNITY_PASS_FORWARDADD
			#define UNITY_PASS_FORWARDADD
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_SHADOWS 1

			//This is a late directive
			
			uniform float _StencilZFailFront;
			uniform float _StencilFailFront;
			uniform float _StencilPassFront;
			uniform float _StencilComparison;
			uniform float _StencilWriteMask;
			uniform float _StencilReadMask;
			uniform float _StencilReference;
			uniform float _CullMode;
			uniform float _UseCustomTransform;
			uniform float _FakeEyeTrackingL;
			uniform float3 _VertexOffsetL;
			uniform float _ObjectSpace;
			uniform float3 _FaceForward;
			uniform float3 _FaceUp;
			uniform float3 _FaceCenterPos;
			uniform float4 _WorkingAngleLxxyy;
			uniform float4 _MoveRangeLxxyy;
			uniform float _IsBlenderCoordinateSystem;
			uniform float3 _XAxisVectorL;
			uniform float3 _YAxisVectorL;
			uniform float _FakeEyeTrackingR;
			uniform float3 _VertexOffsetR;
			uniform float4 _WorkingAngleRxxyy;
			uniform float4 _MoveRangeRxxyy;
			uniform float3 _XAxisVectorR;
			uniform float3 _YAxisVectorR;
			uniform float4 _UnsaturationColor;
			uniform float4 _CharaColor;
			uniform float _EyeShadow;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float4 _AdditionalDiffuseColor;
			uniform float4 _Shadow;
			uniform float _ShadowStep;
			uniform float _ReceiveShadowLerp;
			uniform float _ShadowFeather;
			uniform float _NoShadowinDirectionalLightColor;
			uniform float _MinDirectLight;
			uniform float _ShadowinLightColor;
			uniform float _MaxDirectLight;
			uniform float _UnifyIndirectDiffuseLight;
			uniform float _MinIndirectLight;
			uniform float _MaxIndirectLight;
			uniform float _LightColorGrayScale;
			uniform float _EyeLightFactor;
			uniform float _GlobalLightFactor;
			uniform sampler2D _EmiTex;
			uniform float4 _EmiTex_ST;
			uniform float4 _EmissiveColor;
			uniform float _EmmisiveStrength;
			uniform float _Saturation;
			inline float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max( 0.001f , dot( inVec , inVec ) );
				return inVec* rsqrt( dp3);
			}
			
			float IsThereALight(  )
			{
				return any(_WorldSpaceLightPos0.xyz);
			}
			
			float PureLightAttenuation( float3 worldPos )
			{
				#ifdef POINT
				        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
				        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
				#endif
				#ifdef SPOT
				#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))
				#else
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord
				#endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
				#endif
				#ifdef DIRECTIONAL
				        return 1;
				#endif
				#ifdef POINT_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
				#endif
				#ifdef DIRECTIONAL_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTexture0, lightCoord).w;
				#endif
			}
			
			float3 ShadeSH9out( half4 Normal )
			{
				return ShadeSH9(Normal);
			}
			
			float3 MaxShadeSH9(  )
			{
				return max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb);
			}
			


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_SHADOW_COORDS(4)
			};
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				
				float3 objToWorldDir1741 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceForward, 0 ) ).xyz );
				float3 normalizeResult1978 = normalize( ( _ObjectSpace == 0.0 ? _FaceForward : objToWorldDir1741 ) );
				float3 Forward1743 = normalizeResult1978;
				float isObjectSpace1965 = _ObjectSpace;
				float3 objToWorldDir1740 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceUp, 0 ) ).xyz );
				float3 normalizeResult1979 = normalize( ( isObjectSpace1965 == 0.0 ? _FaceUp : objToWorldDir1740 ) );
				float3 Up1742 = normalizeResult1979;
				float3 normalizeResult1732 = normalize( cross( Forward1743 , Up1742 ) );
				float3 Left1737 = normalizeResult1732;
				float3 objToWorld1733 = mul( unity_ObjectToWorld, float4( _FaceCenterPos, 1 ) ).xyz;
				float3 temp_output_1969_0 = ( isObjectSpace1965 == 0.0 ? _FaceCenterPos : objToWorld1733 );
				float3 normalizeResult1729 = normalize( ( _WorldSpaceCameraPos - temp_output_1969_0 ) );
				float3 Center2Cam1734 = normalizeResult1729;
				float dotResult1761 = dot( (Left1737).xz , (Center2Cam1734).xz );
				float Xsign1763 = sign( dotResult1761 );
				float3 FCenterPos1735 = temp_output_1969_0;
				float3 temp_output_1745_0 = ( _WorldSpaceCameraPos - FCenterPos1735 );
				float3 normalizeResult1746 = normalize( temp_output_1745_0 );
				float dotResult1749 = dot( normalizeResult1746 , Up1742 );
				float3 normalizeResult1754 = normalize( ( _WorldSpaceCameraPos - ( ( dotResult1749 * length( temp_output_1745_0 ) * Up1742 ) + FCenterPos1735 ) ) );
				float3 Cylinder1755 = normalizeResult1754;
				float dotResult1764 = dot( Forward1743 , Cylinder1755 );
				float Xvalue1768 = acos( dotResult1764 );
				float dotResult1769 = dot( Up1742 , Center2Cam1734 );
				float Ysign1778 = sign( dotResult1769 );
				float dotResult1773 = dot( Center2Cam1734 , Cylinder1755 );
				float Yvalue1777 = acos( dotResult1773 );
				float3 appendResult1836 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1781 = (float3(-_XAxisVectorL.x , _XAxisVectorL.z , -_XAxisVectorL.y));
				float3 normalizeResult1787 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1781 : _XAxisVectorL ) );
				float3 appendResult1785 = (float3(-_YAxisVectorL.x , _YAxisVectorL.z , -_YAxisVectorL.y));
				float3 normalizeResult1786 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1785 : _YAxisVectorL ) );
				float3 normalizeResult1790 = ASESafeNormalize( cross( normalizeResult1787 , normalizeResult1786 ) );
				float3x3 CustomMatrixL1802 = float3x3(normalizeResult1787, normalizeResult1786, normalizeResult1790);
				float3 appendResult1898 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1792 = (float3(-_XAxisVectorR.x , _XAxisVectorR.z , -_XAxisVectorR.y));
				float3 normalizeResult1797 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1792 : _XAxisVectorR ) );
				float3 break1806 = -_YAxisVectorR;
				float3 appendResult1795 = (float3(-break1806.x , break1806.z , -break1806.y));
				float3 normalizeResult1796 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1795 : -_YAxisVectorR ) );
				float3 normalizeResult1800 = ASESafeNormalize( cross( normalizeResult1797 , normalizeResult1796 ) );
				float3x3 CustomMatrixR1801 = float3x3(normalizeResult1797, normalizeResult1796, normalizeResult1800);
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				
				v.vertex.xyz += ( v.ase_texcoord1.y >= 0.5 ? ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )), CustomMatrixL1802 ) : (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )) ) : ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )), CustomMatrixR1801 ) : (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )) ) );
				o.pos = UnityObjectToClipPos(v.vertex);
				#if ASE_SHADOWS
					#if UNITY_VERSION >= 560
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#else
						TRANSFER_SHADOW( o );
					#endif
				#endif
				return o;
			}
			
			float4 frag (v2f i ) : SV_Target
			{
				float3 outColor;
				float outAlpha;

				float2 uv_MainTex = i.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 temp_output_1425_0 = ( tex2D( _MainTex, uv_MainTex ) * _AdditionalDiffuseColor );
				float4 Shadow1322 = _Shadow;
				float localIsThereALight797 = IsThereALight();
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float dotResult779 = dot( worldSpaceLightDir , ase_worldNormal );
				float HalfLambertTerm781 = ( localIsThereALight797 == 1.0 ? (dotResult779*0.5 + 0.5) : 1.0 );
				float localIsThereALight1962 = IsThereALight();
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float HalfShadowAttenuation1955 = ( localIsThereALight1962 == 1.0 ? (saturate( ase_atten )*0.5 + 0.5) : 1.0 );
				float shad_lerp1312 = saturate( ( ( _ShadowStep - (( _ReceiveShadowLerp )?( ( HalfLambertTerm781 * HalfShadowAttenuation1955 ) ):( HalfLambertTerm781 )) ) / _ShadowFeather ) );
				float4 lerpResult1325 = lerp( temp_output_1425_0 , ( temp_output_1425_0 * Shadow1322 ) , shad_lerp1312);
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_cast_0 = (_MinDirectLight).xxx;
				float3 temp_output_1974_0 = max( ase_lightColor.rgb , temp_cast_0 );
				float3 worldPos1939 = ase_worldPos;
				float localPureLightAttenuation1939 = PureLightAttenuation( worldPos1939 );
				float3 temp_output_1942_0 = ( temp_output_1974_0 * (( _ShadowinLightColor )?( ase_atten ):( localPureLightAttenuation1939 )) );
				float3 temp_cast_1 = (_MinDirectLight).xxx;
				float3 temp_cast_2 = (_MinDirectLight).xxx;
				#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch1941 = temp_output_1942_0;
				#else
				float3 staticSwitch1941 = temp_output_1974_0;
				#endif
				float3 temp_cast_3 = (_MaxDirectLight).xxx;
				float4 Normal1973 = float4( 0,0,0,0 );
				float3 localShadeSH9out1973 = ShadeSH9out( Normal1973 );
				float3 localMaxShadeSH9876 = MaxShadeSH9();
				float3 temp_cast_4 = (_MinIndirectLight).xxx;
				float3 temp_cast_5 = (_MaxIndirectLight).xxx;
				float3 temp_output_1706_0 = max( min( (( _NoShadowinDirectionalLightColor )?( staticSwitch1941 ):( temp_output_1942_0 )) , temp_cast_3 ) , min( max( (( _UnifyIndirectDiffuseLight )?( localMaxShadeSH9876 ):( localShadeSH9out1973 )) , temp_cast_4 ) , temp_cast_5 ) );
				float3 temp_cast_6 = (_MinDirectLight).xxx;
				float3 temp_cast_7 = (_MaxDirectLight).xxx;
				float3 temp_cast_8 = (_MinIndirectLight).xxx;
				float3 temp_cast_9 = (_MaxIndirectLight).xxx;
				float grayscale1945 = dot(temp_output_1706_0, float3(0.299,0.587,0.114));
				float3 temp_cast_10 = (grayscale1945).xxx;
				float3 lerpResult1944 = lerp( temp_output_1706_0 , temp_cast_10 , _LightColorGrayScale);
				float3 LightColor208 = lerpResult1944;
				float EyeLightFactor1708 = _EyeLightFactor;
				float4 lerpResult1712 = lerp( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) , ( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) * float4( LightColor208 , 0.0 ) ) , EyeLightFactor1708);
				float4 blend_diff916 = ( lerpResult1712 + float4( 0,0,0,0 ) );
				float GlobalLightFactor1719 = _GlobalLightFactor;
				float4 lerpResult1723 = lerp( ( _CharaColor * blend_diff916 ) , ( _CharaColor * blend_diff916 * float4( LightColor208 , 0.0 ) ) , GlobalLightFactor1719);
				float2 uv_EmiTex = i.ase_texcoord1.xy * _EmiTex_ST.xy + _EmiTex_ST.zw;
				float4 Emissive600 = tex2D( _EmiTex, uv_EmiTex );
				float4 Refined_diff612 = ( lerpResult1723 + ( Emissive600 * _EmissiveColor * _EmmisiveStrength ) );
				float dotResult614 = dot( _UnsaturationColor , Refined_diff612 );
				float4 temp_cast_13 = (dotResult614).xxxx;
				float4 lerpResult616 = lerp( temp_cast_13 , Refined_diff612 , _Saturation);
				float4 output_diff618 = lerpResult616;
				
				
				outColor = output_diff618.rgb;
				outAlpha = 1;
				return float4(outColor,outAlpha);
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }
			ZWrite On
			ZTest LEqual
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#ifndef UNITY_PASS_SHADOWCASTER
			#define UNITY_PASS_SHADOWCASTER
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_SHADOWS 1

			//This is a late directive
			
			uniform float _StencilZFailFront;
			uniform float _StencilFailFront;
			uniform float _StencilPassFront;
			uniform float _StencilComparison;
			uniform float _StencilWriteMask;
			uniform float _StencilReadMask;
			uniform float _StencilReference;
			uniform float _CullMode;
			uniform float _UseCustomTransform;
			uniform float _FakeEyeTrackingL;
			uniform float3 _VertexOffsetL;
			uniform float _ObjectSpace;
			uniform float3 _FaceForward;
			uniform float3 _FaceUp;
			uniform float3 _FaceCenterPos;
			uniform float4 _WorkingAngleLxxyy;
			uniform float4 _MoveRangeLxxyy;
			uniform float _IsBlenderCoordinateSystem;
			uniform float3 _XAxisVectorL;
			uniform float3 _YAxisVectorL;
			uniform float _FakeEyeTrackingR;
			uniform float3 _VertexOffsetR;
			uniform float4 _WorkingAngleRxxyy;
			uniform float4 _MoveRangeRxxyy;
			uniform float3 _XAxisVectorR;
			uniform float3 _YAxisVectorR;
			uniform float4 _UnsaturationColor;
			uniform float4 _CharaColor;
			uniform float _EyeShadow;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float4 _AdditionalDiffuseColor;
			uniform float4 _Shadow;
			uniform float _ShadowStep;
			uniform float _ReceiveShadowLerp;
			uniform float _ShadowFeather;
			uniform float _NoShadowinDirectionalLightColor;
			uniform float _MinDirectLight;
			uniform float _ShadowinLightColor;
			uniform float _MaxDirectLight;
			uniform float _UnifyIndirectDiffuseLight;
			uniform float _MinIndirectLight;
			uniform float _MaxIndirectLight;
			uniform float _LightColorGrayScale;
			uniform float _EyeLightFactor;
			uniform float _GlobalLightFactor;
			uniform sampler2D _EmiTex;
			uniform float4 _EmiTex_ST;
			uniform float4 _EmissiveColor;
			uniform float _EmmisiveStrength;
			uniform float _Saturation;
			inline float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max( 0.001f , dot( inVec , inVec ) );
				return inVec* rsqrt( dp3);
			}
			
			float IsThereALight(  )
			{
				return any(_WorldSpaceLightPos0.xyz);
			}
			
			float PureLightAttenuation( float3 worldPos )
			{
				#ifdef POINT
				        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
				        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
				#endif
				#ifdef SPOT
				#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))
				#else
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord
				#endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
				#endif
				#ifdef DIRECTIONAL
				        return 1;
				#endif
				#ifdef POINT_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
				#endif
				#ifdef DIRECTIONAL_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTexture0, lightCoord).w;
				#endif
			}
			
			float3 ShadeSH9out( half4 Normal )
			{
				return ShadeSH9(Normal);
			}
			
			float3 MaxShadeSH9(  )
			{
				return max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb);
			}
			


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				V2F_SHADOW_CASTER;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_SHADOW_COORDS(4)
			};

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				
				float3 objToWorldDir1741 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceForward, 0 ) ).xyz );
				float3 normalizeResult1978 = normalize( ( _ObjectSpace == 0.0 ? _FaceForward : objToWorldDir1741 ) );
				float3 Forward1743 = normalizeResult1978;
				float isObjectSpace1965 = _ObjectSpace;
				float3 objToWorldDir1740 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( _FaceUp, 0 ) ).xyz );
				float3 normalizeResult1979 = normalize( ( isObjectSpace1965 == 0.0 ? _FaceUp : objToWorldDir1740 ) );
				float3 Up1742 = normalizeResult1979;
				float3 normalizeResult1732 = normalize( cross( Forward1743 , Up1742 ) );
				float3 Left1737 = normalizeResult1732;
				float3 objToWorld1733 = mul( unity_ObjectToWorld, float4( _FaceCenterPos, 1 ) ).xyz;
				float3 temp_output_1969_0 = ( isObjectSpace1965 == 0.0 ? _FaceCenterPos : objToWorld1733 );
				float3 normalizeResult1729 = normalize( ( _WorldSpaceCameraPos - temp_output_1969_0 ) );
				float3 Center2Cam1734 = normalizeResult1729;
				float dotResult1761 = dot( (Left1737).xz , (Center2Cam1734).xz );
				float Xsign1763 = sign( dotResult1761 );
				float3 FCenterPos1735 = temp_output_1969_0;
				float3 temp_output_1745_0 = ( _WorldSpaceCameraPos - FCenterPos1735 );
				float3 normalizeResult1746 = normalize( temp_output_1745_0 );
				float dotResult1749 = dot( normalizeResult1746 , Up1742 );
				float3 normalizeResult1754 = normalize( ( _WorldSpaceCameraPos - ( ( dotResult1749 * length( temp_output_1745_0 ) * Up1742 ) + FCenterPos1735 ) ) );
				float3 Cylinder1755 = normalizeResult1754;
				float dotResult1764 = dot( Forward1743 , Cylinder1755 );
				float Xvalue1768 = acos( dotResult1764 );
				float dotResult1769 = dot( Up1742 , Center2Cam1734 );
				float Ysign1778 = sign( dotResult1769 );
				float dotResult1773 = dot( Center2Cam1734 , Cylinder1755 );
				float Yvalue1777 = acos( dotResult1773 );
				float3 appendResult1836 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleLxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleLxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeLxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1781 = (float3(-_XAxisVectorL.x , _XAxisVectorL.z , -_XAxisVectorL.y));
				float3 normalizeResult1787 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1781 : _XAxisVectorL ) );
				float3 appendResult1785 = (float3(-_YAxisVectorL.x , _YAxisVectorL.z , -_YAxisVectorL.y));
				float3 normalizeResult1786 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1785 : _YAxisVectorL ) );
				float3 normalizeResult1790 = ASESafeNormalize( cross( normalizeResult1787 , normalizeResult1786 ) );
				float3x3 CustomMatrixL1802 = float3x3(normalizeResult1787, normalizeResult1786, normalizeResult1790);
				float3 appendResult1898 = (float3(( Xsign1763 <= 0.0 ? (0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.x ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.x - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Xvalue1768 - 0.0) * (( 180.0 / _WorkingAngleRxxyy.y ) - 0.0) / (UNITY_PI - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.y - 0.0) / (1.0 - 0.0)) ) , ( Ysign1778 >= 0.0 ? (0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.z ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.z - 0.0) / (1.0 - 0.0)) : -(0.0 + (saturate( (0.0 + (Yvalue1777 - 0.0) * (( 90.0 / _WorkingAngleRxxyy.w ) - 0.0) / (( 0.5 * UNITY_PI ) - 0.0)) ) - 0.0) * (_MoveRangeRxxyy.w - 0.0) / (1.0 - 0.0)) ) , 0.0));
				float3 appendResult1792 = (float3(-_XAxisVectorR.x , _XAxisVectorR.z , -_XAxisVectorR.y));
				float3 normalizeResult1797 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1792 : _XAxisVectorR ) );
				float3 break1806 = -_YAxisVectorR;
				float3 appendResult1795 = (float3(-break1806.x , break1806.z , -break1806.y));
				float3 normalizeResult1796 = ASESafeNormalize( ( _IsBlenderCoordinateSystem == 1.0 ? appendResult1795 : -_YAxisVectorR ) );
				float3 normalizeResult1800 = ASESafeNormalize( cross( normalizeResult1797 , normalizeResult1796 ) );
				float3x3 CustomMatrixR1801 = float3x3(normalizeResult1797, normalizeResult1796, normalizeResult1800);
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				
				v.vertex.xyz += ( v.ase_texcoord1.y >= 0.5 ? ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )), CustomMatrixL1802 ) : (( _FakeEyeTrackingL )?( ( _VertexOffsetL + appendResult1836 ) ):( _VertexOffsetL )) ) : ( _UseCustomTransform == 1.0 ? mul( (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )), CustomMatrixR1801 ) : (( _FakeEyeTrackingR )?( ( _VertexOffsetR + appendResult1898 ) ):( _VertexOffsetR )) ) );
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				return o;
			}
			
			float4 frag (v2f i ) : SV_Target
			{
				float3 outColor;
				float outAlpha;

				float2 uv_MainTex = i.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 temp_output_1425_0 = ( tex2D( _MainTex, uv_MainTex ) * _AdditionalDiffuseColor );
				float4 Shadow1322 = _Shadow;
				float localIsThereALight797 = IsThereALight();
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float dotResult779 = dot( worldSpaceLightDir , ase_worldNormal );
				float HalfLambertTerm781 = ( localIsThereALight797 == 1.0 ? (dotResult779*0.5 + 0.5) : 1.0 );
				float localIsThereALight1962 = IsThereALight();
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float HalfShadowAttenuation1955 = ( localIsThereALight1962 == 1.0 ? (saturate( ase_atten )*0.5 + 0.5) : 1.0 );
				float shad_lerp1312 = saturate( ( ( _ShadowStep - (( _ReceiveShadowLerp )?( ( HalfLambertTerm781 * HalfShadowAttenuation1955 ) ):( HalfLambertTerm781 )) ) / _ShadowFeather ) );
				float4 lerpResult1325 = lerp( temp_output_1425_0 , ( temp_output_1425_0 * Shadow1322 ) , shad_lerp1312);
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_cast_0 = (_MinDirectLight).xxx;
				float3 temp_output_1974_0 = max( ase_lightColor.rgb , temp_cast_0 );
				float3 worldPos1939 = ase_worldPos;
				float localPureLightAttenuation1939 = PureLightAttenuation( worldPos1939 );
				float3 temp_output_1942_0 = ( temp_output_1974_0 * (( _ShadowinLightColor )?( ase_atten ):( localPureLightAttenuation1939 )) );
				float3 temp_cast_1 = (_MinDirectLight).xxx;
				float3 temp_cast_2 = (_MinDirectLight).xxx;
				#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch1941 = temp_output_1942_0;
				#else
				float3 staticSwitch1941 = temp_output_1974_0;
				#endif
				float3 temp_cast_3 = (_MaxDirectLight).xxx;
				float4 Normal1973 = float4( 0,0,0,0 );
				float3 localShadeSH9out1973 = ShadeSH9out( Normal1973 );
				float3 localMaxShadeSH9876 = MaxShadeSH9();
				float3 temp_cast_4 = (_MinIndirectLight).xxx;
				float3 temp_cast_5 = (_MaxIndirectLight).xxx;
				float3 temp_output_1706_0 = max( min( (( _NoShadowinDirectionalLightColor )?( staticSwitch1941 ):( temp_output_1942_0 )) , temp_cast_3 ) , min( max( (( _UnifyIndirectDiffuseLight )?( localMaxShadeSH9876 ):( localShadeSH9out1973 )) , temp_cast_4 ) , temp_cast_5 ) );
				float3 temp_cast_6 = (_MinDirectLight).xxx;
				float3 temp_cast_7 = (_MaxDirectLight).xxx;
				float3 temp_cast_8 = (_MinIndirectLight).xxx;
				float3 temp_cast_9 = (_MaxIndirectLight).xxx;
				float grayscale1945 = dot(temp_output_1706_0, float3(0.299,0.587,0.114));
				float3 temp_cast_10 = (grayscale1945).xxx;
				float3 lerpResult1944 = lerp( temp_output_1706_0 , temp_cast_10 , _LightColorGrayScale);
				float3 LightColor208 = lerpResult1944;
				float EyeLightFactor1708 = _EyeLightFactor;
				float4 lerpResult1712 = lerp( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) , ( (( _EyeShadow )?( lerpResult1325 ):( temp_output_1425_0 )) * float4( LightColor208 , 0.0 ) ) , EyeLightFactor1708);
				float4 blend_diff916 = ( lerpResult1712 + float4( 0,0,0,0 ) );
				float GlobalLightFactor1719 = _GlobalLightFactor;
				float4 lerpResult1723 = lerp( ( _CharaColor * blend_diff916 ) , ( _CharaColor * blend_diff916 * float4( LightColor208 , 0.0 ) ) , GlobalLightFactor1719);
				float2 uv_EmiTex = i.ase_texcoord1.xy * _EmiTex_ST.xy + _EmiTex_ST.zw;
				float4 Emissive600 = tex2D( _EmiTex, uv_EmiTex );
				float4 Refined_diff612 = ( lerpResult1723 + ( Emissive600 * _EmissiveColor * _EmmisiveStrength ) );
				float dotResult614 = dot( _UnsaturationColor , Refined_diff612 );
				float4 temp_cast_13 = (dotResult614).xxxx;
				float4 lerpResult616 = lerp( temp_cast_13 , Refined_diff612 , _Saturation);
				float4 output_diff618 = lerpResult616;
				
				
				outColor = output_diff618.rgb;
				outAlpha = 1;
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG
		}
		
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19200
Node;AmplifyShaderEditor.CommentaryNode;1972;-3531.603,-38.40202;Inherit;False;583.0522;495.6197;;4;600;68;345;906;Texture Input;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1970;-4401.998,2799.662;Inherit;False;1839.151;763.2612;;27;1726;1727;1728;1729;1731;1732;1734;1737;1735;1730;1736;1968;1969;1733;1739;1740;1742;1966;1967;1738;1741;1743;1963;1965;1964;1978;1979;HeadBoneTransform;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1956;-5387.377,627.3367;Inherit;False;2116.237;1227.786;;39;1706;773;825;1940;1936;1937;1938;1939;1942;826;875;303;876;301;1941;1944;1945;1946;208;780;779;776;778;1929;800;797;781;1951;1952;1953;1954;1955;1708;1707;1720;1719;1961;1962;1974;Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1928;-4191.22,4622.324;Inherit;False;1688.098;1002.819;;35;1787;1788;1802;1809;1780;1781;1782;1923;1924;1805;1783;1785;1784;1786;1789;1790;1925;1804;1791;1792;1793;1797;1798;1801;1926;1927;1794;1795;1803;1807;1808;1806;1796;1799;1800;Custom Transform;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1426;-2976.086,748.0109;Inherit;False;2172.378;763.1063;;27;1345;1325;1323;1324;1318;1309;1310;1312;1316;1314;1317;1315;1322;1321;1380;916;1390;1359;1424;1425;932;933;1712;1711;1957;1958;1959;Main Blend;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;870;-339.2699,501.8363;Inherit;False;356.8159;717.053;;7;869;865;864;868;866;867;863;Stencil;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;643;-601.8802,1347.168;Inherit;False;946.0739;1196.966;;19;609;610;605;604;611;606;612;602;613;616;614;617;615;618;1697;1721;1722;1723;1724;Emissive and other Process;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;613;-512.1442,2338.781;Inherit;False;612;Refined_diff;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;614;-263.2475,2199.979;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;616;-139.797,2250.183;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;617;-563.7191,2426.13;Inherit;False;Property;_Saturation;Saturation;13;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;618;132.6317,2238.969;Inherit;False;output_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;869;-252.8253,1102.89;Inherit;False;Property;_StencilZFailFront;Stencil ZFailFront;47;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;868;-251.8039,1014.002;Inherit;False;Property;_StencilFailFront;Stencil FailFront;46;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;864;-252.0719,921.8448;Inherit;False;Property;_StencilPassFront;Stencil PassFront;45;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;865;-254.1154,827.78;Inherit;False;Property;_StencilComparison;Stencil Comparison;44;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;866;-282.4536,729.9727;Inherit;False;Property;_StencilWriteMask;Stencil WriteMask;43;0;Create;True;0;0;0;True;0;False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;867;-287.5633,641.0858;Inherit;False;Property;_StencilReadMask;Stencil ReadMask;42;0;Create;True;0;0;0;True;0;False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1325;-1983.27,1181.129;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1323;-2450.992,1285.425;Inherit;False;1322;Shadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1324;-2288.381,1224.126;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1318;-2156.434,1290.853;Inherit;False;1312;shad_lerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1380;-1165.008,1104.351;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1359;-1808.839,1212.242;Inherit;False;208;LightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1425;-2415.715,1103.918;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;916;-1027.708,1099.753;Inherit;False;blend_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;932;-2761.884,1094.533;Inherit;True;Property;_TextureSample0;Texture Sample 0;28;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;863;-289.2696,551.8365;Inherit;False;Property;_StencilReference;Stencil Reference;41;1;[Header];Create;True;1;Stencil Buffer;0;0;True;0;False;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;609;-493.3135,1750.618;Inherit;False;600;Emissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;610;-212.5704,1771.048;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1697;-535.5019,2026.743;Inherit;False;Property;_EmmisiveStrength;EmmisiveStrength;11;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1698;538.3658,1661.995;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1701;538.3658,1970.995;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;Deferred;0;3;Deferred;4;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Deferred;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1702;538.3658,1799.995;Float;False;False;-1;2;ASEMaterialInspector;100;1;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ShadowCaster;0;4;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.ColorNode;1424;-2721.632,1299.117;Inherit;False;Property;_AdditionalDiffuseColor;AdditionalDiffuseColor;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1390;-1618.809,1190.694;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1711;-1664.585,1310.469;Inherit;False;1708;EyeLightFactor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1712;-1450.389,1114.755;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;611;-517.2138,1839.521;Inherit;False;Property;_EmissiveColor;EmissiveColor;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;615;-523.7452,2153.081;Inherit;False;Property;_UnsaturationColor;UnsaturationColor;14;1;[HDR];Create;True;0;0;0;False;0;False;0.2117647,0.7137255,0.07058824,0;0.2117647,0.7137255,0.07058824,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1717;119.2916,657.576;Inherit;False;225;166;;1;1718;Cull;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1718;169.2916,707.576;Inherit;False;Property;_CullMode;Cull Mode;48;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1700;454.0132,2352.484;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ForwardAdd;0;2;ForwardAdd;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;True;True;4;1;False;;1;False;;1;0;False;;1;False;;True;5;False;;5;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;True;True;True;0;True;_StencilReference;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComparison;0;True;_StencilPassFront;0;True;_StencilFailFront;0;True;_StencilZFailFront;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.SimpleAddOpNode;606;21.08198,1677.067;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;612;159.1932,1675.52;Inherit;False;Refined_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;602;-564.319,1389.368;Inherit;False;Property;_CharaColor;CharaColor;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;605;-539.4921,1578.86;Inherit;False;916;blend_diff;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1721;-545.2052,1663.846;Inherit;False;208;LightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;604;-315.0464,1559.61;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1722;-314.2054,1451.846;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1724;-334.2054,1683.846;Inherit;False;1719;GlobalLightFactor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1723;-143.0053,1496.446;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1744;-4044.458,3638.102;Inherit;False;1512.629;875.1907;;34;1778;1777;1776;1775;1774;1773;1772;1771;1770;1769;1768;1767;1766;1765;1764;1763;1762;1761;1760;1759;1758;1757;1756;1755;1754;1753;1752;1751;1750;1749;1748;1747;1746;1745;Tracking PreCaculate;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1810;-2483.03,2917.753;Inherit;False;1570.031;1309.381;;31;1841;1840;1839;1838;1837;1836;1835;1833;1832;1829;1828;1824;1823;1822;1821;1820;1819;1818;1817;1816;1815;1814;1813;1812;1811;1834;1831;1830;1827;1826;1825;LeftEyeTracking;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1874;-2462.696,4344.314;Inherit;False;1570.03;1315.75;;31;1905;1904;1903;1902;1901;1900;1899;1898;1897;1896;1895;1894;1893;1892;1891;1890;1889;1888;1887;1886;1885;1884;1883;1882;1881;1880;1879;1878;1877;1876;1875;RightEyeTracking;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;1875;-1846.361,4484.906;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1876;-1666.856,4486.343;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1877;-1849.928,4770.801;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1878;-1670.423,4772.237;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1879;-2053.268,4470.179;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1880;-1998.003,4546.058;Inherit;False;2;0;FLOAT;180;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1881;-2052.035,4780.073;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1882;-1504.221,4774.014;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1883;-1506.058,4481.16;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1884;-1273.498,4427.395;Inherit;False;5;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1885;-1993.505,4851.528;Inherit;False;2;0;FLOAT;180;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1886;-1845.676,5175.855;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1887;-1667.054,5176.348;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1888;-1849.276,5451.919;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1889;-1670.654,5452.412;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1890;-1504.838,5442.928;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1891;-2045.929,5175.569;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1892;-1994.277,5256.281;Inherit;False;2;0;FLOAT;90;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1893;-2045.97,5445.553;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1894;-1994.318,5526.265;Inherit;False;2;0;FLOAT;90;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;1895;-1328.487,4771.596;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;1896;-1333.308,5444.088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1897;-1206.421,5335.897;Inherit;False;3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1898;-1053.466,4838.533;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;1899;-1498.038,5171.065;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1900;-2412.696,4957.022;Inherit;False;Property;_WorkingAngleRxxyy;+/-WorkingAngleR.xxyy;30;0;Create;True;0;0;0;False;0;False;45,30,30,30;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;1901;-1787.632,4962.694;Inherit;False;Property;_MoveRangeRxxyy;+/-MoveRangeR.xxyy;29;0;Create;True;0;0;0;False;0;False;0.004,0.003,0.004,0.004;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1902;-1489.278,4394.314;Inherit;False;1763;Xsign;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1903;-2025.948,4663.75;Inherit;False;1768;Xvalue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1904;-2030.41,5360.096;Inherit;False;1777;Yvalue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1905;-1427.082,5350.817;Inherit;False;1778;Ysign;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1811;-1866.695,3051.976;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1812;-1687.19,3053.413;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1813;-1870.263,3337.87;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1814;-1690.757,3339.307;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1815;-2073.602,3037.249;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1816;-2018.337,3113.127;Inherit;False;2;0;FLOAT;180;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1817;-2072.369,3347.142;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1818;-1524.554,3341.084;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1819;-1526.391,3048.23;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1820;-2433.03,3524.091;Inherit;False;Property;_WorkingAngleLxxyy;+/-WorkingAngleL.xxyy;26;0;Create;True;0;0;0;False;0;False;30,45,30,30;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;1821;-1293.832,2994.464;Inherit;False;5;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1822;-2013.839,3418.599;Inherit;False;2;0;FLOAT;180;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1823;-1866.01,3742.924;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1824;-1687.388,3743.418;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1828;-2066.263,3742.639;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1829;-2014.611,3823.351;Inherit;False;2;0;FLOAT;90;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1832;-1807.966,3529.765;Inherit;False;Property;_MoveRangeLxxyy;+/-MoveRangeL.xxyy;25;0;Create;True;0;0;0;False;0;False;0.003,0.004,0.004,0.004;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;1833;-1348.821,3338.665;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1835;-1226.755,3902.966;Inherit;False;3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1836;-1073.799,3405.603;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;1837;-1518.372,3738.134;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1838;-1512.317,2967.753;Inherit;False;1763;Xsign;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1839;-2044.234,3238.162;Inherit;False;1768;Xvalue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1840;-2051.458,3924.475;Inherit;False;1777;Yvalue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1841;-1453.707,3918.546;Inherit;False;1778;Ysign;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1825;-1886.501,4023.697;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1826;-1707.879,4024.19;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1827;-1542.063,4014.706;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;1830;-2083.194,4017.332;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1831;-2031.543,4098.041;Inherit;False;2;0;FLOAT;90;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;1834;-1370.532,4015.866;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1745;-3763.481,3858.821;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1746;-3616.337,3849.896;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;1747;-3607.04,3933.024;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1748;-3634.808,4011.846;Inherit;False;1742;Up;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;1749;-3445.303,3901.943;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1750;-3318.334,3972.049;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1751;-3184.394,4025.515;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1752;-3926.059,4041.941;Inherit;False;1735;FCenterPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1753;-3039.962,3963.679;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1754;-2902.285,3976.336;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1755;-2759.446,3975.204;Inherit;False;Cylinder;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;1756;-3994.458,3688.102;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1757;-3983.633,4217.979;Inherit;False;1734;Center2Cam;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1758;-3809.903,4218.188;Inherit;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1759;-3972.035,4139.201;Inherit;False;1737;Left;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1760;-3809.836,4137.701;Inherit;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;1761;-3613.904,4166.189;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;1762;-3491.79,4168.186;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1763;-3375.279,4164.128;Inherit;False;Xsign;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1764;-3001.281,4164.84;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ACosOpNode;1765;-2877.819,4166.76;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1766;-3184.868,4135.429;Inherit;False;1743;Forward;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1767;-3186.283,4224.438;Inherit;False;1755;Cylinder;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1768;-2756.63,4160.171;Inherit;False;Xvalue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1769;-3707.183,4339.539;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;1770;-3585.07,4341.536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1771;-3884.314,4310.551;Inherit;False;1742;Up;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1772;-3895.915,4389.33;Inherit;False;1734;Center2Cam;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;1773;-3072.246,4345.876;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1774;-3261.713,4311.268;Inherit;False;1734;Center2Cam;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1775;-3257.93,4397.889;Inherit;False;1755;Cylinder;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ACosOpNode;1776;-2953.629,4346.058;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1777;-2833.247,4339.826;Inherit;False;Yvalue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1778;-3461.442,4336.695;Inherit;False;Ysign;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1906;-844.5308,2988.37;Inherit;False;1249.787;829.2251;;16;1922;1921;1920;1919;1918;1917;1916;1915;1914;1913;1912;1911;1910;1909;1908;1907;Vertex Fuction Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1908;-578.7957,3372.975;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1909;-794.5308,3275.316;Inherit;False;Property;_VertexOffsetL;Vertex OffsetL;23;1;[Header];Create;True;1;Vertex Function;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1910;-435.9395,3382.565;Inherit;False;1802;CustomMatrixL;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1911;-233.8359,3340.474;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1912;-93.05063,3207.027;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1913;-457.6861,3689.758;Inherit;False;1801;CustomMatrixR;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1915;-604.0518,3683.795;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1916;-786.5456,3574.667;Inherit;False;Property;_VertexOffsetR;Vertex OffsetR;27;0;Create;True;1;Vertex Function;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1917;-233.6249,3646.499;Inherit;False;2;2;0;FLOAT3;0,1,1;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1918;-88.15909,3504.581;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1919;225.6561,3159.758;Inherit;False;3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1920;60.04242,3161.64;Inherit;False;Constant;_0_9;0.5_;16;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1699;454.0132,2240.484;Float;False;True;-1;2;ASEMaterialInspector;100;12;LCPjSkshader/Eye;fe4af87006695164d84819765fe282b7;True;ForwardBase;0;1;ForwardBase;3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;True;True;True;0;True;_StencilReference;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComparison;0;True;_StencilPassFront;0;True;_StencilFailFront;0;True;_StencilZFailFront;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;True;2;False;0;;0;0;Standard;0;0;5;False;True;True;False;True;False;;False;0
Node;AmplifyShaderEditor.NormalizeNode;1787;-3321.873,4680.507;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;1788;-2955.082,4678.167;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1802;-2744.379,4672.324;Inherit;False;CustomMatrixL;-1;True;1;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.Vector3Node;1809;-3965.876,4742.991;Inherit;False;Property;_XAxisVectorL;+X Axis Vector L;33;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;1780;-3770.148,4818.665;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1781;-3646.018,4816.005;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;1782;-3770.655,4895.259;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1923;-3772.464,4674.881;Inherit;False;Property;_IsBlenderCoordinateSystem;IsBlenderCoordinateSystem;32;1;[Toggle];Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1924;-3467.79,4677.006;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1805;-3977.303,4930.197;Inherit;False;Property;_YAxisVectorL;+Y Axis Vector L;34;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;1783;-3763.784,5005;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1785;-3639.597,5003.517;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;1784;-3765.748,5079.284;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;1786;-3317.488,4869.488;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;1789;-3135.974,4862.697;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1790;-2985.781,4860.132;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1925;-3466.987,4863.66;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1804;-3969.566,5163.908;Inherit;False;Property;_XAxisVectorR;+X Axis Vector R;35;0;Create;True;2;Custom Transform Vector;(In Blender Coordinate System);0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;1791;-3781.551,5231.749;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1792;-3657.421,5229.087;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;1793;-3778.621,5309.417;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;1797;-3327.803,5096.92;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;1798;-2950.212,5098.682;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1801;-2732.723,5092.138;Inherit;False;CustomMatrixR;-1;True;1;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.Compare;1926;-3476.134,5095.518;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1927;-3475.34,5299.771;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;1794;-3722.24,5440.656;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1795;-3599.353,5444.376;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;1803;-3720.905,5514.743;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;1807;-3964.751,5374.167;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1808;-4141.22,5372.3;Inherit;False;Property;_YAxisVectorR;-Y Axis Vector R;36;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;1806;-3840.654,5447.83;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.NormalizeNode;1796;-3331.145,5305.044;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;1799;-3152.233,5294.354;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1800;-3002.039,5295.688;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1922;-333.9278,3466.95;Inherit;False;Property;_UseCustomTransform;Use Custom Transform;31;2;[Header];[Toggle];Create;True;1;Custom Transform Direction;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1314;-2512.99,808.3229;Inherit;False;Property;_ShadowStep;ShadowStep;4;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1315;-2344.325,1016.654;Inherit;False;Property;_ShadowFeather;ShadowFeather;5;0;Create;True;0;0;0;False;0;False;0.01;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1317;-2785.379,889.7416;Inherit;False;781;HalfLambertTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1316;-2184.991,817.1553;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1309;-1893.074,819.3734;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1310;-2027.774,819.6725;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;-1736.728,812.2093;Inherit;False;shad_lerp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1322;-1769.406,918.5505;Inherit;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1321;-1990.481,918.4626;Inherit;False;Property;_Shadow;Shadow;3;1;[HDR];Create;True;0;0;0;False;0;False;0.7,0.7,0.7,0;0.5188679,0.5188679,0.5188679,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1959;-2807.633,978.3679;Inherit;False;1955;HalfShadowAttenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1706;-3966.708,1365.349;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1942;-4674.568,1347.116;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;826;-4379.409,1316.5;Inherit;False;Property;_MaxDirectLight;MaxDirectLight;16;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1944;-3644.654,1367.456;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCGrayscale;1945;-3845.748,1431.222;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1946;-3904.494,1510.273;Inherit;False;Property;_LightColorGrayScale;LightColor GrayScale;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;208;-3495.141,1365.047;Inherit;False;LightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;825;-5169.267,1277.485;Inherit;False;Property;_MinDirectLight;MinDirectLight;15;1;[Header];Create;True;1;Light;0;0;False;0;False;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;773;-5027.083,1155.293;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;1936;-5283.784,1409.343;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;1937;-5108.101,1476.58;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1939;-5112.071,1391.87;Inherit;False;#ifdef POINT$        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz@ \$        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r@$#endif$$#ifdef SPOT$#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))$#else$#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord$#endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz)@$#endif$$#ifdef DIRECTIONAL$        return 1@$#endif$$#ifdef POINT_COOKIE$#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz$#   else$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord$#   endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w@$#endif$$#ifdef DIRECTIONAL_COOKIE$#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy$#   else$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord$#   endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return tex2D(_LightTexture0, lightCoord).w@$#endif;1;Create;1;True;worldPos;FLOAT3;0,0,0;In;;Inherit;False;Pure Light Attenuation;False;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1708;-3476.912,832.4066;Inherit;False;EyeLightFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1707;-3749.176,833.4706;Inherit;False;Property;_EyeLightFactor;EyeLightFactor;21;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1720;-3751.967,744.3607;Inherit;False;Property;_GlobalLightFactor;GlobalLightFactor;22;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1719;-3478.703,744.2968;Inherit;False;GlobalLightFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1951;-5337.444,996.2292;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1952;-5153.501,998.1462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1953;-5016.804,1029.2;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1954;-5173.391,1077.431;Float;False;Constant;_RemapValue3;Remap Value;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1962;-4969.545,954.1534;Inherit;False;return any(_WorldSpaceLightPos0.xyz)@;1;Create;0;Is There A Light;False;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1961;-4820.727,975.8102;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1955;-4652.956,977.9238;Inherit;False;HalfShadowAttenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1929;-5322.598,675.2253;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;780;-5311.33,820.4559;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;779;-5088.403,727.2106;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;778;-5100.163,835.2687;Float;False;Constant;_RemapValue1;Remap Value;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;776;-4929.407,749.3162;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;797;-4897.558,666.2983;Inherit;False;return any(_WorldSpaceLightPos0.xyz)@;1;Create;0;Is There A Light;False;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;800;-4720.234,723.8494;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;781;-4572.785,722.2114;Inherit;False;HalfLambertTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1726;-3353.439,2979.584;Inherit;False;1742;Up;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1727;-3061.531,3153.736;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;1728;-3313.581,3068.365;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;1729;-2928.147,3153.759;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;1731;-3182.054,2929.556;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1732;-3030.147,2931.759;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1734;-2786.847,3149.382;Inherit;False;Center2Cam;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1737;-2890.054,2928.556;Inherit;False;Left;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1735;-3039.856,3280.554;Inherit;False;FCenterPos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1730;-3354.455,2904.342;Inherit;False;1743;Forward;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1736;-3629.102,3292.546;Inherit;False;Property;_FaceCenterPos;FaceCenterPos;38;0;Create;True;1;Tracking Basis(In ObjectSpace);0;0;False;0;False;0,0.15,0;0,0.125,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1968;-3427.762,3250.205;Inherit;False;1965;isObjectSpace;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1969;-3230.095,3247.564;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;1733;-3434.369,3368.147;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;1739;-4351.998,3287.291;Inherit;False;Property;_FaceUp;FaceUp;40;0;Create;True;0;0;0;False;0;False;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;1740;-4192.646,3374.923;Inherit;False;Object;World;True;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1966;-4185.408,3242.224;Inherit;False;1965;isObjectSpace;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1967;-3993.306,3243.757;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1738;-4346.923,2991.826;Inherit;False;Property;_FaceForward;FaceForward;39;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;1741;-4171.94,3067.443;Inherit;False;Object;World;True;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1963;-4170.731,2907.761;Inherit;False;Property;_ObjectSpace;ObjectSpace;37;2;[Header];[Toggle];Create;True;1;HeadBoneTransform;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1965;-3984.632,2849.662;Inherit;False;isObjectSpace;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1964;-3943.332,2941.86;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;933;-2943.086,1092.55;Inherit;False;345;_eye;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1957;-2564.061,955.2468;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;600;-3190.55,230.5776;Inherit;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;68;-3479.57,230.2174;Inherit;True;Property;_EmiTex;Emissive (_emi) [optional];9;1;[Header];Create;False;1;Emissive and Other;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;-3212.25,11.59797;Inherit;False;_eye;-1;True;1;0;SAMPLER2D;0,0,0,0;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;906;-3481.603,14.30176;Inherit;True;Property;_MainTex;Diffuse Map (_eye);0;1;[Header];Create;False;1;Diffuse;0;0;False;0;False;None;784ceb657845ba045b7c7cede00feb22;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMaxOpNode;1974;-4848.982,1214.225;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1975;-4074.725,1227.759;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;301;-4652.379,1759.093;Inherit;False;Property;_MaxIndirectLight;MaxIndirectLight;19;0;Create;True;0;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;303;-4686.504,1669.935;Inherit;False;Property;_MinIndirectLight;MinIndirectLight;18;0;Create;True;0;0;0;False;0;False;0.1;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;876;-4854.507,1618.514;Inherit;False;return max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb)@;3;Create;0;MaxShadeSH9;False;False;0;;False;0;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;1973;-4874.136,1535.189;Inherit;False;return ShadeSH9(Normal)@;3;Create;1;True;Normal;FLOAT4;0,0,0,0;In;;Half;False;ShadeSH9out;False;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1976;-4384.026,1565.975;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1977;-4253.265,1608.724;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1941;-4673.04,1158.339;Inherit;False;Property;_Keyword2;Keyword 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1940;-4393.598,1173.338;Inherit;False;Property;_NoShadowinDirectionalLightColor;NoShadow in DirectionalLightColor;8;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1938;-4916.467,1424.622;Inherit;False;Property;_ShadowinLightColor;Shadow in LightColor;7;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;875;-4688.987,1562.513;Inherit;False;Property;_UnifyIndirectDiffuseLight;Unify IndirectDiffuseLight;17;0;Create;True;0;0;0;False;0;False;1;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1958;-2418.562,898.4468;Inherit;False;Property;_ReceiveShadowLerp;ReceiveShadowLerp;6;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1907;-462.9501,3282.734;Inherit;False;Property;_FakeEyeTrackingL;FakeEyeTrackingL;24;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1914;-473.6465,3575.184;Inherit;False;Property;_FakeEyeTrackingR;FakeEyeTrackingR;28;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1345;-1828.41,1102.49;Inherit;False;Property;_EyeShadow;EyeShadow;2;0;Create;True;0;0;0;False;0;False;1;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1921;16.67091,3038.37;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1743;-3650.811,2942.555;Inherit;False;Forward;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1978;-3795.503,2941.408;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1979;-3844.706,3210.822;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1742;-3693.109,3209.295;Inherit;False;Up;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
WireConnection;614;0;615;0
WireConnection;614;1;613;0
WireConnection;616;0;614;0
WireConnection;616;1;613;0
WireConnection;616;2;617;0
WireConnection;618;0;616;0
WireConnection;1325;0;1425;0
WireConnection;1325;1;1324;0
WireConnection;1325;2;1318;0
WireConnection;1324;0;1425;0
WireConnection;1324;1;1323;0
WireConnection;1380;0;1712;0
WireConnection;1425;0;932;0
WireConnection;1425;1;1424;0
WireConnection;916;0;1380;0
WireConnection;932;0;933;0
WireConnection;610;0;609;0
WireConnection;610;1;611;0
WireConnection;610;2;1697;0
WireConnection;1390;0;1345;0
WireConnection;1390;1;1359;0
WireConnection;1712;0;1345;0
WireConnection;1712;1;1390;0
WireConnection;1712;2;1711;0
WireConnection;606;0;1723;0
WireConnection;606;1;610;0
WireConnection;612;0;606;0
WireConnection;604;0;602;0
WireConnection;604;1;605;0
WireConnection;604;2;1721;0
WireConnection;1722;0;602;0
WireConnection;1722;1;605;0
WireConnection;1723;0;1722;0
WireConnection;1723;1;604;0
WireConnection;1723;2;1724;0
WireConnection;1875;0;1903;0
WireConnection;1875;2;1879;0
WireConnection;1875;4;1880;0
WireConnection;1876;0;1875;0
WireConnection;1877;0;1903;0
WireConnection;1877;2;1881;0
WireConnection;1877;4;1885;0
WireConnection;1878;0;1877;0
WireConnection;1880;1;1900;1
WireConnection;1882;0;1878;0
WireConnection;1882;4;1901;2
WireConnection;1883;0;1876;0
WireConnection;1883;4;1901;1
WireConnection;1884;0;1902;0
WireConnection;1884;2;1883;0
WireConnection;1884;3;1895;0
WireConnection;1885;1;1900;2
WireConnection;1886;0;1904;0
WireConnection;1886;2;1891;0
WireConnection;1886;4;1892;0
WireConnection;1887;0;1886;0
WireConnection;1888;0;1904;0
WireConnection;1888;2;1893;0
WireConnection;1888;4;1894;0
WireConnection;1889;0;1888;0
WireConnection;1890;0;1889;0
WireConnection;1890;4;1901;4
WireConnection;1892;1;1900;3
WireConnection;1894;1;1900;4
WireConnection;1895;0;1882;0
WireConnection;1896;0;1890;0
WireConnection;1897;0;1905;0
WireConnection;1897;2;1899;0
WireConnection;1897;3;1896;0
WireConnection;1898;0;1884;0
WireConnection;1898;1;1897;0
WireConnection;1899;0;1887;0
WireConnection;1899;4;1901;3
WireConnection;1811;0;1839;0
WireConnection;1811;2;1815;0
WireConnection;1811;4;1816;0
WireConnection;1812;0;1811;0
WireConnection;1813;0;1839;0
WireConnection;1813;2;1817;0
WireConnection;1813;4;1822;0
WireConnection;1814;0;1813;0
WireConnection;1816;1;1820;1
WireConnection;1818;0;1814;0
WireConnection;1818;4;1832;2
WireConnection;1819;0;1812;0
WireConnection;1819;4;1832;1
WireConnection;1821;0;1838;0
WireConnection;1821;2;1819;0
WireConnection;1821;3;1833;0
WireConnection;1822;1;1820;2
WireConnection;1823;0;1840;0
WireConnection;1823;2;1828;0
WireConnection;1823;4;1829;0
WireConnection;1824;0;1823;0
WireConnection;1829;1;1820;3
WireConnection;1833;0;1818;0
WireConnection;1835;0;1841;0
WireConnection;1835;2;1837;0
WireConnection;1835;3;1834;0
WireConnection;1836;0;1821;0
WireConnection;1836;1;1835;0
WireConnection;1837;0;1824;0
WireConnection;1837;4;1832;3
WireConnection;1825;0;1840;0
WireConnection;1825;2;1830;0
WireConnection;1825;4;1831;0
WireConnection;1826;0;1825;0
WireConnection;1827;0;1826;0
WireConnection;1827;4;1832;4
WireConnection;1831;1;1820;4
WireConnection;1834;0;1827;0
WireConnection;1745;0;1756;0
WireConnection;1745;1;1752;0
WireConnection;1746;0;1745;0
WireConnection;1747;0;1745;0
WireConnection;1749;0;1746;0
WireConnection;1749;1;1748;0
WireConnection;1750;0;1749;0
WireConnection;1750;1;1747;0
WireConnection;1750;2;1748;0
WireConnection;1751;0;1750;0
WireConnection;1751;1;1752;0
WireConnection;1753;0;1756;0
WireConnection;1753;1;1751;0
WireConnection;1754;0;1753;0
WireConnection;1755;0;1754;0
WireConnection;1758;0;1757;0
WireConnection;1760;0;1759;0
WireConnection;1761;0;1760;0
WireConnection;1761;1;1758;0
WireConnection;1762;0;1761;0
WireConnection;1763;0;1762;0
WireConnection;1764;0;1766;0
WireConnection;1764;1;1767;0
WireConnection;1765;0;1764;0
WireConnection;1768;0;1765;0
WireConnection;1769;0;1771;0
WireConnection;1769;1;1772;0
WireConnection;1770;0;1769;0
WireConnection;1773;0;1774;0
WireConnection;1773;1;1775;0
WireConnection;1776;0;1773;0
WireConnection;1777;0;1776;0
WireConnection;1778;0;1770;0
WireConnection;1908;0;1909;0
WireConnection;1908;1;1836;0
WireConnection;1911;0;1907;0
WireConnection;1911;1;1910;0
WireConnection;1912;0;1922;0
WireConnection;1912;2;1911;0
WireConnection;1912;3;1907;0
WireConnection;1915;0;1916;0
WireConnection;1915;1;1898;0
WireConnection;1917;0;1914;0
WireConnection;1917;1;1913;0
WireConnection;1918;0;1922;0
WireConnection;1918;2;1917;0
WireConnection;1918;3;1914;0
WireConnection;1919;0;1921;2
WireConnection;1919;1;1920;0
WireConnection;1919;2;1912;0
WireConnection;1919;3;1918;0
WireConnection;1699;0;618;0
WireConnection;1699;2;1919;0
WireConnection;1787;0;1924;0
WireConnection;1788;0;1787;0
WireConnection;1788;1;1786;0
WireConnection;1788;2;1790;0
WireConnection;1802;0;1788;0
WireConnection;1780;0;1809;1
WireConnection;1781;0;1780;0
WireConnection;1781;1;1809;3
WireConnection;1781;2;1782;0
WireConnection;1782;0;1809;2
WireConnection;1924;0;1923;0
WireConnection;1924;2;1781;0
WireConnection;1924;3;1809;0
WireConnection;1783;0;1805;1
WireConnection;1785;0;1783;0
WireConnection;1785;1;1805;3
WireConnection;1785;2;1784;0
WireConnection;1784;0;1805;2
WireConnection;1786;0;1925;0
WireConnection;1789;0;1787;0
WireConnection;1789;1;1786;0
WireConnection;1790;0;1789;0
WireConnection;1925;0;1923;0
WireConnection;1925;2;1785;0
WireConnection;1925;3;1805;0
WireConnection;1791;0;1804;1
WireConnection;1792;0;1791;0
WireConnection;1792;1;1804;3
WireConnection;1792;2;1793;0
WireConnection;1793;0;1804;2
WireConnection;1797;0;1926;0
WireConnection;1798;0;1797;0
WireConnection;1798;1;1796;0
WireConnection;1798;2;1800;0
WireConnection;1801;0;1798;0
WireConnection;1926;0;1923;0
WireConnection;1926;2;1792;0
WireConnection;1926;3;1804;0
WireConnection;1927;0;1923;0
WireConnection;1927;2;1795;0
WireConnection;1927;3;1807;0
WireConnection;1794;0;1806;0
WireConnection;1795;0;1794;0
WireConnection;1795;1;1806;2
WireConnection;1795;2;1803;0
WireConnection;1803;0;1806;1
WireConnection;1807;0;1808;0
WireConnection;1806;0;1807;0
WireConnection;1796;0;1927;0
WireConnection;1799;0;1797;0
WireConnection;1799;1;1796;0
WireConnection;1800;0;1799;0
WireConnection;1316;0;1314;0
WireConnection;1316;1;1958;0
WireConnection;1309;0;1310;0
WireConnection;1310;0;1316;0
WireConnection;1310;1;1315;0
WireConnection;1312;0;1309;0
WireConnection;1322;0;1321;0
WireConnection;1706;0;1975;0
WireConnection;1706;1;1977;0
WireConnection;1942;0;1974;0
WireConnection;1942;1;1938;0
WireConnection;1944;0;1706;0
WireConnection;1944;1;1945;0
WireConnection;1944;2;1946;0
WireConnection;1945;0;1706;0
WireConnection;208;0;1944;0
WireConnection;1939;0;1936;0
WireConnection;1708;0;1707;0
WireConnection;1719;0;1720;0
WireConnection;1952;0;1951;0
WireConnection;1953;0;1952;0
WireConnection;1953;1;1954;0
WireConnection;1953;2;1954;0
WireConnection;1961;0;1962;0
WireConnection;1961;2;1953;0
WireConnection;1955;0;1961;0
WireConnection;779;0;1929;0
WireConnection;779;1;780;0
WireConnection;776;0;779;0
WireConnection;776;1;778;0
WireConnection;776;2;778;0
WireConnection;800;0;797;0
WireConnection;800;2;776;0
WireConnection;781;0;800;0
WireConnection;1727;0;1728;0
WireConnection;1727;1;1969;0
WireConnection;1729;0;1727;0
WireConnection;1731;0;1730;0
WireConnection;1731;1;1726;0
WireConnection;1732;0;1731;0
WireConnection;1734;0;1729;0
WireConnection;1737;0;1732;0
WireConnection;1735;0;1969;0
WireConnection;1969;0;1968;0
WireConnection;1969;2;1736;0
WireConnection;1969;3;1733;0
WireConnection;1733;0;1736;0
WireConnection;1740;0;1739;0
WireConnection;1967;0;1966;0
WireConnection;1967;2;1739;0
WireConnection;1967;3;1740;0
WireConnection;1741;0;1738;0
WireConnection;1965;0;1963;0
WireConnection;1964;0;1963;0
WireConnection;1964;2;1738;0
WireConnection;1964;3;1741;0
WireConnection;1957;0;1317;0
WireConnection;1957;1;1959;0
WireConnection;600;0;68;0
WireConnection;345;0;906;0
WireConnection;1974;0;773;1
WireConnection;1974;1;825;0
WireConnection;1975;0;1940;0
WireConnection;1975;1;826;0
WireConnection;1976;0;875;0
WireConnection;1976;1;303;0
WireConnection;1977;0;1976;0
WireConnection;1977;1;301;0
WireConnection;1941;1;1974;0
WireConnection;1941;0;1942;0
WireConnection;1940;0;1942;0
WireConnection;1940;1;1941;0
WireConnection;1938;0;1939;0
WireConnection;1938;1;1937;0
WireConnection;875;0;1973;0
WireConnection;875;1;876;0
WireConnection;1958;0;1317;0
WireConnection;1958;1;1957;0
WireConnection;1907;0;1909;0
WireConnection;1907;1;1908;0
WireConnection;1914;0;1916;0
WireConnection;1914;1;1915;0
WireConnection;1345;0;1425;0
WireConnection;1345;1;1325;0
WireConnection;1743;0;1978;0
WireConnection;1978;0;1964;0
WireConnection;1979;0;1967;0
WireConnection;1742;0;1979;0
ASEEND*/
//CHKSM=FBD0F0771B110CE45295ED9D9510FB1FC2DE73C0