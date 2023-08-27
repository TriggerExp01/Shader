Shader "Unlit/005"
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
                fixed3 color:Color;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float3 worldLight = normalize(_WorldSpaceLightPos0.xyz) ;
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal,worldLight));
                o.color = diffuse + ambient;
                return  o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return  fixed4(i.color,1);
            }
            ENDCG
        }
    }
}
