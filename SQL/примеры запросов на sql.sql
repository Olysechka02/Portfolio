select
 --   bsss."NAME" ,
    date_trunc('day', bsss."CREATED_TIME") AS "day",
    bsss."OWNER_ID",
    bsss."UF_CRM_1695137337" ,
    count(distinct bsss."OWNER_ID")
FROM bitrix_sdelki bsss
where bsss."UTM_SOURCE" is null 
	  and bsss."UF_CRM_1695137337" is not null 
	  and bsss."DATE_CREATE" > '2025-01-01' 
	  and bsss."NAME" = 'Встреча назначена'
group by 
   bsss."OWNER_ID",
    bsss."UF_CRM_1695137337",
    bsss."CREATED_TIME"


-- Расчеты с учетом возможных NULL
    COALESCE("cost", 0) * 1.2 * COALESCE(comission_percent, 1) + COALESCE(comission_fix, 0) AS "rashod_s_nds_ak",
 	CASE 
        WHEN p."status....row.status" like '%pending%' THEN 0
        ELSE COALESCE(budget_plan, 0) * 1.2 * COALESCE(comission_percent, 1) + COALESCE(comission_fix, 0)
    END AS "rashod_s_nds_ak_plan",      
    (COALESCE("cost", 0) * 1.2) AS "rashod_s_nds",
	CASE 
        WHEN p."status....row.status" like '%pending%' THEN 0
        ELSE (COALESCE(budget_plan, 0) * 1.2)
    END AS "rashod_s_nds_plan",    
    CASE 
        WHEN COALESCE(budget_plan, 0) = 0 THEN 0
        ELSE COALESCE("cost", 0) / budget_plan 
    END AS "rashod_percent",
    COALESCE("joinings", 0) as "joinings",
    COALESCE("count_calls", 0) AS "vse_lidi",
    COALESCE("calltags_celevoi", 0) AS "celevie_lidi",
	CASE 
        WHEN p."status....row.status" like '%pending%' THEN 0
        ELSE COALESCE("lidsUC", 0)
    END AS "celevie_lidi_plan",
    CASE 
        WHEN COALESCE("lidsUC", 0) = 0 THEN 0
        ELSE COALESCE("calltags_celevoi", 0) / COALESCE("lidsUC", 1)
    END AS "celevie_lidi_percent",
    COALESCE("calltags_celevoi_commerce", 0) AS "celevie_lidi_commerce",
   	CASE 
        WHEN p."status....row.status" like '%pending%' THEN 0
        ELSE COALESCE(commerce_stories, 0)
    END AS "celevie_lidi_commerce_plan",  
    COALESCE(percent_of_month_day, 0) AS percent_of_month_day
FROM public."plan" p


