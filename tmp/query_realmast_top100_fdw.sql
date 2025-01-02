create table realmast_top100_fdw as 
    	Select *
    	From S.vw_Cama_realmast(obs=100);
    	
