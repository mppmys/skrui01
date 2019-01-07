"SELECT '201712' month_id,"
"       '079' prov_id,"
"       'zhqg'  comp_name,"
"       A.COMP_TYPE COMP_TYPE,"
        
"       COUNT(DISTINCT (A.comp_id))   comp_da,--套餐到达   去重"
"        COUNT(DISTINCT(CASE WHEN  A.IS_DEV='1' THEN A.comp_id END ) )  comp_xz,   --新增套餐数"
"       SUM(nvl(COMP_TOTAL_FEE,0)) COMP_TOTAL_FEE,    --融合套餐出账收入"
"       CASE WHEN B.service_type LIKE ('40%') THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END modell_fee,  --融合移动用户出账"
"       CASE WHEN B.service_type LIKE ('04%') THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END kuand_fee,   --融合宽带用户出账"
"       CASE WHEN B.service_type LIKE ('04%') AND B.IS_DEV='1' THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END dev_kuand_fee,   --新发展宽带宽带收入"
       CASE WHEN B.service_type LIKE ('40%') AND B.IS_ACCT='1' THEN COUNT(user_id) ELSE 0 END modell_cnt  --移动出账用户
 FROM
"(SELECT  month_id,"
"        COMP_ID,"
"        COMP_TYPE,"
"        IS_DEV,"
"        IS_ACCT,"
"        IS_COMP_VALID,     --   1  到达"
        COMP_TOTAL_FEE
FROM ZBG_DWA.DWA_V_M_CUS_CB_RH_COMP_WIT_079@LINK_DSSDWE
"WHERE month_id='201712' AND COMP_TYPE IN ('81', '82', '83') "
      AND IS_COMP_VALID='1') A
","
"(SELECT  COMP_ID,"
"        USER_ID,"
"        COMP_TYPE,"
"        service_type,--04AAAAAA 宽带 01AAAAAA固话 40AAAAAA 手机"
"        USER_TOTAL_FEE,"
"        IS_COMP_VALID,"
"        IS_DEV,"
        IS_ACCT
FROM ZBG_DWA.DWA_V_M_CUS_CB_RH_MEM_WIT_079@LINK_DSSDWE
"WHERE month_id='201712' AND COMP_TYPE IN ('81', '82', '83')"
AND IS_MEM_VALID='1' AND IS_COMP_VALID='1') B
WHERE A.comp_id=B.comp_id(+)
"GROUP BY A.IS_DEV,A.COMP_TYPE,B.service_type,B.IS_DEV,B.IS_ACCT"



UNION ALL
"(SELECT '201712' month_id,"
"       '079' prov_id,"
"       'zhbd'  comp_name,"
"       A.COMP_TYPE COMP_TYPE,"
"       count(distinct(A.comp_id)) ELSE 0 END comp_da,  --套餐到达"
"       count(distinct(CASE WHEN A.IS_DEV='1' THEN A.comp_id ELSE NULL END)) comp_xz,   --新增套餐数"
"       SUM(nvl(COMP_TOTAL_FEE,0)) COMP_TOTAL_FEE,    --融合套餐出账收入"
"       CASE WHEN B.service_type LIKE ('40%') THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END modell_fee,  --融合移动用户出账"
"       CASE WHEN B.service_type LIKE ('04%') THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END kuand_fee,   --融合宽带用户出账"
"       CASE WHEN B.service_type LIKE ('04%') AND B.IS_DEV='1' THEN SUM(nvl(B.USER_TOTAL_FEE,0)) ELSE 0 END dev_kuand_fee,   --新发展宽带宽带收入"
       CASE WHEN B.service_type LIKE ('40%') AND B.IS_ACCT='1' THEN COUNT(user_id) ELSE 0 END modell_cnt  --移动出账用户
FROM
"(SELECT COMP_ID,"
"        COMP_TYPE,"
"        comp_TOTAL_FEE,"
"        IS_COMP_VALID,"
        IS_DEV
FROM  ZBA_DWA.DWA_V_M_CUS_MB_RH_comp_WIT_079
"WHERE MONTH_ID='201712' AND COMP_TYPE in ('71','72','73')"
"      AND IS_COMP_VALID='1' ) A,   --71  智慧沃家套餐数-本地共享版(B侧)    72 智慧沃家套餐数-本地组合版(B侧)   73  智慧沃家套餐数-本地组合优化版(B侧)"
"(SELECT COMP_ID,"
"        user_id,"
"        COMP_TYPE,"
"        SERVICE_TYPE,"
"        USER_TOTAL_FEE,"
"        IS_COMP_VALID,"
"        IS_DEV,"
        IS_ACCT
FROM  ZBA_DWA.DWA_V_M_CUS_MB_RH_MEM_WIT_079
"WHERE MONTH_ID='201712' AND COMP_TYPE in ('71','72','73')"
AND IS_MEM_VALID='1' AND IS_COMP_VALID='1') B

WHERE A.comp_id=B.comp_id(+)
"GROUP BY  ,A.IS_DEV,A.COMP_TYPE,B.service_type,B.IS_DEV,B.IS_ACCT)"




UNION ALL
"(SELECT '201712' month_id,"
"        '079' prov_id,"
"        'wjt' comp_name,"
"         COMP_TYPE ,"
"         SUM(COMP_DA) COMP_DA,"
"         SUM(COMP_XZ) COMP_XZ,"
"         SUM(COMP_TOTAL_FEE) COMP_TOTAL_FEE,"
"         SUM(MODELL_FEE) MODELL_FEE,"
"         SUM(KUAND_FEE) KUAND_FEE,"
"         SUM(DEV_KUAND_FEE) DEV_KUAND_FEE,"
         SUM(MODELL_CNT) MODELL_CNT

FROM (
" SELECT '201712' month_id,"
"        '079' prov_id,"
"         A.COMP_TYPE,"
"         count(DISTINCT(A.comp_id)) comp_da,"
"         count(CASE WHEN A.IS_THIS_COMP_ADD='1' THEN A.comp_id ELSE NULL END) comp_xz,"
"         CASE WHEN A.IS_COMP_VALID='1' THEN SUM(NVL(B.TOTAL_FEE,0)) ELSE 0 END COMP_TOTAL_FEE,"
"         CASE WHEN B.SERVICE_TYPE LIKE ('30%')  THEN SUM(NVL(B.TOTAL_FEE,0)) ELSE 0 END modell_fee,"
"         CASE WHEN B.SERVICE_TYPE LIKE ('04%')  THEN SUM(NVL(B.TOTAL_FEE,0)) ELSE 0 END kuand_fee,"
"         CASE WHEN B.SERVICE_TYPE LIKE ('04%')  AND B.IS_THIS_DEV='1' THEN SUM(NVL(B.TOTAL_FEE,0)) ELSE 0 END dev_kuand_fee,"
         CASE WHEN B.SERVICE_TYPE LIKE ('30%')  AND B.is_acct='1' THEN COUNT(b.USER_ID) ELSE 0 END modell_cnt

 FROM
" ( SELECT COMP_ID,"
"        COMP_TYPE,"
"        IS_COMP_VALID,"
        IS_THIS_COMP_ADD
 FROM
 ZBA_DWA.DWA_V_M_CUS_AL_ORDER_GROUP_079
" WHERE COMP_TYPE IN ('61','62','67')    --沃家庭A,沃家庭B,沃自由"
 AND month_id='201712'
" AND IS_COMP_VALID='1' ) A,"
"(SELECT W.COMP_ID,"
"        'B'||W.USER_ID USER_ID,"
"        W.SERVICE_TYPE, --30AAAAAA  移动，04AAAAAA  宽带"
"        W.is_acct,"
"        W.IS_THIS_DEV,"
        
        sum(CASE WHEN w.SERVICE_TYPE LIKE ('30%') THEN yd_fee.total_fee 
                 WHEN w.SERVICE_TYPE LIKE ('04%')ELSE kd_fee.total_fee
                   END ) TOTAL_FEE
FROM ( SELECT * 
     FROM  ZBA_DWA.DWA_V_M_CUS_AL_ORD_MEMBER_079
     WHERE month_id='201712' AND IS_COMP_VALID='1' AND IS_VALID='1'
"     AND COMP_TYPE IN ('61','62','67')"
"     AND ) w,"
     (SELECT * 
     FROM   ZBG_DWA.DWA_V_M_CUS_NM_CHARGE_079@LINK_DSSDWE 
"     WHERE month_id='201712') yd_fee,"
     (SELECT * 
     FROM  ZBA_DWA.DWA_V_M_CUS_BB_RH_SCHARGE_011 --宽带出账
"     WHERE month_id='201712') kd_fee,"
WHERE   
       'B'||w.user_id=yd_fee.user_id(+) 
   AND 'B'||w.user_id=kd_fee.user_id(+)
" GROUP BY w.COMP_ID,w.user_id,w.SERVICE_TYPE, W.is_acct,"
        W.IS_THIS_DEV
 ) B
 WHERE A.comp_id=B.comp_id(+)
"GROUP BY A.comp_id,A.COMP_TYPE, A.IS_THIS_COMP_ADD,B.SERVICE_TYPE,B.IS_COMP_VALID, B.IS_THIS_DEV,B.is_acct"
)
GROUP BY COMP_TYPE)
