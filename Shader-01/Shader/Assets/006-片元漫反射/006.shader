Shader "Unlit/006"
{
    Properties
    {
        _Diffuse ("Diffuse", Color) =  (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            float4 _Diffuse;

            struct v2f
            {
                float4 vertex : SV_Position;
                fixed3 worldNormal:TEXCOORD0;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return  o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                float3 worldLight = normalize(_WorldSpaceLightPos0.xyz) ;
                float3 worldNormal = UnityObjectToWorldNormal(i.worldNormal);
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(0,dot(worldNormal,worldLight));
                fixed3 color = diffuse + ambient;
                return  fixed4(color,1);
            }
            ENDCG
        }
    }
}
