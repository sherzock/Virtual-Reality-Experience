// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "EarthShader"
{
	Properties
	{
		_ShadowIntensity("ShadowIntensity", Range( 0 , 10)) = 0
		_EarthLightSideAlbedo("EarthLightSide Albedo", 2D) = "white" {}
		_EarthDarkSideAlbedo("EarthDarkSide Albedo", 2D) = "white" {}
		_LightNightAlbedo("LightNight Albedo", 2D) = "white" {}
		_LightNightIntensity("LightNight Intensity", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _EarthLightSideAlbedo;
		uniform float4 _EarthLightSideAlbedo_ST;
		uniform sampler2D _EarthDarkSideAlbedo;
		uniform float4 _EarthDarkSideAlbedo_ST;
		uniform float _ShadowIntensity;
		uniform sampler2D _LightNightAlbedo;
		uniform float4 _LightNightAlbedo_ST;
		uniform float _LightNightIntensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_EarthLightSideAlbedo = i.uv_texcoord * _EarthLightSideAlbedo_ST.xy + _EarthLightSideAlbedo_ST.zw;
			float2 uv_EarthDarkSideAlbedo = i.uv_texcoord * _EarthDarkSideAlbedo_ST.xy + _EarthDarkSideAlbedo_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float clampResult13 = clamp( ( ase_worldPos.x * _ShadowIntensity ) , 0.0 , 1.0 );
			float4 lerpResult10 = lerp( tex2D( _EarthLightSideAlbedo, uv_EarthLightSideAlbedo ) , tex2D( _EarthDarkSideAlbedo, uv_EarthDarkSideAlbedo ) , clampResult13);
			o.Albedo = lerpResult10.rgb;
			float2 uv_LightNightAlbedo = i.uv_texcoord * _LightNightAlbedo_ST.xy + _LightNightAlbedo_ST.zw;
			float4 temp_output_25_0 = ( tex2D( _LightNightAlbedo, uv_LightNightAlbedo ) * _LightNightIntensity );
			float4 lerpResult24 = lerp( temp_output_25_0 , temp_output_25_0 , clampResult13);
			o.Emission = lerpResult24.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
278;73;1635;712;1654.156;1013.899;2.408386;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-786.5002,-422.218;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;3;-907.5001,-221.218;Inherit;False;Property;_ShadowIntensity;ShadowIntensity;0;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;403.3658,487.8447;Inherit;False;Property;_LightNightIntensity;LightNight Intensity;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;355.0224,266.4867;Inherit;True;Property;_LightNightAlbedo;LightNight Albedo;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-571.5,-396.218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-187.5461,-874.5988;Inherit;True;Property;_EarthLightSideAlbedo;EarthLightSide Albedo;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;13;-211.1923,-383.2788;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;711.9838,322.6777;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;11;-184.1463,-665.9987;Inherit;True;Property;_EarthDarkSideAlbedo;EarthDarkSide Albedo;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;10;225.2536,-493.3986;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-546.3341,-13.50948;Inherit;False;Property;_DarkSideFresnelIntensity;DarkSideFresnelIntensity;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-210.9723,355.1924;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;24;950.2209,231.3474;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;4;-519.6585,196.5929;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-852.0942,312.3916;Inherit;False;Property;_PowerFresnel;PowerFresnel;2;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-887.5739,226.127;Inherit;False;Property;_ScaleFresnel;ScaleFresnel;1;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-117.5084,-6.553833;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;17;267.7067,8.705526;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-583.7417,439.9126;Inherit;False;Property;_RimLightEarthColor;RimLightEarthColor;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1403.933,-322.8174;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;EarthShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;3;0
WireConnection;13;0;2;0
WireConnection;25;0;20;0
WireConnection;25;1;26;0
WireConnection;10;0;8;0
WireConnection;10;1;11;0
WireConnection;10;2;13;0
WireConnection;15;0;4;0
WireConnection;15;1;14;0
WireConnection;24;0;25;0
WireConnection;24;1;25;0
WireConnection;24;2;13;0
WireConnection;4;2;5;0
WireConnection;4;3;6;0
WireConnection;18;0;19;0
WireConnection;18;1;15;0
WireConnection;17;0;15;0
WireConnection;17;1;18;0
WireConnection;17;2;13;0
WireConnection;0;0;10;0
WireConnection;0;2;24;0
ASEEND*/
//CHKSM=63BBEC76F67B664DF1808BA795820DDACF0BC835