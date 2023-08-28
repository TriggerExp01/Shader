Shader "Unlit/002"
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

            //POSITION 顶点信息  SV_POSITION 裁剪空间的 顶点信息 语义 
            float4 vert(float4 v :POSITION):SV_POSITION
            {
                return  UnityObjectToClipPos(v);
            }

            fixed4 frag():SV_Target
            {
                return fixed4(0,0,0,0);
            }
            ENDCG
        }
    }
}
