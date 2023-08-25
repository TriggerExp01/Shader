Shader "Unlit/004"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            
            struct v2f //vert dao frag
            {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };
            //POSITION 顶点信息  SV_POSITION 裁剪空间的 顶点信息 语义 
            v2f vert(appdata_full v)
            {
                v2f O ;
                O.pos = UnityObjectToClipPos(v.vertex);
                //法线
                O.color = v.normal * 0.5 + fixed3 (0.5,0.5,0.5);
                //切线
                O.color = v.tangent.xyz * 0.5 + fixed3 (0.5,0.5,0.5);
                //uv
                O.color = fixed4 (v.texcoord.xy , 0,1 );
                //顶点颜色
                O.color = v.color;
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
