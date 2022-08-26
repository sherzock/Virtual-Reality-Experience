// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "EarthShader"
{
	Properties
	{
		_ShadowIntensity("ShadowIntensity", Range( 0 , 1)) = 0
		_ScaleFresnel("ScaleFresnel", Range( 0 , 10)) = 0
		_PowerFresnel("PowerFresnel", Range( 0 , 10)) = 0
		_EarthLightSideAlbedo("EarthLightSide Albedo", 2D) = "white" {}
		_EarthDarkSideAlbedo("EarthDarkSide Albedo", 2D) = "white" {}
		_RimLightEarthColor("RimLightEarthColor", Color) = (0,0,0,0)
		_DarkSideFresnelIntensity("DarkSideFresnelIntensity", Range( -10 , 10)) = 0
		_LightNightAlbedo("LightNight Albedo", 2D) = "white" {}
		_LightNightIntensity("LightNight Intensity", Range( 0 , 50)) = 0
		_MaskMapSea("MaskMapSea", 2D) = "white" {}
		_SmoothnessWater("SmoothnessWater", Range( 0 , 1)) = 0
		_SmoothnessLand("SmoothnessLand", Range( 0 , 1)) = 0
		_EarthNormal("EarthNormal", 2D) = "bump" {}
		_NormalIntensity("NormalIntensity", Range( 0 , 5)) = 0
		_SpeedRotationEarth("SpeedRotationEarth", Range( 0 , 1)) = 0
		_Clouds("Clouds", 2D) = "white" {}
		_DarkSideCloudIntensity("DarkSideCloudIntensity", Range( -50 , 50)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _EarthNormal;
		uniform float _SpeedRotationEarth;
		uniform float _NormalIntensity;
		uniform sampler2D _EarthLightSideAlbedo;
		uniform sampler2D _EarthDarkSideAlbedo;
		uniform float _ShadowIntensity;
		uniform sampler2D _Clouds;
		uniform float _DarkSideCloudIntensity;
		uniform float _ScaleFresnel;
		uniform float _PowerFresnel;
		uniform float4 _RimLightEarthColor;
		uniform float _DarkSideFresnelIntensity;
		uniform sampler2D _LightNightAlbedo;
		uniform float _LightNightIntensity;
		uniform float _SmoothnessLand;
		uniform float _SmoothnessWater;
		uniform sampler2D _MaskMapSea;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime36 = _Time.y * _SpeedRotationEarth;
			float2 panner38 = ( mulTime36 * float2( 1,0 ) + i.uv_texcoord);
			o.Normal = UnpackScaleNormal( tex2D( _EarthNormal, panner38 ), _NormalIntensity );
			float3 ase_worldPos = i.worldPos;
			float clampResult13 = clamp( ( ase_worldPos.x * _ShadowIntensity ) , 0.0 , 1.0 );
			float4 lerpResult10 = lerp( tex2D( _EarthLightSideAlbedo, panner38 ) , tex2D( _EarthDarkSideAlbedo, panner38 ) , clampResult13);
			o.Albedo = lerpResult10.rgb;
			float4 tex2DNode39 = tex2D( _Clouds, panner38 );
			float4 lerpResult42 = lerp( tex2DNode39 , ( tex2DNode39 * _DarkSideCloudIntensity ) , clampResult13);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV4 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode4 = ( 0.0 + _ScaleFresnel * pow( 1.0 - fresnelNdotV4, _PowerFresnel ) );
			float4 temp_output_15_0 = ( fresnelNode4 * _RimLightEarthColor );
			float4 lerpResult17 = lerp( temp_output_15_0 , ( _DarkSideFresnelIntensity * temp_output_15_0 ) , clampResult13);
			o.Emission = ( lerpResult42 + ( lerpResult17 + ( clampResult13 * ( tex2D( _LightNightAlbedo, panner38 ) * _LightNightIntensity ) ) ) ).rgb;
			float lerpResult30 = lerp( _SmoothnessLand , _SmoothnessWater , tex2D( _MaskMapSea, panner38 ).r);
			o.Smoothness = lerpResult30;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
284;73;1687;701;636.6724;656.3236;1.779315;True;True
Node;AmplifyShaderEditor.RangedFloatNode;35;-2384.018,-181.4336;Inherit;False;Property;_SpeedRotationEarth;SpeedRotationEarth;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1674.396,266.4769;Inherit;False;Property;_ScaleFresnel;ScaleFresnel;1;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2032.735,-307.8389;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;36;-1986.373,-176.7071;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1638.917,352.7415;Inherit;False;Property;_PowerFresnel;PowerFresnel;2;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-1370.564,480.2625;Inherit;False;Property;_RimLightEarthColor;RimLightEarthColor;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-925.7,-231.618;Inherit;False;Property;_ShadowIntensity;ShadowIntensity;0;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;4;-1306.481,236.9428;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-838.4997,-415.718;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;38;-1712.735,-178.8389;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-383.4564,528.1946;Inherit;False;Property;_LightNightIntensity;LightNight Intensity;8;0;Create;True;0;0;0;False;0;False;0;0;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1279.156,-1.15962;Inherit;False;Property;_DarkSideFresnelIntensity;DarkSideFresnelIntensity;6;0;Create;True;0;0;0;False;0;False;0;0;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-431.7998,306.8365;Inherit;True;Property;_LightNightAlbedo;LightNight Albedo;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-997.7946,395.5423;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-571.5,-396.218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-16.26337,-267.721;Inherit;True;Property;_Clouds;Clouds;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-17.4709,-37.12229;Inherit;False;Property;_DarkSideCloudIntensity;DarkSideCloudIntensity;16;0;Create;True;0;0;0;False;0;False;0;0;-50;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;13;-346.3921,-342.9792;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-904.3309,33.79603;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-74.83835,363.0276;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;17;-519.1155,49.05538;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;117.3661,296.7343;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;358.1712,-44.66747;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;11;-184.1463,-665.9987;Inherit;True;Property;_EarthDarkSideAlbedo;EarthDarkSide Albedo;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-211.0387,721.5206;Inherit;False;Property;_SmoothnessLand;SmoothnessLand;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-187.5461,-874.5988;Inherit;True;Property;_EarthLightSideAlbedo;EarthLightSide Albedo;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;28;394.5943,109.3702;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-216.3135,803.2709;Inherit;False;Property;_SmoothnessWater;SmoothnessWater;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;421.9924,-711.7317;Inherit;False;Property;_NormalIntensity;NormalIntensity;13;0;Create;True;0;0;0;False;0;False;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-399.377,903.8408;Inherit;True;Property;_MaskMapSea;MaskMapSea;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;42;665.8705,-180.7851;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;10;275.6598,-478.2767;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;30;137.1769,826.279;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;848.4866,-802.2092;Inherit;True;Property;_EarthNormal;EarthNormal;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;937.4407,-119.0009;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1403.933,-322.8174;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;EarthShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;35;0
WireConnection;4;2;5;0
WireConnection;4;3;6;0
WireConnection;38;0;37;0
WireConnection;38;1;36;0
WireConnection;20;1;38;0
WireConnection;15;0;4;0
WireConnection;15;1;14;0
WireConnection;2;0;1;1
WireConnection;2;1;3;0
WireConnection;39;1;38;0
WireConnection;13;0;2;0
WireConnection;18;0;19;0
WireConnection;18;1;15;0
WireConnection;25;0;20;0
WireConnection;25;1;26;0
WireConnection;17;0;15;0
WireConnection;17;1;18;0
WireConnection;17;2;13;0
WireConnection;27;0;13;0
WireConnection;27;1;25;0
WireConnection;43;0;39;0
WireConnection;43;1;44;0
WireConnection;11;1;38;0
WireConnection;8;1;38;0
WireConnection;28;0;17;0
WireConnection;28;1;27;0
WireConnection;29;1;38;0
WireConnection;42;0;39;0
WireConnection;42;1;43;0
WireConnection;42;2;13;0
WireConnection;10;0;8;0
WireConnection;10;1;11;0
WireConnection;10;2;13;0
WireConnection;30;0;32;0
WireConnection;30;1;31;0
WireConnection;30;2;29;0
WireConnection;33;1;38;0
WireConnection;33;5;34;0
WireConnection;40;0;42;0
WireConnection;40;1;28;0
WireConnection;0;0;10;0
WireConnection;0;1;33;0
WireConnection;0;2;40;0
WireConnection;0;4;30;0
ASEEND*/
//CHKSM=73C36A0CA157599FFB41FFD857BF750246CD5542