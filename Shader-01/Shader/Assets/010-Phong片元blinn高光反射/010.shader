Shader "Unlit/010"
{
      Properties
    {
        _Diffuse ("Diffuse", Color) =  (1,1,1,1)
        _Specular("Specular", Color) =  (1,1,1,1)
        _Gloss("Gloss", Range(1,256)) =  1
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
            float4 _Specular;
            float _Gloss;

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
                worldLight = WorldSpaceLightDir(i.vertex);
                float3 worldNormal =i.worldNormal;
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(0,dot(worldNormal,worldLight));



                fixed3 reflectDir =normalize(reflect(-worldLight , worldNormal));
                fixed3 viewDir = normalize(_WorldSpaceCameraPos - mul(unity_ObjectToWorld, i.vertex).xyz);
                fixed3 halfDir = normalize(worldLight + viewDir);//半角方向  视角方向 + 光照方向
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow( max(0,dot( halfDir , worldNormal)) , _Gloss);
                fixed3 color = diffuse + ambient +specular;
                return fixed4(color,1);
            }
            ENDCG
        }
    }
}
