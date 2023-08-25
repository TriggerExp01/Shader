Shader "Unlit/003"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color) = (1,1,1,1)
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

            //只有在cgprogram内 再次定义一个与属性块儿内名字和类型相同的的变量，才能起左右
            fixed4 _Color;

            #include "UnityCG.cginc"
            
            struct a2v   // application dao  vert
            {
                //用模型顶点填充v 变量
                float4 v : POSITION;
                //用模型的法线填充n变量
                float3 n : NORMAL;
                //用模型的第一套uv填充 texcood
                float4 texcoord : TEXCOORD0;
            };
            
            struct v2f //vert dao frag
            {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };
            //POSITION 顶点信息  SV_POSITION 裁剪空间的 顶点信息 语义 
            v2f vert(appdata_base v)
            {
                v2f O ;
                O.pos = UnityObjectToClipPos(v.vertex);
                O.color = v.normal * 0.5 + fixed3 (0.5,0.5,0.5);
                return O;
            }

            fixed4 frag(v2f i):SV_Target
            {
                fixed3 c  = i.color;
                c*=_Color.rgb;
                return fixed4(c,1);
            }
            ENDCG
        }
    }
}
